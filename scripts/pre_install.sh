#!/bin/sh

export DEBIAN_FRONTEND="noninteractive"
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

sudo apt-get update -y
sudo apt-get install -y python3 python3-dev curl apt-transport-https ca-certificates

curl -O -L https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
rm get-pip.py*

sudo pip3 install --upgrade -r requirements.txt
