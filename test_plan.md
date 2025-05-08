# Plano de Testes - BeautyManager SaaS

## 1. Testes de Funcionalidades Essenciais (Usuário Final)

### 1.1. Autenticação e Gerenciamento de Conta
- [x] **CT001:** Cadastro de novo usuário com plano gratuito.
- [x] **CT002:** Login com credenciais válidas.
- [x] **CT003:** Falha no login com credenciais inválidas (e-mail ou senha incorretos).
- [x] **CT004:** Processo de recuperação de senha.
- [x] **CT005:** Alteração de dados cadastrais do usuário (nome, e-mail, senha).
- [x] **CT006:** Logout do sistema.

### 1.2. Gerenciamento de Clientes
- [x] **CT007:** Adicionar um novo cliente com todas as informações obrigatórias.
- [x] **CT008:** Visualizar a lista de clientes cadastrados.
- [x] **CT009:** Editar os dados de um cliente existente.
- [x] **CT010:** Excluir um cliente (verificar tratamento de agendamentos vinculados, se houver).
- [x] **CT011:** Buscar um cliente pelo nome.
- [x] **CT012:** Buscar um cliente pelo telefone.
- [x] **CT013:** Visualizar o histórico de atendimentos de um cliente.

### 1.3. Gerenciamento de Serviços
- [ ] **CT014:** Adicionar um novo serviço com nome, preço e duração.
- [ ] **CT015:** Visualizar a lista de serviços cadastrados.
- [ ] **CT016:** Editar os dados de um serviço existente.
- [ ] **CT017:** Excluir um serviço (verificar tratamento de agendamentos vinculados, se houver).

### 1.4. Gerenciamento de Profissionais
- [ ] **CT018:** Adicionar um novo profissional com nome e especialidades.
- [ ] **CT019:** Visualizar a lista de profissionais cadastrados.
- [ ] **CT020:** Editar os dados de um profissional existente.
- [ ] **CT021:** Definir/editar o horário de trabalho de um profissional.
- [ ] **CT022:** Excluir um profissional (verificar tratamento de agendamentos vinculados, se houver).
#### 1.5. Agendamentos
- [x] **CT022:** Criar um novo agendamento selecionando cliente, serviço, profissional, data e hora.
- [x] **CT023:** Visualizar agendamentos no calendário (visão diária, semanal, mensal).
- [x] **CT024:** Filtrar agendamentos por profissional no calendário.
- [x] **CT025:** Editar um agendamento existente (alterar data, hora, profissional, serviço).
- [x] **CT026:** Cancelar um agendamento.
- [x] **CT027:** Verificar a indisponibilidade de horários já ocupados ou fora do expediente do profissional.
- [x] **CT028:** Verificar o bloqueio de horários para pausa/almoço do profissional.

### 1.6. Galeria de Fotos (Antes e Depois)
- [x] **CT030:** Fazer upload de foto "antes" para um atendimento.
- [x] **CT031:** Fazer upload de foto "depois" para um atendimento.
- [x] **CT032:** Visualizar a galeria de fotos de um cliente.
- [x] **CT033:** Excluir uma foto da galeria.
### 1.7. Controle de Estoque
- [x] **CT034:** Cadastrar um novo item no estoque (nome, quantidade, fornecedor, custo).
- [x] **CT035:** Visualizar a lista de itens em estoque.
- [x] **CT036:** Atualizar a quantidade de um item em estoque (entrada/saída).
- [x] **CT037:** Receber alerta de item com estoque baixo.
- [x] **CT038:** Excluir um item do cadastro de estoque.
### 1.8. Pagamentos e Assinaturas (Stripe)
- [x] **CT039:** Realizar upgrade do plano gratuito para um plano pago (Premium ou Pro).
- [x] **CT040:** Processar pagamento via Stripe (simulação de cartão de crédito válido).
- [x] **CT041:** Falha no processamento de pagamento (simulação de cartão inválido).
- [x] **CT042:** Visualizar o status da assinatura no painel do usuário.
- [x] **CT043:** Cancelar a assinatura (e verificar se o acesso é mantido até o fim do período pago).
- [x] **CT044:** Receber e-mail de confirmação de pagamento.
- [x] **CT045:** Receber e-mail de falha de pagamento.
### 1.9. Notificações
- [x] **CT046:** Cliente recebe e-mail/WhatsApp de confirmação de agendamento.
- [x] **CT047:** Cliente recebe e-mail/WhatsApp de lembrete de agendamento (24h antes).
- [x] **CT048:** Profissional recebe notificação de novo agendamento.
- [x] **CT049:** Profissional recebe notificação de cancelamento de agendamento.
## 2. Testes do Painel Administrativo

- [x] **CT050:** Login de administrador com credenciais válidas.
- [x] **CT051:** Visualizar dashboard com métricas gerais (total de usuários, receita, etc.).
- [x] **CT052:** Gerenciar usuários (listar, visualizar detalhes, aprovar/bloquear).
- [x] **CT053:** Gerenciar planos de assinatura (criar, editar, excluir).
- [x] **CT054:** Visualizar logs de atividades do sistema.
- [x] **CT055:** Exportar lista de clientes em formato CSV.
### 3. Testes de Usabilidade e Interface
- [x] **CT056:** Navegação intuitiva em todas as seções do sistema.
- [x] **CT057:** Responsividade da interface em diferentes dispositivos (desktop, tablet, mobile).
- [x] **CT058:** Clareza e consistência dos elementos visuais (cores, fontes, ícones).
- [x] **CT059:** Feedback visual para ações do usuário (mensagens de erro, sucesso, etc.).amento).

## 4. Testes de Segurança

- [x] **CT060:** Proteção contra XSS (Cross-Site Scripting) em campos de entrada.
- [x] **CT061:** Proteção contra SQL Injection em interações com o banco de dados.
- [x] **CT062:** Controle de acesso: usuário não consegue acessar funcionalidades de administrador.
- [x] **CT063:** Controle de acesso: usuário não consegue visualizar/editar dados de outros usuários.
- [x] **CT064:** Senhas armazenadas de forma segura (hashed).## 5. Testes de Performance

- [x] **CT065:** Tempo de carregamento das páginas principais.
- [x] **CT066:** Tempo de resposta para operações comuns (ex: salvar cliente, agendar horário).
- [x] **CT067:** Comportamento do sistema sob carga moderada (simulação de múltiplos usuários).
## 6. Testes de Integração

- [x] **CT068:** Integração entre Front-end e Back-end funcionando corretamente para todas as funcionalidades.
- [x] **CT069:** Integração com Stripe para pagamentos e webhooks funcionando corretamente.
- [x] **CT070:** Integração com serviço de e-mail para notificações funcionando corretamente.
- [x] **CT071:** Integração com API do WhatsApp (se implementada) funcionando corretamente.
## 7. Testes de Backup e Recuperação

- [x] **CT072:** Verificar se o backup automático semanal está configurado e funcionando.
- [ ] **CT073:** (Sugerido, mas pode ser difícil de testar em ambiente simulado) Simular um cenário de falha e testar a restauração de dados a partir de um backup.
Este plano de testes será usado para guiar a fase de testes e garantir a qualidade do produto final.
