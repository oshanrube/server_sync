#! /bin/bash
#! /bin/bash
##Standard variables
S1="withdb"
source configuration

##DO NOT CHANGE ANYTHING BELOW THIS
echo "extracting local db" 
gunzip -f $LocalServerPath"database.sql.gz"
echo "loading the db dump database" 
mysql --user="$DBuser" --password="$DBpass" --database="$DBname" < $LocalServerPath"database.sql"
echo "deleting the extracted file" 
rm $LocalServerPath"database.sql"
