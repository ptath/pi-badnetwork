#!/bin/bash

# Version 0.1
# By ptath (https://ptath.ru)
# badnetwork installation script

# Checking ~/scripts folder
[ ! -d ~/scripts ] && mkdir ~/scripts
[ -e ~/scripts/badnetwork.sh ] &&
  echo " Script already installed (~/scripts/badnetwork.sh)?" &&
  echo " Remove it manually (rm ~/scripts/badnetwork.sh) and run again to reinstall" &&
  exit

# Downloading script and badnetwork.service file
echo " Downloading script to ~/scripts/badnetwork.sh..."
wget -q -N -O ~/scripts/badnetwork.sh https://github.com/ptath/pi-badnetwork/raw/master/scripts/badnetwork.sh
echo " Making it executable..."
chmod +x ~/scripts/badnetwork.sh
echo " Done!"

# Installing badnetwork.sh as systemd service
read -n 1 -p " Install script as systemd service? (Y/n): " choice
case $choice in
  y|Y )
    echo " Yes"
    [ -e /lib/systemd/system/badnetwork.service ] && echo " Badnetwork service exists (/lib/systemd/system/badnetwork.service)? Exiting..." && exit
    wget -q -N -O /tmp/badnetwork.service https://github.com/ptath/pi-badnetwork/raw/master/badnetwork.service
    sudo mv /tmp/badnetwork.service /lib/systemd/system/badnetwork.service
    sudo chmod 644 /lib/systemd/system/badnetwork.service
    sudo systemctl daemon-reload
    sudo systemctl enable badnetwork.service
    echo " Will reboot in 10 sec, press CTRL+C to abort..."
    sleep 10
    sudo reboot now
    ;;
  n|N|* )
    echo " No"
    echo " You can run script manually (~/scripts/badnetwork.sh)"
    exit
    ;;
esac
