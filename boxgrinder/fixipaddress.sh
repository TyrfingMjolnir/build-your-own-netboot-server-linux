#!/bin/sh

MYIP=$(/sbin/ifconfig eth0 | /bin/grep inet | /bin/grep -v inet6 | /bin/cut -d ":" -f 2 | /bin/cut -d " " -f 1)

/bin/sed -i "s/theipadress/$MYIP/g" /var/www/html/Reinstall.app/Contents/Resources/script

/bin/sed -i "s/theipadress/$MYIP/g" /etc/dhcp/dhcpd.conf

/bin/sed -i "s/theipadress/$MYIP/g" /var/www/html/restore/restore.sh

/bin/echo $MYIP >/var/www/html/restore/restore.conf

cd /var/www/html/

/usr/bin/zip -r Reinstall.zip Reinstall.app

#adjoin -u administrator -p 'Password!' -c "OU=intra,DC=hger,DC=org" -n $(hostname -s) -w hger.org
