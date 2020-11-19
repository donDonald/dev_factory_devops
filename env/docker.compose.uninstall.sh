#!/bin/bash

C_LOG_PREFIX="$C_LOG_PREFIX.docker-compose"
echo "$C_LOG_PREFIX: Uninstalling docker-compose..."

apt purge docker-compose* \
  && rm /usr/bin/docker-compose \
  && rm /usr/local/bin/docker-compose 

echo "$C_LOG_PREFIX: Uninstalling docker-compose is complete."

