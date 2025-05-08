# Documentação Técnica - BeautyManager SaaS

## 1. Introdução

Este documento fornece uma visão geral técnica do Micro SaaS BeautyManager, incluindo sua arquitetura, tecnologias utilizadas, configuração do ambiente de desenvolvimento, estrutura do projeto e detalhes da API.

## 2. Arquitetura do Sistema

O BeautyManager é construído sobre uma arquitetura moderna de microsserviços, com um front-end desacoplado e um back-end robusto.

-   **Front-end:** Aplicação de página única (SPA) desenvolvida com ReactJS e TailwindCSS, responsável pela interface do usuário e interação com o cliente.
-   **Back-end:** API RESTful desenvolvida com NestJS (Node.js) e TypeScript, responsável pela lógica de negócios, gerenciamento de dados e integrações com serviços externos.
-   **Banco de Dados:** PostgreSQL, um sistema de gerenciamento de banco de dados relacional objeto, utilizado para persistência de dados.
-   **Autenticação:** JWT (JSON Web Tokens) para proteger as rotas da API e gerenciar sessões de usuário.
-   **Pagamentos:** Integração com a API do Stripe para processamento de pagamentos de assinaturas recorrentes.
-   **Notificações:** Integração com serviços de e-mail (via Nodemailer e SMTP) e, opcionalmente, WhatsApp API para notificações automáticas.

## 3. Tecnologias Utilizadas

### 3.1. Back-end
-   **Framework:** NestJS (vX.Y.Z) - Um framework Node.js progressivo para construir aplicações do lado do servidor eficientes e escaláveis.
-   **Linguagem:** TypeScript (vX.Y.Z)
-   **Banco de Dados:** PostgreSQL (vX.Y)
-   **ORM:** TypeORM
-   **Autenticação:** Passport.js com estratégia JWT (@nestjs/jwt, passport-jwt)
-   **Pagamentos:** Stripe SDK (stripe-node)
-   **E-mails:** Nodemailer (@nestjs-modules/mailer)
-   **Gerenciador de Pacotes:** npm

### 3.2. Front-end
-   **Framework/Biblioteca:** ReactJS (vX.Y.Z)
-   **Linguagem:** TypeScript (vX.Y.Z)
-   **Estilização:** TailwindCSS (vX.Y.Z)
-   **Roteamento:** React Router DOM
-   **Gerenciamento de Estado (sugestão):** Context API, Redux Toolkit ou Zustand
-   **Requisições HTTP:** Axios ou Fetch API
-   **Gerenciador de Pacotes:** pnpm (conforme template utilizado)

## 4. Configuração do Ambiente de Desenvolvimento

### 4.1. Pré-requisitos
-   Node.js (v18.x ou superior)
-   npm (geralmente vem com o Node.js)
-   pnpm (para o front-end, se utilizado)
-   PostgreSQL (servidor local ou remoto)
-   Conta Stripe (com chaves de API de teste)
-   Servidor SMTP (para envio de e-mails)

### 4.2. Configuração do Back-end
1.  Clone o repositório do back-end.
2.  Navegue até o diretório `/home/ubuntu/beautymanager/backend`.
3.  Crie um arquivo `.env` na raiz do diretório do back-end com base no `.env.example` (a ser criado) e preencha as variáveis de ambiente:
    ```env
    # PostgreSQL
    DB_HOST=localhost
    DB_PORT=5432
    DB_USERNAME=seu_usuario_pg
    DB_PASSWORD=sua_senha_pg
    DB_DATABASE=beautymanager

    # JWT
    JWT_SECRET=suaChaveSecretaMuitoForteParaJWT
    JWT_EXPIRATION_TIME=3600s # Ex: 1 hora

    # Stripe
    STRIPE_SECRET_KEY=sk_test_suaChaveSecretaStripe
    STRIPE_WEBHOOK_SECRET=whsec_seuSegredoDeWebhookStripe
    # IDs dos Planos Stripe (após criá-los no dashboard Stripe ou via API)
    STRIPE_PREMIUM_PLAN_PRICE_ID=price_xxx
    STRIPE_PRO_PLAN_PRICE_ID=price_yyy

    # SMTP (Nodemailer)
    SMTP_HOST=seu_host_smtp
    SMTP_PORT=587 # ou 465
    SMTP_SECURE=false # true para porta 465
    SMTP_USER=seu_usuario_smtp
    SMTP_PASS=sua_senha_smtp
    SMTP_FROM_EMAIL=noreply@beautymanager.com
    ```
4.  Instale as dependências: `npm install`
5.  Execute as migrações do banco de dados (se aplicável com TypeORM): `npm run migration:run` (comando a ser configurado no package.json)
6.  Inicie o servidor de desenvolvimento: `npm run start:dev`

### 4.3. Configuração do Front-end
1.  Clone o repositório do front-end.
2.  Navegue até o diretório `/home/ubuntu/beautymanager/frontend`.
3.  Crie um arquivo `.env.local` na raiz do diretório do front-end e configure a URL da API do back-end:
    ```env
    REACT_APP_API_URL=http://localhost:3000/api # Ajuste a porta se necessário
    ```
