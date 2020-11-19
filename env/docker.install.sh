#!/bin/bash

C_LOG_PREFIX="$C_LOG_PREFIX.docker"
echo "$C_LOG_PREFIX: Installing docker..."

INSTALLED=$(dpkg -l | grep -E '^ii' | grep docker | wc -l)

if [ "$INSTALLED" -gt "0" ]; then
    echo "$C_LOG_PREFIX: docker is already installed, exit."
else
    WHOAMI="${SUDO_USER:-${USER}}"
    LSB=$(lsb_release -cs)
    # https://docs.docker.com/develop/sdk/#api-version-matrix
    DOCKER_REPO="deb [arch=amd64] https://download.docker.com/linux/ubuntu $LSB stable"
    DOCKER_VERSION="19.03.12" # For Ubuntu 20.04
    #DOCKER_VERSION="19.03.8" # For Ubuntu 18.04
    # To check available versions
    #     $ apt-cache madison docker-ce
    #     $ apt-cache policy docker-ce

    echo "$C_LOG_PREFIX: docker repo:$DOCKER_REPO"
    echo "$C_LOG_PREFIX: docker version:$DOCKER_VERSION"

    apt update \
     && apt install -y apt-transport-https \
                         ca-certificates \
                         curl \
                         software-properties-common \
     && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
     && apt-key fingerprint 0EBFCD88 \
     && add-apt-repository "$DOCKER_REPO" \
     && apt update \
     && DOCKER_EXACT_VERSION=$(apt-cache madison docker-ce | grep $DOCKER_VERSION | awk '{print $3}') \
     && echo "$C_LOG_PREFIX: docker full version:$DOCKER_EXACT_VERSION" \
     && apt-cache policy docker-ce \
     && apt install -y docker-ce="$DOCKER_EXACT_VERSION" containerd.io \
     && echo "$C_LOG_PREFIX: !!!!!! Adding user to docker group to avoid using sudo !!!!!!" \
     && usermod -aG docker "$WHOAMI" \
     && echo "$C_LOG_PREFIX: !!!!!! Gropus have changed, dont forget to logout-login !!!!!!"

    echo "$C_LOG_PREFIX: Installing docker is complete, version: $(docker --version)."
    echo "$C_LOG_PREFIX: !Don't forget to logout and login!"
fi

