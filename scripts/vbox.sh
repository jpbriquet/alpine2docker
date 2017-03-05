#!/bin/sh
set -uxe

### Install VirtualBox guest additions
apk add virtualbox-guest-additions virtualbox-guest-modules-grsec virtualbox-additions-grsec

# Autoload vbox modules at start
echo -e 'vboxpci\n'\
'vboxdrv\n'\
'vboxnetflt\n'\
'vboxsf'\
| tee -a /etc/modules

### Add virtualbox-guest-additions service
rc-update add virtualbox-guest-additions

### Remove openntpd service (time sync is handled by virtualbox-guest-additions)
rc-update del openntpd
