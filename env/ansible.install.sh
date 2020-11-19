#!/bin/bash

C_LOG_PREFIX="$C_LOG_PREFIX.ansible"
echo "$C_LOG_PREFIX: Installing ansible..."

apt update \
 && apt install -y ansible

# I'm getting "The repository 'http://ppa.launchpad.net/ansible/ansible/ubuntu focal Release' does not have a Release file." with this setup
#   apt update \
#    && apt install -y software-properties-common \
#    && apt-add-repository --yes --update ppa:ansible/ansible \
#    && apt install -y ansible

echo "$C_LOG_PREFIX: Installing ansible version $(ansible --version) is complete"

