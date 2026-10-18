#!/bin/bash
set -e

# Use Render's $PORT environment variable if set, otherwise default to 8080
export GOTTY_PORT="${PORT:-8080}"
export TERM="${TERM:-xterm-256color}"

ARGS=(--port "$GOTTY_PORT" --permit-write --reconnect)

# Optional password protection: set GOTTY_CREDENTIAL="username:password" in Render environment variables
if [ -n "$GOTTY_CREDENTIAL" ]; then
    ARGS+=(--credential "$GOTTY_CREDENTIAL")
fi

echo "Starting Gotty Ubuntu terminal on port $GOTTY_PORT..."
exec /usr/local/bin/gotty "${ARGS[@]}" /bin/bash
