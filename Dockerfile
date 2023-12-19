FROM ghcr.io/tailscale/tailscale:v1.56.1
COPY run.sh /run.sh
CMD "/run.sh"
