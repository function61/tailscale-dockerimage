FROM alpine:latest

# "amd64" | "arm" | ...
ARG TARGETARCH

# Adapted from https://github.com/tailscale/tailscale/blob/main/Dockerfile

ENTRYPOINT ["/usr/local/bin/tailscaled"]

RUN mkdir -p /tmp/ts-install && cd /tmp/ts-install \
	&& apk add --no-cache ca-certificates iptables iproute2 curl \
	&& curl -fsSL -o tailscale.tar.gz "https://pkgs.tailscale.com/stable/tailscale_1.8.7_$TARGETARCH.tgz" \
	&& tar --strip-components=1 -xzf tailscale.tar.gz \
	&& cp tailscale tailscaled /usr/local/bin/ \
	&& rm -rf /tmp/ts-install


