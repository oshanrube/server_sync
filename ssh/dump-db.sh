#! /bin/bash
#! /bin/bash
##Standard variables
S1="withdb"
PWD=`pwd`

source configuration

mysqldump --user="$DBuser" --password="$DBpass" --lock-tables=false $DBname | gzip > $LocalServerPath/database.sql.gz