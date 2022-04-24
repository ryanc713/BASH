# BASH GETOPTS
>This is an example of how to use the BASH getopts to parse arguments passed to your script.Note that this is the short-argument version and cannot parse long command line arguments.

<br>

````bash
while getopts ae:d:f:s:qx: option
do
        case "${option}"
        in
                a) ALARM="TRUE";;
                e) ADMIN=${OPTARG};;
                d) DOMAIN=${OPTARG};;
                f) SERVERFILE=$OPTARG;;
                s) WHOIS_SERVER=$OPTARG;;
                q) QUIET="TRUE";;
                x) WARNDAYS=$OPTARG;;
                \?) usage
                    exit 1;;
        esac
done
````

# Explanation
- We start with a while loop to run until no more options are passed. Then we execute getopts followed by the options we want to parse. 
- **IF the option requires an argument to follow, it must be proceeded by a colon. This tells getopts that the option requires an argument to follow it.**
- Next is a variable, in the example it is option but you can put anything here.
- Following the specification of the while loop, we run a case statement that pretty much says "In case $option(Or whatever variable name you choose) is provided when executing"
- This is followed by our list of options, along with what to do with them. The option should be followed by a closing parenthesis symbol, then whatever it is you want to happen when this option is passed. You can set a variable to a BOOLEAN, execute a command, or if the option requires an argument, you can set a variable as the argument that was passed by the user.
- If the option requires an argument, you can access this argument as the OPTARG variable. For example if we execute this script with the -e option, it would look like:
````bash
./scriptname.sh -e ARGUMENT

echo $ADMIN
# Would output
ARGUMENT
````
- When we are done with each option, you must close the statement with 2 semi-colons. This tells the script that we are moving to the next option.
