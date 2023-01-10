![Build status](https://github.com/function61/tailscale-dockerimage/workflows/Build/badge.svg)
[![Download](https://img.shields.io/docker/pulls/fn61/tailscale.svg?style=for-the-badge)](https://hub.docker.com/r/fn61/tailscale/)

[Tailscale](https://tailscale.com/) doesn't yet publish their Docker image.
See [their ticket](https://github.com/tailscale/tailscale/issues/295).

This is adapted from their [official Dockerfile](https://github.com/tailscale/tailscale/blob/main/Dockerfile).

DEPRECATED
----------

Tailscale has published their Docker image, and later even added multi-arch images (which was the final reason for me to support this repo).

Pro-tip: here's an example `docker-compose.yml` to get some equivalence to this image:

```yml
version: '3'
services:
  tailscale:
    restart: unless-stopped
    image: tailscale/tailscale:v1.34.2
    environment:
    # without this, uses "--state=mem" and uses ephemeral mode
    - TS_STATE_DIR=/var/lib/tailscale
    - TS_SOCKET=/var/run/tailscale/tailscaled.sock
    # defaults to true. ip routes don't get installed etc. maybe Tailscale isn't designed to work in a container in this manner
    # because we seem to be needing quite a bunch of overrides..
    - TS_USERSPACE=false
    devices:
    - /dev/net/tun
    # TODO: reduce to individual caps
    privileged: true
    network_mode: host
    volumes:
    - /persist/apps/tailscale-state:/var/lib/tailscale
    - /var/run/tailscale:/var/run/tailscale
```


NOTE
----

Tailscale now pushes their official Docker image, though it's still missing ARM builds (they only publish amd64).

I'll support this repo (with ARM build) until Tailscale fixes that.


Start tailscale daemon
----------------------

```console
$ docker run \
	-d \
	--name tailscaled \
	-v tailscale-state:/var/lib/tailscale \
	--device /dev/net/tun \
	--network host \
	--privileged \
	--restart unless-stopped \
	fn61/tailscale:SEE_TAG_FROM_DOCKERHUB
```

To join your node to network
----------------------------

```console
$ docker exec -it tailscaled tailscale up
```
