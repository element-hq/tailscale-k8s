FROM ghcr.io/tailscale/tailscale:v1.76.6
COPY run.sh /run.sh
CMD "/run.sh"
