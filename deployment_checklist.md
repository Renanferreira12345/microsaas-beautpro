# Checklist de Implantação e Entrega - BeautyManager SaaS

## 1. Preparação do Ambiente de Produção

- [ ] **PD001:** Configurar servidor de produção (VPS, Cloud, etc.).
- [ ] **PD002:** Instalar Node.js, npm/pnpm, PostgreSQL no servidor.
- [ ] **PD003:** Configurar o banco de dados PostgreSQL em produção (usuário, senha, banco de dados).
- [ ] **PD004:** Configurar variáveis de ambiente para o back-end em produção (arquivo `.env`):
    - [ ] Chaves de API do Stripe (produção).
    - [ ] Segredo do webhook do Stripe (produção).
    - [ ] IDs dos planos Stripe (produção).
    - [ ] Credenciais do servidor SMTP (produção).
    - [ ] Segredo JWT (produção).
    - [ ] Configurações do banco de dados (produção).
- [ ] **PD005:** Configurar variáveis de ambiente para o front-end em produção (arquivo `.env.local` ou similar):
    - [ ] URL da API do back-end (produção).
- [ ] **PD006:** Configurar um servidor web (Nginx ou Apache) para servir o front-end e como proxy reverso para o back-end (recomendado).
- [ ] **PD007:** Configurar SSL/TLS (HTTPS) para o domínio (ex: usando Let's Encrypt).
- [ ] **PD008:** Configurar firewall e regras de segurança no servidor.

## 2. Deploy do Back-end

- [ ] **PD009:** Transferir o código do back-end para o servidor de produção.
- [ ] **PD010:** Executar o script `deploy_backend.sh` (ou seguir os passos manualmente):
    - [ ] Instalar dependências (`npm install`).
    - [ ] Compilar o código TypeScript (`npm run build`).
    - [ ] Iniciar a aplicação com um gerenciador de processos (PM2 recomendado: `pm2 start npm --name "beautymanager-backend" -- run start:prod`).
- [ ] **PD011:** Verificar se o back-end está rodando e acessível (localmente no servidor e via proxy reverso, se configurado).
- [ ] **PD012:** Configurar o webhook do Stripe no dashboard do Stripe para apontar para o endpoint de webhook do back-end em produção.

## 3. Deploy do Front-end

- [ ] **PD013:** Transferir o código do front-end para o servidor de produção (ou para a plataforma de hospedagem de front-end, ex: Vercel, Netlify).
- [ ] **PD014:** Executar o script `deploy_frontend.sh` (ou seguir os passos manualmente):
    - [ ] Instalar dependências (`pnpm install` ou `npm install`).
    - [ ] Construir os arquivos estáticos para produção (`pnpm build` ou `npm run build`).
- [ ] **PD015:** Copiar os arquivos estáticos da pasta `dist` (ou `build`) para o diretório raiz do servidor web (configurado no Nginx/Apache).
- [ ] **PD016:** Verificar se o front-end está acessível via navegador e se comunica corretamente com o back-end.

## 4. Testes Finais em Produção

- [ ] **PD017:** Realizar um subconjunto crítico dos testes do `test_plan.md` no ambiente de produção:
    - [ ] Cadastro de novo usuário.
    - [ ] Login.
    - [ ] Criação de agendamento.
    - [ ] Processo de upgrade de plano (com pagamento real de teste, se possível, ou simulação cuidadosa).
    - [ ] Envio de notificações por e-mail.
- [ ] **PD018:** Verificar logs do back-end e do servidor web por erros.

## 5. Entrega ao Usuário

- [ ] **PD019:** Comunicar ao usuário que o sistema está pronto e fornecer a URL de acesso.
- [ ] **PD020:** Enviar os seguintes documentos ao usuário:
    - [x] `technical_documentation.md` (Documentação Técnica)
    - [x] `manual_usuario.md` (Manual do Usuário)
    - [x] `deploy_backend.sh` (Script de Deploy do Back-end)
    - [x] `deploy_frontend.sh` (Script de Deploy do Front-end)
    - [ ] Este `deployment_checklist.md`
- [ ] **PD021:** Fornecer credenciais de acesso iniciais (se aplicável, ex: conta de administrador do salão).
- [ ] **PD022:** Agendar uma sessão de demonstração/treinamento com o usuário (opcional, mas recomendado).
- [ ] **PD023:** Explicar os canais de suporte.

## 6. Pós-Entrega

- [ ] **PD024:** Coletar feedback inicial do usuário.
- [ ] **PD025:** Monitorar o sistema por alguns dias para identificar quaisquer problemas imprevistos.
- [ ] **PD026:** Realizar ajustes e correções com base no feedback e monitoramento (conforme o passo 9 do plano de projeto).
- [ ] **PD027:** Configurar backups automáticos do banco de dados em produção.

Este checklist ajudará a garantir uma implantação e entrega suaves do BeautyManager SaaS.
