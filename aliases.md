# USEFUL BASH ALIASES
<br>

| Generate random 20 character password |
|---------------------------------------|
````bash
alias getpass='openssl rand -base64 20'
````
<br>

| External IP Address using curl |
|--------------------------------|
````bash
alias ipe='curl ipinfo.io/ip'
````
<br>

| Clear the Screen |
|------------------|
````bash
alias c='clear'
````
<br>

| Sudo |
|------|
````bash
alias s='sudo'
````

<br>

| Show Date |
|-----------|
````bash
alias now='date +%B.%d.%Y
````

<br>

| Navigate back Directories |
|---------------------------|
````bash
alias b1='cd ../'
alias b2='cd ../../'
alias b3='cd ../../../'
alias b4='cd ../../../../'
````

<br>

| Navigate to Web Root Directory |
|--------------------------------|
````bash
alias web='cd /var/www/html'
````

<br>

| Navigate to  Apache's Virtual Host Directory |
|----------------------------------------------|
````bash
alias vhost='cd /etc/apache2/sites-available'
````

<br>

| Update Server                                                      |
|--------------------------------------------------------------------|
````bash
alias update='apt update && apt upgrade -y
````

<br>

| Extract Tar Archive |
|---------------------|
````bash
alias extract="tar -xvf $1"
````

<br>

| Create Backup Using Tar |
|-------------------------|
**Alias takes two arguments the first is the name of the Backup File and the second is what you want to backup.**
````bash
alias backup='tar -cjf $1.tar.bz2 $2'
````
