const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const helmet = require('helmet');
const cors = require('cors');
const { body, validationResult } = require('express-validator');

dotenv.config();

const app = express();
const port = process.env.PORT || 3306;
const saltRounds = 10;

app.use(express.json());
app.use(morgan('dev')); 
app.use(helmet());
app.use(cors({ origin: process.env.CLIENT_URL || 'http://localhost:3000' }));

const db = mysql.createPool({
    host: process.env.DB_HOST || '10.11.90.15',
    user: process.env.DB_USER || 'AppUser',
    password: process.env.DB_PASSWORD || 'Special888%',
    database: process.env.DB_NAME || 'FBLA_Mobile_Application_2025',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

const secretKey = process.env.JWT_SECRET || 'secret';
const tokenExpiry = process.env.JWT_EXPIRES_IN || '1h';
const refreshTokenExpiry = process.env.JWT_REFRESH_EXPIRES_IN || '7d';

const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ error: 'Unauthorized: No token provided' });
    }

    jwt.verify(token, secretKey, (err, user) => {
        if (err) {
            return res.status(403).json({ error: 'Forbidden: Invalid token' });
        }
        req.user = user;
        next();
    });
};

const rateLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, 
    max: 5, 
    message: 'Too many login attempts, please try again later.'
});

const isValidPassword = (password) => {
    const regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    return regex.test(password);
};

const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;

passport.use(new GoogleStrategy(
    {
        clientID: process.env.GOOGLE_CLIENT_ID,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET,
        callbackURL: '/auth/google/callback',
    },
    async (accessToken, refreshToken, profile, done) => {
        try {
            const [user] = await db.promise().query('SELECT id FROM users WHERE google_id = ?', [profile.id]);
            if (user.length === 0) {
                const result = await db.promise().query(
                    'INSERT INTO users (username, email, google_id) VALUES (?, ?, ?)',
                    [profile.displayName, profile.emails[0].value, profile.id]
                );
                return done(null, { id: result.insertId });
            } else {
                return done(null, { id: user[0].id });
            }
        } catch (err) {
            return done(err);
        }
    }
));

passport.serializeUser((user, done) => done(null, user.id));
passport.deserializeUser(async (id, done) => {
    try {
        const [user] = await db.promise().query('SELECT id, username, email FROM users WHERE id = ?', [id]);
        done(null, user[0]);
    } catch (err) {
        done(err);
    }
});

app.get('/auth/google', passport.authenticate('google', {
    scope: ['profile', 'email']
}));

app.get('/auth/google/callback',
    passport.authenticate('google', { failureRedirect: '/login' }),
    (req, res) => {
        res.redirect('/dashboard');
    }
);

function isAuthenticated(req, res, next) {
    if (req.isAuthenticated()) {
        return next();
    }
    res.redirect('/login');
}


const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: process.env.EMAIL_USER, // Your email address (e.g., gmail)
        pass: process.env.EMAIL_PASS  // Your email password (or an app-specific password if using Gmail)
    }
});

