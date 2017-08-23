#!/bin/sh

#Configure all preferential settings after a fresh install of Kali

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')/ default-size-columns 120

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')/ default-size-rows 24

gsettings set org.gtk.Settings.FileChooser sort-directories-first true

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')/ default-size-columns 120

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')/ cursor-shape 'ibeam'

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')/ default-size-columns 120

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')/ foreground-color 'rgb(0,255,0)'

gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false

gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

gsettings set org.gnome.settings-daemon.peripherals.keyboard numlock-state 'on'

gsettings set org.gnome.settings-daemon.peripherals.keyboard remember-numlock-state true

macchanger -m 74:99:75:A5:6C:9B eth0
macchanger -m 74:99:75:A5:6C:9C wlan0

service postgresql start

update-rc.d postgresql enable

/usr/sbin/ufw enable

/usr/bin/pip install shodan

./VMware-Player-12.5.7-5813279.x86_64.bundle

rm VMware-Player-12.5.7-5813279.x86_64.bundle

#rm all-the-settings.sh
