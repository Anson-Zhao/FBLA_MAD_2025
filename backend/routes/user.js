const express = require('express');
const { authenticateToken } = require('../middlewares/auth');
const db = require('../config/database');

const router = express.Router();

// Get User Recent Quiz Score Route
router.get('/recent_quiz_score', authenticateToken, (req, res) => {
    // (Your logic for fetching user quiz score goes here.)
});

module.exports = router;
