#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/juju4.redhat_epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat_epel
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.sysdigcapture ] && ln -s ansible-sysdigcapture $rolesdir/juju4.sysdigcapture
[ ! -e $rolesdir/juju4.sysdigcapture ] && cp -R $rolesdir/ansible-sysdigcapture $rolesdir/juju4.sysdigcapture

## don't stop build on this script return code
true
