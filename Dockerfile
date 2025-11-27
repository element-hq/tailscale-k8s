FROM ghcr.io/tailscale/tailscale:v1.90.9
COPY run.sh /run.sh
CMD "/run.sh"
