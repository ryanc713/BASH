# Check SSH Log file for newly created users

<br>

````bash
grep useradd /var/log/auth.log
````

<br>

# Echo Host Public Facing IP Address

<br>

````bash
curl ifconfig.me.`                 
````

<br>

# Print Currently Installed PHP version (Number Only)

<br>

````bash
php -v | grep ^PHP | cut -d' ' -f2
````

<br>

# One Liner to check Previous Command's Exit Status

<br>

````bash 
[ $? -eq 0 ] && echo "SUCCESS" || echo "FAILED"    
````

<br>

# Fetch Geodata

<br>

````bash
curl "http://ip-api.com/line/?fields=query,city,region,country,zip,isp"
`````

<br>

# Find Command to show files modified within the past 24hrs

<br>

````bash
find . -maxdepth 1 -mtime -1
````

<br>

# Find command to Delete Files older than 5 days in a Directory

<br>

````bash
find /path/to/directory/ -mindepth 1 -mtime +5 -delete
````

<br>

# SQL Query to Fix the Database root user

<br>

````bash
UPDATE mysql.user SET Grant_priv = 'Y', Super_priv = 'Y' WHERE User = 'root';
````

<br>

# Generate Self Signed SSL Cert

<br>

````bash
openssl req -x509 -newkey rsa:4096 -keyout NEWKEYNAME.pem -out NEWCERTNAME.pem -days 10000 -nodes
````

<br>

# Print the Host's IP Address from `ifconfig`                        

<br>

````bash
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
````

<br>

# Grep IP Addresses from a file

<br>

````bash
grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"
````

<br>

# List Packages installed on system using dpkg

<br>

````bash
dpkg -l

dpkg -l | grep PACKAGENAME
````

<br>


# Bash Script Version of `mysql_secure_installation`

<br>

````bash
mysql -u root -pPASSWORDHERE<< _EOQ_
SET PASSWORD FOR root@localhost = PASSWORD('ROOTPASSWORDHERE');
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
CREATE USER 'USERNAMEHERE'@'localhost' IDENTIFIED BY 'PASSWORDHERE';
GRANT ALL PRIVILEGES ON *.* TO 'USERNAMEHERE'@'localhost';
FLUSH PRIVILEGES;
_EOQ_
````

<br>

# Generate new Public/Private Keypair without Interaction

<br>

````bash
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
````

<br>

# Sed Commands to configure the php.ini Files

<br>

````bash
sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/*.*/fpm/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/*.*/cli/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/*.*/apache2/php.ini
````
````bash
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php/*.*/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php/*.*/cli/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php/*.*/apache2/php.ini
````
````bash
sed -i 's|;date.timezone =|date.timezone = America/Chicago|g' /etc/php/*.*/fpm/php.ini
sed -i 's|;date.timezone =|date.timezone = America/Chicago|g' /etc/php/*.*/cli/php.ini
sed -i 's|;date.timezone =|date.timezone = America/Chicago|g' /etc/php/*.*/apache2/php.ini
````
````bash
sed -i 's|;sendmail_path =|sendmail_path = /usr/sbin/sendmail|g' /etc/php/*.*/fpm/php.ini
sed -i 's|;sendmail_path =|sendmail_path = /usr/sbin/sendmail|g' /etc/php/*.*/cli/php.ini
sed -i 's|;sendmail_path =|sendmail_path = /usr/sbin/sendmail|g' /etc/php/*.*/apache2/php.ini
````
````bash
sed -i 's|mysqli.default_socket =|mysqli.default_socket = /var/run/mysqld/mysqld.sock|g' /etc/php/*.*/fpm/php.ini
sed -i 's|mysqli.default_socket =|mysqli.default_socket = /var/run/mysqld/mysqld.sock|g' /etc/php/*.*/cli/php.ini
sed -i 's|mysqli.default_socket =|mysqli.default_socket = /var/run/mysqld/mysqld.sock|g' /etc/php/*.*/apache2/php.ini
````
````bash
sed -i 's/mysqli.default_host =/mysqli.default_host = localhost/g' /etc/php/*.*/fpm/php.ini
sed -i 's/mysqli.default_host =/mysqli.default_host = localhost/g' /etc/php/*.*/cli/php.ini
sed -i 's/mysqli.default_host =/mysqli.default_host = localhost/g' /etc/php/*.*/apache2/php.ini
````
````bash
sed -i 's/mysqli.default_user =/mysqli.default_user = root/g' /etc/php/*.*/fpm/php.ini
sed -i 's/mysqli.default_user =/mysqli.default_user = root/g' /etc/php/*.*/cli/php.ini
sed -i 's/mysqli.default_user =/mysqli.default_user = root/g' /etc/php/*.*/apache2/php.ini
````
````bash
sed -i 's/mysqli.default_pw =/mysqli.default_pw = /g' /etc/php/*.*/fpm/php.ini
sed -i 's/mysqli.default_pw =/mysqli.default_pw = /g' /etc/php/*.*/cli/php.ini
sed -i 's/mysqli.default_pw =/mysqli.default_pw = /g' /etc/php/*.*/apache2/php.ini
````
````bash
sed -i "s|;include_path = ".:/php/includes"|include_path = "$include_dir"|g" /etc/php/*.*/fpm/php.ini
/etc/php/*.*/cli/php.ini
/etc/php/*.*/apache2/php.ini
````
````bash
# Needs variable $session_path
sed -i "s|;session.save_path = "/tmp"|session.save_path = "$session_path"|g" /etc/php/*.*/fpm/php.ini
sed -i "s|;session.save_path = "/tmp"|session.save_path = "$session_path"|g" /etc/php/*.*/cli/php.ini
sed -i "s|;session.save_path = "/tmp"|session.save_path = "$session_path"|g" /etc/php/*.*/apache2/php.ini

