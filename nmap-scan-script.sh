#!/bin/bash

read -p 'Enter the name of the folder for these to be stored: ' folder

mkdir $folder
cd $folder

read -p 'Enter the IP address: ' ip
read -p 'Scan the entire subnet as well (y/n)? ' response

if [ "$response" = "y" ] ; then
	echo 'The CIDR mask /24 will be used for the subnet scans'

	echo 'Initiating subnet ping scan...'
	nmap -sn -oX $ip-subnet-ping-scan $ip\/24 &

	echo 'Initiating subnet ICS scan...'
	nmap -sT -sU -sV -p U:47808-47810,T:21-25,80,443,445,502-509,1911,3011,4011,4911,8080 -v -Pn --script banner -O -oX $ip-subnet-ICS-scan $ip\/24 &

fi

echo 'Intiating BACnet interrogation...'
nmap -sU -p 47808 -v -Pn --script bacnet-info -oX $ip-BACnet-interrogation $ip &

echo 'Intiating ICS device port scan...'
nmap -sT -sU -sV -p U:47808-47810,T:21-25,80,443,445,502-509,1911,3011,4011,4911,8080 -v -Pn --script banner -O -oX $ip-ICS-port-scan $ip

exit 0
