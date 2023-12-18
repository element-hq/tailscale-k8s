FROM ghcr.io/tailscale/tailscale:v1.56.0
COPY run.sh /run.sh
CMD "/run.sh"
