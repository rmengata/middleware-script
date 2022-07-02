#!/bin/bash
# AUTHOR: Robertson Mengata
# DATE: June 2022
## This script performs a full system inventory and provides a file that contains the inventory report.

# -------------------------------------- System inventory ----------------------------------------------

echo "Welcome to the automated system inventory"
sleep 1
echo "Please enter a name for your system inventory file"
read name


touch /home/$(whoami)/${name}
echo "       ----------------------------------------------
$(date)" >> /home/$(whoami)/${name}

echo "       ----------------------------------------------
CPU INVENTORY" >> /home/$(whoami)/${name}
lscpu >> /home/$(whoami)/${name}

echo "       ----------------------------------------------
MEMORY INVENTORY" >> /home/$(whoami)/${name}
free -m >> /home/$(whoami)/${name}

echo "       ----------------------------------------------
HARD DRIVE INVENTORY" >> /home/$(whoami)/${name}
lsblk >> /home/$(whoami)/${name}

echo "       ----------------------------------------------
OS-INVENTORY" >> /home/$(whoami)/${name}
cat /etc/os-release >> /home/$(whoami)/${name}

echo "       ----------------------------------------------
KERNEL INVENTORY" >> /home/$(whoami)/${name}
uname -m >> /home/$(whoami)/${name}

echo "       ----------------------------------------------
END OF INVENTORY - THANK YOU!" >> /home/$(whoami)/${name}
clear

echo "Your system inventory file named - ${name} - is ready and can be found in /home/$(whoami) directory"
