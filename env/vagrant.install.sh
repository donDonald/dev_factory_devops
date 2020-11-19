#!/bin/bash

# Vagrant boxes, i.e. virtual machines like ubuntu, centos, etc.
# https://app.vagrantup.com/boxes/search
#
# To quckly start ubuntu2004 vm do this:
#     $ vagrant init generic/ubuntu2004
#     $ vagrant up --provider libvirt
#
# Commands:
#     To list|add|remove a box:
#             $ vagrant box list
#             $ vagrant box add generic/ubuntu2004 --provider libvirt
#             $ vagrant box remove <box name>
#     To startup VM (using virtualbox):
#             $ vagrant up
#     To startup VM (using libvirt/KVM):
#             $ vagrant up --provider libvirt
#     To shutdown VM:
#             $ vagrant halt
#     To startup collect VM status:
#             $ vagrant status
#     To ssh into VM:
#             $ vagrant ssh
#     To setup machine upon config chabges:
#             $ vagrant provision
#     To make/push snapshot:
#             $ vagrant snapshot push
#     To load/pop snapshot:
#             $ vagrant snapshot pop
#     To list machines:
#             $ virsh list
#
# Docs:
#     https://ostechnix.com/how-to-use-vagrant-with-libvirt-kvm-provider/
#     https://linuxize.com/post/how-to-install-vagrant-on-ubuntu-18-04/
#     https://linuxize.com/post/how-to-install-vagrant-on-ubuntu-20-04/
#     https://github.com/vagrant-libvirt/vagrant-libvirt
#     https://www.vagrantup.com/docs/vagrantfile
#     https://www.vagrantup.com/docs/networking
#
# Notes:
#     - Here virsh tool which can also manage VMs and domains
#     - virt-manager - UI tool for managing VMs
#
# HowTos:
#     - to setup VM hostname: https://www.vagrantup.com/docs/vagrantfile/machine_settings#config-vm-hostname
#     - to update host's /etc/hosts:
#           - vagrant plugin install vagrant-hostsupdater
#           - https://github.com/agiledivider/vagrant-hostsupdater
#     - To define many VMs with single Vagrantfile: https://www.vagrantup.com/docs/multi-machine

C_LOG_PREFIX="$C_LOG_PREFIX.vagrant"
echo "$C_LOG_PREFIX: Installing vagrant..."

VAGRANT_VERSION=2.2.13
PACKAGE_NAME="vagrant_${VAGRANT_VERSION##v}_x86_64.deb"
URL_PREFIX="releases.hashicorp.com/vagrant/${VAGRANT_VERSION##v}"

echo "$C_LOG_PREFIX: Installing dependencies..." \
 && apt update \
 && apt install -y \
        bridge-utils \
        cpu-checker \
        libguestfs-tools \
        libvirt-clients \
        libvirt-daemon-system \
        libvirt-dev \
        qemu-kvm \
        virt-manager \
 && echo "$C_LOG_PREFIX: Installing vagrant itself..." \
 && pushd /tmp \
 && curl -sOL https://$URL_PREFIX/$PACKAGE_NAME \
 && apt install -y ./$PACKAGE_NAME \
 && popd \
 && echo "$C_LOG_PREFIX: Installing vagrant libvirt plugin..." \
 && vagrant plugin install vagrant-libvirt \
 && echo "$C_LOG_PREFIX: Installing vagrant hostsupdater plugin for updating /etc/hosts..." \
 && vagrant plugin install vagrant-hostsupdater \
 && echo "$C_LOG_PREFIX: !!!!!! Adding user to libvirt group to avoid using sudo !!!!!!" \
 && usermod -a -G libvirt $(whoami) \
 && echo "$C_LOG_PREFIX: !!!!!! Gropus have changed, dont forget to logout-login !!!!!!"

echo "$C_LOG_PREFIX: Installing vagrant version $(vagrant -v) is complete"



# https://joachim8675309.medium.com/devops-box-vagrant-with-kvm-d7344e79322c
#   LATEST_VAGRANT=$(
#     curl -s https://github.com/hashicorp/vagrant/releases.atom | \
#      xml2 | grep -oP '(?<=feed/entry/title=).*' | sort -V | tail -1
#   )

#   PACKAGE_NAME="vagrant_${LATEST_VAGRANT##v}_x86_64.deb"
#   URL_PREFIX="releases.hashicorp.com/vagrant/${LATEST_VAGRANT##v}"

#   pushd ~/Downloads
#   curl -sOL https://$URL_PREFIX/$PACKAGE_NAME
#   sudo apt install ./$PACKAGE_NAME
#   popd

# https://releases.hashicorp.com/vagrant/2.2.13/vagrant_2.2.13_x86_64.deb
#   curl -O https://releases.hashicorp.com/vagrant/2.2.13/vagrant_2.2.13_x86_64.deb
#   apt install ./vagrant_2.2.13_x86_64.deb

