# Trabalho 03 - Linux, Shell Script e Automação Operacional aplicada à Cloud

## Aluno

Jean Koerich

## Tema

Servidor de Jogos Multiplayer com Pong Online.

## Descrição do projeto

Este projeto simula a preparação de um ambiente Linux para uma aplicação relacionada a jogos multiplayer. O container utiliza Ubuntu e Apache para publicar um site estático do Pong Online.

Os scripts Shell automatizam tarefas comuns de operação: atualização do sistema, instalação e validação do Apache, criação de diretórios, backup, deploy, gerenciamento de processos, monitoramento, configuração de usuários e permissões e geração de relatório.

## Tecnologias utilizadas

- Linux Ubuntu 24.04
- Docker
- Docker Compose
- Apache
- Shell Script
- HTML e CSS
- GitHub
- DockerHub

## Estrutura do projeto

```text
trabalho03-jogos-multiplayer-shell/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── .env.example
├── scripts/
│   ├── 01_update.sh
│   ├── 02_apache.sh
│   ├── 03_estrutura.sh
│   ├── 04_backup.sh
│   ├── 05_deploy.sh
│   ├── 06_processos.sh
│   ├── 07_monitoramento.sh
│   ├── 08_usuarios_permissoes.sh
│   ├── 09_relatorio.sh
│   ├── menu.sh
│   ├── healthcheck.sh
│   └── pipeline-local.sh
├── source/
│   ├── index.html
│   ├── sobre.html
│   └── assets/
│       └── style.css
├── docs/
│   ├── arquitetura.md
│   └── troubleshooting.md
├── backups/
├── logs/
└── evidencias/
```

## Como executar

### 1. Criar o arquivo de ambiente

No Linux, Git Bash ou WSL:

```bash
cp .env.example .env
```

No PowerShell:

```powershell
Copy-Item .env.example .env
```

### 2. Subir o ambiente

```bash
docker compose up -d --build
```

### 3. Verificar o container

```bash
docker compose ps
```

### 4. Acessar o site

Abra no navegador:

```text
http://localhost:8080
```

### 5. Acessar o container

```bash
docker exec -it trabalho03-jogos-linux bash
```

### 6. Acessar os scripts dentro do container

```bash
cd /app/scripts
chmod +x *.sh
```

## Scripts disponíveis

| Script | Descrição |
|---|---|
| `01_update.sh` | Atualiza os pacotes do sistema e registra log |
| `02_apache.sh` | Instala, inicia, valida e exibe a versão do Apache |
| `03_estrutura.sh` | Cria a estrutura temática do servidor multiplayer |
| `04_backup.sh` | Gera backup compactado com data e hora |
| `05_deploy.sh` | Publica o site estático no Apache |
| `06_processos.sh` | Lista, busca e encerra processos |
| `07_monitoramento.sh` | Monitora CPU, memória, disco e Apache |
| `08_usuarios_permissoes.sh` | Cria grupo, usuário e aplica permissões |
| `09_relatorio.sh` | Gera relatório operacional em `logs/relatorio_execucao.txt` |
| `menu.sh` | Integra as principais rotinas em um menu interativo |
| `healthcheck.sh` | Testa se o site responde com HTTP 200 |
| `pipeline-local.sh` | Reconstrói o ambiente e executa o healthcheck |

## Executar o menu principal

Dentro do container:

```bash
cd /app/scripts
./menu.sh
```

## Executar scripts individualmente

```bash
./01_update.sh
./02_apache.sh
./03_estrutura.sh
./04_backup.sh
./05_deploy.sh
./06_processos.sh listar
./06_processos.sh buscar apache
./07_monitoramento.sh
./08_usuarios_permissoes.sh
./09_relatorio.sh
```

## Pipeline local

O pipeline deve ser executado na máquina local, fora do container:

```bash
./scripts/pipeline-local.sh
```

## Persistência

O volume Docker `jogos-dados` mantém os arquivos do diretório:

```text
/app/jogos-multiplayer/dados
```

As pastas `backups/`, `logs/` e `evidencias/` também são montadas entre a máquina local e o container.

## Evidências recomendadas

Adicionar prints na pasta `evidencias/` demonstrando:

1. Container executando com `docker compose ps`.
2. Volume criado com `docker volume ls`.
3. Scripts com permissão de execução usando `ls -la /app/scripts`.
4. Execução de cada script obrigatório.
5. Estrutura criada em `/app/jogos-multiplayer`.
6. Arquivo `.tar.gz` criado em `backups/`.
7. Arquivos publicados em `/var/www/html`.
8. Site acessível em `http://localhost:8080`.
9. Usuário `pong_user` e grupo `jogos_ops` configurados.
10. Relatório final em `logs/relatorio_execucao.txt`.
11. Imagem publicada no DockerHub.

## DockerHub

Adicionar o link da imagem após a publicação.

## Uso de Inteligência Artificial

Foi utilizada uma ferramenta de inteligência artificial como apoio para revisar a organização do projeto, sugerir melhorias nos scripts e auxiliar na documentação. Os arquivos foram analisados e ajustados manualmente durante os testes para compreender o funcionamento de cada comando.

## Dificuldades encontradas

Preencher após a execução dos testes, descrevendo os problemas encontrados e como foram resolvidos.

## Documentação complementar

- `docs/arquitetura.md`
- `docs/troubleshooting.md`
