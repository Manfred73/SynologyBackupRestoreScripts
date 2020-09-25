#!/bin/sh

##########################################################################################################################################################
# Global variables
##########################################################################################################################################################
# Array of applications to backup.
# To add more applications, you can extend this array with a new prefix;
# then you can add a new section with variables for the new application as is done for Lidarr;
# and also add a new entry for the new application to the functions get_backup_path(), 
# get_app_prefix() and get_files_to_backup() below.
#
APPS=("Lidarr" "Homes<your_user_name>" "HomesRoot" "NzbGet" "Plex" "Radarr" "SickChill" "Transmission")

# General location variables for backup & restore
# Change these according to your preferences and available volumes
#
APPSTORE_LOCATION='/volume1/@appstore'
BACKUP_LOCATION="/volume7/Backup/SYNOLOGY"
SCRIPTS_LOCATION='/volume1/homes/<your_user_name>/scripts'
HOMES_LOCATION='/volume1/homes'
HOMES_ROOT_LOCATION='/root'
TMP_FILE_LIST='/tmp/filesToBackup.lst'
CURRENT_DIR=$(pwd)

# Variables for Lidarr backup & restore
#
LIDARR_PATH="$APPSTORE_LOCATION/lidarr/var/.config/Lidarr"
LIDARR_BACKUP_PATH="$BACKUP_LOCATION/Lidarr"
LIDARR_PREFIX="Lidarr"
LIDARR_FILES_TO_BACKUP=("$LIDARR_PATH/config.xml" "$LIDARR_PATH/lidarr.db")

# Variables for HOME_USER backup & restore
#
HOMES_PATH_<YOUR_USER_NAME>="$HOMES_LOCATION/<your_user_name>"
HOMES_<YOUR_USER_NAME>_BACKUP_PATH="$BACKUP_LOCATION/homes/<your_user_name>"
HOMES_<YOUR_USER_NAME>_PREFIX="<your_user_name>"
HOMES_<YOUR_USER_NAME>_FILES_TO_BACKUP=("$HOMES_PATH_<YOUR_USER_NAME>")

# Variables for HOMES_ROOT backup & restore
#
HOMES_ROOT_BACKUP_PATH="$BACKUP_LOCATION/homes/root"
HOMES_ROOT_PREFIX="root"
HOMES_ROOT_FILES_TO_BACKUP=("$HOMES_ROOT_LOCATION")

# Variables for NzbGet backup & restore
#
NZBGET_PATH="$APPSTORE_LOCATION/nzbget"
NZBGET_BACKUP_PATH="$BACKUP_LOCATION/NzbGet"
NZBGET_PREFIX="NzbGet"
NZBGET_FILES_TO_BACKUP=("$NZBGET_PATH/var/nzbget.conf")

# Variables for Plex backup & restore
#
PLEX_PATH="/volume1/Plex/Library/Application Support"
PLEX_BACKUP_PATH="$BACKUP_LOCATION/Plex"
PLEX_PREFI="Plex"
PLEX_FILES_TO_BACKUP=("$PLEX_PATH/Plex Media Server")

# Variables for Radarr backup & restore
#
RADARR_PATH="$APPSTORE_LOCATION/radarr/var/.config/Radarr"
RADARR_BACKUP_PATH="$BACKUP_LOCATION/Radarr"
RADARR_PREFIX="Radarr"
RADARR_FILES_TO_BACKUP=("$RADARR_PATH/config.xml" "$RADARR_PATH/nzbdrone.db")

# Variables for Sickchill backup & restore
#
SICKCHILL_PATH="$APPSTORE_LOCATION/sickchill/var"
SICKCHILL_BACKUP_PATH="$BACKUP_LOCATION/SickChill"
SICKCHILL_PREFIX="SickChill"
SICKCHILL_FILES_TO_BACKUP=("$SICKCHILL_PATH/config.ini" "$SICKCHILL_PATH/cache.db" "$SICKCHILL_PATH/sickchill.db" "$SICKCHILL_PATH/sickchill.db.v44" "$SICKCHILL_PATH/cache" "$SICKCHILL_PATH/failed.db")

