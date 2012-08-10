#! /bin/bash
#! /bin/bash
##Standard variables
S1="withdb"
PWD=`pwd`

source configuration

gunzip -f $LocalServerPath"database.sql.gz" 
mysql --user="$DBuser" --password="$DBpass" --database="$DBname" < $LocalServerPath"database.sql" 
rm $LocalServerPath"database.sql"
