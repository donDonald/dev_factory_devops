
### Intro
    Manuals on prometheus and nodeexporter + cAdvisor setup
    Everything will run using docker-compose



### Setup prometheus + all sources using docker-compose
```
$ git clone https://github.com/stefanprodan/dockprom.git
$ cd dockprom
$ docker-compose -f ./docker-compose.pt.yml up -d --build --force-recreate



$ docker-compose -f ./docker-compose.pt.yml ps
    Name                  Command                  State                                                   Ports                                             
-------------------------------------------------------------------------------------------------------------------------------------------------------------
caddy          /sbin/tini -- caddy -agree ...   Up             0.0.0.0:3000->3000/tcp, 0.0.0.0:9090->9090/tcp, 0.0.0.0:9091->9091/tcp, 0.0.0.0:9093->9093/tcp
cadvisor       /usr/bin/cadvisor -logtostderr   Up (healthy)   8080/tcp                                                                                      
grafana        /run.sh                          Up             3000/tcp                                                                                      
nodeexporter   /bin/node_exporter --path. ...   Up             9100/tcp                                                                                      
prometheus     /bin/prometheus --config.f ...   Up             9090/tcp 



$ docker network ls
NETWORK ID          NAME                   DRIVER              SCOPE
d700fadb3028        bridge                 bridge              local
90dd35ec0f7d        dockprom_monitor-net   bridge              local
cd76f883677e        host                   host                local
6ba5f58b1408        none    



$ docker network inspect dockprom_monitor-net
[
    {
        "Name": "dockprom_monitor-net",
        "Id": "90dd35ec0f7d1e0b6c254f0f2194d5a3d2e4eb9dabd1ea945e6abb5eb251414e",
        "Created": "2021-01-05T23:13:05.449000464+03:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.22.0.0/16",
                    "Gateway": "172.22.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": true,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "03abadad8218603fbf7164bdd7d369f8a1a1c655ecc690a3d0af29fc117341b1": {
                "Name": "prometheus",
                "EndpointID": "9e84f4dfc949e696183167ea20b5acc4826942a9ffe157170ca01e8190460752",
                "MacAddress": "02:42:ac:16:00:05",
                "IPv4Address": "172.22.0.5/16",
                "IPv6Address": ""
            },
            "0fb66d63bdac969fff7db58d2978f24c1663394bb32863c6d26df7e4f6cd5dc5": {
                "Name": "grafana",
                "EndpointID": "e1872ca0638207ff9cf13cc6bb628ebafc18ff2b767af19ec2b65234e91de7ed",
                "MacAddress": "02:42:ac:16:00:02",
                "IPv4Address": "172.22.0.2/16",
                "IPv6Address": ""
            },
            "66ddc2ae9599538008e18da88d0a00aff94039b6e0652bfe348a22ab5dd98825": {
                "Name": "caddy",
                "EndpointID": "92891e43b118d467002ef14be8b96a2131a81fc7302f9a5e9936110f68748503",
                "MacAddress": "02:42:ac:16:00:06",
                "IPv4Address": "172.22.0.6/16",
                "IPv6Address": ""
            },
            "6c5f3458ad23acf7f77455d1412bc51ef8a90f82ce8461bc1eb63afde3c2a4ce": {
                "Name": "cadvisor",
                "EndpointID": "8e9a6518f533d1edb6fa5ab0d744fb0e3c65de7bd22aa6a95e18f503a99227fc",
                "MacAddress": "02:42:ac:16:00:03",
                "IPv4Address": "172.22.0.3/16",
                "IPv6Address": ""
            },
            "8c76f23efc18bf893d25ba7a5a2ec70c92997ca04c13f9d8f7f1c04c7b7a089e": {
                "Name": "nodeexporter",
                "EndpointID": "5e1db173dfa5ccccf15b472dd2b6feefd14dd93a1c1a9e1b7c3cedda0b0a509e",
                "MacAddress": "02:42:ac:16:00:04",
                "IPv4Address": "172.22.0.4/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {
            "com.docker.compose.network": "monitor-net",
            "com.docker.compose.project": "dockprom",
            "com.docker.compose.version": "1.25.5"
        }
    }
]
```



###### Check nodeexporter and cAdvisor work
Since nodeexorter cAdvisor are http servers, lets poll like this:
```
$ docker exec -it prometheus sh
      $ wget -qO- nodeexporter:9100/metrics
      $ wget -qO- cadvisor:8080/metrics
      $ exit
```



###### Check prometheus works
https://prometheus.io/docs/guides/node-exporter/#exploring-node-exporter-metrics-through-the-prometheus-expression-browser

- browser: localhost:9090/graph
- Expression bar: node_uname_info
- Click execute and will get something back

Other expressions:
    - rate(node_cpu_seconds_total{mode="system"}[1m])
    - checkout what 'wget -qO- cadvisor:8080/metrics' returns



### Grafana dashboards



###### For node-exporter




These look ok:
* https://grafana.com/grafana/dashboards/11074 (1 Node Exporter for Prometheus Dashboard EN v20201010)
* https://grafana.com/grafana/dashboards/10180 (Linux Hosts Metrics | Base)
* https://grafana.com/grafana/dashboards/1860 (Prometheus Node Exporter Full)




These suxx:
* https://grafana.com/grafana/dashboards/405 (Node Exporter Server Metrics)
* https://grafana.com/grafana/dashboards/10242 (Node Exporter Full with Node Name)
* https://grafana.com/grafana/dashboards/10566 (Docker and OS metrics ( cadvisor, node_exporter ))
* https://grafana.com/grafana/dashboards/179 (Docker and Host Monitoring w/ Prometheus)