# Variables for Transmission backup & restore
#
TRANSMISSION_PATH="$APPSTORE_LOCATION/transmission"
TRANSMISSION_BACKUP_PATH="$BACKUP_LOCATION/Transmission"
TRANSMISSION_PREFIX="Transmission"
TRANSMISSION_FILES_TO_BACKUP=("$TRANSMISSION_PATH/app/config" "$TRANSMISSION_PATH/var/blocklists" "$TRANSMISSION_PATH/var/resume" "$TRANSMISSION_PATH/var/torrents" "$TRANSMISSION_PATH/var/dht.dat" "$TRANSMISSION_PATH/var/settings.json" "$TRANSMISSION_PATH/var/stats.json")

##########################################################################################################################################################
# Function to return the application backup path based on the provided appication configuration parameter.
#
# Arguments: $1 the application configuration to return the application backup path for
##########################################################################################################################################################
function get_backup_path() {
    case $1 in
        "Lidarr") echo "$LIDARR_BACKUP_PATH" ;;
        "Homes<your_user_name>") echo "$HOMES_<YOUR_USER_NAME>_BACKUP_PATH" ;;
        "HomesRoot") echo "$HOMES_ROOT_BACKUP_PATH" ;;
        "NzbGet") echo "$NZBGET_BACKUP_PATH" ;;
        "Plex") echo "$PLEX_BACKUP_PATH" ;;
        "Radarr") echo "$RADARR_BACKUP_PATH" ;;
        "SickChill") echo "$SICKCHILL_BACKUP_PATH" ;;
        "Transmission") echo "$TRANSMISSION_BACKUP_PATH" ;;
        *) exit 1 ;;
    esac
}

##########################################################################################################################################################
# Function to return the application prefix based on the provided appication configuration parameter.
#
# Arguments: $1 the application configuration to return the application backup path for
##########################################################################################################################################################
function get_app_prefix() {
    case $1 in
        "Lidarr") echo "$LIDARR_PREFIX" ;;
        "Homes<your_user_name>") echo "$HOMES_<YOUR_USER_NAME>_PREFIX" ;;
        "HomesRoot") echo "$HOMES_ROOT_PREFIX" ;;
        "NzbGet") echo "$NZBGET_PREFIX" ;;
        "Plex") echo "$PLEX_PREFIX" ;;
        "Radarr") echo "$RADARR_PREFIX" ;;
        "SickChill") echo "$SICKCHILL_PREFIX" ;;
        "Transmission") echo "$TRANSMISSION_PREFIX" ;;
        *) exit 1 ;;
    esac
}

##########################################################################################################################################################
# Function to return the files to backup based on the provided appication configuration parameter.
#
# Arguments: $1 the application configuration to return the files to backup for
##########################################################################################################################################################
function get_files_to_backup() {
    case $1 in
        "Lidarr") create_files_to_backup "${LIDARR_FILES_TO_BACKUP[@]}" ;;
        "Homes<your_user_name>") create_files_to_backup "${HOMES_<YOUR_USER_NAME>_FILES_TO_BACKUP[@]}" ;;
        "HomesRoot") create_files_to_backup "${HOMES_ROOT_FILES_TO_BACKUP[@]}" ;;
        "NzbGet") create_files_to_backup "${NZBGET_FILES_TO_BACKUP[@]}" ;;
        "Plex") create_files_to_backup "${PLEX_FILES_TO_BACKUP[@]}" ;;
        "Radarr") create_files_to_backup "${RADARR_FILES_TO_BACKUP[@]}" ;;
        "SickChill") create_files_to_backup "${SICKCHILL_FILES_TO_BACKUP[@]}" ;;
        "Transmission") create_files_to_backup "${TRANSMISSION_FILES_TO_BACKUP[@]}" ;;
        *) exit 1 ;;
    esac
}