sed -i 's/session.use_strict_mode = 0/session.use_strict_mode = 1/g' /etc/php/*.*/fpm/php.ini
sed -i 's/session.use_strict_mode = 0/session.use_strict_mode = 1/g' /etc/php/*.*/cli/php.ini
sed -i 's/session.use_strict_mode = 0/session.use_strict_mode = 1/g' /etc/php/*.*/apache2/php.ini

sed -i 's/;session.cookie_secure =/session.cookie_secure =1/g' /etc/php/*.*/fpm/php.ini
sed -i 's/;session.cookie_secure =/session.cookie_secure =1/g' /etc/php/*.*/cli/php.ini
sed -i 's/;session.cookie_secure =/session.cookie_secure =1/g' /etc/php/*.*/apache2/php.ini

# Needs variable $domain
sed -i "s/session.name = PHPSESSID/session.name = $domain_PHPSESSID/g" /etc/php/*.*/fpm/php.ini
sed -i "s/session.name = PHPSESSID/session.name = $domain_PHPSESSID/g" /etc/php/*.*/cli/php.ini
sed -i "s/session.name = PHPSESSID/session.name = $domain_PHPSESSID/g" /etc/php/*.*/apache2/php.ini

sed -i 's/session.cookie_lifetime = 0/session.cookie_lifetime = 14400/g' /etc/php/*.*/fpm/php.ini
sed -i 's/session.cookie_lifetime = 0/session.cookie_lifetime = 14400/g' /etc/php/*.*/cli/php.ini
sed -i 's/session.cookie_lifetime = 0/session.cookie_lifetime = 14400/g' /etc/php/*.*/apache2/php.ini

# Needs Variable $domain
sed -i "s/session.cookie_domain =/session.cookie_domain =$domain/g" /etc/php/*.*/fpm/php.ini
sed -i "s/session.cookie_domain =/session.cookie_domain =$domain/g" /etc/php/*.*/cli/php.ini
sed -i "s/session.cookie_domain =/session.cookie_domain =$domain/g" /etc/php/*.*/apache2/php.ini

sed -i 's/session.cookie_samesite =/session.cookie_samesite =Strict/g' /etc/php/*.*/fpm/php.ini
sed -i 's/session.cookie_samesite =/session.cookie_samesite =Strict/g' /etc/php/*.*/cli/php.ini
sed -i 's/session.cookie_samesite =/session.cookie_samesite =Strict/g' /etc/php/*.*/apache2/php.ini

sed -i 's/session.cache_expire = 180/session.cache_expire = 30/g' /etc/php/*.*/fpm/php.ini
sed -i 's/session.cache_expire = 180/session.cache_expire = 30/g' /etc/php/*.*/cli/php.ini
sed -i 's/session.cache_expire = 180/session.cache_expire = 30/g' /etc/php/*.*/apache2/php.ini
````

<br>

# Remove Duplicate lines from txt file
````bash
awk '!seen[$0]++' FILENAME
````

<br>

# Create Tar archive from list of files and directories inside a txt file

<br>

````bash
tar -czvf ARCHIVE_NAME.tar.gz -T DIRECTORY_LIST.txt
````

<br>


# Loop a question until the desired outcome is reached

<br>

````bash
echo "Enter the Path to the directory you want to password protect:"
    read web_dir
    while [ ! -d "$web_dir" ] ; do
        echo "The path you entered, $web_dir, could not be found. Check the spelling and try again."
        sleep 5
        echo "Enter the Path to the Directory you want to password protect:"
        read web_dir
    done
````

<br>

# List Non built-in Users

<br>

````bash
awk -F: '$3 >= 1000 {print $1}' /etc/passwd
````
<br>

# List only Usernames from /etc/passwd file

<br>

````bash
cut -d: -f1 /etc/passwd
````

<br>

# Calculate # of Lines in a file

<br>

````bash
wc -l FILENAME.txt | awk '{ print $1 }'
````

<br>

# Read file line by line

<br>

````bash
while read -r line; do
// Commands here
done<INPUT_FILE.txt
````
