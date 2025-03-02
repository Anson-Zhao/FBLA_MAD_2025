const rateLimit = require('express-rate-limit');

const rateLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 5,
    message: 'Too many login attempts, please try again later.',
});

module.exports = rateLimiter;
