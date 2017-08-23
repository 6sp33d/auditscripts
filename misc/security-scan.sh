#!/bin/bash
#Run a couple different rootkit scanners and output the results to the desktop

echo 'Does rkhunter need an update?
' > ~/Desktop/security-scan-log.txt

#check for updates and report it
exec /usr/bin/rkhunter --versioncheck >> ~/Desktop/security-scan-log.txt &
wait $!

echo '
Please proceed as you see fit based on the above information
' >> ~/Desktop/security-scan-log.txt

echo 'Here be the checksecurity log' >> ~/Desktop/security-scan-log.txt

echo '---------------------------------------------------------
' >> ~/Desktop/security-scan-log.txt

echo 'Checking security...
'

#run checksecurity
exec /usr/sbin/checksecurity >> ~/Desktop/security-scan-log.txt &
wait $!

echo '
And here be the rkhunter log' >> ~/Desktop/security-scan-log.txt

echo '---------------------------------------------------------
' >> ~/Desktop/security-scan-log.txt

echo 'Hunting for rookits...
'

#run RootKit Hunter with crazy hashing, only warning outputs, and no necessary keypresses
exec /usr/bin/rkhunter --hash SHA512 --rwo --sk --check >> ~/Desktop/security-scan-log.txt &
wait $!

echo '
And last, but certainly not least, here be the chkrootkit log' >> ~/Desktop/security-scan-log.txt

echo '---------------------------------------------------------
' >> ~/Desktop/security-scan-log.txt

echo 'Checking for rootkits...
'

#run chkrootkit
exec /usr/sbin/chkrootkit >> ~/Desktop/security-scan-log.txt &
wait $!

echo 'Done!'

exit 0
