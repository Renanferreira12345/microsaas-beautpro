# Guia de Implantação (Deploy) - BeautyManager SaaS

## 1. Introdução

Este guia fornece instruções passo a passo para realizar a implantação (deploy) do back-end e front-end do sistema BeautyManager, bem como a configuração do banco de dados PostgreSQL em ambiente de produção.

As plataformas de hospedagem recomendadas são:
-   **Front-end (ReactJS):** Vercel, Netlify, AWS Amplify, Heroku.
-   **Back-end (NestJS):** Railway, Heroku, AWS Elastic Beanstalk, Render.
-   **Banco de Dados (PostgreSQL):** Supabase, Railway, Amazon RDS, ElephantSQL, Heroku Postgres.

Este guia focará em exemplos com Vercel para o front-end, Railway para o back-end e Supabase para o PostgreSQL, mas os princípios podem ser adaptados para outras plataformas.

## 2. Pré-requisitos

-   Contas criadas nas plataformas de hospedagem escolhidas (ex: Vercel, Railway, Supabase).
-   Código-fonte do back-end e front-end versionado em um repositório Git (ex: GitHub, GitLab, Bitbucket).
-   Chaves de API do Stripe (produção).
-   Credenciais do servidor SMTP (produção).

## 3. Implantação do Banco de Dados (PostgreSQL com Supabase)

Supabase oferece uma instância PostgreSQL gerenciada e outras ferramentas úteis.

