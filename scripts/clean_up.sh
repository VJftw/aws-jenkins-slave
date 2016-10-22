#!/bin/sh

sudo docker rm -v $(sudo docker ps -a -q)
sudo docker rmi -f $(sudo docker images -q)
sudo docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
