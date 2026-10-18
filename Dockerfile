FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=C.UTF-8
ENV TERM=xterm-256color
ENV GOTTY_TAG_VER=v1.0.1

# Install common Ubuntu VPS utilities and GoTTY
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
        tmux \
        net-tools \
        iputils-ping \
        unzip \
    && curl -sLk "https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz" \
       | tar xzC /usr/local/bin \
    && chmod +x /usr/local/bin/gotty \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

COPY .gotty /root/.gotty
COPY entrypoint.sh /entrypoint.sh
COPY deup-gaming.sh /deup-gaming.sh
RUN chmod +x /entrypoint.sh /deup-gaming.sh

EXPOSE 8080 10000

CMD ["/entrypoint.sh"]
