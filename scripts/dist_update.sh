#!/bin/sh

export DEBIAN_FRONTEND="noninteractive"
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-get autoremove -y
