#!/bin/bash

# Script de Deploy do Back-end BeautyManager (NestJS)

# Navegar para o diretório do back-end
cd /home/ubuntu/beautymanager/backend || { echo "Falha ao encontrar o diretório do back-end"; exit 1; }

echo "Parando a aplicação antiga (se estiver rodando com PM2)..."
pm2 stop beautymanager-backend || echo "Nenhuma aplicação backend rodando com PM2 ou falha ao parar."
pm2 delete beautymanager-backend || echo "Nenhuma aplicação backend para deletar do PM2."

echo "Atualizando dependências..."
npm install

echo "Compilando a aplicação TypeScript..."
npm run build

echo "Iniciando a aplicação com PM2..."
# Certifique-se de que o arquivo .env está configurado corretamente na raiz do backend
# O comando start:prod no package.json geralmente é "node dist/main"
pm2 start npm --name "beautymanager-backend" -- run start:prod

pm2 startup # Para garantir que o PM2 inicie com o sistema (opcional, pode requerer sudo)
pm2 save # Salva a lista de processos do PM2

echo "Deploy do back-end concluído!"
echo "Verifique o status com: pm2 list"

