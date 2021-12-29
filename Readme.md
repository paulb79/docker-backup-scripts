# docker backup

## Description
Backup of all your running containers dynamically.

This will create a backup of docker images & volumes, and store them on the local filesystem.

### Changes
This is a fork of /piscue/docker-backup-scripts, with the following changes:
* Unified into a single bash script
* Tidier output
* Removal of dropbox (local storage only)
* Removed CoreOS support
* Add -all flag to ensure all images and volumes are backed up

## Setup and Usage

Check inside **docker-backup.sh** to set the **backup_path** variable point at your current backup folder

Run the backup
```
bash
./docker-backup.sh
```

## Extra

Create a cron if you want to run it often.

## Credits

Original version by piscue
https://github.com/piscue/docker-backup-scripts

Modifications / Fork by Ricky Hewitt
https://github.com/rickyhewitt/docker-backup-scripts
