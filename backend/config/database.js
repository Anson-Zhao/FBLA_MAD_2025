const mysql = require('mysql');
const dotenv = require('dotenv');

dotenv.config();

//Connect to database
const db = mysql.createConnection({
    // host: '10.11.90.15',
    host: 'localhost',
    user: 'AppUser',
    password: 'Special888%',
    database: 'FBLA_Mobile_Application_2025',
});

db.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to MySQL database');
});

module.exports = db;
