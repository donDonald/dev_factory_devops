
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



const metrics = {

    set sink(sink) { this._sink = sink; },
    get sink() { return this._sink; },



    set prefix(prefix) { this._prefix = prefix; },
    get prefix() { return this._prefix ? this._prefix : ''; },



    setup(sink, prefix) {
        this.sink = sink;
        this.prefix = prefix;

        const http_requests = new client.Gauge({
            name: this.prefix + 'http_requests',
            help: 'Amount of managed http requests',
            collect() { this.set(metrics.sink.reqCount) }
        });
        registry.registerMetric(http_requests);

        async function collect() {
            http_requests.set(metrics.sink.reqCount);
        }
        setInterval(collect, 5000);
    },



    async mw(req, res) {
        res.set('Content-Type', registry.contentType);
        res.end(await registry.metrics());
    }
};



module.exports = metrics;

