| CHECK FOR NEWLY CREATED USERS IN SSH LOG FILE |
|-----------------------------------------------|
````bash
grep useradd /var/log/auth.log
````
<br>

| ECHO PUBLIC IP ADDRESS USING CURL |
|-----------------------------------|
````bash
curl ifconfig.me.`                 
````
<br>

| PRINT PHP VERSION NUMBER                 |
|------------------------------------------|
````bash
php -v | grep ^PHP | cut -d' ' -f2
````
<br>

| EXIT STATUS ONE LINER                                |
|------------------------------------------------------|
````bash 
[ $? -eq 0 ] && echo "SUCCESS" || echo "FAILED"    
````
<br>

| FETCH GEODATA                                                           |
|-------------------------------------------------------------------------|
````bash
curl "http://ip-api.com/line/?fields=query,city,region,country,zip,isp"
`````
<br>

| FIND FILES IN CURRENT DIRECTORY THAT HAVE BEEN MODIFIED IN THE PAST 24 HRS |
|--------------------------------------------------------------------------|
````bash
find . -maxdepth 1 -mtime -1
````
<br>

| DELETE FILES OLDER THAN 5 DAYS                                                                     |
|----------------------------------------------------------------------------------------------------|
````bash
find /path/to/directory/ -mindepth 1 -mtime +5 -delete
````
<br>

| FIX MYSQL ROOT USER                                                           |
|-------------------------------------------------------------------------------|
````bash
UPDATE mysql.user SET Grant_priv = 'Y', Super_priv = 'Y' WHERE User = 'root';
````
<br>

| GENERATE SELF SIGNED SSL                                                           |
|------------------------------------------------------------------------------------|
````bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 10000 -nodes
````
<br>

| PRINT LOCAL IP ADDRESS FROM IFCONFIG COMMAND                                                                  |
|---------------------------------------------------------------------------------------------------------------|
````bash
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
````
<br>

| GREP IP ADDRESS FROM FILE                    |
|----------------------------------------------|
````bash
grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"
````
<br>

| LIST INSTALLED PACKAGES |
|-----------------------|
````bash
dpkg --list
````
<br>

| SEARCH FOR INSTALLED PACKAGE    |
|---------------------------------|
````bash
dpkg --list | grep PACKAGE_NAME
````


| MYSQL SECURE INSTALLATION BASH SCRIPT  |
|--------------------------------------- |
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

---

| SSH-KEYGEN NON-INTERACTIVE                                         |
|--------------------------------------------------------------------|
````bash
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
````
<br>

| CONFIGURE PHP.INI FILES     |
|-----------------------------|
````bash
sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/7.4/fpm/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/7.4/cli/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/7.4/apache2/php.ini
````
````bash
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php/7.4/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php/7.4/cli/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php/7.4/apache2/php.ini
````
````bash
sed -i 's|;date.timezone =|date.timezone = America/Chicago|g' /etc/php/7.4/fpm/php.ini
sed -i 's|;date.timezone =|date.timezone = America/Chicago|g' /etc/php/7.4/cli/php.ini
sed -i 's|;date.timezone =|date.timezone = America/Chicago|g' /etc/php/7.4/apache2/php.ini
````
````bash
sed -i 's|;sendmail_path =|sendmail_path = /usr/sbin/sendmail|g' /etc/php/7.4/fpm/php.ini
sed -i 's|;sendmail_path =|sendmail_path = /usr/sbin/sendmail|g' /etc/php/7.4/cli/php.ini
sed -i 's|;sendmail_path =|sendmail_path = /usr/sbin/sendmail|g' /etc/php/7.4/apache2/php.ini
````
````bash
sed -i 's|mysqli.default_socket =|mysqli.default_socket = /var/run/mysqld/mysqld.sock|g' /etc/php/7.4/fpm/php.ini
sed -i 's|mysqli.default_socket =|mysqli.default_socket = /var/run/mysqld/mysqld.sock|g' /etc/php/7.4/cli/php.ini
sed -i 's|mysqli.default_socket =|mysqli.default_socket = /var/run/mysqld/mysqld.sock|g' /etc/php/7.4/apache2/php.ini
````
````bash
sed -i 's/mysqli.default_host =/mysqli.default_host = localhost/g' /etc/php/7.4/fpm/php.ini
sed -i 's/mysqli.default_host =/mysqli.default_host = localhost/g' /etc/php/7.4/cli/php.ini
sed -i 's/mysqli.default_host =/mysqli.default_host = localhost/g' /etc/php/7.4/apache2/php.ini
````
````bash
sed -i 's/mysqli.default_user =/mysqli.default_user = root/g' /etc/php/7.4/fpm/php.ini
sed -i 's/mysqli.default_user =/mysqli.default_user = root/g' /etc/php/7.4/cli/php.ini
sed -i 's/mysqli.default_user =/mysqli.default_user = root/g' /etc/php/7.4/apache2/php.ini
````
````bash
sed -i 's/mysqli.default_pw =/mysqli.default_pw = /g' /etc/php/7.4/fpm/php.ini
sed -i 's/mysqli.default_pw =/mysqli.default_pw = /g' /etc/php/7.4/cli/php.ini
sed -i 's/mysqli.default_pw =/mysqli.default_pw = /g' /etc/php/7.4/apache2/php.ini
````

<br>

| REMOVE DUPLICATE LINES FROM TEXT FILE |
|--------------------------------------|
````bash
awk '!seen[$0]++' FILENAME
````
<br>

| TAR ARCHIVE FROM LIST.TXT
|-----------------------------------------------------|
````bash
tar -czvf ARCHIVE_NAME.tar.gz -T DIRECTORY_LIST.txt
````
<br>


|LOOP OVER A QUESTION UNTIL THE CORRECT ANSWER IS PROVIDED |
|----------------------------------------------------------|
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

| LIST ALL NON-BUILT IN USERS                 |
|---------------------------------------------|
````bash
awk -F: '$3 >= 1000 {print $1}' /etc/passwd
````
<br>

| LIST ONLY USERNAMES FROM /etc/passwd FILE |
|-----------------------------------------|
````bash
cut -d: -f1 /etc/passwd
````
<br>

| CALCULATE THE NUMBER OF LINES IN A FILE |
|-----------------------------------------|
````bash
wc -l FILENAME.txt | awk '{ print $1 }'
````