4.  Instale as dependências: `pnpm install` (ou `npm install` se pnpm não for usado)
5.  Inicie o servidor de desenvolvimento: `pnpm dev` (ou `npm start`)

## 5. Estrutura do Projeto

### 5.1. Back-end (NestJS)
```
/home/ubuntu/beautymanager/backend/
├── src/
│   ├── app.controller.ts
│   ├── app.module.ts
│   ├── app.service.ts
│   ├── main.ts
│   ├── auth/                     # Módulo de Autenticação
│   │   ├── dto/
│   │   ├── strategies/
│   │   ├── guards/
│   │   ├── auth.controller.ts
│   │   ├── auth.module.ts
│   │   └── auth.service.ts
│   ├── users/                    # Módulo de Usuários (Salões)
│   ├── clients/                  # Módulo de Clientes Finais
│   ├── services/                 # Módulo de Serviços do Salão
│   ├── staff/                    # Módulo de Profissionais
│   ├── appointments/             # Módulo de Agendamentos
│   ├── payments/                 # Módulo de Pagamentos (lógica interna, não Stripe direto)
│   ├── photos/                   # Módulo de Fotos (antes/depois)
│   ├── stock-items/              # Módulo de Controle de Estoque
│   ├── automated-campaigns/      # Módulo de Campanhas Automatizadas
│   ├── notifications/            # Módulo de Notificações (e-mail, WhatsApp)
│   ├── stripe/                   # Módulo de Integração Stripe
│   ├── database/                 # Configuração do Banco de Dados (TypeORM)
│   └── templates/                # Templates de E-mail (Handlebars)
├── .env
├── nest-cli.json
├── package.json
├── tsconfig.build.json
└── tsconfig.json
```

### 5.2. Front-end (ReactJS)
```
/home/ubuntu/beautymanager/frontend/
├── public/
│   └── index.html
├── src/
│   ├── App.tsx
│   ├── main.tsx
│   ├── index.css
│   ├── assets/                   # Ícones, imagens
│   ├── components/               # Componentes reutilizáveis (ex: Button, Calendar, Input)
│   ├── pages/                    # Componentes de página (ex: LoginPage, DashboardPage)
│   ├── services/                 # Lógica de chamada de API (ex: authService.ts, appointmentService.ts)
│   ├── contexts/                 # Context API para gerenciamento de estado global (opcional)
│   ├── hooks/                    # Hooks customizados
│   ├── routes/                   # Configuração de rotas (React Router)
│   ├── styles/                   # Estilos globais ou específicos (se não usar apenas Tailwind)
│   └── utils/                    # Funções utilitárias
├── .env.local
├── package.json
├── pnpm-lock.yaml (ou package-lock.json)
├── postcss.config.js
├── tailwind.config.js
└── tsconfig.json
```

## 6. Detalhes da API (Back-end)

(Esta seção deve ser expandida com os principais endpoints, métodos HTTP, parâmetros esperados e respostas para cada módulo)

### Exemplo: Autenticação
-   **POST /auth/register:** Registra um novo usuário (salão).
    -   Corpo: `{ email, password, salonName, ... }`
    -   Resposta: `{ accessToken, user }`
-   **POST /auth/login:** Autentica um usuário existente.
    -   Corpo: `{ email, password }`
    -   Resposta: `{ accessToken, user }`

### Exemplo: Clientes
-   **POST /clients:** Cria um novo cliente (requer autenticação).
    -   Corpo: `{ name, phone, email, ... }`
    -   Resposta: `{ clienteCriado }`
-   **GET /clients:** Lista todos os clientes do salão autenticado.
    -   Resposta: `[ { cliente1 }, { cliente2 }, ... ]`

(Continuar para todos os outros módulos: Serviços, Profissionais, Agendamentos, Stripe Webhooks, etc.)

## 7. Considerações de Segurança

-   Validação de entrada em todas as rotas da API.
-   Uso de HTTPS em produção.
-   Proteção contra ataques comuns (XSS, CSRF, SQL Injection).
-   Gerenciamento seguro de segredos e chaves de API (via variáveis de ambiente).
-   Hashing de senhas (bcrypt já é usado pelo NestJS com TypeORM).
-   Autorização baseada em roles/permissions, se necessário para diferentes tipos de usuários (ex: admin do salão vs. profissional).

## 8. Escalabilidade e Performance

-   O NestJS e o Node.js são capazes de lidar com um número significativo de requisições concorrentes.
-   O PostgreSQL é um banco de dados robusto e escalável.
-   Otimização de queries no banco de dados.
-   Uso de paginação para listas grandes.
-   Caching para dados frequentemente acessados (ex: Redis).
-   Considerar o uso de um load balancer e múltiplas instâncias da aplicação em produção para alta disponibilidade e escalabilidade horizontal.

## 9. Manutenção e Atualizações

-   Manter as dependências do projeto atualizadas.
-   Monitorar logs da aplicação e do servidor.
-   Realizar backups regulares do banco de dados.

Este documento técnico serve como um guia inicial e deve ser atualizado conforme o projeto evolui.

