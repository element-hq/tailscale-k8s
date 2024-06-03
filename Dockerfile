FROM ghcr.io/tailscale/tailscale:v1.66.4
COPY run.sh /run.sh
CMD "/run.sh"
