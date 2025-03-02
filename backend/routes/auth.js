const express = require('express');
const {body, validationResult} = require('express-validator');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/database');
const rateLimiter = require('../middlewares/rateLimiter');
const {isValidPassword} = require('../utils/validators');
const transporter = require('../utils/emailService');
const passport = require("../config/passport")
const crypto = require('crypto');
const nodemailer = require('nodemailer');
const {OAuth2Client} = require('google-auth-library');

const router = express.Router();
const saltRounds = 10;

//Connect with nodemailer 
const sendResetEmail = (email, resetCode) => {
    const transporter = nodemailer.createTransport({
        host: 'smtp.sendgrid.net',
        port: 587,
        secure: false,
        auth: {
            user: 'apikey',
            pass: process.env.API_KEY, // Load API key from .env
        },
    });


    const mailOptions = {
        from: process.env.EMAIL_USER,  // Replace with your email
        to: email,
        subject: 'Password Reset Code',
        text: `Your password reset code is: ${resetCode}`,
    };

    return transporter.sendMail(mailOptions);
};


//Regiset new user
router.post('/register', async (req, res) => {
    const {username, email, password} = req.body;

    // Validate input
    if (!username || !email || !password) {
        return res.status(400).json({message: 'Username, email, and password are required'});
    } else { 
        try {
            // Check if the email already exists
            const checkEmailQuery = 'SELECT id FROM users WHERE email = ?';
            db.query(checkEmailQuery, [email], async (err, results) => {
                if (err) {
                    console.error('Database query error:', err.message);
                    return res.status(500).json({message: 'Database error'});
                } else if (results.length > 0) {
                    return res.status(409).json({message: 'Email is already registered'});
                }
    
                // Hash the password
                const hashedPassword = await bcrypt.hash(password, 10);
    
                // Insert the new user into the database
                const insertQuery = 'INSERT INTO users (username, email, password) VALUES (?, ?, ?)';
                db.query(insertQuery, [username, email, hashedPassword], (err, result) => {
                    if (err) {
                        console.error('Database insertion error:', err.message);
                        return res.status(500).json({message: 'Failed to register user'});
                    }
    
                    // Generate tokens for the newly registered user
                    const token = jwt.sign(
                        {id: result.insertId, username, email},
                        process.env.JWT_SECRET,
                        {expiresIn: '182d'}
                    );
    
                    const refreshToken = jwt.sign(
                        {id: result.insertId, username, email}, // Use result.insertId for user ID
                        process.env.JWT_REFRESH_SECRET,
                        {expiresIn: '182d'}
                    );
    
                    // Send success response
                    res.status(201).json({
                        message: 'User registered successfully',
                        token,
                        refreshToken,
                        user: {id: result.insertId, username, email}
                    });
    
                    console.log(`${username} just signed up.`);
                });
            });
        } catch (error) {
            console.error('Server error:', error.message);
            res.status(500).json({message: 'Server error'});
        }
    }

    
});

//Log user in 
router.post('/login', async (req, res) => {
    const {email, password} = req.body;

    if (!email || !password) {
        return res.status(400).json({message: 'Email and password are required'});
    } else {
        try {
            // Fetch user by email
            const query = 'SELECT id, username, email, password FROM users WHERE email = ?';
            db.query(query, [email], async (err, results) => {
                    if (err) {
                        console.error('Database query error:', err.message);
                        return res.status(500).json({message: 'Database error'});
                    } else if (results.length === 0) {
                        return res.status(401).json({message: 'Invalid email or password'});
                    } else {
                        const user = results[0];

                        // Check password
                        const match = await bcrypt.compare(password, user.password);
                        if (!match) {
                            return res.status(401).json({message: 'Invalid email or password'});
                        }

                        // Generate JWT token
                        const token = jwt.sign(
                            {id: user.id, username: user.username, email: user.email},
                            "your_secret_key",
                            {expiresIn: '182d'}
                        );

                        const refreshToken = jwt.sign(
                            {id: user.id, username: user.username, email: user.email},
                            "refresh_secret_key",
                            {expiresIn: '182d'}
                        );

                        res.status(200).json({
                            token,
                            refreshToken,
                            user: {id: user.id, username: user.username, email: user.email}
                        });
                        console.log(`${user.username} just logged in.`)
                    }
                }
            )


        } catch (error) {
            console.error('Server error:', error.message);
            res.status(500).json({message: 'Server error'});
        }
    }


});

