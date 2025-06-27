FROM ghcr.io/tailscale/tailscale:v1.84.3
COPY run.sh /run.sh
CMD "/run.sh"
