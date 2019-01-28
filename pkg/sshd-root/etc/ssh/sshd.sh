#!/bin/sh

test -e /run/config/sshd/disable_root && exit 0

mkdir -p /tmp/etc/ssh
ssh-keygen -A -f /tmp

exec /usr/sbin/sshd -D -e -p ${PORT:-22}
