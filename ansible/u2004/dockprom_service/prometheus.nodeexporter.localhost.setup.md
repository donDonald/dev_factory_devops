
### Intro
    Manuals on prometheus and nodeexporter setup
    prometheus will run locally
    All sources(nodeexporter) will run locally



### Referencies
    - https://habr.com/ru/company/southbridge/blog/314212/
    - https://stefanprodan.com/2016/a-monitoring-solution-for-docker-hosts-containers-and-containerized-services/
    - https://blog.alexellis.io/docker-stacks-attachable-networks/
    - https://prometheus.io/docs/guides/node-exporter/



### Setup nodeexporter(4 instances to make things cool)
    nodeexporter is metrics source for prometheus
    nodeexporter collecting node info like cpus, memory, etc. and sending it back upon http get, i.e. http server

    https://prometheus.io/docs/guides/node-exporter/
    https://prometheus.io/docs/prometheus/latest/getting_started/#starting-up-some-sample-targets
```
    $ wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
    $ tar xvfz node_exporter-*.*-amd64.tar.gz
    $ cd node_exporter-*.*-amd64
    $ ./node_exporter --web.listen-address 127.0.0.1:9100&
    $ ./node_exporter --web.listen-address 127.0.0.1:9101&
    $ ./node_exporter --web.listen-address 127.0.0.1:9102&
    $ ./node_exporter --web.listen-address 127.0.0.1:9103&
```



###### Check nodeexporter works
    Since nodeexorter is http server, lets poll it like this:
```
    $ curl localhost:9100/metrics
    $ curl localhost:9101/metrics
    $ curl localhost:9102/metrics
    $ curl localhost:9103/metrics
```



### Setup prometheus
    prometheus is metrics database
    prometheus collects metrics from different sources like nodeexporter or cAdvisor
    sources usually are http servers providing metrics url like this: localhost:9100/metrics

    https://prometheus.io/docs/prometheus/latest/getting_started/
    https://prometheus.io/docs/prometheus/latest/getting_started/#configure-prometheus-to-monitor-the-sample-targets
```
    $ wget https://github.com/prometheus/prometheus/releases/download/v2.23.0/prometheus-2.23.0.linux-amd64.tar.gz
    $ tar xvf prometheus-*.*-amd64.tar.gz
    $ cd prometheus-2.23.0.linux-amd64/
    $ CFG=../templates/prometheus.yml.j2
    $ ./prometheus --config.file=$CFG
```



###### Check prometheus works
https://prometheus.io/docs/guides/node-exporter/#exploring-node-exporter-metrics-through-the-prometheus-expression-browser

- browser: localhost:9090/graph
- Expression bar: node_uname_info
- Click execute and will get something back

Other expressions:
    - rate(node_cpu_seconds_total{mode="system"}[1m])

