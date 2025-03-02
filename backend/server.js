const dotenv = require('dotenv');
const app = require('./app');

dotenv.config();

const port = 9094;

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
