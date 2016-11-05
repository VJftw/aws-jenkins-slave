#!/bin/bash

export DEBIAN_FRONTEND="noninteractive"
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

# Docker PPA
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
if [ -f /etc/apt/sources.list.d/docker.list ]; then
    sudo rm /etc/apt/sources.list.d/docker.list
fi
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee -a /etc/apt/sources.list.d/docker.list

# Git PPA
sudo add-apt-repository ppa:git-core/ppa -y

sudo apt-get -y update
sudo apt-get install -y \
    linux-image-extra-$(uname -r) \
    docker-engine \
    openjdk-7-jdk \
    git \
    pv \
    curl

# Setup Docker group
sudo groupadd docker
sudo usermod -aG docker ubuntu

# Install build deps
sudo pip3 install --upgrade \
    docker-py \
    invoke-docker-flow \
    invoke-tools

# Restart Docker
sudo service docker restart
