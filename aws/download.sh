#! /bin/bash
##STANDARD VARIABLES
S1="withdb"
PWD=pwd
source configuration

##DO NOT CHANGE ANYTHING BELOW THIS
if [ "$1" == "$S1" ];then
	echo "Dumping the database in server"
	ssh -i $PublicKey ec2-user@$ServerIp 'bash -s' < $PWD/lib/dump-db.sh $DBname $DBuser $DBpass $WebServerPath
fi

echo "Syncronising the files"
rsync -Paz --delete --progress --rsh "ssh -i $PublicKey" --rsync-path "rsync" ec2-user@$ServerIp:$WebServerPath $LocalServerPath --exclude-from $Excludes

if [ "$1" == "$S1" ];then
echo "Running the database sync"
ssh -i $PublicKey ec2-user@$ServerIp 'rm '$WebServerPath$DBname'-database.sql.gz'
gunzip -f $LocalServerPath$DBname-database.sql.gz 
mysql --user=$DBuser --password=$DBpass --database=$DBname < $LocalServerPath$DBname-database.sql 
rm $LocalServerPath$DBname-database.sql
fi
