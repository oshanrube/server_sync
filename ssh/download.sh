#! /bin/bash
##Standard variables
S1="withdb"
PWD=`pwd`

source configuration

##DO NOT CHANGE ANYTHING BELOW THIS
if [ "$1" == "$S1" ];then
	echo "Dumping the database in server"
	ssh -i $PublicKey ec2-user@$ServerIp 'bash -s' < $PWD/lib/dump-db.sh $DBname $DBuser $DBpass $WebServerPath
fi

echo "Syncronising the files"
rsync -Paz --progress $ServerUser@$ServerIp:$WebServerPath $LocalServerPath --exclude-from $Excludes

if [ "$1" == "$S1" ];then
echo "Running the database sync"
ssh $ServerUser@$ServerIp 'rm '$WebServerPath$DBname'-database.sql.gz'
gunzip -f $LocalServerPath$DBname-database.sql.gz 
mysql --user=$DBuser --password=$DBpass --database=$DBname < $LocalServerPath$DBname-database.sql 
rm $LocalServerPath$DBname-database.sql
fi
