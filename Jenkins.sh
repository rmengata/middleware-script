#!/bin/bash

# Author: Robertson Mengata
# Date: June 2022
# This is an automaded Jenkins installation with exit codes to ensure an errorless installation. 
# You need to create a personalized VM first and then run this script to install the latest Jenkins on it.

# _____________________________Jenkins Automated Installation _________________________

echo "Welcome to the Jenkins Automated Installation"
echo "Please wait ..."
sleep 1

# Java installation process
sudo yum install java-1.8.0-openjdk-devel -y
if [ $? -eq 0 ]
then 
echo "Java Installation in process. Please wait ..."
else
echo "Installation failed! Please read error message"
exit 3
fi

# Enabling the Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
if [ $? -eq 0 ]
then
sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
else
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
fi 
clear

# Installing the latest stable version of Jenkins
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins
if [ $? -eq 0 ]
then
echo "Jenkins successfully installed and enabled"
else
echo "Jenkins installation failed. Please read the error message"
exit 4
fi

# Adjusting the firewall
sudo systemctl restart firewalld
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload
if [ $? -eq 0 ]
then
echo "Firewall successfully adjusted"
else
echo "Firewall adjustment failed. Please read the error message"
exit 5
fi
sudo systemctl status firewalld

# Installing net-tools
sudo yum install net-tools -y
if [ $? -eq 0 ]
then
echo "Net-tools successfully installed"
else
echo "Net-tools installation failed. Please read the error messsage"
exit 6
fi
clear

# Displaying the IP address
ifconfig
echo "Please write down the IP address from the eth1"
sleep 20
clear

# Setting up Jenkins in the browser
echo "Launch your google chrome browser an type the IP address you got from previous step followed by the port number 8080
For example 192.168.58.18:8080"
sleep 20
clear

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "Copy the above password and paste it into the Administrator password field in the page you have in the browser. Then click on Continue"
echo "Click on INSTALL SUGGESTED PLUGINS"
echo "You can now finish the setting of Jenkins in your browser. Please enter your credentials when asked."
