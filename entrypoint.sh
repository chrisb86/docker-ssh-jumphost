#! /bin/sh

CONFIG_DIR="/config"
USER="bastion"
PORT="2222"

## Ensure host ssh keys
if [ ! -f "/config/ssh_host_rsa_key" ]; then
    ssh-keygen -t rsa -b 4096 -f /config/ssh_host_rsa_key -N ""
fi

if [ ! -f "/config/ssh_host_ed25519_key" ]; then
    ssh-keygen -t ed25519 -f /config/ssh_host_ed25519_key -N ""
fi

## Ensure authorized_keys file and link it to user's home
touch ${CONFIG_DIR}/authorized_keys

chown -R ${USER}:${USER} /config

set -xv

/usr/sbin/sshd -D -e -4
