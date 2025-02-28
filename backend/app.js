const express = require('express');
const helmet = require('helmet');
const cors = require('cors');
const morgan = require('morgan');
const passport = require('./config/passport');
const authRoutes = require('./routes/auth');
const quizRoutes = require('./routes/quiz');
const userRoutes = require('./routes/user');
const achievemenRoutes = require('./routes/achievement');
const tokenRoutes = require('./routes/tokenRoutes');
const feedbackRoutes = require('./routes/feedback');
const flashcardsRoutes = require('./routes/flashcards');

const app = express();

app.use(express.json());
app.use(morgan('dev'));
app.use(helmet());
app.use(cors({ origin: process.env.CLIENT_URL || 'http://localhost:3000' }));
app.use(passport.initialize());

app.use('/auth', authRoutes);
app.use('/quiz', quizRoutes);
app.use('/user', userRoutes);
app.use('/achievement', achievemenRoutes);
app.use('/api', tokenRoutes);
app.use('/feedback', feedbackRoutes);
app.use('/flashcards', flashcardsRoutes);

module.exports = app;
