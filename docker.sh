#!/bin/bash

# Author: Robertson Mengata 
# Date: June 2022

## This script is for installing Docker on Centos7
## Docker is a containerization software used to create and manage containers. To use docker containers, you must first of all install Docker on your system.
## First, you need to boot up a Centos 7 server and connect remotely to it.

# _________________________________ Docker Installation _______________________________________________

# Cleaning up the system
echo "Welcome to Docker installation. Please wait ...."
sleep 2
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

# Setting up the docker repository
sudo yum install -y yum-utils
if [ $? -ne 0 ]
then
echo "Docker installation failed. Please read the error message."
exit 1
fi
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
if [ $? -ne 0 ]
then
echo "Docker installation failed. Please read the error message."
exit 2
fi
# Installing the docker engine
sudo yum install docker-ce docker-ce-cli containerd.io
if [ $? -ne 0 ]
then
echo "Docker installation failed. Please read the error message."
exit 3
fi

# Checking the status, starting and enabling docker daemon
sudo systemctl status docker

sudo systemctl start docker
sudo systemctl enable docker
if [ $? -ne 0 ]
then
echo "Docker installation failed. Please read the error message."
exit 4
fi

sudo systemctl status docker
sleep 2
clear
echo " Docker has been successfully installed"
