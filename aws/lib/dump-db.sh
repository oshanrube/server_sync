#! /bin/bash
DBname=$1
DBuser=$2
DBpass=$3
WebServerPath=$4

mysqldump --user=$DBuser --password=$DBpass --lock-tables=false $DBname | gzip > $WebServerPath/$DBname-database.sql.gz