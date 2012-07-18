#! /bin/bash
DBname=$1
DBuser=$2
DBpass=$3
WebServerPath=$4

gunzip -f $WebServerPath$DBname-database.sql.gz 
mysql --user="$DBuser" --password="$DBpass" --database="$DBname" < $WebServerPath$DBname-database.sql 
rm $WebServerPath$DBname-database.sql
