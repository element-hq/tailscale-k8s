FROM ghcr.io/tailscale/tailscale:v1.90.5
COPY run.sh /run.sh
CMD "/run.sh"
