FROM ghcr.io/tailscale/tailscale:v1.86.5
COPY run.sh /run.sh
CMD "/run.sh"
