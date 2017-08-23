#!/bin/bash

#This script lets you monitor the amount of traffic coming into and going out of a chosen network interface. 

echo "iptables Traffic Accountability
"

#select what you'd like to do

echo "What would you like to do?"
echo "1) Clear counters and begin measuring traffic"
echo "2) View Traffic"
echo "0) Exit"
read -p 'Please choose an option: ' selection
echo ""

if [ $selection = 1 ] ; then
	adapters=()
	
	#locate all ethernet adapters that are currently up and add their names to an array
	for eth in $(ip a | grep -E ': eth.:.*state UP' | grep -oP 'eth.{0,1}'); do
		adapters+=($eth)
	done

	#locate all wireless adapters that are currently up and add their names to an array
	for wlan in $(ip a | grep -E ': wlan.:.*state UP' | grep -oP 'wlan.{0,1}'); do
		adapters+=("$wlan")
	done

	#iterate through the array and print the found adapters as options from which to select
	for i in ${!adapters[@]}; do
		printf '%s\n' "$i) ${adapters[$i]}"
	done

	read -p "Please select the adapter you wish to monitor: " mon

	#once an adapter is selected, locate that adapter and get its IPv4 address
	ip="$(ip a | grep -A3 ${adapters[$mon]} | grep 'inet' | cut -d" " -f6 | cut -d"/" -f1 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"

	echo ""
	echo 'Your IP address for adapter' ${adapters[$mon]} 'is' $ip
	
	#reset all counters and iptables rules
	iptables -Z && iptables -F
	#measure incoming traffic to selected network adapter
	iptables -I INPUT 1 -s $ip -j ACCEPT
	#measure outgoing traffic to selected network adapter
	iptables -I OUTPUT 1 -d $ip -j ACCEPT
fi

if [ $selection = 2 ] ; then
	#display INPUT and OUTPUT chains and their associate traffic quantities
	iptables -vn -L INPUT
	iptables -vn -L OUTPUT
fi

if [ $selection = 0 ] ; then
	#quit
	exit 0
fi
