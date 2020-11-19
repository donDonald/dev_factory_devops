#!/bin/bash

C_LOG_PREFIX="$C_LOG_PREFIX.ansible"
echo "$C_LOG_PREFIX: Uninstalling ansible..."

apt purge -y ansible

echo "$C_LOG_PREFIX: Uninstalling ansible is complete"

