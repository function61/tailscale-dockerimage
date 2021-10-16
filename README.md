![Build status](https://github.com/function61/tailscale-dockerimage/workflows/Build/badge.svg)
[![Download](https://img.shields.io/docker/pulls/fn61/tailscale.svg?style=for-the-badge)](https://hub.docker.com/r/fn61/tailscale/)

[Tailscale](https://tailscale.com/) doesn't yet publish their Docker image.
See [their ticket](https://github.com/tailscale/tailscale/issues/295).

This is adapted from their [official Dockerfile](https://github.com/tailscale/tailscale/blob/main/Dockerfile).

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
