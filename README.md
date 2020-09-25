# Synology Backup & Restore Scripts

This repository contains some generic scripts which can be used for backing up and restoring data for the following applications which you may have installed on your Synology:

* Lidarr
* Homes direcotry of a specific user
* Homes directory of the root user
* NzbGet
* Plex
* Radarr
* SickChill (v1.0 Python 3 version)
* Transmission

The script can be easily changed to add more applications like Sonarr, SickBeard, SABnzbd, etc. The only file to change is the `appConfig.sh` file which contains all the data/locations for the specific applications to backup and restore. The file is self-explanatory and describes what needs to be changed if you want to add a new application.

## The scripts

### appConfig.sh
Contains all the data/locations for the specific applications to backup and restore. It should only be necessary to customize this script.

### backup.sh
This is the backup script. It uses the `appConfig.sh` and `functions.sh` as input.
The script takes one mandatory application id as input and creates a backup of all the files/directories specified in the `appConfig.sh` for the specific application id. The result is stored as a `tar.gz` file with a filename consisting of the application id and a timestamp, e.g. `SickChill-20200925212759.tar.gz.` All files are stored within the `tar.gz` file are stored with absolute paths, so the restore can extract them in the same exact location.
A backup for a specific application can easily be scheduled in Synology's taksmanager, using a command like: `/bin/sh /volume1/homes/myname/scripts/backupAndRestore/backup.sh SickChill >>/tmp/task_debug.log 2>&1`. For more information on how to do that, see: http://domoticx.com/synology-nas-scripts-via-de-taakplanner/. In general, this script shouldn't be changed.

Example:
```
./backup.sh SickChill
```

### restore.sh
This is the restore script. It uses the `appConfig.sh` and `functions.sh` as input.
The script takes one mandatory application id (the application to restore) as input and finds the most recent backup file for that application. If you want to restore a specific version, you can add a date/time string as the second argument in the format of `YYYYMMDDHHMMSS`. In general, this script shouldn't be changed. But if you use Radarr and you want to restore a version of that then there are still some TODO actions here that need to be outcommented (still some work in progress to change that so that it won't be necessary to change this).

Example 1:
```
./restore.sh SickChill
```
Example 2:
```
./restore.sh SickChill 20200925212759
```

### functions.sh
This script contains all the main logic used by the backup and restore scripts and uses `appConfig.sh` as input. In general, this script shouldn't be changed.

## How to use
* Just copy these 4 scripts to your Synology, e.g. to `/volume1/homes/<your_user_name>/scripts/backupAndRestore/`.
* Recursively change the owner of the `backupAndRestore` directory and files: `chown -R <your_user_name>:users backupAndRestore`.
* Recursively change permissions of the `backupAndRestore` directory and files to 0755: `chmod -R 755 backupAndRestore`.
* In `appConfig.sh` change the following:
  * <your_user_name> with the name of your own homes folder
  * <YOUR_USER_NAME> with the name of your own homes folder (in capitals)
