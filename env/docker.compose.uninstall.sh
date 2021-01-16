#!/bin/bash

C_LOG_PREFIX="$C_LOG_PREFIX.docker-compose"
echo "$C_LOG_PREFIX: Uninstalling docker-compose..."

rm -f /usr/bin/docker-compose \
  && rm -f /usr/local/bin/docker-compose \
  && apt-get purge docker-compose* \

echo "$C_LOG_PREFIX: Uninstalling docker-compose is complete."

