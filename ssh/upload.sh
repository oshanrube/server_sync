#! /bin/bash
S1="withdb"
PWD=pwd

source configuration

##DO NOT CHANGE ANYTHING BELOW THIS
if [ "$1" == "$S1" ];then
	echo "Dumping the database"
	mysqldump --user=$DBuser --password=$DBpass --lock-tables=false $DBname | gzip > $LocalServerPath/$DBname-database.sql.gz
fi

echo "Removing tempory files"
find $LocalServerPath | grep "~" | xargs rm -f
echo "Setting file permission"
find $LocalServerPath -type f -exec chmod 644 {} \;
find $LocalServerPath -type d -exec chmod 755 {} \;

if [ "$SYSTEM" == "joomla" ];then
find $LocalServerPath/administrator/components -type d -exec chmod 755 {} \;
find $LocalServerPath/components -type d -exec chmod 777 {} \;
find $LocalServerPath/logs -type d -exec chmod 777 {} \;
find $LocalServerPath/tmp -type d -exec chmod 777 {} \;
else if [ "$SYSTEM" == "symfony" ];then
find $LocalServerPath/web -type d -exec chmod 744 {} \;
find $LocalServerPath/web -type f -exec chmod 644 {} \;
fi

echo "Syncronising the files"
rsync -Paz --progress $LocalServerPath $ServerUser@$ServerIp:$WebServerPath --exclude-from $Excludes

if [ "$1" == "$S1" ];then
echo "Running the database sync"
ssh $ServerUser@$ServerIp 'bash -s' < $PWD/lib/sync-db.sh $DBname $DBuser $DBpass $WebServerPath
rm $LocalServerPath$DBname-database.sql.gz
fi
