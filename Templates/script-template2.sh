#!/usr/bin/env bash
#################################################
## Script Name:
## Author:
## Date:
## Version:
## Description:
#################################################
## VARIABLES
#################################################







#################################################
## FUNCTIONS
#################################################
check_root()
{
    if [[ $EUID != 0 ]]; then
        echo "Script needs root privileges to run!"
        sleep 3
        exit 1
    fi
}
check_os()
{
    if [[ $OSTYPE != linux-gnu ]]; then
        echo "Script not compatible with your Operating System!"
        sleep 3
        exit 2
    fi
}
help()
{
    echo "SCRIPT NAME v1.0 (Date Created). Usage:"
    echo ""
    echo "command [-options] [arg1] [arg2] [arg3]"
    echo ""
    echo "Description of usage here."
    echo "-h    help"
    echo "-x    exit"
    echo "-l    blah"
    echo "-d    blah"
}
header()
{
    clear
    echo "######################################"
    echo "#          SCRIPT NAME HERE          #"
    echo "######################################"
    echo ""
}





################################################
## SCRIPT
################################################
while [ "$1" != "" ]; do
    case $1 in
        -f | --file )           shift
                                filename=$1
                                ;;
        -i | --interactive )    interactive=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