app.post('/signup', rateLimiter, [
    body('username').isLength({ min: 3 }).trim().escape(),
    body('email').isEmail().normalizeEmail(),
    body('password').isLength({ min: 8 }).custom(isValidPassword).withMessage('Password must be at least 8 characters long and contain letters, numbers, and special characters.')
], async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    try {
        const { username, email, password } = req.body;

        const [usernameCheck] = await db.promise().query('SELECT id FROM users WHERE username = ?', [username]);
        if (usernameCheck.length > 0) {
            return res.status(400).json({ error: 'Username already exists. Please choose a different username.' });
        }

        const [emailCheck] = await db.promise().query('SELECT id FROM users WHERE email = ?', [email]);
        if (emailCheck.length > 0) {
            return res.status(400).json({ error: 'Email already in use. Please login instead.' });
        }

        const hashedPassword = await bcrypt.hash(password, saltRounds);

        const emailVerificationToken = jwt.sign({ email }, process.env.JWT_SECRET, { expiresIn: '1h' });

        const verificationLink = `${process.env.BASE_URL}/verify-email?token=${emailVerificationToken}`;

        const mailOptions = {
            from: process.env.EMAIL_USER,
            to: email,
            subject: 'Email Verification',
            text: `Click on the following link to verify your email: ${verificationLink}`
        };

        transporter.sendMail(mailOptions, async (err, info) => {
            if (err) {
                console.error('Error sending email:', err);
                return res.status(500).json({ error: 'Error sending verification email.' });
            }

            const sql = 'INSERT INTO users (username, email, password, email_verified) VALUES (?, ?, ?, ?)';
            db.query(sql, [username, email, hashedPassword, false], (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).json({ error: 'Internal server error' });
                }
                res.status(201).json({ message: 'User registered successfully. Please check your email to verify your account.' });
            });
        });

    } catch (err) {
        console.error('Error:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.get('/verify-email', async (req, res) => {
    const { token } = req.query;

    if (!token) {
        return res.status(400).json({ error: 'Token is required.' });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        const [user] = await db.promise().query('SELECT id FROM users WHERE email = ?', [decoded.email]);
        if (user.length === 0) {
            return res.status(404).json({ error: 'User not found.' });
        }

        const sql = 'UPDATE users SET email_verified = ? WHERE email = ?';
        await db.promise().query(sql, [true, decoded.email]);

        res.status(200).json({ message: 'Email verified successfully!' });
    } catch (err) {
        console.error('Verification error:', err);
        res.status(500).json({ error: 'Failed to verify email.' });
    }
});

