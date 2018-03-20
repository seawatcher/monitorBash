#!/bin/sh
PATH=/usr/bin:/bin
#----------------------------------------------------------
# a simple mysql database backup script.
# version 2, updated March 26, 2011.
# copyright 2011 alvin alexander, http://alvinalexander.com
#----------------------------------------------------------
# This work is licensed under a Creative Commons 
# Attribution-ShareAlike 3.0 Unported License;
# see http://creativecommons.org/licenses/by-sa/3.0/ 
# for more information.
#----------------------------------------------------------

# (1) set up all the mysqldump variables
DIR=<path/to/volume>
FILE=`date +"%Y%m%d"`.xtactusx.sql
TODAY=`date +"%Y%m%d"`
DBSERVER=127.0.0.1
DATABASE=dbname
USER=dbusername
PASS=dbpassword

# (2) in case you run this more than once a day, remove the previous version of the file
#unalias rm     2> /dev/null
#rm ${DIR} ${FILE}     2> /dev/null
#rm ${FILE}.gz  2> /dev/null

# (3) do the mysql database backup (dump)

# use this command for a database server on a separate host:
#mysqldump --opt --protocol=TCP --user=${USER} --password=${PASS} --host=${DBSERVER} ${DATABASE} > ${FILE}

# use this command for a database server on localhost. add other options if need be.
/usr/local/bin/mysqldump --opt --user=${USER} --password=${PASS} ${DATABASE} > ${DIR}${FILE}

# (4) gzip the mysql database dump file
#gzip $DIR$FILE

#tar zcf $DIR$FILE.tar.gz $DIR$FILE
# (5) show the user the result
#echo "${DIR}${FILE} was created:"
#ls -l ${DIR}${FILE}

echo "today::" $TODAY "file backup is" $FILE >> "log/"$TODAY"_backup.log"


HOST='server.myserver.com'
USERX='root'
PASSWD='xxxxxx'
IP=<your remote iP>
remoteDIR=/var/www/vhosts/your.yoursite.com/httpdocs/<directory>



sftp -oPort=22 $USERX@$HOST <<END_SCRIPT
cd $remoteDIR
put $DIR$FILE
quit
END_SCRIPT
exit 0




