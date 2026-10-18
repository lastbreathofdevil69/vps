#!/bin/bash
set -e

PORT="${PORT:-10000}"
VNC_PASSWORD="${VNC_PASSWORD:-4215}"
RESOLUTION="${RESOLUTION:-1280x720}"
SOCK_PATH="/tmp/vnc.sock"

echo "========================================================"
echo " Starting Ubuntu 24.04 Desktop (XFCE) on port $PORT"
echo " User: viru"
echo " Resolution: $RESOLUTION (16-bit Fast Mode)"
echo " Browser: Falkon (Chromium-based)"
echo "========================================================"

# Clean up stale locks or sockets
rm -rf /tmp/.X11-unix /tmp/.X1-lock "$SOCK_PATH"
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Optimize XFCE for cloud environments: disable compositing & animations to maximize speed on 0.1 CPU
mkdir -p /home/viru/.config/xfce4/xfconf/xfce-perchannel-xml
cat << 'EOF' > /home/viru/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="use_compositing" type="bool" value="false"/>
    <property name="box_move" type="bool" value="true"/>
    <property name="box_resize" type="bool" value="true"/>
  </property>
</channel>
EOF

# Setup desktop icons for Falkon Browser and Terminal
mkdir -p /home/viru/Desktop
if [ -f /usr/share/applications/org.kde.falkon.desktop ]; then
    cp /usr/share/applications/org.kde.falkon.desktop /home/viru/Desktop/
fi
if [ -f /usr/share/applications/xfce4-terminal.desktop ]; then
    cp /usr/share/applications/xfce4-terminal.desktop /home/viru/Desktop/
fi
chmod +x /home/viru/Desktop/*.desktop 2>/dev/null || true

mkdir -p /home/viru/.vnc
chown -R viru:viru /home/viru

# Configure TigerVNC (Xvnc)
# -depth 16 reduces data transfer and CPU load by 50% compared to 24-bit
VNC_ARGS=(-geometry "$RESOLUTION" -depth 16 -rfbport -1 -rfbunixpath "$SOCK_PATH" -rfbunixmode 0666)

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
echo "Serving Ubuntu 24.04 Desktop on http://0.0.0.0:$PORT via $SOCK_PATH..."
exec websockify --web /usr/share/novnc "$PORT" --unix-target="$SOCK_PATH"
