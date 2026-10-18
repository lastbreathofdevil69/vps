#!/bin/bash
set -e

PORT="${PORT:-10000}"
VNC_PASSWORD="${VNC_PASSWORD:-viru123}"
RESOLUTION="${RESOLUTION:-1280x720}"
SOCK_PATH="/tmp/vnc.sock"

echo "========================================================"
echo " Starting Ubuntu Desktop (XFCE) on port $PORT"
echo " User: viru"
echo " Resolution: $RESOLUTION"
echo "========================================================"

# Clean up stale locks or sockets
rm -rf /tmp/.X11-unix /tmp/.X1-lock "$SOCK_PATH"
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Ensure viru's home directory permissions
mkdir -p /home/viru/.vnc
chown -R viru:viru /home/viru

# Configure TigerVNC (Xvnc)
# -rfbport -1 disables TCP listening so Render never routes traffic to port 5900
VNC_ARGS=(-geometry "$RESOLUTION" -depth 24 -rfbport -1 -rfbunixpath "$SOCK_PATH" -rfbunixmode 0666)

if [ "$VNC_PASSWORD" = "none" ] || [ -z "$VNC_PASSWORD" ]; then
    echo "Starting Xvnc with no password..."
    VNC_ARGS+=(-SecurityTypes None)
else
    echo "Configuring VNC password..."
    echo "$VNC_PASSWORD" | vncpasswd -f > /home/viru/.vnc/passwd
    chmod 600 /home/viru/.vnc/passwd
    chown viru:viru /home/viru/.vnc/passwd
    VNC_ARGS+=(-SecurityTypes VncAuth -PasswordFile /home/viru/.vnc/passwd)
fi

echo "Starting Xvnc virtual display on :1..."
Xvnc :1 "${VNC_ARGS[@]}" &
sleep 2

# Start XFCE4 desktop session as user 'viru'
echo "Starting XFCE desktop session for user viru..."
su - viru -c "DISPLAY=:1 dbus-launch --exit-with-session startxfce4" &
sleep 2

# Start websockify bridging Render's $PORT directly to Unix socket
echo "Serving Ubuntu Desktop on http://0.0.0.0:$PORT via $SOCK_PATH..."
exec websockify --web /usr/share/novnc "$PORT" --unix-target="$SOCK_PATH"