1.  **Crie um Projeto no Supabase:**
    *   Acesse [supabase.com](https://supabase.com) e crie uma nova organização e um novo projeto.
    *   Escolha a região do servidor mais próxima dos seus usuários.
    *   Anote a senha do banco de dados gerada (ou defina uma nova).
2.  **Obtenha os Detalhes da Conexão:**
    *   No painel do seu projeto Supabase, vá para "Project Settings" > "Database".
    *   Você encontrará os detalhes da conexão: Host, Port, Database name, User (geralmente `postgres`), e a senha que você anotou/definiu.
    *   A string de conexão se parecerá com: `postgresql://postgres:[SUA_SENHA]@[HOST_DO_PROJETO_SUPABASE]:[PORTA]/postgres`
3.  **Segurança:**
    *   Configure as regras de Row Level Security (RLS) no Supabase se for expor a API do Supabase diretamente, embora para o BeautyManager, o acesso ao banco será primariamente pelo back-end NestJS.
    *   Certifique-se de que o acesso direto ao banco de dados pela internet esteja restrito, se possível, permitindo apenas conexões da sua aplicação back-end.

## 4. Implantação do Back-end (NestJS com Railway)

Railway facilita o deploy de aplicações conteinerizadas ou baseadas em Nixpacks.

1.  **Prepare seu Projeto NestJS:**
    *   Certifique-se de que seu `package.json` tenha um script de build e um script de start para produção:
        ```json
        // package.json
        "scripts": {
          // ... outros scripts
          "build": "nest build",
          "start:prod": "node dist/main"
        }
        ```
    *   Crie um arquivo `Dockerfile` na raiz do projeto back-end para conteinerizar a aplicação (recomendado para maior controle e portabilidade):
        ```Dockerfile
        # Dockerfile para NestJS
        FROM node:18-alpine AS development
        WORKDIR /usr/src/app
        COPY package*.json ./
        RUN npm install --only=development
        COPY . .
        RUN npm run build

        FROM node:18-alpine as production
        ARG NODE_ENV=production
        ENV NODE_ENV=${NODE_ENV}
        WORKDIR /usr/src/app
        COPY package*.json ./
        RUN npm install --only=production
        COPY --from=development /usr/src/app/dist ./dist
        CMD ["node", "dist/main"]
        ```
    *   Alternativamente, Railway pode tentar construir o projeto automaticamente usando Nixpacks se não encontrar um Dockerfile.
2.  **Crie um Projeto no Railway:**
    *   Acesse [railway.app](https://railway.app) e crie um novo projeto.
    *   Escolha "Deploy from GitHub repo" e selecione o repositório do seu back-end.
3.  **Configure o Serviço:**
    *   Railway detectará o `Dockerfile` (ou tentará construir de outra forma).
    *   **Porta:** O NestJS por padrão roda na porta 3000. Certifique-se de que sua aplicação escute em `0.0.0.0` (o `main.ts` padrão do NestJS já faz isso: `await app.listen(process.env.PORT || 3000);`). Railway exporá a porta automaticamente.
    *   **Variáveis de Ambiente:** Vá para a aba "Variables" do seu serviço no Railway e adicione todas as variáveis de ambiente necessárias para produção, conforme definido no seu arquivo `.env` local (mas usando os valores de produção):
        *   `DB_HOST`: Host do seu banco de dados Supabase.
        *   `DB_PORT`: Porta do seu banco de dados Supabase.
        *   `DB_USERNAME`: Usuário do seu banco de dados Supabase.
        *   `DB_PASSWORD`: Senha do seu banco de dados Supabase.
        *   `DB_DATABASE`: Nome do banco de dados Supabase (geralmente `postgres`).
        *   `JWT_SECRET`: Uma chave secreta forte para produção.
        *   `JWT_EXPIRATION_TIME`: Ex: `3600s` ou `1d`.
        *   `STRIPE_SECRET_KEY`: Sua chave secreta do Stripe para produção (ex: `sk_live_...`).
        *   `STRIPE_WEBHOOK_SECRET`: Seu segredo de webhook do Stripe para produção.
        *   `STRIPE_PREMIUM_PLAN_PRICE_ID`: ID do preço do plano Premium em produção.
        *   `STRIPE_PRO_PLAN_PRICE_ID`: ID do preço do plano Pro em produção.
        *   `SMTP_HOST`, `SMTP_PORT`, `SMTP_SECURE`, `SMTP_USER`, `SMTP_PASS`, `SMTP_FROM_EMAIL`: Configurações do seu servidor SMTP de produção.
        *   `PORT`: Railway geralmente define isso, mas pode ser 3000 se não.
        *   `NODE_ENV=production`
4.  **Deploy:**
    *   Railway iniciará o build e o deploy automaticamente após a configuração.
    *   Você receberá um domínio público para acessar sua API (ex: `my-backend-app.up.railway.app`). Anote este domínio.
5.  **Stripe Webhook:**
    *   No seu Dashboard Stripe, configure o endpoint do webhook para apontar para `[SEU_DOMINIO_RAILWAY]/stripe/webhook` (ou o endpoint que você definiu no `StripeController`).
    *   Selecione os eventos que você precisa escutar (ex: `invoice.payment_succeeded`, `invoice.payment_failed`, `customer.subscription.updated`, `customer.subscription.deleted`).

## 5. Implantação do Front-end (ReactJS com Vercel)

Vercel é otimizado para hospedar aplicações front-end estáticas e Jamstack.

1.  **Prepare seu Projeto React:**
    *   Certifique-se de que seu `package.json` tenha um script de build (ex: `pnpm build` ou `npm run build`). O template `create-react-app` geralmente já inclui isso.
2.  **Crie um Projeto no Vercel:**
    *   Acesse [vercel.com](https://vercel.com) e crie um novo projeto.
    *   Escolha "Import Git Repository" e selecione o repositório do seu front-end.
3.  **Configure o Projeto:**
    *   **Framework Preset:** Vercel geralmente detecta "Create React App" ou "Vite" automaticamente.
    *   **Build Command:** Verifique se está correto (ex: `pnpm build` ou `npm run build`).
    *   **Output Directory:** Geralmente `build` para Create React App ou `dist` para Vite.
    *   **Variáveis de Ambiente:** Vá para "Settings" > "Environment Variables" e adicione:
        *   `REACT_APP_API_URL`: A URL da sua API back-end implantada no Railway (ex: `https://my-backend-app.up.railway.app/api`).
        *   `REACT_APP_STRIPE_PUBLISHABLE_KEY`: Sua chave publicável do Stripe para produção (ex: `pk_live_...`).
4.  **Deploy:**
    *   Clique em "Deploy". Vercel fará o build e implantará sua aplicação.
    *   Você receberá um domínio público para seu front-end (ex: `my-frontend-app.vercel.app`).

## 6. Configurações Pós-Implantação

1.  **Domínios Personalizados:**
    *   Configure domínios personalizados para seu front-end e back-end nas respectivas plataformas de hospedagem, se desejar (ex: `app.beautymanager.com` para o front-end, `api.beautymanager.com` para o back-end).
2.  **HTTPS:**
    *   Vercel e Railway geralmente fornecem certificados SSL/TLS e HTTPS automaticamente.
3.  **Testes Finais:**
    *   Realize testes completos em ambiente de produção para garantir que todas as funcionalidades, integrações (especialmente Stripe) e fluxos de usuário estejam funcionando corretamente.
    *   Teste o fluxo de cadastro, login, agendamento, pagamento de assinatura, e notificações.
4.  **Monitoramento e Logs:**
    *   Configure ferramentas de monitoramento e utilize os logs fornecidos pelas plataformas de hospedagem para acompanhar a saúde da sua aplicação.

## 7. Atualizações da Aplicação

-   **Back-end (Railway):** Ao fazer push de novas alterações para o branch conectado ao Railway, um novo deploy será acionado automaticamente (se configurado).
-   **Front-end (Vercel):** Similarmente, Vercel reconstruirá e implantará seu front-end automaticamente após pushes para o branch conectado.

Este guia oferece uma base para a implantação. Consulte a documentação específica de cada plataforma de hospedagem para detalhes adicionais e opções avançadas.

