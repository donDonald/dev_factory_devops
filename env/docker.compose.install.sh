#!/bin/bash

C_LOG_PREFIX="$C_LOG_PREFIX.docker-compose"
echo "$C_LOG_PREFIX: Installing docker-compose..."

INSTALLED=$(which docker-compose | wc -l)

#if [ "$INSTALLED" -gt "2" ]; then
if [ "$INSTALLED" -gt "0" ]; then
    echo "$C_LOG_PREFIX: docker-compose already installed, exit."
else
    # https://github.com/docker/compose/releases
    # https://docs.docker.com/compose/compose-file/compose-versioning/
    COMPOSE_VERSION="1.25.5"
    LINK="https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)"
    echo "$C_LOG_PREFIX: Download link:$LINK"

    curl -kL "$LINK" -o /usr/local/bin/docker-compose \
      && chmod 755 /usr/local/bin/docker-compose \
      && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    echo "$C_LOG_PREFIX: Installing docker-compose is complete, version: $(docker-compose --version)"
fi

