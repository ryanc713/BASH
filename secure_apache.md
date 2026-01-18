# Secure Apache VirtualHost Configuration Example

---

### Example: `/etc/apache2/sites-available/example.conf`

```apache
<VirtualHost *:80>
    ServerName example.com
    ServerAlias www.example.com

    # Redirect all HTTP to HTTPS
    Redirect permanent / https://example.com/
</VirtualHost>

<VirtualHost *:443>
    ServerName example.com
    ServerAlias www.example.com

    DocumentRoot /var/www/example.com/public

    # Logs
    ErrorLog ${APACHE_LOG_DIR}/example-error.log
    CustomLog ${APACHE_LOG_DIR}/example-access.log combined

    # SSL Configuration
    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/example.com/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/example.com/privkey.pem
    SSLCertificateChainFile /etc/letsencrypt/live/example.com/chain.pem

    # Security Headers
    Header always set X-Frame-Options "SAMEORIGIN"
    Header always set X-XSS-Protection "1; mode=block"
    Header always set X-Content-Type-Options "nosniff"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
    Header always set Permissions-Policy "geolocation=(), microphone=(), camera=()"
    Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"

    # Disable directory listing
    <Directory /var/www/example.com/public>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    # Restrict access to sensitive files
    <FilesMatch "(^\.|~$|\.bak$|\.inc$|\.sql$)">
        Require all denied
    </FilesMatch>

    # Limit Request Size
    LimitRequestBody 10485760

    # Enable OCSP Stapling (if supported)
    SSLUseStapling on
    SSLStaplingCache "shmcb:/var/run/ocsp(128000)"
</VirtualHost>
```

---

### Steps to Secure It:

1. **Enable required Apache modules**:

   ```bash
   sudo a2enmod ssl headers rewrite
   sudo systemctl reload apache2
   ```

2. **Use Let’s Encrypt for SSL/TLS** (recommended):

   ```bash
   sudo apt install certbot python3-certbot-apache
   sudo certbot --apache -d example.com -d www.example.com
   ```

3. **Set file permissions**:

   ```bash
   sudo chown -R www-data:www-data /var/www/example.com/public
   sudo chmod -R 750 /var/www/example.com
   ```

4. **Harden Apache globally** (`/etc/apache2/conf-available/security.conf`):

   ```apache
   ServerTokens Prod
   ServerSignature Off
   TraceEnable Off
   ```

---
