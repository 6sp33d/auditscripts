#!/bin/bash

#Download audit scripts to load into the ISO as it's built

cd /root/Documents/kali-live/live-build-config/config/includes.chroot/root/Desktop/

exec svn checkout https://github.com/flipflop1192/auditscripts/trunk/kali_iso_scripts/

exit $?
