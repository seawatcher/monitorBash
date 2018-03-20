#!/bin/bash

SITESFILE=<path-to-file>/sites.txt 
#list the sites you want to monitor in this file
EMAILS="pluto@papera.com,paperin@email.com" 
#list of email addresses to receive alerts (comma separated)

TODAY=`date +"%Y%m%d"`

while read site; do
    if [ ! -z "${site}" ]; then
      
      
        aCURL=$(curl -Is --head $site | head -1)   
        
        CURL=$(curl -s --head $site)
        
        if echo $CURL | grep "200 OK" > /dev/null
        then
            echo "$TODAY :: The HTTP server on ${site} is up with 200 OK"
        elif echo $CURL | grep "302 Found" > /dev/null
        then
            echo "$TODAY :: The HTTP server on ${site} is up with 302 Found"
        else    

            MESSAGE="This is an alert that your site ${site} has failed to respond either 200 OK and 302 Found ::=> $aCURL"
            DOWN=1
            echo $DOWN
            
            
            # for EMAIL in $(echo $EMAILS | tr "," " "); do
            #   SUBJECT="$site (http) Failed"
            #   echo "$MESSAGE" | mail -s "$SUBJECT" $EMAIL
            #   echo $SUBJECT
            #   echo "Alert sent to $EMAIL"
            # done  
           
                
        fi
    fi
done < $SITESFILE
HOST='server.server.com'
USERX='root'
PASSWD='xxxxxxx'
IP=100.100.100.100


if echo $DOWN=1
then
ssh $USERX@$HOST  'apachectl -k graceful'
         
exit 0
fi