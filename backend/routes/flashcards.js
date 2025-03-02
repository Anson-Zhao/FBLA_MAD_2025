const express = require('express');
const db = require('../config/database');
const router = express.Router();

//Make a flashcard and save it into the table 
router.post('/', (req, res) => {
    const { user_id, topic, description } = req.body;
  
    if (!user_id || !topic || !description) {
      return res.status(400).json({ error: 'Missing required fields.' });
    }
  
    const query = 'INSERT INTO flashcards (user_id, topic, description) VALUES (?, ?, ?)';
    db.query(query, [user_id, topic, description], (err, result) => {
      if (err) {
        console.error('Error inserting flashcard:', err);
        return res.status(500).json({ error: 'Failed to add flashcard.' });
      }
      res.status(201).json({ message: 'Flashcard added successfully.', flashcard_id: result.insertId });
    });
  });
  
//Delete a flashcard by its id 
router.delete('/:id', (req, res) => {
  const { id } = req.params;

  const query = 'DELETE FROM flashcards WHERE id = ?';
  db.query(query, [id], (err, result) => {
    if (err) {
      console.error('Error deleting flashcard:', err);
      return res.status(500).json({ error: 'Failed to delete flashcard.' });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Flashcard not found.' });
    }

    res.status(200).json({ message: 'Flashcard deleted successfully.' });
  });
});

//Get flashcards bu user id
router.get('/:user_id', (req, res) => {
  const userId = req.params.user_id; 

  // SQL query to get flashcards for the specified user
  const sql = `SELECT * FROM flashcards WHERE user_id = ?`;

  db.query(sql, [userId], (err, results) => {
    if (err) {
      console.error("Error fetching flashcards:", err);
      res.status(500).json({ error: 'Failed to fetch flashcards' });
      return;
    }
    res.status(200).json(results); 
  });
});

  
  module.exports = router;