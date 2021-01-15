#!/bin/bash

CONTAINER_NAME=$1

if [ -z $CONTAINER_NAME ]; then
    echo "Where is CONTAINER_NAME dude? Exiting" 1>&2
    exit
fi

docker build -t $CONTAINER_NAME -f ./Dockerfile .

#To authenticate: docker login
#To tag: $docker tag <image id reported by docker images> <user>/<repo>:<tag to assign>
#To push: $docker push <user>/<repo>:<tag>

#Example:
#    docker tag <image id by docker images> dondonald/goood:first
#    docker push dondonald/goood:first

