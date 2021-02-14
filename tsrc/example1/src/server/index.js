
const express = require('express');
const metrics = require('./metrics');
const PORT = 3000
const CAPTION = '';

const app = express();

app.use(metrics({prefix:'example1'}));

app.get('/', (req, res) => {
    res.end(CAPTION + 'Hallo Node.js Server\n')
});

app.listen(PORT, '0.0.0.0', () => console.log(CAPTION + `App started. Try this:$ curl http://localhost:${PORT}`));

