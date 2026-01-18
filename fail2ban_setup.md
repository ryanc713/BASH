# Setup Fail2ban

Fail2Ban will monitor Apache logs for malicious behavior (e.g., repeated 404s, bots scanning sensitive paths, brute-force attempts) and automatically block abusive IPs with firewall rules.

---

## 1. Install Fail2Ban

```bash
sudo apt update
sudo apt install fail2ban -y
```

---

## 2. Basic Fail2Ban Setup

Copy the default config so updates don’t overwrite your changes:

```bash
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

---

## 3. Enable Apache Jails

Open `/etc/fail2ban/jail.local` and add/edit these sections:

```ini
[apache-auth]
enabled  = true
port     = http,https
filter   = apache-auth
logpath  = /var/log/apache2/error.log
maxretry = 3
bantime  = 3600
findtime = 600

[apache-badbots]
enabled  = true
port     = http,https
filter   = apache-badbots
logpath  = /var/log/apache2/access.log
maxretry = 2
bantime  = 86400
findtime = 3600

[apache-noscript]
enabled  = true
port     = http,https
filter   = apache-noscript
logpath  = /var/log/apache2/error.log
maxretry = 2
bantime  = 86400

[apache-overflows]
enabled  = true
port     = http,https
filter   = apache-overflows
logpath  = /var/log/apache2/error.log
maxretry = 2
bantime  = 86400

[apache-nohome]
enabled  = true
port     = http,https
filter   = apache-nohome
logpath  = /var/log/apache2/access.log
maxretry = 2
bantime  = 86400
```

---

## 4. Example Custom Filter for Sensitive Files

Create a new filter `/etc/fail2ban/filter.d/apache-sensitive.conf`:

```ini
[Definition]
failregex = ^<HOST> -.*"(GET|POST).* (wp-login\.php|xmlrpc\.php|\.env|\.git|/config|/phpmyadmin).*"
ignoreregex =
```

Enable it in `jail.local`:

```ini
[apache-sensitive]
enabled  = true
port     = http,https
filter   = apache-sensitive
logpath  = /var/log/apache2/access.log
maxretry = 2
bantime  = 172800
```

This bans bots scanning for WordPress, phpMyAdmin, or sensitive config files.

---

## 5. Restart Fail2Ban

```bash
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban
```

---

## 6. Monitor Status

Check what’s happening:

```bash
sudo fail2ban-client status
sudo fail2ban-client status apache-auth
```



