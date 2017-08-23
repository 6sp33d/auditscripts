#!/bin/bash

#Execute up to 4 parallel nmap scans
#2 of the scans are subnet-wide: a ping scan and an ICS scan to look for potential ICS devices
#The other 2 scans target a specific IP to get as much information from it as possible
#This scan assumes the BACnet protocol is the primary target, but that can be modified as needed


#create a folder to store the XML scan results
read -p 'Enter the name of the folder for these to be stored: ' folder

mkdir $folder
cd $folder

#ask for IP and determine if the target is just an address or also a subnet
read -p 'Enter the IP address: ' ip
read -p 'Scan the entire subnet as well (y/n)? ' response

#if requested, carry out the 2 subnet scans
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

exit $?
