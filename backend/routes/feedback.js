const express = require('express');
const nodemailer = require('nodemailer');
const router = express.Router();
require('dotenv').config();

const transporter = nodemailer.createTransport({
    host: 'smtp.sendgrid.net',
    port: 587,
    secure: false,
    auth: {
        user: 'apikey',
        pass: process.env.API_KEY, // Load API key from .env
    },
});

//Send the feedback to Eduventure's email
router.post('/submit-feedback', async (req, res) => {
    const { username, feedback, index } = req.body;
    var emoji = 'none';
    if (!feedback) {
        return res.status(400).send('Feedback is required');
    }

    switch(index) {
        case 0:
            emoji = "Very Bad";
            break;
        case 1:
            emoji = "Bad";
            break;
        case 2: 
            emoji = "Good";
            break;
        case 3:
            emoji = "Very Good";
            break;
    }

    const mailOptions = {
        from: process.env.EMAIL_USER,
        to: process.env.EMAIL_USER,
        subject: `New Feedback Received from ${username || 'Anonymous'}, ${username || 'Anonymous'} rated our application as ${emoji}`,
        text: `Feedback: ${feedback}`
    };

    try {
        await transporter.sendMail(mailOptions);
        res.status(200).send('Feedback sent successfully');
    } catch (error) {
        console.error('Error sending email:', error);
        res.status(500).send('Failed to send feedback');
    }
});

module.exports = router;
