FROM ghcr.io/tailscale/tailscale:v1.88.3
COPY run.sh /run.sh
CMD "/run.sh"