//Request the passport reset and also send to user's email code
router.post('/request-password-reset', async (req, res) => {
    const {email} = req.body;

    try {
        // Generate a 6-digit code
        const resetCode = crypto.randomInt(100000, 999999).toString();

        // Save the reset code to the database temporarily with an expiration
        const expirationTime = Date.now() + 10 * 60 * 1000; // 10 minutes

        // Get the query result first
        const query = 'SELECT * FROM users WHERE email = ?';
        db.query(query, [email], async (err, results) => {
            if (err) {
                console.error('Database query error:', err.message);
                return res.status(500).json({message: 'Database error'});
            } else if (results.length === 0) {
                return res.status(401).json({message: 'User not found'});
            }

            const user = results[0];

            await db.query('UPDATE users SET reset_code = ?, reset_code_expiry = ? WHERE email = ?', [resetCode, expirationTime, email]);

            // Send the reset code to the user's email
            await sendResetEmail(email, resetCode);

            res.status(200).send('Password reset code sent to email');

        });
    } catch (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
    }
});

//Validate the code from user input and compare to actual code 
router.post('/code-validation', async (req, res) => {
    const {email, resetCode} = req.body;

    try {
        const query = 'SELECT * FROM users WHERE email = ?';
        db.query(query, [email], async (err, results) => {
            if (err) {
                console.error('Database query error:', err.message);
                return res.status(500).json({message: 'Database error'});
            }

            if (results.length === 0) {
                return res.status(401).json({message: 'User not found'});
            }

            const user = results[0];

            if (user.reset_code != resetCode) {
                return res.status(400).send('Invalid code');
            }

            res.status(200).send('Code is correct!')

        })
    } catch (e) {
        res.status(500).send('Internal Server Error');
    }
})

//Reset password and update table with new hashed password
router.post('/reset-password', async (req, res) => {
    const {email, newPassword} = req.body;

    try {
        const query = 'SELECT * FROM users WHERE email = ?';
        db.query(query, [email], async (err, results) => {
            if (err) {
                console.error('Database query error:', err.message);
                return res.status(500).json({message: 'Database error'});
            }

            if (results.length === 0) {
                return res.status(401).json({message: 'User not found'});
            }

            const user = results[0];
            const hashedPassword = await bcrypt.hash(newPassword, 10);

            await db.query(
                'UPDATE users SET password = ?, reset_code = NULL, reset_code_expiry = NULL WHERE email = ?',
                [hashedPassword, email]
            );

            res.status(200).send('Password reset successfully');

        });
    } catch (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
    }
});


//Log in with twitter 
//OAuth 2.0 client secret MlbY5b2wcn7fs8EQb_ofXmXnZdB-6Kch38Hnowr19eNGJ9WGpo
router.post('/twitter-login', (req, res) => {
    const {twitter_id, username, email} = req.body;

    // Check if the user exists or needs to be created
    const query = `SELECT *
                   FROM users
                   WHERE twitter_id = ?`;
    db.query(query, [twitter_id], (err, result) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Database error');
        }

        let user = result[0];

        if (!user) {
            // Insert user if not found
            const insertQuery = `
                INSERT INTO users (twitter_id, username, email, created_at)
                VALUES (?, ?, ?, NOW())`;
            db.query(insertQuery, [twitter_id, username, email], (err, result) => {
                if (err) {
                    console.error('Error inserting user:', err);
                    return res.status(500).send('Database error');
                }
                // Retrieve the newly inserted user
                user = {twitter_id, username, email};
                const token = jwt.sign(
                    {id: user.id, username: user.username, email: user.email},
                    process.env.JWT_SECRET,
                    {expiresIn: '1h'}
                );

                res.status(200).json({token, user: {id: user.id, username: user.username, email: user.email}});
            });
        } else {
            const token = jwt.sign(
                {id: user.id, username: user.username, email: user.email},
                process.env.JWT_SECRET,
                {expiresIn: '1h'}
            )
            res.status(200).json({token, user: {id: user.id, username: user.username, email: user.email}});
        }
    });
});


module.exports = router;