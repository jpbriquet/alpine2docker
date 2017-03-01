#!/bin/sh
set -uxe

# Disable root login
sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config

# Don't use DNS to make 'vagrant ssh' connections faster
sed -i "s/#UseDNS no/UseDNS no/g" /etc/ssh/sshd_config
