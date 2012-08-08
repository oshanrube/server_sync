#! /bin/bash
##Standard variables
S1="withdb"
DEV="dev"

source configuration

##DO NOT CHANGE ANYTHING BELOW THIS
if [ "$1" == "$S1" ];then
	echo "Dumping the database in server"
	ssh $ServerUser@$ServerIp 'bash -s' < $PWD/lib/dump-db.sh $DBname $DBuser $DBpass $WebServerPath
fi

echo "Syncronising the files"
RC=1 
while [[ $RC -ne 0 && $RC -ne 20 ]]
do
	rsync -Paz --progress $ServerUser@$ServerIp:$WebServerPath $LocalServerPath --exclude-from $Excludes
	RC=$?
done

if [ "$1" == "$S1" ];then
echo "Running the database sync"
	ssh $ServerUser@$ServerIp 'rm '$WebServerPath$DBname'-database.sql.gz'
	gunzip -f $LocalServerPath$DBname-database.sql.gz 
	mysql --user="$DBuser" --password="$DBpass" --database="$DBname" < $LocalServerPath$DBname-database.sql 
	rm $LocalServerPath$DBname-database.sql
fi

if [ "$2" == "$DEV" ];then
chmod 777 -R $LocalServerPath
fi
