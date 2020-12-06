#!/bin/bash

CONTAINER_NAME=$1

if [ -z $CONTAINER_NAME ]; then
    echo "Where is CONTAINER_NAME dude? Exiting" 1>&2
    exit
fi

docker stop $CONTAINER_NAME
docker rm -f $CONTAINER_NAME

./docker.build.sh $CONTAINER_NAME

KEYS="-it"

docker run --name $CONTAINER_NAME --hostname $CONTAINER_NAME -p 3000:3000 $KEYS $CONTAINER_NAME

