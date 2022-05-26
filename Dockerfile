FROM ghcr.io/tailscale/tailscale:v1.24.2
COPY run.sh /run.sh
CMD "/run.sh"
