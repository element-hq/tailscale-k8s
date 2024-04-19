FROM ghcr.io/tailscale/tailscale:v1.64.2
COPY run.sh /run.sh
CMD "/run.sh"
