FROM ghcr.io/tailscale/tailscale:v1.78.1
COPY run.sh /run.sh
CMD "/run.sh"
