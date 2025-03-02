const express = require('express');
const db = require('../config/database'); // Import the database connection
const router = express.Router();

// Endpoint to fetch all questions with their answers
router.get('/questions/:id', (req, res) => { 
    const quizId = req.params.id; // Extract quiz ID from the URL parameter

    // Query to check if the previous quiz is completed
    const checkPreviousQuizQuery = `
        SELECT 
            q.previous_quiz_id, 
            pq.is_completed AS previous_quiz_completed
        FROM quizzes q
        LEFT JOIN quizzes pq ON q.previous_quiz_id = pq.id
        WHERE q.id = ?;
    `;

    db.query(checkPreviousQuizQuery, [quizId], (err, results) => {
        if (err) {
            console.error('Error checking quiz dependencies:', err);
            res.status(500).send('Error checking quiz dependencies');
            return;
        }

        if (results.length === 0) {
            res.status(404).send('Quiz not found');
            return;
        }

        const { previous_quiz_id, previous_quiz_completed } = results[0];

        // Allow access if it's the first quiz (no previous_quiz_id) or the previous quiz is completed
        // if (previous_quiz_id && !previous_quiz_completed) {
        //     res.status(403).send('The previous quiz must be completed before accessing this quiz.');
        //     return;
        // }

        // Fetch questions and answers if the current quiz is accessible
        const query = `
            SELECT 
                q.id AS question_id, 
                q.question_text, 
                a.id AS answer_id, 
                a.answer_text, 
                a.is_correct 
            FROM questions q
            JOIN answers a ON q.id = a.question_id
            WHERE q.quiz_id = ? -- Filter by quiz_id
            ORDER BY q.id, a.id;
        `;

        db.query(query, [quizId], (err, results) => {
            if (err) {
                console.error('Error fetching questions:', err);
                res.status(500).send('Error fetching questions');
                return;
            }

            if (results.length === 0) {
                res.status(404).send('No questions found for this quiz');
                return;
            }

            // Group answers by question
            const questions = {};
            results.forEach((row) => {
                if (!questions[row.question_id]) {
                    questions[row.question_id] = {
                        id: row.question_id,
                        question: row.question_text,
                        answers: []
                    };
                }
                questions[row.question_id].answers.push({
                    id: row.answer_id,
                    text: row.answer_text,
                    isCorrect: row.is_correct
                });
            });

            res.json(Object.values(questions));
        });
    });
});

router.get('/hello', (req, res) => {
    res.send("this is /hello");
});

module.exports = router;
