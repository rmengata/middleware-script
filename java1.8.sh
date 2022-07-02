#!/bin/bash

# Author: Robertson Mengata
# Date: June 2022

# ______QA/UAT java1.8 app deployment

if [ $UID -ne 0 ]
then
echo "You need to be root to run this script!!"
exit 2
fi

## Make sure java is installed

echo "Installing java1.8 Please wait as this may take a while ..."
sleep 2
yum install java-1.8* -y
if [ $? -ne 0 ]
then
echo "Java installation failed. Please read the error message"
exit 3
fi

yum install wget unzip -y
if [ $? -ne 0 ]
then
echo "Installation failed. Please read the error message"
exit 4
fi

## Download the developer code
wget --user admin --password school1 http://96.126.114.68:8081/repository/ewr/bio/bio-2/v2/bio-2-v2-bio.jar
if [ $? -ne 0 ]
then
echo "Download failed. Please read the error message"
exit 5
fi
clear

# Get the IP address to test in a browser
echo "Please get the IP address from eth1. Open a browser and type the IP address followed by :8082"
sleep 2
ip a
sleep 20
clear
echo "When java1.8 starts running, please refresh your browser"
sleep 10

## Run the app
java -jar bio-2-v2-bio.jar
