FROM docker.io/alpine:3.14.0

ARG OPENSSH_SERVER_PACKAGE_VERSION=8.4_p1-r3
ENV SSHD_HOST_KEYS_DIR=/etc/ssh/host_keys
ENV CLIENT_USER=nonroot
ENV CLIENT_HOME=/home/$CLIENT_USER
ARG CHROOT_PATH=/data
RUN apk add --no-cache \
        openssh-server="$OPENSSH_SERVER_PACKAGE_VERSION" \
        openssh-sftp-server="$OPENSSH_SERVER_PACKAGE_VERSION" \
    && mkdir "$SSHD_HOST_KEYS_DIR" \
    && adduser -S -h "$CLIENT_HOME" "$CLIENT_USER" \
    && sed -i "s/^$CLIENT_USER:!:/$CLIENT_USER:*:/" /etc/shadow \
    && mkdir "$CLIENT_HOME/.ssh" \
    && chmod -c a+rX "$CLIENT_HOME/.ssh" \
    && mkdir "$CHROOT_PATH" \
    && chmod -c a+rX "$CHROOT_PATH"
VOLUME $SSHD_HOST_KEYS_DIR
VOLUME $CHROOT_PATH

COPY sshd_config /etc/ssh/sshd_config
EXPOSE 2200/tcp

ENV SSH_CLIENT_PUBLIC_KEYS=
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# uid=0 required for ChrootDirectory option
# https://unix.stackexchange.com/a/224329/155174
USER 0
CMD ["/usr/sbin/sshd", "-D", "-e"]

# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
ARG REVISION=
LABEL org.opencontainers.image.title="single-user openssh server restricted to sftp access" \
    org.opencontainers.image.source="https://github.com/fphammerle/docker-sftpd" \
    org.opencontainers.image.revision="$REVISION"
