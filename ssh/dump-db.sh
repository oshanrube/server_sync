#! /bin/bash
#! /bin/bash
##Standard variables
S1="withdb"
DATETIME=`date "+%Y%m%d%H%M%S"`
source configuration

##DO NOT CHANGE ANYTHING BELOW THIS
echo "Dumping the database in server"
ssh $ServerUser@$ServerIp 'bash -s' < $PWD/lib/dump-db.sh $DBname $DBuser $DBpass $WebServerPath
echo "Downloading the db"
rsync -Paz --progress $ServerUser@$ServerIp:$WebServerPath/$DBname-database.sql.gz  ./db/"server-"$DATETIME"-database.sql.gz"
echo "Deleting from the remote server"
ssh $ServerUser@$ServerIp 'rm '$WebServerPath$DBname'-database.sql.gz'
echo "Dumping the database in local"
mysqldump --user="$DBuser" --password="$DBpass" --lock-tables=false "$DBname" | gzip > ./db/"local-"$DATETIME"-database.sql.gz"