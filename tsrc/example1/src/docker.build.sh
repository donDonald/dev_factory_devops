#!/bin/bash

CONTAINER_NAME=$1
FOLDER=$2

if [ -z $CONTAINER_NAME ]; then
    echo "Where is CONTAINER_NAME dude? Exiting" 1>&2
    exit
fi

if [ -z $FOLDER ]; then
    echo "Where is FOLDER dude? Exiting" 1>&2
    exit
fi

pushd $FOLDER
docker build -t $CONTAINER_NAME -f ./Dockerfile .
popd

#To authenticate: docker login
#To tag: $docker tag <image id reported by docker images> <user>/<repo>:<tag to assign>
#To push: $docker push <user>/<repo>:<tag>

#Example:
#    docker tag <image id by docker images> dondonald/goood:first
#    docker push dondonald/goood:first

