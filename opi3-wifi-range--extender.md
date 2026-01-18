# Orangepi 3 LTS Wifi Range Extender

Below is a **practical, production-grade method** to turn an **Orange Pi 3 LTS** into a **Wi-Fi range extender / repeater** using an **external Alfa Network USB adapter**. This approach is stable, flexible, and appropriate for real deployments.

---

## Architecture Overview (Recommended)

You will use **two wireless interfaces**:

* **Internal Wi-Fi (wlan0)** → *Client mode* (connects to existing Wi-Fi)
* **Alfa USB adapter (wlan1)** → *Access Point mode* (rebroadcasts Wi-Fi)

Traffic is forwarded using **NAT + DHCP**.

```
[ Main Router ] <---> wlan0 (client)
                          |
                     Orange Pi 3 LTS
                          |
                   wlan1 (AP - Alfa)
                          |
                 [ Extended Wi-Fi Clients ]
```

This avoids the instability of single-interface repeating.

---

## Prerequisites

### Hardware

* Orange Pi 3 LTS
* Alfa Network USB adapter (RTL8812AU / RTL8814AU recommended)
* Quality power supply (5V 3A minimum)

### Software

* **Armbian (Debian-based)** recommended
* Internet access for package installation

---

## Step 1: Update System

```bash
sudo apt update && sudo apt upgrade -y
sudo reboot
```

---

## Step 2: Verify Wireless Interfaces

Plug in the Alfa adapter and confirm interfaces:

```bash
ip link
```

Expected:

* `wlan0` → internal Wi-Fi
* `wlan1` → Alfa adapter

If `wlan1` does not appear, install Alfa drivers (often required).

---

## Step 3: Install Required Packages

```bash
sudo apt install -y hostapd dnsmasq iptables-persistent
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq
```

---

## Step 4: Configure Client Wi-Fi (wlan0)

Edit `/etc/network/interfaces` **or** use NetworkManager.

### Example using `wpa_supplicant`:

```bash
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```

```ini
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid="MainWiFi"
    psk="MainWiFiPassword"
}
```

Enable and connect:

```bash
sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
sudo dhclient wlan0
```

Verify connectivity:

```bash
ping -c 3 8.8.8.8
```

---

## Step 5: Assign Static IP to AP Interface (wlan1)

```bash
sudo nano /etc/network/interfaces
```

Add:

```ini
auto wlan1
iface wlan1 inet static
    address 192.168.50.1
    netmask 255.255.255.0
```

Restart networking:

```bash
sudo systemctl restart networking
```

---

## Step 6: Configure hostapd (Access Point)

```bash
sudo nano /etc/hostapd/hostapd.conf
```

```ini
interface=wlan1
driver=nl80211
ssid=OrangePi_Extender
hw_mode=g
channel=6
ieee80211n=1
wmm_enabled=1
country_code=US

auth_algs=1
wpa=2
wpa_passphrase=StrongPassword123
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
```

Tell hostapd where config is:

```bash
sudo nano /etc/default/hostapd
```

```ini
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```

---

## Step 7: Configure dnsmasq (DHCP)

Backup original config:

```bash
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
```

Create new config:

```bash
sudo nano /etc/dnsmasq.conf
```

```ini
interface=wlan1
dhcp-range=192.168.50.10,192.168.50.100,12h
domain-needed
bogus-priv
```

---

## Step 8: Enable IP Forwarding

```bash
sudo nano /etc/sysctl.conf
```

Uncomment or add:

```ini
net.ipv4.ip_forward=1
```

Apply:

```bash
sudo sysctl -p
```

---

## Step 9: Configure NAT (iptables)

```bash
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan1 -o wlan0 -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT
```

Save rules:

```bash
sudo netfilter-persistent save
```

---

## Step 10: Start Services

```bash
sudo systemctl start hostapd
sudo systemctl start dnsmasq
sudo systemctl enable hostapd
sudo systemctl enable dnsmasq
```

---

## Step 11: Test the Extender

1. Connect a phone or laptop to **OrangePi_Extender**
2. Confirm:

   * You receive an IP in `192.168.50.x`
   * Internet access works
3. Test signal strength improvement

---

## Alfa Adapter Optimization (Optional but Recommended)

For high-power Alfa adapters:

```bash
sudo iw dev wlan1 set txpower fixed 3000
```

(Ensure local regulations allow this.)

---

## Common Issues & Fixes

### hostapd fails to start

```bash
journalctl -u hostapd
```

* Ensure Alfa driver supports **AP mode**
* Many Alfa adapters require **out-of-tree drivers**

### Slow speeds

* Use **5GHz Alfa adapter**
* Change AP channel to avoid interference
* Disable power saving:

```bash
iw dev wlan1 set power_save off
```

---

## Alternative (Advanced): True Bridge Mode

True Layer-2 bridging (same subnet as main router) is **not recommended** on Wi-Fi due to driver limitations. NAT mode above is **far more stable**.

---

## Summary

This setup gives you:

* Reliable Wi-Fi extension
* Strong Alfa transmission power
* Isolated AP subnet
* Minimal packet loss

