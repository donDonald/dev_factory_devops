
const express = require('express');
const fs = require('fs');
const PORT = 3001
const CAPTION = '';

const app = express();



// https://habr.com/ru/post/492742/(Визуализируем данные Node JS приложения с помощью Prometheus + Grafana)
// !!! https://sysdig.com/blog/prometheus-metrics/#nodejsjavascriptcodeinstrumentationwithprometheusopenmetrics
// https://medium.com/the-monitoring-metric/simple-prometheus-exporter-for-express-js-7906b2883fde(Simple Prometheus exporter for express.js)
// https://sysdig.com/blog/prometheus-metrics/
// https://github.com/siimon/prom-client

//express-prom-bundle
//    https://www.npmjs.com/package/express-prom-bundle
//    https://github.com/jochen-schweizer/express-prom-bundle

//express-prometheus-middleware
//    https://www.npmjs.com/package/express-prometheus-middleware
//    https://github.com/joao-fontenele/express-prometheus-middleware

// Initialize phrometheus exporter
const client = require('prom-client');
const registry = new client.Registry();

const http_requests = new client.Gauge({
    name: 'example1_http_requests',
    help: 'Amount of managed http requests',
    async collect() {
        let promise = new Promise((resolve, reject) => {
            fs.readFile('/var/example1/http_requests', (err, data)=>{
                if (err) {
                    reject(0);
                } else {
                    resolve(parseInt(data));
                }
            });
        });
        this.set(await promise);
    }
});
registry.registerMetric(http_requests);

app.get('/metrics', async (req, res)=>{
    res.set('Content-Type', registry.contentType);
    res.end(await registry.metrics());
});

app.listen(PORT, '0.0.0.0', () => console.log(CAPTION + `App started. Try this:$ curl http://localhost:${PORT}/metrics`));

