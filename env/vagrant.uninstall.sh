#!/bin/bash


C_LOG_PREFIX="$C_LOG_PREFIX.vagrant"
echo "$C_LOG_PREFIX: Uninstalling vagrant..."

rm -rf /opt/vagrant \
&& rm -f /usr/bin/vagrant \
&& apt purge -y vagrant
#&& sudo rm -rf ~/.vagrant.d

echo "$C_LOG_PREFIX: Uninstalling vagrant is complete."


