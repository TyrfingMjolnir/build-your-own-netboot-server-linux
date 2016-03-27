# Introduction #

Howto set up the boxgrinder box that will build your appliances


# Details #

Do a fresh install of fedora 15 or later, no need for any graphical interfaces.

Do a yum install rubygem-boxgrinder-build createrepo -y

And a yum update -y

Now you have a complete boxgrinder setup. Copy the netbooter catalog to any directory that have loads of space, atleast 60 Gb free.

Change the configure.sh script to suit your keyboard needs, it is set to swedish in the code.

Also on the same box copy your rpms that are needed, booter and restorescript to the repopath of your choice, in the code it points to /var/myrepo

Before building the appliance create a repo at the path:

createrepo /var/myrepo

Now build:

boxgrinder-build netbooter.appl

and check in the build directory:

build/appliances/i686/centos/6/netbooter/1.0/centos-plugin/

for the newly created kvm image.

If you want to run the newly created appliance in virtualbox, add this switch:

boxgrinder-build netbooter.appl -p virtualbox

and check in this directory:

build/appliances/i686/centos/6/netbooter/1.0/virtualbox-plugin

for an vmdk file that you can copy to your mac and run in virtual box.