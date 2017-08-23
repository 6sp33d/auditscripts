#!/bin/sh

#Present a popup asking if I want to connect to a VPN after either an ethernet or wlan connection comes up

wlanState=$(ip a | grep -E ': wlan.:.*state UP' | grep -Eo 'state UP')
ethState=$(ip a | grep -E ': eth.:.*state UP' | grep -Eo 'state UP')

#check to see if the VPN is up; exit if so
if ifconfig tun0 | grep -q "00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00"; then
	exit 0
elif [ "$wlanState" = "state UP" ] || [ "$ethState" = "state UP" ] ; then

	#this was the test to make this dynamic and pull the DISPLAY variable, but I couldn't make it work
	#display=$(sudo env | grep DISPLAY)
	#sudo "$display" zenity --question --text="Connect to VPN?" 
	
	#sleep if you want to
	#sleep 10

	#display Zenity popup on primary display
	sudo DISPLAY=:1 zenity --question --text="Connect to VPN?" 

	#check the value of $?, which is default to 0
	#if anything goes wrong and popup doesn't show, it won't connect
	#if yes, connect; if no, exit
	if [ $? = 0 ]; then
		exec /usr/bin/nmcli con up 'Private Internet Access'
	else
		exit 0
	fi

fi

exit 0
