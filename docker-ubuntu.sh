#!/bin/bash

# Author: Robertson Mengata 
# Date: June 2022

## This script is for installing Docker on Ubuntu (Jammy 22.04 (LTS), Impish 21.10, Focal 20.04 (LTS), or Bionic 18.04 (LTS))
## Docker is a containerization software used to create and manage containers. To use docker containers, you must first of all install Docker on your system.
## First, you need to boot up your Ubuntu server and connect remotely to it.

# _________________________________ Docker Installation _______________________________________________

# Cleaning up the system
echo "Welcome to Docker installation. Please wait ...."
sleep 2
sudo apt-get remove docker docker-engine docker.io containerd runc

# Setting up the docker repository
sudo apt-get update
sudo apt-get -y install     ca-certificates     curl     gnupg     lsb-release
if [ $? -ne 0 ]
then
echo "Docker installation failed. Please read the error message."
exit 1
fi

# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
if [ $? -ne 0 ]
then
echo "Docker installation failed. Please read the error message."
exit 2
fi

# Set up the repository
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  if [ $? -ne 0 ]
then
echo "Docker installation failed. Please read the error message."
exit 3
fi

# Install Docker Engine
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
if [ $? -ne 0 ]
then
echo "Docker installation failed. Please read the error message."
exit 4
fi
clear

# Verify that Docker Engine is installed correctly 
echo "Docker has been successfully installed. Below is your Welcome message."
sleep 2
clear
sudo docker run hello-world
