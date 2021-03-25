# docker: sftpd 💾 🐳 🐙

Single-user [OpenSSH server](https://www.openssh.com/) restricted to SFTP access

```sh
$ sudo docker run --name sftpd \
    -v ssh_host_keys:/etc/ssh/host_keys:rw \
    -v /somewhere:/data:rw \
    --tmpfs /home/nonroot/.ssh,size=16k \
    -p 2200:2200 \
    -e SSH_CLIENT_PUBLIC_KEYS="$(cat ~/.ssh/id_*.pub)" \
    --read-only --security-opt=no-new-privileges \
    --cap-drop=ALL --cap-add SETUID --cap-add SETGID --cap-add SYS_CHROOT \
    docker.io/fphammerle/sftpd

$ sshfs -p 2200 nonroot@localhost:/ /mount/point
```

`sudo docker` may be replaced with `podman`.

Pre-built docker images are available at https://hub.docker.com/r/fphammerle/sftpd/tags
(mirror: https://quay.io/repository/fphammerle/sftpd?tab=tags)

Annotation of signed git tags `docker/*` contains docker image digests: https://github.com/fphammerle/docker-sftpd/tags

Detached signatures of images are available at https://github.com/fphammerle/container-image-sigstore
(exluding automatically built `latest` tag).

### Docker Compose 🐙

1. `git clone https://github.com/fphammerle/docker-sftpd`
2. Adapt public keys to `SSH_CLIENT_PUBLIC_KEYS` in [docker-compose.yml](docker-compose.yml)
3. `docker-compose up --build`
