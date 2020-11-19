#!/bin/bash

C_LOG_PREFIX="$C_LOG_PREFIX.docker"
echo "$C_LOG_PREFIX: Uninstalling docker..."

WHOAMI="${SUDO_USER:-${USER}}"

apt purge docker-ce* \
 && gpasswd -d "$WHOAMI" docker

echo "$C_LOG_PREFIX: Uninstalling docker is complete."

