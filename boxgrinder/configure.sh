#!/bin/bash
#Setting Swedish Keyboard
/bin/cat >/etc/sysconfig/keyboard <<EOF
KEYTABLE=sv-latin1
MODEL=pc105
LAYOUT=se
EOF

#Setting hostname to netbooter
/bin/cat >/etc/sysconfig/network <<EOF
NETWORKING=yes
NETWORKING_IPV6=no
HOSTNAME=netbooter
EOF

#Turning of SE linux
/bin/cat >/etc/sysconfig/selinux <<EOF
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
#     targeted - Targeted processes are protected,
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted 
EOF

#Setting the networksettings
/bin/cat >>/root/ifcfg-eth0 <<EOF
DEVICE=eth0
NM_CONTROLLED=no
ONBOOT=yes
BOOTPROTO=dhcp
#IPADDR=192.168.56.254
#NETMASK=255.255.255.0
#TYPE=Ethernet
#GATEWAY=192.168.56.1
#IPV6INIT=no
#USERCTL=no
EOF

#Setting hostname for apache
/bin/echo "ServerName localhost">>/etc/httpd/conf/httpd.conf

#Adding upload account
/usr/sbin/useradd imager
/bin/echo "imager" | passwd --stdin imager > /dev/null

#Making directory for uploads
/bin/mkdir /var/www/html/restore

#Giving group write right
/bin/chmod 775 /var/www/html/restore/

#Changing group ownership
/bin/chown root:imager /var/www/html/restore/

# The script to fix the download file
/bin/cat >/root/fixit.sh <<EOF
MYIP=$(/sbin/ifconfig eth0 | /bin/grep inet | /bin/grep -v inet6 | /bin/cut -d ":" -f 2 | /bin/cut -d " " -f 1)

/bin/sed -i "s/theipadress/$MYIP/g" /var/www/html/Reinstall.app/Contents/Resources/script

/bin/sed -i "s/theipadress/$MYIP/g" /etc/dhcpd.conf

/bin/echo $MYIP >/var/www/html/restore/restore.conf

cd /var/www/html/

/usr/bin/zip -r Reinstall.zip Reinstall.app
/bin/cp -r /tftpboot/* /var/lib/tftpboot/
EOF
