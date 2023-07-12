#! /bin/sh
export PATH=$PATH:/tailscale/bin

LOW_PORT=$(cat /proc/sys/net/ipv4/ip_local_port_range | cut -d '' -f1 )
HIGH_PORT=$(cat /proc/sys/net/ipv4/ip_local_port_range | cut -d '' -f2 )

AUTH_KEY="${AUTH_KEY:-}"
ROUTES="${ROUTES:-}"
EXTRA_ARGS="${EXTRA_ARGS:-}"
USERSPACE="${USERSPACE:-true}"
OUTBOUND_PROXY=${OUTBOUND_PROXY:-true}
RANDOMIZE_PORT=${RANDOMIZE_PORT:-false}

# If AUTH_KEY is not in env, attempt to find it under $AUTH_KEY_LOCAL_PATH
if [ -z "${AUTH_KEY}" ] && [ ! -z  "${AUTH_KEY_LOCAL_PATH}" ];  then
	AUTH_KEY=$(cat ${AUTH_KEY_LOCAL_PATH})
fi

set -e

TAILSCALED_ARGS="--socket=/tmp/tailscaled.sock"


while true
do
	if [[ "${RANDOMIZE_PORT}" == "true" ]]; then
	  UDP_PORT=$(shuf -i ${LOW_PORT}-${HIGH_PORT} -n 1)
	  TAILSCALED_ARGS="${TAILSCALED_ARGS} --port ${UDP_PORT}"
	fi

	if [[ "${OUTBOUND_PROXY}" == "true" ]]; then
	  TAILSCALED_ARGS="${TAILSCALED_ARGS} --outbound-http-proxy-listen=localhost:1055"
	fi

	if [[ "${USERSPACE}" == "true" ]]; then
	  TAILSCALED_ARGS="${TAILSCALED_ARGS} --tun=userspace-networking"
	else
	  if [[ ! -d /dev/net ]]; then
		mkdir -p /dev/net
	  fi

	  if [[ ! -c /dev/net/tun ]]; then
		mknod /dev/net/tun c 10 200
	  fi
	fi

	echo "Starting tailscaled"
	tailscaled ${TAILSCALED_ARGS} &
	PID=$!

	UP_ARGS="--accept-dns=false"
	if [[ ! -z "${ROUTES}" ]]; then
	  UP_ARGS="--advertise-routes=${ROUTES} ${UP_ARGS}"
	fi
	if [[ ! -z "${AUTH_KEY}" ]]; then
	  UP_ARGS="--authkey=${AUTH_KEY} ${UP_ARGS}"
	fi
	if [[ ! -z "${EXTRA_ARGS}" ]]; then
	  UP_ARGS="${UP_ARGS} ${EXTRA_ARGS:-}"
	fi

	echo "Running tailscale up"
	tailscale --socket=/tmp/tailscaled.sock up ${UP_ARGS}
	if [ $? -eq 0 ]
	then
		break;
	else
		sleep 1
	fi
done


wait ${PID}
