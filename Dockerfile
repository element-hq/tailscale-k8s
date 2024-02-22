FROM ghcr.io/tailscale/tailscale:v1.61.11
COPY run.sh /run.sh
CMD "/run.sh"
