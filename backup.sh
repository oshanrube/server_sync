#! /bin/bash
DBuser=""
DBpass=""
LocalServerPath="/var/www/html/"

echo "removing backup files older than 60 days"
find ~/backups/ -type f -mtime +60  -exec rm {} \;
mkdir -p ~/backups
echo Backup Started `date` >> ~/backups/backuplog
mkdir ~/backups/`date +%Y%m%d`
tar -czf ~/backups/`date +%Y%m%d`/data.tar.gz $LocalServerPath
mysqldump --user=$DBuser --password=$DBpass --all-databases --lock-tables=false > ~/backups/`date +%Y%m%d`/database.sql
echo Backup Completed `date` >> ~/backups/backuplog
