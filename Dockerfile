FROM ghcr.io/tailscale/tailscale:v1.94.2
COPY run.sh /run.sh
CMD "/run.sh"
