const express = require('express');
const { authenticateToken } = require('../middlewares/auth');
const db = require('../config/database');

const router = express.Router();

//Submit quiz result after finishing one
router.post('/api/quiz/submit', authenticateToken, (req, res) => {
    const userId = req.user.id; // Get user ID from the authenticated token
    const { quiz_id, score } = req.body;

    // Validate input
    if (!quiz_id || score === undefined || score < 0 || score > 100) {
        return res.status(400).json({ error: 'Invalid quiz data submitted' });
    }

    // Check if the user has already taken this quiz
    db.query(
        'SELECT score, completed FROM user_progress WHERE user_id = ? AND quiz_id = ?',
        [userId, quiz_id],
        (err, progress) => {
            if (err) {
                console.error('Error fetching user progress:', err);
                return res.status(500).json({ error: 'Internal server error' });
            }

            let shouldUpdateLevel = false;

            if (progress.length > 0) {
                // User has taken the quiz before
                const existingScore = progress[0].score;
                const isCompleted = progress[0].completed;

                // Update the score only if the new score is higher
                if (score > existingScore) {
                    db.query(
                        'UPDATE user_progress SET score = ?, completed = ? WHERE user_id = ? AND quiz_id = ?',
                        [score, score >= 60, userId, quiz_id],
                        (err) => {
                            if (err) {
                                console.error('Error updating user progress:', err);
                                return res.status(500).json({ error: 'Internal server error' });
                            }

                            // Update level only if the quiz was not previously completed and the new score is >= 60%
                            if (!isCompleted && score >= 60) {
                                shouldUpdateLevel = true;
                            }

                            // Call updateUserLevel to handle the response
                            updateUserLevel(userId, res, shouldUpdateLevel);
                        }
                    );
                } else {
                    // If the score is not higher, just return success
                    res.status(200).json({ success: true, message: 'Quiz result submitted successfully.' });
                }
            } else {
                // User is taking the quiz for the first time
                db.query(
                    'INSERT INTO user_progress (user_id, quiz_id, score, completed) VALUES (?, ?, ?, ?)',
                    [userId, quiz_id, score, score >= 60],
                    (err) => {
                        if (err) {
                            console.error('Error inserting user progress:', err);
                            return res.status(500).json({ error: 'Internal server error' });
                        }

                        // Update level if the score is >= 60%
                        if (score >= 60) {
                            shouldUpdateLevel = true;
                        }

                        // Call updateUserLevel to handle the response
                        updateUserLevel(userId, res, shouldUpdateLevel);
                    }
                );
            }
        }
    );
});

// Helper function to update the user's level
function updateUserLevel(userId, res, shouldUpdateLevel) {
    if (shouldUpdateLevel) {
        db.query(
            'UPDATE users SET current_level = current_level + 1 WHERE id = ?',
            [userId],
            (err) => {
                if (err) {
                    console.error('Error updating user level:', err);
                    return res.status(500).json({ error: 'Internal server error' });
                }
                res.status(200).json({ success: true, message: 'Quiz result submitted successfully and level updated.' });
            }
        );
    } else {
        res.status(200).json({ success: true, message: 'Quiz result submitted successfully.' });
    }
}

router.get('/total-quiz', authenticateToken, (req, res) => {
    const userId = req.user.id;

    const query = `
        SELECT *
        FROM users 
        WHERE id = ?
    `;

    db.query(query, [userId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Failed to fetch total achievements.' });
        }
        res.status(200).json({ current_level: results[0].current_level });
    });
});

//Get the total quiz-score
router.get('/quiz/total-score', authenticateToken, (req, res) => {
    const userId = req.user.id; // Get user ID from the authenticated token

    // Query to calculate the total score of all quizzes for the user
    const query = `
        SELECT SUM(score) AS total_score
        FROM user_progress
        WHERE user_id = ?
    `;

    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error fetching total quiz score:', err);
            return res.status(500).json({ error: 'Internal server error' });
        }

        // Extract the total score from the query results
        const totalScore = results[0].total_score || 0; // Default to 0 if no scores exist

        res.status(200).json({ total_score: totalScore });
    });
});

//Get the highest user's 
router.get('/quiz/score/:quizId', authenticateToken, (req, res) => {
    const userId = req.user.id; // Get user ID from the authenticated token
    const quizId = req.params.quizId; // Get quiz ID from the URL parameter

    // Validate quiz ID
    if (!quizId || isNaN(quizId)) {
        return res.status(400).json({ error: 'Invalid quiz ID' });
    }

    // Query to fetch the quiz score for the user and quiz ID
    const query = `
        SELECT score
        FROM user_progress
        WHERE user_id = ? AND quiz_id = ?
    `;

    db.query(query, [userId, quizId], (err, results) => {
        if (err) {
            console.error('Error fetching quiz score:', err);
            return res.status(500).json({ error: 'Internal server error' });
        }

        // If no score exists for the quiz, return 0
        if (results.length === 0) {
            return res.status(200).json({ success: true, quiz_id: quizId, score: 0 });
        }

        // Return the quiz score
        const quizScore = results[0].score;
        res.status(200).json({ success: true, quiz_id: quizId, score: quizScore });
    });
});

router.put('/edit-username', authenticateToken, (req, res) => {
    const userId = req.user.id; 
    const username = req.body.username;

    const mysql = 'UPDATE users SET username = ? WHERE id = ?';

    db.query(mysql, [username, userId], (error, results) => {
        if (error) {
            console.error('Error in database:', error);
        }
        
        res.status(200).json({username: username})
    })
})

module.exports = router;
