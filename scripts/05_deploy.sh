#!/bin/bash

ORIGEM="/app/source"
DESTINO="/var/www/html"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/deploy.log"

registrar_log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

realizar_deploy() {
  mkdir -p "$LOG_DIR"

  if [ "$EUID" -ne 0 ]; then
    registrar_log "[ERRO] Execute este script como root."
    return 1
  fi

  if [ ! -f "$ORIGEM/index.html" ]; then
    registrar_log "[ERRO] Arquivo $ORIGEM/index.html não encontrado."
    return 1
  fi

  registrar_log "Limpando diretório de publicação."
  rm -rf "${DESTINO:?}"/*

  registrar_log "Copiando site estático para o Apache."
  cp -r "$ORIGEM"/. "$DESTINO"/

  if [ -f "$DESTINO/index.html" ]; then
    registrar_log "[OK] Deploy realizado com sucesso."
    registrar_log "Arquivos publicados:"
    find "$DESTINO" -maxdepth 3 -type f | sort | tee -a "$LOG_FILE"
  else
    registrar_log "[ERRO] O index.html não foi publicado corretamente."
    return 1
  fi
}

realizar_deploy
