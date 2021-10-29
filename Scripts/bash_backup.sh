#!/usr/bin/env bash
#-------------------------------------------------
# NAME: BASH Backup Script
# AUTHOR: Ryan C
# DATE: 10/28/2021
# VERSION: 1.0.0
# DESCRIPTION: Takes command line arguments as files/directories to backup. 
#-------------------------------------------------
# VARIABLES
#-------------------------------------------------
BACKUP_DIRS=( "$@" )
BACKUP_DEST=/backups/"$YEAR"/"$MONTH"/
YEAR=$(date +%Y)
MONTH=$(date +%b)
DAY=$(date +%d)
FILENAME=$DAY.$(hostname -f).tar.gz
#-------------------------------------------------
# FUNCTIONS
#-------------------------------------------------
check_root()
{
    if [[ $EUID != 0 ]]; then
        echo "ERROR: Must be root to perform a backup!"
        sleep 3
        exit 1
    fi
}
#-------------------------------------------------
# SCRIPT
#-------------------------------------------------

check_root

if [[ -z $@ ]]; then
    echo "ERROR: No files provided to Backup!"
    sleep 3
    exit 2
fi

if [[ ! -d $BACKUP_DEST ]]; then
    mkdir -p "$BACKUP_DEST"
fi

echo "Running Backup..."
tar -czf "$BACKUP_DEST"/"$FILENAME" "${BACKUP_DIRS[@]}" &>/dev/null

if [[ -f $BACKUP_DEST/$FILENAME ]]; then
    echo "Backup Completed Successfully!"
    sleep 2
    exit 0
else
    echo "Backup Failed!"
    sleep 2
    exit 3
fi
