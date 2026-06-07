#!/bin/bash

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/monitoramento.log"
LIMITE_CPU=80
LIMITE_MEMORIA=80
LIMITE_DISCO=80

registrar_log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

verificar_limite() {
  local recurso="$1"
  local valor="$2"
  local limite="$3"

  if [ "$valor" -ge "$limite" ]; then
    registrar_log "[ALERTA] Uso de $recurso acima ou igual a ${limite}%: ${valor}%"
  else
    registrar_log "[OK] Uso de $recurso: ${valor}%"
  fi
}

coletar_monitoramento() {
  mkdir -p "$LOG_DIR"

  local cpu memoria disco
  cpu=$(top -bn1 | awk -F',' '/Cpu\(s\)/ {gsub(/[^0-9.]/, "", $4); printf "%.0f", 100 - $4}')
  memoria=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2) * 100}')
  disco=$(df -P / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

  cpu=${cpu:-0}
  memoria=${memoria:-0}
  disco=${disco:-0}

  registrar_log "===== MONITORAMENTO DO SISTEMA ====="
  verificar_limite "CPU" "$cpu" "$LIMITE_CPU"
  verificar_limite "memória RAM" "$memoria" "$LIMITE_MEMORIA"
  verificar_limite "disco" "$disco" "$LIMITE_DISCO"

  if pgrep -x apache2 >/dev/null 2>&1; then
    registrar_log "[OK] Apache em execução."
  else
    registrar_log "[ALERTA] Apache não está em execução."
  fi
}

coletar_monitoramento
