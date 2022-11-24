#! /bin/sh
export PATH=$PATH:/tailscale/bin

AUTH_KEY="${AUTH_KEY:-}"
ROUTES="${ROUTES:-}"
EXTRA_ARGS="${EXTRA_ARGS:-}"
USERSPACE="${USERSPACE:-true}"

# If AUTH_KEY is not in env, attempt to find it under $AUTH_KEY_LOCAL_PATH
if [ -z "${AUTH_KEY}" ] && [ ! -z  "${AUTH_KEY_LOCAL_PATH}" ];  then
	AUTH_KEY=$(cat ${AUTH_KEY_LOCAL_PATH})
fi

set -e

TAILSCALED_ARGS="--socket=/tmp/tailscaled.sock"

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

wait ${PID}
