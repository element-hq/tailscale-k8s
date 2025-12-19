FROM ghcr.io/tailscale/tailscale:v1.92.4
COPY run.sh /run.sh
CMD "/run.sh"
