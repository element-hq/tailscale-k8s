FROM ghcr.io/tailscale/tailscale:v1.52.0
COPY run.sh /run.sh
CMD "/run.sh"
