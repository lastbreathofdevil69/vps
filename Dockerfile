FROM alpine:latest

ENV LANG=en_US.UTF-8
ENV LC_ALL=C.UTF-8
ENV HOME=/home/viru

# Install lightweight XFCE4, Papirus icons, TigerVNC, websockify, Falkon browser, and essential tools
RUN apk update && \
    apk add --no-cache \
        bash \
        sudo \
        shadow \
        curl \
        wget \
        git \
        nano \
        vim \
        htop \
        tar \
        ca-certificates \
        font-dejavu \
        font-noto \
        papirus-icon-theme \
        dbus-x11 \
        xfce4 \
        xfce4-terminal \
        thunar \
        mousepad \
        tigervnc \
        websockify \
        py3-numpy \
        falkon

# Install official clean noVNC v1.5.0
RUN rm -rf /usr/share/novnc && \
    mkdir -p /usr/share/novnc && \
    curl -sLk "https://github.com/novnc/noVNC/archive/refs/tags/v1.5.0.tar.gz" \
    | tar xzC /usr/share/novnc --strip-components=1

# Create non-root user 'viru' with passwordless sudo (password: viru)
RUN adduser -D -s /bin/bash -u 1000 viru && \
    echo "viru:viru" | chpasswd && \
    echo "viru ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configure noVNC index.html redirect to full-screen desktop with auto-connect
RUN echo '<!DOCTYPE html><html><head><meta charset="utf-8"><meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"><title>Alpine Linux Clean Desktop - viru</title><script>window.location.href="vnc.html?autoconnect=true&resize=scale&quality=5&compression=6";</script></head><body style="background:#202225;color:#fff;font-family:sans-serif;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;"><h3>Starting Clean Alpine Desktop (viru)...</h3></body></html>' > /usr/share/novnc/index.html

WORKDIR /home/viru

COPY entrypoint.sh /entrypoint.sh
COPY deup-gaming.sh /deup-gaming.sh
RUN chmod +x /entrypoint.sh /deup-gaming.sh

EXPOSE 10000

CMD ["/entrypoint.sh"]
