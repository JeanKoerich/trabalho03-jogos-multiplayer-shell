#!/bin/bash

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/update.log"

registrar_log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

atualizar_sistema() {
  mkdir -p "$LOG_DIR"

  if [ "$EUID" -ne 0 ]; then
    registrar_log "[ERRO] Execute este script como root."
    return 1
  fi

  registrar_log "Iniciando atualização do sistema."

  if apt-get update && apt-get upgrade -y; then
    registrar_log "[OK] Sistema atualizado com sucesso."
  else
    registrar_log "[ERRO] Falha durante a atualização do sistema."
    return 1
  fi
}

atualizar_sistema
