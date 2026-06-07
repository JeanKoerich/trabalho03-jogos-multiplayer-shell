#!/bin/bash

PROJECT_DIR="/app/jogos-multiplayer"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/estrutura.log"

registrar_log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

remover_estrutura_antiga() {
  if [ "$PROJECT_DIR" != "/app/jogos-multiplayer" ]; then
    registrar_log "[ERRO] Diretório inesperado. Remoção cancelada por segurança."
    return 1
  fi

  registrar_log "Removendo diretórios antigos que podem ser recriados."
  rm -rf \
    "$PROJECT_DIR/jogadores" \
    "$PROJECT_DIR/partidas" \
    "$PROJECT_DIR/ranking" \
    "$PROJECT_DIR/publicacao" \
    "$PROJECT_DIR/logs" \
    "$PROJECT_DIR/backups"
}

criar_estrutura() {
  mkdir -p "$LOG_DIR"
  remover_estrutura_antiga

  mkdir -p \
    "$PROJECT_DIR/jogadores" \
    "$PROJECT_DIR/partidas" \
    "$PROJECT_DIR/ranking" \
    "$PROJECT_DIR/dados" \
    "$PROJECT_DIR/publicacao" \
    "$PROJECT_DIR/logs" \
    "$PROJECT_DIR/backups"

  echo "Jogadores cadastrados no ambiente de demonstração" > "$PROJECT_DIR/jogadores/cadastro_inicial.txt"
  echo "Histórico de partidas do Pong Online" > "$PROJECT_DIR/partidas/historico_partidas.txt"
  echo "Ranking inicial do servidor multiplayer" > "$PROJECT_DIR/ranking/classificacao.txt"
  echo "Arquivos persistentes do servidor" > "$PROJECT_DIR/dados/README.txt"

  registrar_log "[OK] Estrutura temática criada em $PROJECT_DIR."
  find "$PROJECT_DIR" -maxdepth 2 -print | tee -a "$LOG_FILE"
}

criar_estrutura
