#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

pausar() {
  echo
  read -r -p "Pressione ENTER para continuar..."
}

mostrar_cabecalho() {
  clear
  echo "=========================================="
  echo " MENU DEVOPS CLOUD - JOGOS MULTIPLAYER"
  echo " Criado por: Jean Koerich"
  echo " Instituição: Unidavi"
  echo " Tema: Servidor de Jogos Multiplayer"
  echo "=========================================="
}

menu_processos() {
  echo "1 - Listar processos"
  echo "2 - Buscar processo por nome"
  echo "3 - Encerrar processo por PID"
  read -r -p "Escolha uma opção: " opcao_processo

  case "$opcao_processo" in
    1) "$SCRIPT_DIR/06_processos.sh" listar ;;
    2)
      read -r -p "Informe o nome do processo: " nome
      "$SCRIPT_DIR/06_processos.sh" buscar "$nome"
      ;;
    3)
      read -r -p "Informe o PID: " pid
      "$SCRIPT_DIR/06_processos.sh" matar "$pid"
      ;;
    *) echo "Opção inválida." ;;
  esac
}

while true; do
  mostrar_cabecalho
  echo "1 - Atualizar sistema"
  echo "2 - Instalar e validar Apache"
  echo "3 - Criar estrutura do projeto"
  echo "4 - Realizar backup"
  echo "5 - Fazer deploy do site"
  echo "6 - Gerenciar processos"
  echo "7 - Monitorar sistema"
  echo "8 - Configurar usuários e permissões"
  echo "9 - Gerar relatório"
  echo "0 - Sair"
  echo
  read -r -p "Escolha uma opção: " opcao

  case "$opcao" in
    1) "$SCRIPT_DIR/01_update.sh" ;;
    2) "$SCRIPT_DIR/02_apache.sh" ;;
    3) "$SCRIPT_DIR/03_estrutura.sh" ;;
    4) "$SCRIPT_DIR/04_backup.sh" ;;
    5) "$SCRIPT_DIR/05_deploy.sh" ;;
    6) menu_processos ;;
    7) "$SCRIPT_DIR/07_monitoramento.sh" ;;
    8) "$SCRIPT_DIR/08_usuarios_permissoes.sh" ;;
    9) "$SCRIPT_DIR/09_relatorio.sh" ;;
    0)
      echo "Encerrando menu."
      exit 0
      ;;
    *) echo "Opção inválida." ;;
  esac

  pausar
done
