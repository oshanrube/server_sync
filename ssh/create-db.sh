#! /bin/bash
##Standard variables
RootPW=""

source configuration

##DO NOT CHANGE ANYTHING BELOW THIS
echo "create the database" 
mysql -u root -p$RootPW -e "create database $DBname default character set utf8" 
 
echo "add the user and grant all privilages to that user"
mysql -u root -p$RootPW -e "grant all privileges on $DBname.* to $DBuser@localhost identified by '$DBpass'" 