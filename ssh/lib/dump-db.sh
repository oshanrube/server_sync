#! /bin/bash
DBname=$1
DBuser=$2
DBpass=$3
WebServerPath=$4

<<<<<<< HEAD
mysqldump --user=$DBuser --password="$DBpass" --lock-tables=false $DBname | gzip > $WebServerPath/$DBname-database.sql.gz
=======
mysqldump --user="$DBuser" --password="$DBpass" --lock-tables=false "$DBname" | gzip > $WebServerPath/$DBname-database.sql.gz
>>>>>>> db31ab63afefd42fd386171821fcd77e5f049af7
