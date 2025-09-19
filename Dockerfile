FROM ghcr.io/tailscale/tailscale:v1.88.2
COPY run.sh /run.sh
CMD "/run.sh"
