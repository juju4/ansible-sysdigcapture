[![Build Status](https://travis-ci.org/juju4/ansible-sysdigcapture.svg?branch=master)](https://travis-ci.org/juju4/ansible-sysdigcapture)
# Sysdig capture ansible role

A simple ansible role to install and execute sysdig.
https://github.com/draios/sysdig/
http://www.sysdig.org/

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9
 * 2.0

### Operating systems

Tested with vagrant on Ubuntu 14.04
Verified with kitchen (with issues, see below)

## Example Playbook

Just include this role in your list.
For example

```
- host: myhost
  roles:
    - sysdigcapture
```

you probably want to review variables


## Variables

```
prefix: "{{ ansible_fqdn }}"
dst_mount: "/tmp/cases"
dst_path: "{{ dst_mount }}/{{ prefix }}-incidentreport"

## do we want to install new packages? might be required if building kernel module for example
## allow ansible to download stuff which does not exist, eventually build it?
## more impacting the evidence but sometimes have no choice...
do_download: true
do_build: true
do_install: true

bin_path: "/tmp/ir-bin"
```

* bin_path: can be a network path or removable media. If local and 
  download/build/install is enabled, the role will add everything necessary.
  Of course, from a forensic perspective, better if everything is setup either
  before locally (but can be altered) or a network read-only share
* dst_path: where to store the output. again, came be local or remote.

## Continuous integration

you can test this role with test kitchen or travis.
```
$ cd /path/to/roles/myrole
$ kitchen verify
$ kitchen login
```

Known bugs
* sometimes issues with kernel headers of default install not available anymore for whatever reasons...
```
$ rpm -qa|grep kernel-headers; uname -a; ls -l /lib/modules/*/build
```
You would need either to fix build symlink, either to upgrade system and reboot which does not seem supported by kitchen
```
$ sudo ln -sf /usr/src/kernels/x.y.z-573.18.1.el6.x86_64 /lib/modules/x.y.z-573.el6.x86_64/build
## OR
$ sudo yum -y upgrade kernel
$ sudo reboot
```
https://github.com/test-kitchen/test-kitchen/issues/324
Once header and kernel are aligned, may need to re-compile modules manually
```
$ sudo /usr/lib/dkms/dkms_autoinstaller start
```
and 'kitchen verify' should work fine
* Travis CI is not testing execution as there is no kernel modules support
https://github.com/travis-ci/travis-ci/issues/2291


## Troubleshooting & Known issues

* compilation issue on Ubuntu 14.04
https://bugs.launchpad.net/ubuntu/+source/sysdig/+bug/1419402
https://github.com/draios/sysdig/issues/30

## License

BSD 2-clause


