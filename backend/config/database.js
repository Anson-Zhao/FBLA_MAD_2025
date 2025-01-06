const mysql = require('mysql');
const dotenv = require('dotenv');

dotenv.config();

const db = mysql.createPool({
    host: process.env.DB_HOST || '10.11.90.15',
    user: process.env.DB_USER || 'AppUser',
    password: process.env.DB_PASSWORD || 'Special888%',
    database: process.env.DB_NAME || 'FBLA_Mobile_Application_2025',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

module.exports = db;
