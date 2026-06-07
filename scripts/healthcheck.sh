#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -f "$PROJECT_ROOT/.env" ]; then
  # shellcheck disable=SC1091
  source "$PROJECT_ROOT/.env"
fi

URL=${1:-http://localhost:${APACHE_PORT:-8080}}

echo "Verificando acesso ao site em: $URL"

RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

if [ "$RESPONSE" = "200" ]; then
  echo "Site disponível. HTTP $RESPONSE"
  exit 0
else
  echo "Site indisponível. HTTP $RESPONSE"
  exit 1
fi
