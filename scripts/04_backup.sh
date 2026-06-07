#!/bin/bash

ORIGEM="/app/jogos-multiplayer"
DESTINO="/app/backups"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/backup.log"
DATA_HORA=$(date '+%Y-%m-%d_%H-%M-%S')
ARQUIVO_BACKUP="$DESTINO/backup_jogos_multiplayer_$DATA_HORA.tar.gz"

registrar_log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

realizar_backup() {
  mkdir -p "$DESTINO" "$LOG_DIR"

  if [ ! -d "$ORIGEM" ]; then
    registrar_log "[ERRO] Diretório de origem não encontrado: $ORIGEM"
    registrar_log "Execute primeiro o script 03_estrutura.sh."
    return 1
  fi

  registrar_log "Iniciando backup de $ORIGEM."

  if tar -czf "$ARQUIVO_BACKUP" -C "$(dirname "$ORIGEM")" "$(basename "$ORIGEM")"; then
    if [ -s "$ARQUIVO_BACKUP" ]; then
      registrar_log "[OK] Backup criado: $ARQUIVO_BACKUP"
      ls -lh "$ARQUIVO_BACKUP" | tee -a "$LOG_FILE"
    else
      registrar_log "[ERRO] O arquivo de backup foi criado, mas está vazio."
      return 1
    fi
  else
    registrar_log "[ERRO] Falha ao gerar o backup."
    return 1
  fi
}

realizar_backup
