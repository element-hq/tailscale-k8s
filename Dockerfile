FROM ghcr.io/tailscale/tailscale:v1.90.8
COPY run.sh /run.sh
CMD "/run.sh"
