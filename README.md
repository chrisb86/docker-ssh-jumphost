# docker-ssh-jumphost

Dockerfile for building an image that runs an OpenSSH server that's configured to act as a ProxJump host only.

The server listens on port 2222. The only user that is able ta connect is _bastion_. It is not possible to get a terminal on the host. It is only suitable to ProxyJump to other hosts.

At the first startup the host SSH keys will be created in _/config_ as well as an _authorized_keys_ file.

Just build the image, define a volume oder bind mount for _/config_ and add your public key to the _authorized_keys_ file.

Expose port 2222 and you can connect as user _bastion_ with your defined private key.

## Sample config for _docker-compose_

```yml
version: "3"

services:
  ssh-jumphost:
    container_name: ssh-jumphost
    build:
      context: https://github.com/chrisb86/docker-ssh-jumphost.git
    volumes:
      - ./config:/config
    ports:
      - 2222:2222
    tmpfs:
      - /tmp
      - /run
      - /var/tmp
    read_only: true
```

In this example the whole container is readonly and directories that have to be writable are mounted with tmpfs.

Just create the _docker-compose.yml_ run `docker-compose up -d --build`and you're done.