app.post('/login', rateLimiter, async (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    try {
        const sql = `
            SELECT 
                u.id, u.username, u.email, u.created_at, u.password,
                (SELECT us.score
                 FROM user_scores us
                 WHERE us.user_id = u.id
                 ORDER BY us.created_at DESC
                 LIMIT 1) AS recentScore
            FROM users u
            WHERE u.username = ? OR u.email = ?;
        `;
        
        const [results] = await db.promise().query(sql, [username, username]);

        if (results.length === 0) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        const user = results[0];
        const match = await bcrypt.compare(password, user.password);

        if (!match) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        const token = jwt.sign(
            { id: user.id, username: user.username },
            secretKey,
            { expiresIn: tokenExpiry }
        );

        const refreshToken = jwt.sign(
            { id: user.id, username: user.username },
            secretKey,
            { expiresIn: refreshTokenExpiry }
        );

        const userData = {
            id: user.id,
            username: user.username,
            email: user.email,
            createdAt: user.created_at,
            recentScore: user.recentScore || 0
        };

        res.status(200).json({
            message: 'Login successful',
            token,
            refreshToken,
            user: userData
        });

    } catch (err) {
        console.error('Error:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.post('/refresh_token', (req, res) => {
    const { refreshToken } = req.body;

    if (!refreshToken) {
        return res.status(401).json({ error: 'Refresh token is required' });
    }

    jwt.verify(refreshToken, secretKey, (err, user) => {
        if (err) {
            return res.status(403).json({ error: 'Forbidden: Invalid refresh token' });
        }

        const newToken = jwt.sign(
            { id: user.id, username: user.username },
            secretKey,
            { expiresIn: tokenExpiry }
        );

        res.status(200).json({ token: newToken });
    });
});

app.put('/change_credentials', authenticateToken, [
    body('newPassword').optional().custom(isValidPassword).withMessage('New password must be at least 8 characters long and contain letters, numbers, and special characters.')
    ], async (req, res) => {

    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    try {
        const { oldPassword, newPassword, username, email } = req.body;

        if (!oldPassword || (!newPassword && !username && !email)) {
            return res.status(400).json({ error: 'Old password is required and at least one new credential (password, username, or email) must be provided' });
        }

        const userId = req.user.id;

        const sql = 'SELECT id, username, email, password FROM users WHERE id = ?';
        const [results] = await db.promise().query(sql, [userId]);

        if (results.length === 0) {
            return res.status(404).json({ error: 'User not found' });
        }

        const user = results[0];

        const match = await bcrypt.compare(oldPassword, user.password);
        if (!match) {
            return res.status(401).json({ error: 'Invalid old password' });
        }

        let updates = {};
        if (newPassword) {
            const hashedPassword = await bcrypt.hash(newPassword, saltRounds);
            updates.password = hashedPassword;
        }

        if (username) {
            const [usernameCheck] = await db.promise().query('SELECT id FROM users WHERE username = ? AND id != ?', [username, userId]);
            if (usernameCheck.length > 0) {
                return res.status(400).json({ error: 'Username is already taken' });
            }
            updates.username = username;
        }

        if (email) {
            const [emailCheck] = await db.promise().query('SELECT id FROM users WHERE email = ? AND id != ?', [email, userId]);
            if (emailCheck.length > 0) {
                return res.status(400).json({ error: 'Email is already in use' });
            }
            updates.email = email;
        }

        const updateFields = Object.keys(updates);
        if (updateFields.length > 0) {
            const updateQuery = `UPDATE users SET ${updateFields.map(field => `${field} = ?`).join(', ')} WHERE id = ?`;
            const updateValues = [...updateFields.map(field => updates[field]), userId];

            await db.promise().query(updateQuery, updateValues);

            res.status(200).json({ message: 'Credentials updated successfully' });
        } else {
            res.status(400).json({ error: 'No valid fields provided for update' });
        }
    } catch (err) {
        console.error('Error updating credentials:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.post('/submit_quiz', authenticateToken, async (req, res) => {
    const userId = req.user.id;
    const { quizId, answers } = req.body;

    if (!quizId || !Array.isArray(answers) || answers.length === 0) {
        return res.status(400).json({ error: 'Invalid quiz data submitted' });
    }

    try {
        const [quizQuestions] = await db.promise().query(`
            SELECT q.id AS question_id, q.correct_answer_id 
            FROM questions q 
            WHERE q.quiz_id = ?;
        `, [quizId]);

        if (quizQuestions.length === 0) {
            return res.status(404).json({ error: 'Quiz not found' });
        }

        let totalScore = 0;
        const scoreDetails = answers.map(answer => {
            const question = quizQuestions.find(q => q.question_id === answer.question_id);
            const isCorrect = question && question.correct_answer_id === answer.answer_id;
            const score = isCorrect ? 1 : 0;
            totalScore += score;

            return {
                question_id: answer.question_id,
                is_correct: isCorrect,
                score: score,
                attempted_at: new Date()
            };
        });

        const scoreInsertQuery = `
            INSERT INTO quiz_scores (user_id, question_id, is_correct, score, attempted_at)
            VALUES ?
        `;
        const scoreValues = scoreDetails.map(detail => [
            userId,
            detail.question_id,
            detail.is_correct,
            detail.score,
            detail.attempted_at
        ]);

        await db.promise().query(scoreInsertQuery, [scoreValues]);

        const updateScoreQuery = `
            INSERT INTO user_scores (user_id, quiz_id, score, attempted_at)
            VALUES (?, ?, ?, NOW())
            ON DUPLICATE KEY UPDATE
            score = score + VALUES(score), attempted_at = NOW();
        `;

        await db.promise().query(updateScoreQuery, [userId, quizId, totalScore]);

        res.status(200).json({ message: 'Quiz submitted successfully', totalScore });
    } catch (err) {
        console.error('Error submitting quiz:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.get('/user/recent_quiz_score', authenticateToken, (req, res) => {
    const userId = req.user.id;

    const query = `
        SELECT 
            us.score, 
            us.attempted_at 
        FROM quiz_scores us
        WHERE us.user_id = ? 
          AND us.attempted_at = (
              SELECT MAX(attempted_at) 
              FROM quiz_scores 
              WHERE user_id = us.user_id
          )
        ORDER BY us.attempted_at DESC;
    `;

    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error fetching scores:', err);
            return res.status(500).json({ message: 'Internal server error' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'No scores found for this user' });
        }

        const scores = results.map(row => ({
            score: row.score,
            attemptedAt: row.attempted_at
        }));

        res.json({ recentQuizScores: scores });
    });
});

app.get('/user/quiz_scores', authenticateToken, (req, res) => {
    const userId = req.user.id;

    const query = `
        SELECT 
            us.id AS score_id, 
            q.id AS question_id,
            q.question_text, 
            us.is_correct, 
            us.score, 
            us.attempted_at 
        FROM quiz_scores us
        JOIN questions q ON us.question_id = q.id
        WHERE us.user_id = ?
        ORDER BY us.attempted_at DESC;
    `;

    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error fetching scores:', err);
            return res.status(500).json({ message: 'Internal server error' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'No scores found for this user' });
        }

        const groupedScores = results.reduce((acc, row) => {
            if (!acc[row.question_id]) {
                acc[row.question_id] = {
                    question: row.question_text,
                    scores: []
                };
            }
            acc[row.question_id].scores.push({
                score_id: row.score_id,
                isCorrect: row.is_correct,
                score: row.score,
                attemptedAt: row.attempted_at
            });
            return acc;
        }, {});

        res.json(groupedScores);
    });
});

