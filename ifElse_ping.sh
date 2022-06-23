#!/bin/bash

    #Author : Robertson Mengata
    #Date : 01-June-2022

    #----------------------- Description ------------------------------
    # in this script we try to contact google, then we redirect the result of the ping command to the standard linux error output. 
    #Because it is the result of the command that interests us to do the test

HOST="google.com"
ping -c 1 $HOST >2    # -c is used for count, it will send the request, number of times mentioned

if [ "$?" -eq "0" ]
then
  echo "$HOST reachable"
else
  echo "$HOST unreachable"
fi
