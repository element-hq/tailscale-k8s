FROM ghcr.io/tailscale/tailscale:v1.88.4
COPY run.sh /run.sh
CMD "/run.sh"
