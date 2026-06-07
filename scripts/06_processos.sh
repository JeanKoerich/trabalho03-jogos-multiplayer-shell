#!/bin/bash

listar_processos() {
  echo "===== PROCESSOS ATIVOS ====="
  ps aux
}

buscar_processo() {
  local nome="$1"

  if [ -z "$nome" ]; then
    echo "Informe o nome do processo."
    echo "Exemplo: ./06_processos.sh buscar apache"
    return 1
  fi

  echo "===== BUSCA POR PROCESSO: $nome ====="
  pgrep -af "$nome" || echo "Nenhum processo encontrado."
}

matar_processo() {
  local pid="$1"

  if [ -z "$pid" ]; then
    echo "PID não informado. Encerramento cancelado."
    echo "Exemplo: ./06_processos.sh matar 1234"
    return 1
  fi

  if ! [[ "$pid" =~ ^[0-9]+$ ]]; then
    echo "PID inválido: $pid"
    return 1
  fi

  if [ "$pid" -eq 1 ]; then
    echo "Por segurança, o processo PID 1 não pode ser encerrado por este script."
    return 1
  fi

  if ! ps -p "$pid" >/dev/null 2>&1; then
    echo "Processo PID $pid não encontrado."
    return 1
  fi

  echo "Encerrando processo PID $pid..."
  kill "$pid"
  echo "Processo encerrado."
}

case "$1" in
  listar)
    listar_processos
    ;;
  buscar)
    buscar_processo "$2"
    ;;
  matar)
    matar_processo "$2"
    ;;
  *)
    echo "Uso: $0 {listar|buscar <nome>|matar <pid>}"
    exit 1
    ;;
esac
