# Arquitetura - Jogos Multiplayer Shell

## Visão geral

O projeto simula a preparação e a administração de um ambiente Linux utilizado por um servidor de jogos multiplayer com temática de Pong Online.

O ambiente é executado em um container Ubuntu e disponibiliza um site estático por meio do Apache.

## Fluxo de acesso

```text
Navegador
   |
   v
http://localhost:8080
   |
   v
Container Ubuntu
   |
   v
Apache
   |
   v
Site estático do Pong Multiplayer
```

## Componentes

### Container Ubuntu

Simula uma instância Linux utilizada em um cenário de cloud computing.

### Apache

Responsável por publicar os arquivos copiados da pasta `/app/source` para `/var/www/html`.

### Scripts Shell

Responsáveis por automatizar atualização do sistema, validação do Apache, preparação de diretórios, backup, deploy, gerenciamento de processos, monitoramento, permissões e relatório operacional.

## Persistência

O volume nomeado `jogos-dados` mantém os dados armazenados em:

```text
/app/jogos-multiplayer/dados
```

As pastas locais `backups/`, `logs/` e `evidencias/` também são montadas no container para facilitar a coleta dos arquivos gerados durante os testes.

## Estrutura temática no container

```text
/app/jogos-multiplayer/
├── jogadores/
├── partidas/
├── ranking/
├── dados/
├── publicacao/
├── logs/
└── backups/
```
