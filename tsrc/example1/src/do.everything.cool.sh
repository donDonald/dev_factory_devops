#!/bin/bash

./docker.build.sh server server
docker tag server dregistry:5000/server:latest
docker push dregistry:5000/server:latest

./docker.build.sh exporter exporter
docker tag exporter dregistry:5000/exporter:latest
docker push dregistry:5000/exporter:latest

