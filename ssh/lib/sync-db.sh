#! /bin/bash
DBname=$1
DBuser=$2
DBpass=$3
WebServerPath=$4

gunzip -f $WebServerPath$DBname-database.sql.gz 
<<<<<<< HEAD
mysql --user=$DBuser --password="$DBpass" --database=$DBname < $WebServerPath$DBname-database.sql 
=======
mysql --user="$DBuser" --password="$DBpass" --database="$DBname" < $WebServerPath$DBname-database.sql 
>>>>>>> db31ab63afefd42fd386171821fcd77e5f049af7
rm $WebServerPath$DBname-database.sql
