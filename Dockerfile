FROM alpine

# Adapted from https://github.com/tailscale/tailscale/blob/main/Dockerfile

RUN mkdir -p /tmp/ts-install && cd /tmp/ts-install \
	&& wget -O tailscale.tar.gz https://pkgs.tailscale.com/stable/tailscale_1.4.1_amd64.tgz \
	&& tar --strip-components=1 -xzf tailscale.tar.gz \
	&& cp tailscale tailscaled /usr/local/bin/ \
	&& rm -rf /tmp/ts-install \
	&& apk add --no-cache ca-certificates iptables iproute2

CMD tailscaled

