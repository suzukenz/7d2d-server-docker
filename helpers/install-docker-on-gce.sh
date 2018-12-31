#!/bin/bash
# setup the repository
sudo apt-get update
sudo apt-get install -y \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg2 \
   software-properties-common
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
# install docker
sudo apt-get update
sudo apt-get install -y docker-ce --allow-unauthenticated
# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" \
   -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
