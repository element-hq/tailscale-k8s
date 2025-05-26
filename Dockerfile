FROM ghcr.io/tailscale/tailscale:v1.84.0
COPY run.sh /run.sh
CMD "/run.sh"
