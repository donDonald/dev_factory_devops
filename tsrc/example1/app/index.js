
const os = require('os');
const express = require('express');

const PORT = 3000
const CAPTION = '';



const app = express();



app.metrics = {
    reqCount: 0
}



app.get('/', (req, res) => {
    ++req.app.metrics.reqCount;
    res.end(CAPTION + 'Hallo Node.js Server, reqs:' + req.app.metrics.reqCount + '\n')
});



const metrics = require('./metrics');
metrics.app = app;
app.get('/metrics', metrics.mw);



app.listen(PORT, '0.0.0.0', () => console.log(CAPTION + `App started. Try this:$ curl http://localhost:${PORT}`));

