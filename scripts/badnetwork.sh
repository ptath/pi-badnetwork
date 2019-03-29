#!/bin/bash

# Version 0.2
# By ptath (https://ptath.ru)
# Raspberry Pi badnetwork script
# Edit values below to fit your needs. Also check network_up function!!!

# Set your router ip address
ROUTER_IP=192.168.1.1
PING_INTERVAL="120" # Polling time in seconds (default 120)
network_up() {
  echo "Network is up againg"
  # You should put your own command, there are examples below:
  #sudo reboot now
  #sudo systemctl restart nodered.service
  #pm2 restart homebridge
}
# Stop editing

# File to store state
TMP_FILE=/tmp/chck_network
# Initial state is OK
echo 1 > $TMP_FILE

ping_action() {
  ping -c4 "$ROUTER_IP" > /dev/null
}

ping_ok() {
  # echo "Ping OK, debug line"
  # If network was down but restored, run network_up
  [[ `cat $TMP_FILE` == 0 ]] && network_up
  # Store state
  echo 1 > $TMP_FILE
}

ping_error() {
  # What to do if ping failed?
  echo "Ping ERROR"
  # Store state
  echo 0 > $TMP_FILE
}

# Loop till Ctrl-C (forever for daemon)
while [ 1 ]
do
  ping_action && ping_ok || ping_error
  sleep "$PING_INTERVAL"
done
