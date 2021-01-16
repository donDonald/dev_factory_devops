
// https://habr.com/ru/post/492742/(Визуализируем данные Node JS приложения с помощью Prometheus + Grafana)
// https://medium.com/the-monitoring-metric/simple-prometheus-exporter-for-express-js-7906b2883fde(Simple Prometheus exporter for express.js)
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



const metrics = {
    set app(app) {
        this._app = app;
    },



    get app() {
        return this._app;
    },



    setup(registry) {
        metrics.requests = new client.Gauge(
            {
                name: 'http_requests',
                help: 'Amount of managed http requests',
                registers: [registry],
                collect() { this.set(metrics.app.metrics.reqCount) }
            }
        );

        ////async function collect() {
        ////    metrics.requests.set(
        ////        Math.floor(gaussian(40, 400).ppf(Math.random())),
        ////    );
        ////}
        ////setInterval(collect, 5000);
    },



    async mw(req, res) {
        res.set('Content-Type', registry.contentType);
        res.end(await registry.metrics());
    }
};



metrics.setup(registry);
module.exports = metrics;

