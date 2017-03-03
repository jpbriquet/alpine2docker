#!/bin/sh
set -uxe

# Setup apk repositories
echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/community\n'\
'http://dl-cdn.alpinelinux.org/alpine/edge/testing'\
    | tee -a /etc/apk/repositories

# Update system
apk update
apk upgrade -U --available

# Install base packages
apk add curl bash bash-completion

# Configure root to use bash
sed -i 's#/ash#/bash#g' /etc/passwd

# Trick vagrant by creating a dummy shutdown command
cat <<EOF > /sbin/shutdown
#!/bin/sh
echo "INFO: Got the command: shutdown ${*}"
echo "INFO: Replacing by: poweroff"
/sbin/poweroff
EOF
chmod a+x /sbin/shutdown

# Create a persisted folder for the customized resources
mkdir -p /var/customize
chmod -R 777 /var/customize
