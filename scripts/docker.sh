#!/bin/sh
set -eux

#### Configure System to handle Docker capabilities

# Make PAX in softmode - example for container with JVM
cat <<EOF >/etc/sysctl.d/10-docker.conf
kernel.pax.softmode=1
EOF

# Enable swap accounting for containers
sed -i 's/quiet/quiet cgroup_enable=memory swapaccount=1/' /boot/extlinux.conf


### Install Docker
apk add docker="${DOCKER_VERSION}-r0"

service docker stop
addgroup root docker
addgroup "${BASE_USER}" docker
service docker start
rc-update add docker boot

### Install Docker-compose
apk add py-pip
pip install --no-cache-dir --upgrade pip
pip install --no-cache-dir "docker-compose==${DOCKER_COMPOSE_VERSION}"

### Install docker bash completions
apk add docker-bash-completion

### Install docker vim
apk add vim
apk add docker-vim

### Install Docker-machine
curl -L https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
  chmod +x /tmp/docker-machine &&
  sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
