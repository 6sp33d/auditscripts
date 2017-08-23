import sys
import subprocess

for i in range (1, 255):
	try:	
		ping = subprocess.check_output(['ping', '-c', '1', '10.11.1.' + str(i) + ' &'])

		pingsplit = ping.split("\n")
		seg_one = str(pingsplit[1]).split(" ")
		seg_two = str(seg_one[3]).split(':')[0]
		print seg_two

	except subprocess.CalledProcessError as e:
		output = e.output
