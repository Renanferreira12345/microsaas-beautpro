#!/bin/bash

# Script de Deploy do Front-end BeautyManager (React)

# Navegar para o diretório do front-end
cd /home/ubuntu/beautymanager/frontend || { echo "Falha ao encontrar o diretório do front-end"; exit 1; }

echo "Parando a aplicação antiga (se servida via serve ou similar)..."
# Adicionar comandos para parar o servidor front-end se estiver rodando (ex: pm2 delete beautymanager-frontend)

echo "Atualizando dependências..."
# O template create_react_app usa pnpm, mas se o usuário instalou com npm, pode ser npm install
if [ -f "pnpm-lock.yaml" ]; then
  pnpm install
elif [ -f "package-lock.json" ]; then
  npm install
else
  echo "Gerenciador de pacotes não identificado claramente. Tentando com pnpm e npm."
  pnpm install || npm install
fi

echo "Construindo a aplicação React para produção..."
# O comando de build pode variar (npm run build, pnpm build)
if [ -f "pnpm-lock.yaml" ]; then
  pnpm build
elif [ -f "package-lock.json" ]; then
  npm run build
else
  echo "Comando de build não identificado claramente. Tentando com pnpm build e npm run build."
  pnpm build || npm run build
fi

echo "Build do front-end concluído!"
echo "Os arquivos estáticos estão prontos em /home/ubuntu/beautymanager/frontend/dist/ (ou /build, verifique a configuração do seu projeto React)."
echo "Você pode servir esta pasta com um servidor HTTP como Nginx, Apache, ou usar 'serve -s dist'."

# Exemplo para servir com PM2 e 'serve' (instale 'serve' globalmente: npm install -g serve)
# echo "Servindo o front-end com PM2 e 'serve'..."
# pm2 stop beautymanager-frontend || echo "Nenhuma aplicação frontend rodando com PM2 ou falha ao parar."
# pm2 delete beautymanager-frontend || echo "Nenhuma aplicação frontend para deletar do PM2."
# pm2 serve /home/ubuntu/beautymanager/frontend/dist --name "beautymanager-frontend" --spa

# pm2 startup
# pm2 save

echo "Deploy do front-end (build) concluído!"

