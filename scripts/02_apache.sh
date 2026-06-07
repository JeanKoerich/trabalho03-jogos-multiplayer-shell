#!/bin/bash

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/apache.log"

registrar_log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

instalar_apache() {
  mkdir -p "$LOG_DIR"

  if [ "$EUID" -ne 0 ]; then
    registrar_log "[ERRO] Execute este script como root."
    return 1
  fi

  if command -v apache2 >/dev/null 2>&1; then
    registrar_log "[OK] Apache já está instalado."
    return 0
  fi

  registrar_log "Instalando Apache."
  if apt-get update && apt-get install -y apache2; then
    registrar_log "[OK] Apache instalado com sucesso."
  else
    registrar_log "[ERRO] Não foi possível instalar o Apache."
    return 1
  fi
}

verificar_apache() {
  if pgrep -x apache2 >/dev/null 2>&1; then
    registrar_log "[OK] Apache está em execução."
  else
    registrar_log "Apache não está em execução. Tentando iniciar o serviço."
    apachectl start
    sleep 2

    if pgrep -x apache2 >/dev/null 2>&1; then
      registrar_log "[OK] Apache iniciado com sucesso."
    else
      registrar_log "[ERRO] Não foi possível iniciar o Apache."
      return 1
    fi
  fi
}

versao_apache() {
  registrar_log "Versão instalada: $(apache2 -v | head -n 1)"
}

instalar_apache
verificar_apache
versao_apache
