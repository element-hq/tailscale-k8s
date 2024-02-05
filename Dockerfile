FROM ghcr.io/tailscale/tailscale:v1.58.2
COPY run.sh /run.sh
CMD "/run.sh"
