#!/bin/bash

MYPATH=$(dirname $0)

BASEIMAGE='InstallESD.dmg'
THINIMAGE='/private/tmp/thinInstallESD.dmg'
NETBOOTIMAGE='/private/tmp/NetInstall.dmg'

/usr/bin/hdiutil mount -mountpoint $MYPATH/source $MYPATH/$BASEIMAGE -shadow $THINIMAGE.shadow
/bin/rm -rf $MYPATH/source/Install\ Mac\ OS\ X\ Lion.app
#/bin/rm -rf $MYPATH/source/Install\ OS\ X\ Mountain\ Lion.app
/bin/rm -rf $MYPATH/source/Packages

/usr/bin/hdiutil mount -mountpoint $MYPATH/nestedsource $MYPATH/source/BaseSystem.dmg -shadow /private/tmp/bootImageCreatorNested.shadow

/bin/cp $MYPATH/rc.cdrom.local $MYPATH/nestedsource/private/etc/
/bin/cp $MYPATH/installer.sh $MYPATH/nestedsource/private/etc/
/bin/cp $MYPATH/bash_profile $MYPATH/nestedsource/var/root/.bash_profile
#/bin/cp /usr/bin/read $MYPATH/nestedsource/usr/bin/
/bin/cp /usr/bin/ldapsearch $MYPATH/nestedsource/usr/bin/
/bin/cp -r /System/Library/PrivateFrameworks/PasswordServer.framework $MYPATH/nestedsource/System/Library/PrivateFrameworks/PasswordServer.framework
/bin/cp /usr/bin/curl $MYPATH/nestedsource/usr/bin/
/bin/cp /usr/sbin/arp $MYPATH/nestedsource/usr/sbin/
/bin/cp /usr/bin/syslog $MYPATH/nestedsource/usr/bin/
/usr/sbin/chown root:wheel $MYPATH/nestedsource/private/etc/rc.cdrom.local
/usr/sbin/chown root:wheel $MYPATH/nestedsource/private/etc/installer.sh
/bin/chmod +x $MYPATH/nestedsource/private/etc/installer.sh
/bin/echo NumberOfPasswordPrompts 1 >>$MYPATH/nestedsource/private/etc/ssh_config

/usr/bin/hdiutil create -format UDZO -imagekey zlib-level=6 -puppetstrings -srcfolder $MYPATH/nestedsource/ /private/tmp/BaseSystem.dmg

/bin/mv /private/tmp/BaseSystem.dmg $MYPATH/source/

/usr/bin/hdiutil create -format UDZO -imagekey zlib-level=6 -puppetstrings -srcfolder $MYPATH/source/ $NETBOOTIMAGE

/usr/bin/hdiutil eject $MYPATH/nestedsource/

/usr/bin/hdiutil eject $MYPATH/source/

/bin/rm -rf /private/tmp/bootImageCreatorNested.shadow

/bin/rm -rf $THINIMAGE.shadow

/bin/mv $NETBOOTIMAGE $MYPATH

/usr/sbin/asr imagescan --verbose --source $MYPATH/NetInstall.dmg

/bin/mv $MYPATH/NetInstall.dmg $MYPATH/booter.dmg