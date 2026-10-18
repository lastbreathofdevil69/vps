FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=C.UTF-8
ENV HOME=/home/viru

# Install minimal XFCE4 desktop, TigerVNC, noVNC, Falkon web browser, and utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        git \
        nano \
        vim \
        sudo \
        htop \
        net-tools \
        iputils-ping \
        unzip \
        dbus-x11 \
        x11-xserver-utils \
        tigervnc-standalone-server \
        tigervnc-common \
        tigervnc-tools \
        novnc \
        websockify \
        python3-numpy \
        fonts-dejavu-core \
        fonts-freefont-ttf \
        xfce4 \
        xfce4-terminal \
        xfwm4 \
        xfce4-session \
        xfce4-panel \
        thunar \
        mousepad \
        desktop-base \
        falkon \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Safely remove default 'ubuntu' user if present in 24.04, then create user 'viru' (password: viru)
RUN if id -u ubuntu >/dev/null 2>&1; then userdel -r ubuntu; fi && \
    useradd -m -s /bin/bash -u 1000 viru && \
    echo "viru:viru" | chpasswd && \
    usermod -aG sudo viru && \
    echo "viru ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configure noVNC index.html redirect with cache-busting to prevent stale script errors
RUN echo '<!DOCTYPE html><html><head><meta charset="utf-8"><meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"><title>Ubuntu 24.04 Desktop - viru</title><script>window.location.href="vnc.html?autoconnect=true&resize=scale&quality=5&compression=6&v=24";</script></head><body style="background:#202225;color:#fff;font-family:sans-serif;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;"><h3>Starting Ubuntu 24.04 Desktop (viru)...</h3></body></html>' > /usr/share/novnc/index.html && \
    sed -i 's|src="app/ui.js"|src="app/ui.js?v=24"|g' /usr/share/novnc/vnc.html 2>/dev/null || true

WORKDIR /home/viru

COPY entrypoint.sh /entrypoint.sh
COPY deup-gaming.sh /deup-gaming.sh
RUN chmod +x /entrypoint.sh /deup-gaming.sh

EXPOSE 10000

CMD ["/entrypoint.sh"]
