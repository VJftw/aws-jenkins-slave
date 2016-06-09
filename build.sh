#!/bin/bash
# Base AMI: ami-f95ef58a (Standard Ubuntu 14.04)
# - Remote user: ubuntu
# - Remote FS root: /var/jenkins
# - Spot instance: true

sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates

echo "--> Setting up Docker repository"
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee -a /etc/apt/sources.list.d/docker.list

echo "--> Installing Docker, Python, Java, Git, pv"
sudo apt-get -y update
sudo apt-get install -y \
    linux-image-extra-$(uname -r) \
    docker-engine \
    openjdk-7-jdk \
    git \
    python3 \
    python3-dev \
    pv \
    curl

echo "--> Adding user to Docker group"
sudo groupadd docker
sudo usermod -aG docker ubuntu

echo "--> Installing pip, invoke, docker-py, invoke-docker-flow"
sudo curl -O https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo pip install \
    invoke \
    docker-py \
    invoke-docker-flow

echo "--> Starting Docker"
sudo service docker start

echo ""
echo "--> Creating Jenkins Workspace"
echo ""
sudo mkdir -p /var/jenkins
sudo chown -R ubuntu:ubuntu /var/jenkins
sudo chmod -R 770 /var/jenkins


echo ""
echo "Installing AWS CLI"
echo ""
sudo pip install --upgrade awscli

echo ""
echo "Getting Current Instance ID"
echo ""
instance_id=`curl http://169.254.169.254/latest/meta-data/instance-id`

DATE=`date +%Y-%m-%d`
ami_name="jenkins-slave_$DATE"

echo ""
echo "Creating $ami_name from $instance_id"
echo ""
aws ec2 create-image --no-reboot --instance-id $instance_id --name $ami_name

echo ""
echo "--> Done!"
echo ""
