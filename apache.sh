#!/bin/bash

# AUTHOR: Robertson Mengata
# DATE: June 2022
# This apache installation script is intended to be run on a Centos OS.
#  Please install a Centos VM first before running this script on it.
# _________________ APACHE AUTOMATED INSTALLATION ____________________

echo "Welcome to the Automated Apache Installation"
sleep 1

sudo yum install httpd -y
if [ $? -eq 0 ]
then
echo "Appache Package successfully installed"
else
echo "Appache Package installation failed. Please read the error message"
exit 2
fi
clear

echo "Please wait ..."
sudo systemctl start httpd
sudo systemctl enable httpd
if [ $? -ne 0 ]
then
echo "httpd installation failed. Please read the error message."
exit 6
fi
sudo systemctl status httpd
sleep 1
clear

sudo touch /var/www/html/index.html
sudo chmod 766 /var/www/html/index.html
echo "Please enter a content to display on your Web browser"
read content

echo "<h1> ${content} </h1>" >> /var/www/html/index.html
if [ $? -ne 0 ]
then
echo "Your Web browser configuration has failed. Please read the error message."
exit 9
fi 
clear

sudo yum install net-tools -y
if [ $? -ne 0 ]
then
echo "Net-tools installation failed"
exit 5
fi
clear

ifconfig
echo "Please retrieve your IP address from eth1.
Open a browser and enter the IP address to test"
sleep 1
echo "Apache successfully installed - Thank you"
