FROM ghcr.io/tailscale/tailscale:v1.50.0
COPY run.sh /run.sh
CMD "/run.sh"
