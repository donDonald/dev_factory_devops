#!/bin/bash

./docker.build.sh server server
docker tag server dondonald/devops-tsrc-example1-server:latest
docker push dondonald/devops-tsrc-example1-server:latest

./docker.build.sh exporter exporter
docker tag exporter dondonald/devops-tsrc-example1-exporter:latest
docker push dondonald/devops-tsrc-example1-exporter:latest

