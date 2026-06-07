#!/bin/bash

PROJECT_DIR="/app/jogos-multiplayer"
LOG_DIR="/app/logs"
BACKUP_DIR="/app/backups"
PUBLICACAO_DIR="/var/www/html"
RELATORIO="$LOG_DIR/relatorio_execucao.txt"

status_apache() {
  if pgrep -x apache2 >/dev/null 2>&1; then
    echo "Apache em execução"
  else
    echo "Apache não está em execução"
  fi
}

gerar_relatorio() {
  mkdir -p "$LOG_DIR" "$BACKUP_DIR"

  {
    echo "=================================================="
    echo " RELATÓRIO OPERACIONAL - JOGOS MULTIPLAYER"
    echo "=================================================="
    echo "Data e hora: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Aluno: Jean Koerich"
    echo "Projeto: Servidor de Jogos Multiplayer com Pong Online"
    echo
    echo "===== ESPAÇO EM DISCO ====="
    df -h
    echo
    echo "===== USO DOS DIRETÓRIOS ====="
    du -sh "$PROJECT_DIR" "$BACKUP_DIR" "$LOG_DIR" "$PUBLICACAO_DIR" 2>/dev/null || true
    echo
    echo "===== STATUS DO APACHE ====="
    status_apache
    echo
    echo "===== ÚLTIMOS BACKUPS ====="
    ls -lht "$BACKUP_DIR" 2>/dev/null | head -n 10
    echo
    echo "===== ÚLTIMOS LOGS ====="
    ls -lht "$LOG_DIR" 2>/dev/null | head -n 15
    echo
    echo "===== ARQUIVOS PUBLICADOS ====="
    find "$PUBLICACAO_DIR" -maxdepth 3 -type f 2>/dev/null | sort
    echo
    echo "===== USUÁRIOS TEMÁTICOS ====="
    getent passwd pong_user || echo "Usuário pong_user ainda não configurado."
    getent group jogos_ops || echo "Grupo jogos_ops ainda não configurado."
    echo
    echo "===== PERMISSÕES PRINCIPAIS ====="
    ls -ld "$PROJECT_DIR" "$PROJECT_DIR/partidas" "$PROJECT_DIR/dados" "$PROJECT_DIR/logs" "$PROJECT_DIR/backups" 2>/dev/null || true
  } > "$RELATORIO"

  echo "[OK] Relatório gerado em $RELATORIO"
  cat "$RELATORIO"
}

gerar_relatorio
