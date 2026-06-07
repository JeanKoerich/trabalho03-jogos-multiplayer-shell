#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker não encontrado."
  exit 1
fi

if [ ! -f .env ]; then
  echo "Arquivo .env não encontrado."
  echo "Copie .env.example para .env antes de executar."
  exit 1
fi

# shellcheck disable=SC1091
source .env

echo "=========================================="
echo " Pipeline Local - Jogos Multiplayer"
echo " Porta externa do Apache: ${APACHE_PORT:-8080}"
echo "=========================================="

echo "[1/6] Parando ambiente anterior..."
docker compose down

echo "[2/6] Construindo imagem..."
docker compose build

echo "[3/6] Subindo container..."
docker compose up -d

echo "[4/6] Aguardando Apache inicializar..."
sleep 5

echo "[5/6] Executando healthcheck..."
"$SCRIPT_DIR/healthcheck.sh" "http://localhost:${APACHE_PORT:-8080}"

echo "[6/6] Exibindo status final..."
docker compose ps

echo "=========================================="
echo " Pipeline executada com sucesso"
echo "=========================================="
