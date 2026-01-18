# CronJob Examples for Use in Production Servers

---

## 1. System Updates (Security-Only)

Keeps critical vulnerabilities patched automatically.

```bash
0 3 * * * /usr/bin/apt update && /usr/bin/apt -y upgrade
```

**Best practice:**
For production, prefer `unattended-upgrades` with security repositories only.

---

## 2. Automated Backups

Backups should be off-host whenever possible.

### Example: Daily rsync backup

```bash
0 2 * * * /usr/bin/rsync -a --delete /data /backup/data
```

### Example: Database backup

```bash
30 2 * * * /usr/bin/mysqldump --all-databases | gzip > /backup/db_$(date +\%F).sql.gz
```

---

## 3. Log Rotation / Cleanup

Prevents disks from filling.

```bash
0 1 * * 0 /usr/bin/find /var/log -type f -name "*.log" -mtime +14 -delete
```

(Note: `logrotate` is preferred, but this is still commonly used.)

---

## 4. Disk Space Monitoring

Emails when disk usage exceeds a threshold.

```bash
*/30 * * * * df -h | awk '$5+0 > 85 {print}' | mail -s "Disk Space Warning" admin@example.com
```

---

## 5. Fail2Ban / Security Health Checks

Ensures services are running.

```bash
*/10 * * * * systemctl is-active fail2ban || systemctl restart fail2ban
```

---

## 6. Web Service Monitoring

Auto-restart if Apache or Nginx dies.

```bash
*/5 * * * * systemctl is-active nginx || systemctl restart nginx
```

```bash
*/5 * * * * systemctl is-active apache2 || systemctl restart apache2
```

---

## 7. SSL Certificate Renewal (Let’s Encrypt)

Usually handled by Certbot, but manual example:

```bash
0 4 * * * /usr/bin/certbot renew --quiet
```

---

## 8. Temporary File Cleanup

Keeps `/tmp` and app caches sane.

```bash
0 3 * * * /usr/bin/find /tmp -type f -mtime +7 -delete
```

---

## 9. Permission & Ownership Enforcement

Useful for shared web hosts.

```bash
0 1 * * * chown -R www-data:www-data /var/www && chmod -R 755 /var/www
```

---

## 10. Cron Health Check (Meta-Cron)

Confirms cron itself is running.

```bash
*/15 * * * * systemctl is-active cron || systemctl restart cron
```

---

## 11. Custom Application Tasks

Examples:

* Clear cache
* Rotate app logs
* Sync queues
* Generate reports

```bash
*/10 * * * * /var/www/app/scripts/clear_cache.sh
```

---

## Best Practices for Bash Cron Jobs

1. **Always use full paths**

   ```bash
   /usr/bin/php /path/script.php
   ```

2. **Redirect output**

   ```bash
   0 2 * * * /script.sh >> /var/log/script.log 2>&1
   ```

3. **Use locking to avoid overlaps**

   ```bash
   * * * * * flock -n /tmp/task.lock /script.sh
   ```

4. **Environment is minimal**
   Explicitly set:

   ```bash
   PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   ```

---

