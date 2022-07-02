#!/bin/bash

# Author: Robertson Mengata 
# Date: June 2022

## This script is for installing and running SonarQube on java11

# _________________________________ SonarQube Installation _______________________________________________

if [ $UID -eq 0 ]
then 
echo "Please do not run this script as root. Switch to a regular user and try again!"
exit 2
else
echo "Please wait while SonarQube is installing ..."
fi

# Java 11 installation
sudo yum update -y
sudo yum install java-11-openjdk-devel -y 
sudo yum install java-11-openjdk -y
if [ $? -ne 0 ]
then
echo "java installation failed. Please read the error message."
exit 6
fi

# Download SonarQube latest versions
cd /opt  
sudo yum install wget -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip
if [ $? -ne 0 ]
then
echo "Installation failed. Please read the error message."
exit 7
fi

# Extract packages
sudo yum install unzip* -y
sudo unzip /opt/sonarqube-9.3.0.51899.zip
if [ $? -ne 0 ]
then
echo "Packages extraction failed. Please read the error message."
exit 8
fi

# Change ownership
sudo chown -R $(whoami):$(whoami) /opt/sonarqube-9.3.0.51899
if [ $? -ne 0 ]
then
echo "Failed to change ownership. Please read the error message."
exit 9
fi

# Start SonarQube
cd sonarqube-9.3.0.51899/bin/linux-x86-64/
./sonar.sh start
if [ $? -ne 0 ]
then
echo "Failed to start SonarQube. Please read the error message."
exit 10
fi

# Connect to SonaQube
clear
echo "Please get your IP address from eth1 below. Open a browser and enter the IP address followed by :9000"
sleep 5
ip a
sleep 20

echo "Is SonarQube starting? Please enter yes/no"
read answer
if [ ${answer} = yes ]
then 
echo "SonarQube Successfully Installed - Use your default credentials to access the page"
exit 3
else 
echo "Please wait ..."
fi

sudo firewall-cmd --permanent --add-port=9000/tcpcd 
sudo firewall-cmd --reload
if [ $? -eq 0 ]
then
echo "Please refresh your browser. SonarQube should be starting soon"
sleep 10
else
echo "SonarQube installation failed. Please read the error message"
fi
