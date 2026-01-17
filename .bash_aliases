# .bash_aliases
# Place file in /home Directory

# CUSTOM PS1 PROMPT
PS1='\[\e[0;31m\]\u@\h \[\e[0;36m\][\w]\$\[\e[0m\] '

# SUDO SHORTCUT
alias s='sudo'

# CLEAR THE SCREEN
alias c='clear'

# UPDATE SYSTEM AND INSTALL UPGRADES
alias update='sudo apt update && sudo apt upgrade -y'

# INSTALL SHORTCUT
alias install="sudo apt install $1 -y"

# DIRECTORY SHORTCUTS
alias b1='cd ../'
alias b2='cd ../../'
alias b3='cd ../../../'
alias web='cd /var/www/html'
alias ssh='cd /etc/ssh'
alias vhosts='cd /etc/apache2/sites-available'
alias phpdir='cd /etc/php/*.*'

# LIST RUNNING SERVICES
alias services='systemctl list-units  --type=service  --state=running'

# LIST SERVICES AND PORTS THEYRE RUNNING ON
alias listen='sudo netstat -ltup'

# SHOW EXTERNAL IP ADDRESS
alias eip='curl ipinfo.io/ip'

# GENERATE A PASSWORD
alias passgen="openssl rand --base64 $1"

# SYSTEMCTL SHORTCUTS
alias enable="sudo systemctl enable $1"
alias start="sudo systemctl start $1"
alias restart="sudo systemctl restart $1"
alias status="sudo systemctl status $1"
alias stop="sudo systemctl stop $1"

# EXTRACT TAR.GZ ARCHIVE
alias extract="tar -xf $1.tar.gz"

# CREATE A BACKUP
# USAGE:
# backup sitebackup /var/www/html
alias backup="tar -cfj $1.tar.bz2 $2"

# GPG ENCRYPT AND DECRYPT 
alias encrypt="gpg -c $1"
alias decrypt="gpg -d $1"

# SET DOMAIN VARIABLE TO SYSTEM FULL HOSTNAME
export DOMAIN=$(hostname -f)

# IF THE .scripts FOLDER IS PRESENT ADD TO PATH
if [[ -d ~/.scripts ]]; then
    export PATH="$PATH:~/.scripts"
fi