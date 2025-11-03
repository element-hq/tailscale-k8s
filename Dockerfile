FROM ghcr.io/tailscale/tailscale:v1.90.6
COPY run.sh /run.sh
CMD "/run.sh"
