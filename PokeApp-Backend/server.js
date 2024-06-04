const express = require('express');
const bodyParser = require('body-parser');
const catchRoute = require('./routes/catch');
const releaseRoute = require('./routes/release');
const renameRoute = require('./routes/rename');

const app = express();
const port = 3000;

app.use(bodyParser.json());

app.use('/api/catch', catchRoute);
app.use('/api/release', releaseRoute);
app.use('/api/rename', renameRoute);

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});
