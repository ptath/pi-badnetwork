# pi-badnetwork
Script to check network connection (and reboot Pi/specified service when it up).

Initially made for restart Homebridge when Wi-Fi restarts or connection lost, because it this situation iOS Home app stops working. Same problem exists with any hap-nodejs service.

## Installation
One-line script:

```
wget -q -N -O /tmp/pi-badnetwork-install.sh https://github.com/ptath/pi-badnetwork/raw/master/pi-badnetwork-install.sh && chmod +x /tmp/pi-badnetwork-install.sh && /tmp/pi-badnetwork-install.sh
```

## Configuration
Important! You *should* configure script `nano ~/scripts/badnetwork.sh` and set your parameters:
```
ROUTER_IP=192.168.1.1 # Your router IP address
PING_INTERVAL="120" # Polling time in seconds (default 120)
network_up() {
  echo "Network is up againg"
  # You should put your own command HERE, there are examples below:
  #sudo reboot now
  #sudo systemctl restart nodered.service
  #pm2 restart homebridge
  # Uncomment or remove sample commands or add your own
}
```
Then restart service `sudo systemctl restart badnetwork.service` or reboot.
