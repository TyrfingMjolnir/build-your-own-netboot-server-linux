# Introduction #

the netboot image that gets served to the client, created as this as possible, but there is most likely room for improvement.


# Details #

the booter image is created on the most current OS version, the same as you wantto deploy. Get a hold of the latest InstallESD.img for your OSX of choice.

Download the entire folder booter and add the InstallESD.img file to the same directory.

navigate to this folder using terminal and become root:

sudo -s

run the create script:

./creator.sh

and wait for a loooooong time, speed this process up by running on SSD/flash based medium

You will end up with a file called booter.img that you can create a rpm with and any netboot set that are created using the same OS version.

Change the NBImageInfo.plist to reflect the NBImageInfo.plist in the folder (not sure if this is strictly necessary but I did)