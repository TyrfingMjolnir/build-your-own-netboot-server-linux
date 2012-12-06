#!/bin/sh

/bin/echo "Locating your restore server"
/bin/sleep 3

BOOTHOST=$(/usr/bin/syslog | /usr/bin/grep booter.dmg | /usr/bin/awk '{ print $NF }' | /usr/bin/tr '/' ' ' | /usr/bin/awk '{ print $2 }')

if [ ! -z $BOOTHOST ];then
	/usr/bin/curl $BOOTHOST/restore/restore.sh | /bin/bash
else
	/bin/echo "Failed to find your restore server, please"
	/bin/echo "make sure that the restore.conf file is in"
	/bin/echo "place at /var/www/html/restore/restore.sh"
fi
