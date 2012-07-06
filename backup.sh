#! /bin/bash
mkdir -p ~/backups
echo Backup Started `date` >> ~/backups/backuplog
mkdir ~/backups/`date +%Y%m%d`
tar -czf ~/backups/`date +%Y%m%d`/data.tar.gz /var/www/html
mysqldump --user=root --password=oshan1991 --all-databases --lock-tables=false > ~/backups/`date +%Y%m%d`/database.sql
echo Backup Completed `date` >> ~/backups/backuplog