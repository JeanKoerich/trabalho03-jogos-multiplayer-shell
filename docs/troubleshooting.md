# Troubleshooting - Jogos Multiplayer Shell

Este documento apresenta comandos para diagnosticar problemas comuns no ambiente.

## 1. Verificar o container

```bash
docker compose ps
```

## 2. Ver logs do container

```bash
docker compose logs jogos-linux
```

Para acompanhar em tempo real:

```bash
docker compose logs -f jogos-linux
```

## 3. Testar o site no terminal

```bash
curl http://localhost:8080
```

Também é possível utilizar:

```bash
./scripts/healthcheck.sh
```

## 4. Acessar o container

```bash
docker exec -it trabalho03-jogos-linux bash
```

## 5. Verificar o Apache

Dentro do container:

```bash
apache2 -v
pgrep -af apache2
```

## 6. Verificar os arquivos publicados

```bash
ls -la /var/www/html
```

## 7. Executar deploy novamente

```bash
/app/scripts/05_deploy.sh
```

## 8. Verificar os volumes

```bash
docker volume ls
docker volume inspect trabalho03-jogos-multiplayer-shell_jogos-dados
```

O prefixo do volume pode mudar conforme o nome da pasta local do projeto.

## 9. Reiniciar o ambiente

```bash
docker compose down
docker compose up -d --build
```

## 10. Remover também o volume persistente

Atenção: este comando remove os dados persistidos.

```bash
docker compose down -v
```
