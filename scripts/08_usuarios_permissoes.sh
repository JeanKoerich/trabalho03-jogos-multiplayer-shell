#!/bin/bash

GRUPO="jogos_ops"
USUARIO="pong_user"
PROJECT_DIR="/app/jogos-multiplayer"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/usuarios_permissoes.log"

registrar_log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

configurar_usuarios_permissoes() {
  mkdir -p "$LOG_DIR" "$PROJECT_DIR/partidas" "$PROJECT_DIR/dados" "$PROJECT_DIR/logs" "$PROJECT_DIR/backups"

  if [ "$EUID" -ne 0 ]; then
    registrar_log "[ERRO] Execute este script como root."
    return 1
  fi

  if getent group "$GRUPO" >/dev/null 2>&1; then
    registrar_log "Grupo $GRUPO já existe."
  else
    groupadd "$GRUPO"
    registrar_log "[OK] Grupo $GRUPO criado."
  fi

  if id "$USUARIO" >/dev/null 2>&1; then
    registrar_log "Usuário $USUARIO já existe."
  else
    useradd --system --gid "$GRUPO" --home-dir "$PROJECT_DIR" --shell /usr/sbin/nologin "$USUARIO"
    registrar_log "[OK] Usuário de sistema $USUARIO criado."
  fi

  chown -R "$USUARIO:$GRUPO" "$PROJECT_DIR"
  chmod 750 "$PROJECT_DIR"
  chmod 770 "$PROJECT_DIR/partidas" "$PROJECT_DIR/dados" "$PROJECT_DIR/logs" "$PROJECT_DIR/backups"

  registrar_log "[OK] Proprietários e permissões aplicados sem utilizar chmod 777."
  ls -ld "$PROJECT_DIR" "$PROJECT_DIR/partidas" "$PROJECT_DIR/dados" "$PROJECT_DIR/logs" "$PROJECT_DIR/backups" | tee -a "$LOG_FILE"
}

configurar_usuarios_permissoes
