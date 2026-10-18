#!/bin/bash
set -e

PORT="${PORT:-10000}"
VNC_PASSWORD="${VNC_PASSWORD:-viru123}"
RESOLUTION="${RESOLUTION:-1280x720}"

echo "========================================================"
echo " Starting Ubuntu Desktop (XFCE) on port $PORT"
echo " User: viru"
echo " Resolution: $RESOLUTION"
echo "========================================================"

# Fix permissions on viru's home directory
chown -R viru:viru /home/viru

# Start Xvfb (Virtual Framebuffer Display :1)
echo "Starting Virtual Display Xvfb on :1..."
Xvfb :1 -screen 0 "${RESOLUTION}x24" &
sleep 2

# Configure and start x11vnc
mkdir -p /home/viru/.vnc
if [ "$VNC_PASSWORD" = "none" ] || [ -z "$VNC_PASSWORD" ]; then
    echo "Starting x11vnc with no password..."
    x11vnc -display :1 -nopw -forever -shared -rfbport 5900 -listen 127.0.0.1 &
else
    echo "Configuring VNC password..."
    x11vnc -storepasswd "$VNC_PASSWORD" /home/viru/.vnc/passwd
    chown viru:viru /home/viru/.vnc/passwd
    chmod 600 /home/viru/.vnc/passwd
    x11vnc -display :1 -rfbauth /home/viru/.vnc/passwd -forever -shared -rfbport 5900 -listen 127.0.0.1 &
fi
sleep 2

# Start XFCE4 desktop session as user 'viru'
echo "Starting XFCE desktop session for user viru..."
su - viru -c "DISPLAY=:1 dbus-launch --exit-with-session startxfce4" &
sleep 2

# Start noVNC websockify bridge in the foreground (binds to Render's $PORT)
echo "Serving Ubuntu Desktop on http://0.0.0.0:$PORT..."
exec websockify --web /usr/share/novnc "$PORT" 127.0.0.1:5900
