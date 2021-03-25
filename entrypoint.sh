#!/bin/sh

set -eu

# sync with https://github.com/fphammerle/docker-gitolite/blob/master/entrypoint.sh
if [ ! -f "$SSHD_HOST_KEYS_DIR/rsa" ]; then
    ssh-keygen -t rsa -b 4096 -N '' -f "$SSHD_HOST_KEYS_DIR/rsa"
fi
if [ ! -f "$SSHD_HOST_KEYS_DIR/ed25519" ]; then
    ssh-keygen -t ed25519 -N '' -f "$SSHD_HOST_KEYS_DIR/ed25519"
fi
unset SSHD_HOST_KEYS_DIR

authorized_keys_path="$CLIENT_HOME/.ssh/authorized_keys"
printenv SSH_CLIENT_PUBLIC_KEYS > "$authorized_keys_path"
chmod a+r "$authorized_keys_path"
unset SSH_CLIENT_PUBLIC_KEYS
unset CLIENT_USER
unset CLIENT_HOME

set -x

exec "$@"
