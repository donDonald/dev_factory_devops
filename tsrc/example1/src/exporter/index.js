const express = require('express');
const fs = require('fs');
const rra = require('recursive-readdir-async');



function readFiles(result, index, files, cb) {
    //console.log('### readFiles');
    if (index < files.length) {
        const f = files[index];
        if (!f.isDirectory) {
            fs.readFile(f.fullname, (err, data)=>{
                if (err) {
                    cb(err);
                } else {
                    result[f.fullname] = parseInt(data);
                    readFiles(result, index+1, files, cb);
                }
            });
        } else {
            assert(false);
        }
    } else {
        cb(undefined, result);
    }
}



async function read(labels) {
    const list = await rra.list('/var/example1');
    //console.log('#read, list'); console.log(list);
    let promise = new Promise((resolve, reject) => {
        const result = {};
        readFiles(result, 0, list, (err, result)=>{
            if (err) {
                reject(err);
            } else {
                const metrics = [];
                for (const [key, value] of Object.entries(result)) {
                    //console.log(`${key}: ${value}`);
                    const elements = key.split('/');
                    const metric = {};
                    labels.forEach((l, index)=>{
                        const p = elements.length-labels.length+index;
                        metric[l] = elements[p];

                    });
                    metrics.push({first:metric, second:value});
                    //console.log('metric:'); console.log(metric);
                }
                resolve(metrics);
            }
        });
    });
    return promise;
}

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

//https://prometheus.io/docs/concepts/data_model/
//https://prometheus.io/docs/practices/naming/
//https://grafana.com/docs/grafana/latest/datasources/prometheus/
//https://prometheus.io/docs/guides/multi-target-exporter/
 


// Initialize phrometheus exporter
const client = require('prom-client');
const registry = new client.Registry();
const labels = ['host', 'worker'];



const http_requests = new client.Gauge({
    name: 'example1_http_requests',
    help: 'Amount of managed http requests',
    labelNames: labels,
    async collect() {
        const metrics = await read(labels);
        //console.log(metrics);
        metrics.forEach((m)=>{
            this.set(m.first, m.second);
        });
    }
});
registry.registerMetric(http_requests);



const app = express();
const PORT = 3001;
const CAPTION = '';



app.get('/metrics', async (req, res)=>{
    res.set('Content-Type', registry.contentType);
    res.end(await registry.metrics());
});



app.listen(PORT, '0.0.0.0', () => console.log(CAPTION + `App started. Try this:$ curl http://localhost:${PORT}/metrics`));

