
### Intro
    Manuals on prometheus, grafana and exporters(nodeexporter + cadvisor) setup
    Everything will run using docker-compose



### Clone repo
```
$ git clone https://github.com/donDonald/dockprom.git
$ cd dockprom
$ git checkout movi9ng-to-host-hetwork-mode
```



### Setup exporters(nodeexporter and cadvisor)
```
$ docker-compose -f ./docker-compose.exporters.yml up -d --build --force-recreate
Creating nodeexporter ... done
Creating cadvisor     ... done

$ docker-compose -f ./docker-compose.exporters.yml ps
    Name                  Command                  State       Ports
--------------------------------------------------------------------
cadvisor       /usr/bin/cadvisor -logtostderr   Up (healthy)        
nodeexporter   /bin/node_exporter --path. ...   Up                  

$ docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED              STATUS                        PORTS     NAMES
8e909f48ccd2   gcr.io/cadvisor/cadvisor:v0.38.6   "/usr/bin/cadvisor -…"   About a minute ago   Up About a minute (healthy)             cadvisor
ecc4aa7d4741   prom/node-exporter:v1.0.1          "/bin/node_exporter …"   About a minute ago   Up About a minute                       nodeexporter
```



###### Check exporters work
    Since every exporter is http server, simply poll it like this:
```
    $ curl localhost:9100/metrics
    $ curl localhost:8080/metrics
```



### Setup prometheus, grafana and the rest
```
$ docker-compose -f ./docker-compose.prometheus.host-net.yml up -d --build --force-recreate
...
Creating grafana    ... done
Creating prometheus ... done

$ docker-compose -f ./docker-compose.prometheus.host-net.yml ps
   Name                 Command               State   Ports
-----------------------------------------------------------
grafana      /run.sh                          Up           
prometheus   /bin/prometheus --config.f ...   Up           

$ docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED              STATUS                    PORTS     NAMES
296456bd5e61   prom/prometheus:v2.24.0            "/bin/prometheus --c…"   About a minute ago   Up 59 seconds                       prometheus
4a55fc7a4a38   grafana/grafana:7.3.6              "/run.sh"                About a minute ago   Up 59 seconds                       grafana
8e909f48ccd2   gcr.io/cadvisor/cadvisor:v0.38.6   "/usr/bin/cadvisor -…"   10 minutes ago       Up 10 minutes (healthy)             cadvisor
ecc4aa7d4741   prom/node-exporter:v1.0.1          "/bin/node_exporter …"   10 minutes ago       Up 10 minutes                       nodeexporter

$ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
4f29fe6cf5ec   bridge    bridge    local
cd76f883677e   host      host      local
6ba5f58b1408   none      null      local

$ docker network inspect host
[
    {
        "Name": "host",
        "Id": "cd76f883677e869ac047d27dd16cee888f99e6072929f15096c439543b69e7d8",
        "Created": "2020-06-27T12:35:39.906740051+03:00",
        "Scope": "local",
        "Driver": "host",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": []
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "296456bd5e61e6917b9a3f46615abdd191daf57b3df128dbb33c0cc827105e08": {
                "Name": "prometheus",
                "EndpointID": "b524aaacec5bd1f6d4f949d402ba38040be6519041ead450cb90c3af9cb1dade",
                "MacAddress": "",
                "IPv4Address": "",
                "IPv6Address": ""
            },
            "4a55fc7a4a380cc7f98aaa48799e222cd10c1ad2d9a01a0314deb008158173ec": {
                "Name": "grafana",
                "EndpointID": "b19d33efb7d02640b5059aa20976bc13e56ac0ddba0c01d584db92e13df5517a",
                "MacAddress": "",
                "IPv4Address": "",
                "IPv6Address": ""
            },
            "8e909f48ccd29703163dccb4758573c23a426c1ce4b7de44a51b63433bcb5dc5": {
                "Name": "cadvisor",
                "EndpointID": "fb28d4df4ea01f843b62782696a0caa023a3de598d8d2c96364a2a55d55f54c2",
                "MacAddress": "",
                "IPv4Address": "",
                "IPv6Address": ""
            },
            "ecc4aa7d47410fc898613e296b4f029448200e7debc098e25ee5c6acb398cf1b": {
                "Name": "nodeexporter",
                "EndpointID": "c89d6b398c9048a25352b89db6a5648e25b32579b000226fa9f2c337b3de8593",
                "MacAddress": "",
                "IPv4Address": "",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
```



###### Check prometheus works
https://prometheus.io/docs/guides/node-exporter/#exploring-node-exporter-metrics-through-the-prometheus-expression-browser

- browser: http://localhost:9090/graph
- Expression bar: node_uname_info
- Click execute and will get something back

Other expressions:
    - rate(node_cpu_seconds_total{mode="system"}[1m])
    - checkout what 'wget -qO- cadvisor:8080/metrics' returns



###### Check grafana works
- browser: http://localhost:3000



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

