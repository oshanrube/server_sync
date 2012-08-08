#! /bin/bash
##Standard variables
S1="withdb"
PWD=`pwd`

RootPW="oshan1991"

source configuration

##DO NOT CHANGE ANYTHING BELOW THIS

# create a database for xwiki
mysql -u root -p$RootPW -e "create database $DBname default character set utf8" 
 
# add user xwikiuser@localhost and grant access to xwikidb
mysql -u root -p$RootPW -e "grant all privileges on $DBname.* \
                    to $DBuser@localhost identified by '$DBpass'" 