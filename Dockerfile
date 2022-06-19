FROM ghcr.io/tailscale/tailscale:v1.27.12
COPY run.sh /run.sh
CMD "/run.sh"
