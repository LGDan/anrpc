FROM alpine:3.16.1

LABEL org.opencontainers.image.authors="github.com/LGDan"
RUN mkdir /app
WORKDIR /app

# Standard Packages
RUN apk add --no-cache \
    nodejs-lts \
    npm \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    curl \
    git

# Edge Packages
RUN apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust

# Powershell
RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.2.5/powershell-7.2.5-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz
RUN mkdir -p /opt/microsoft/powershell/7
RUN tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7
RUN chmod +x /opt/microsoft/powershell/7/pwsh
RUN ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
RUN ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/powershell

# Node-Red
RUN npm install -g --unsafe-perm node-red
RUN npm install -g node-red-contrib-powershell
RUN git clone https://github.com/LGDan/node-red-contrib-cloudhook-client.git \
 && cd node-red-contrib-cloudhook-client \
 && npm install -g \
 && npm install

EXPOSE 1880

ENTRYPOINT node-red --userDir /app
