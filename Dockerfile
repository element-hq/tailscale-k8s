FROM ghcr.io/tailscale/tailscale:v1.66.3
COPY run.sh /run.sh
CMD "/run.sh"
