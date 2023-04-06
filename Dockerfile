FROM ghcr.io/tailscale/tailscale:v1.38.4
COPY run.sh /run.sh
CMD "/run.sh"
