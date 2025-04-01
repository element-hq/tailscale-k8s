FROM ghcr.io/tailscale/tailscale:v1.82.0
COPY run.sh /run.sh
CMD "/run.sh"
