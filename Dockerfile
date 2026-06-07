FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apache2 \
        curl \
        procps \
        tar \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY scripts/ /app/scripts/
COPY source/ /app/source/

RUN mkdir -p \
        /app/backups \
        /app/logs \
        /app/evidencias \
        /app/jogos-multiplayer/dados \
    && chmod +x /app/scripts/*.sh \
    && rm -rf /var/www/html/* \
    && cp -r /app/source/. /var/www/html/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
