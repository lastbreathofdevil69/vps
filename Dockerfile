FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=C.UTF-8
ENV HOME=/home/viru

# Install minimal XFCE4 desktop, TigerVNC (Xvnc), noVNC, and python3-pip
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
        python3-pip \
        python3-setuptools \
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
    && pip3 install --no-cache-dir --upgrade websockify \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create user viru with sudo privileges (password: viru)
RUN useradd -m -s /bin/bash -u 1000 viru && \
    echo "viru:viru" | chpasswd && \
    usermod -aG sudo viru && \
    echo "viru ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configure noVNC index.html redirect to full-screen desktop with optimized quality
RUN echo '<!DOCTYPE html><html><head><meta charset="utf-8"><title>Ubuntu Desktop - viru</title><script>window.location.href="vnc.html?autoconnect=true&resize=scale&quality=4&compression=7";</script></head><body style="background:#202225;color:#fff;font-family:sans-serif;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;"><h3>Connecting to Ubuntu Desktop (viru)...</h3></body></html>' > /usr/share/novnc/index.html

WORKDIR /home/viru

COPY entrypoint.sh /entrypoint.sh
COPY deup-gaming.sh /deup-gaming.sh
RUN chmod +x /entrypoint.sh /deup-gaming.sh

EXPOSE 10000

CMD ["/entrypoint.sh"]