app.put('/user/achievement_unlocked', authenticateToken, async (req, res) => {
    const userId = req.user.id;
    const { quizProgress = 0, gameProgress = 0 } = req.body;

    if (quizProgress < 0 || gameProgress < 0) {
        return res.status(400).json({ error: 'Progress values cannot be negative.' });
    }

    try {
        const updateQuery = `
            INSERT INTO achievement_unlocked (user_id, quiz_achievements, game_achievements)
            VALUES (?, ?, ?)
            ON DUPLICATE KEY UPDATE
                quiz_achievements = quiz_achievements + VALUES(quiz_achievements),
                game_achievements = game_achievements + VALUES(game_achievements);
        `;
        await db.promise().query(updateQuery, [userId, quizProgress, gameProgress]);

        const [userProgress] = await db.promise().query(
            'SELECT quiz_achievements, game_achievements FROM achievement_unlocked WHERE user_id = ?',
            [userId]
        );

        const { quiz_achievements, game_achievements } = userProgress[0];

        const [allAchievements] = await db.promise().query('SELECT * FROM achievements');

        const unlockedAchievements = allAchievements.filter(achievement => {
            if (achievement.type === 'quiz' && quiz_achievements >= achievement.criteria) {
                return true;
            }
            if (achievement.type === 'game' && game_achievements >= achievement.criteria) {
                return true;
            }
            return false;
        });

        res.status(200).json({
            message: 'Progress updated successfully',
            unlockedAchievements: unlockedAchievements.map(a => ({
                name: a.name,
                description: a.description
            }))
        });
    } catch (err) {
        console.error('Error updating achievement_unlocked:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
});



app.get('/questions', (req, res) => {
    const query = `
        SELECT 
            q.id AS question_id, 
            q.question_text, 
            a.id AS answer_id, 
            a.answer_text
        FROM questions q
        LEFT JOIN answers a ON q.id = a.question_id;
    `;
    
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching questions:', err);
            return res.status(500).json({ error: 'Internal server error' });
        }

        const questions = [];
        results.forEach(row => {
            let question = questions.find(q => q.id === row.question_id);
            if (!question) {
                question = {
                    id: row.question_id,
                    question_text: row.question_text,
                    answers: []
                };
                questions.push(question);
            }
            question.answers.push({ id: row.answer_id, text: row.answer_text });
        });

        res.status(200).json({ questions });
    });
});



app.use((err, req, res, next) => {
    console.error(err);
    res.status(500).json({ error: 'Something went wrong. Please try again later.' });
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});

