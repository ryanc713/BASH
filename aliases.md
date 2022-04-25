![Bash_Aliases](https://github.com/ryanc410/BASH/blob/main/bash_aliases.png)

**Table of Contents**
1. <a href="#howto">How to Congfigure Aliases</a>
2. <a href="#navigating">Navigating Directories</a>
3. <a href="#custom">Custom Commands</a>
4. <a href="#extras">Extras</a>

---

<h1 id="howto">How to Configure Aliases in BASH</h1>
To configure BASH to recognize your aliases is extremely easy. When the shell starts, it reads a few files before actually starting, and one of these files is your `.bashrc` file. Near the end of this file you should notice an if statement that tells the shell that if the `.bash_aliases` file exists in the home directory, to source it into the shell. If you dont find this statement in your `.bashrc` file, this is what it should look like:

````bash
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
````

Next, inside your home directory you can do something like `touch .bash_aliases` or `nano .bash_aliases` and add your aliases in this file. After you are done adding them you must logout and log back in for the shell to read this file. Or you can run `newgrp` and then you can use your aliases.

# Alias Examples

<h1 id="navigating"> Navigating Directories</h1>

## **Moving back x number of directories**
>These aliases make it easier to move up a folder tree.

## **Go back one directory**
````bash
alias b1='cd ../'
````

## **Go back two directories**
````bash
alias b2='cd ../../'
````

## **Go back three directories**
````bash
alias b3='cd ../../../'
````

## **Go back four directories**
````bash
alias b4='cd ../../../../'
````

# **Shortcuts**
>Aliases that navigate to specific directories

<br>

## **Navigate to web root directory**
````bash
alias web='cd /var/www/html'
````

## **Navigate to Apache's Virtual Host directory**
````bash
alias vhosts='cd /etc/apache2/sites-available'
````

---

<h1 id="custom">Custom Commands</h1>

>All of these aliases require atleast one argument provided when executing.

<br>

## **Easy Install command.**
>Provide one or more app names to install. If more than one, separate using one whitespace character.
````bash
alias install="sudo apt install $1 -y"
````

## **Simple enable command**
>Enables the app to run at boot.
````bash
alias enable="sudo systemctl enable $1"
````

## **Simple Start command**
>Starts the app
````bash
alias start="sudo systemctl start $1"
````
## **Restart $1**
>Restarts the provided app.
````bash
alias restart="sudo systemctl restart $1"
````

## **Status Check**
>Provide the name of the app you want to check the status of as an argument.
````bash
alias status="sudo systemctl status $1"
````
## **Generate x length Password**
>The argument provided during execution is the desired length of the generated password.
````bash
alias genpass="openssl rand -base64 $1"
````

---

<h1 id="extras">Extras</h1>

## **Update**
>Update repositories and upgrade apps as needed
````bash
alias update='sudo apt update && sudo apt upgrade -y'
````

## **Date**
>Show current date and time
````bash
alias now='date +%b.%d.%Y-%I:%M%p'
````

## **External IP**
>Print your public IP address using curl
````bash
alias eip='curl ipinfo.io/ip'
````

## **Extract**
>Extract a tar.gz archive
````bash
alias extract="tar -xf $1.tar.gz"
````

## **Create Backup**
>First argument is the desired name of the backup, omitting the file extension, and the second is the files/directories you want to backup.,
````bash
alias backup="tar -cfj $1.tar.bz2 $2"
````

## **Encrypt**
>Use gpg to encrypt a file using a passphrase.
````bash
alias encrypt="gpg -c $1"
````

## **Decrypt**
>Use gpg to decrypt a file providing a passphrase.
````bash
alias decrypt="gpg -d $1"
````

## **Sudo**
>For if you get tired of typing out sudo every command.
````bash
alias s='sudo'
````

## **Clear the Screen**
````bash
alias c='clear'
````

---

