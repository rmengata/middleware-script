#!/bin/bash

# Author: Benjamin Tagnan
# Date: June 2022
# This is an automated server installation using a personalized IP address.
# You can personalize the directory name if needed.

# _____________________________ Automated Server Installation _________________________

mkdir Server
cd Server
touch Vagrantfile

echo '# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # load de centos7 box from vagrant cloud
  config.vm.box = "utrains/centos7"
  config.vm.box_version = "5.0"
  config.vm.network "private_network", ip: "192.168.56.32"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    #vb.name = "centos-project3"
    vb.cpus = 2
  end
  #change the value of the SSH configuration file, then restart the ssh service
  config.vm.provision "shell", inline: <<-SHELL
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
   sudo systemctl restart sshd
  SHELL
end' >> Vagrantfile

vagrant up
vagrant ssh
# _________________unfinished script

echo "enter an IP4 number you would like your server to use"
read number

echo "#VAGRANT-BEGIN
# The contents below are automatically generated by Vagrant. Do not modify.
NM_CONTROLLED=yes
BOOTPROTO=none
ONBOOT=yes
IPADDR=$number
NETMASK=255.255.255.0
DEVICE=eth1
PEERDNS=no
#VAGRANT-END" > /etc/sysconfig/network-scripts/ifcfg-eth1

echo "Please wait ..."
sleep 10

sudo systemctl restart network

echo "Please wait ..."
sleep 10

sudo cat /etc/sysconfig/network-scripts/ifcfg-eth1
echo "Is your above IP4 address applied to this server?"
read answer

if [[ $answer = No || $answer = no ]]
then
echo "Please wait ..."
sleep 10

sudo systemctl restart network

echo "Please wait ..."
sleep 10

sudo cat /etc/sysconfig/network-scripts/ifcfg-eth1
else
echo "Please wait ..."
fi

vagrant ssh

 