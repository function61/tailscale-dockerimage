FROM alpine

# Adapted from https://github.com/tailscale/tailscale/blob/main/Dockerfile

RUN mkdir -p /tmp/ts-install && cd /tmp/ts-install \
	&& wget https://pkgs.tailscale.com/stable/tailscale_1.2.8_amd64.tgz \
	&& tar -xzf tailscale_1.2.8_amd64.tgz \
	&& cd tailscale_1.2.8_amd64/ \
	&& cp tailscale tailscaled /usr/local/bin/ \
	&& cd / \
	&& rm -rf /tmp/ts-install \
	&& apk add --no-cache ca-certificates iptables iproute2

CMD tailscaled
