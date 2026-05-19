# Resolut.On

Sistema de Help Desk para gerenciamento de chamados, unidades, usuários, equipamentos e salas, com controle de permissões e acompanhamento do fluxo de atendimento.

---

## Descrição

O Resolut.On é uma aplicação web desenvolvida para facilitar o gerenciamento de solicitações de suporte (chamados) em organizações. O sistema permite a abertura, acompanhamento e conclusão de chamados, além de gerenciar unidades, usuários, equipamentos, salas e categorias. O objetivo é otimizar o fluxo de trabalho, priorizar tarefas e aumentar a eficiência na resolução de problemas.

---

## Funcionalidades

- Cadastro e autenticação de usuários com verificação por e-mail
- Gerenciamento de unidades (criação, visualização, conexão)
- Controle de permissões por cargo (criador, admin, suporte, comum)
- Cadastro e gerenciamento de salas, equipamentos e categorias
- Abertura, acompanhamento, edição e conclusão de chamados
- Chat interno em chamados
- Avaliação de atendimento ao concluir chamados
- Dashboard com gráficos e estatísticas (painel administrativo)
- Recuperação de senha por e-mail
- Interface responsiva e moderna

---

## Tecnologias Utilizadas

- **Backend:** PHP (procedural), MySQL
- **Frontend:** HTML5, CSS3, Bootstrap 4, JavaScript (jQuery)
- **Bibliotecas:**
  - [vlucas/phpdotenv](https://github.com/vlucas/phpdotenv) (variáveis de ambiente)
  - [phpmailer/phpmailer](https://github.com/PHPMailer/PHPMailer) (envio de e-mails)
- **Estilização:** Bootstrap, CSS customizado
- **Gerenciador de dependências:** Composer

---

## Estrutura do Projeto

- **index.php:** Ponto de entrada, carrega rotas e dependências.
- **routes.php:** Define as rotas da aplicação.
- **conect.php:** Conexão com o banco de dados via variáveis de ambiente.
- **Views/**: Telas do sistema (painel, perfil, unidades, chamados, etc).
- **start/**: Telas de autenticação, registro, redefinição de senha e landing page.
- **email/**: Templates e lógica de envio de e-mails.
- **assets/**: Imagens, fontes e arquivos estáticos.
- **css/**: Estilos customizados.
- **vendor/**: Dependências gerenciadas pelo Composer.
- **bdresoluton.sql:** Script de criação do banco de dados.

---

## Como Executar o Projeto

### Pré-requisitos

- PHP 7.4+
- MySQL/MariaDB
- Composer

### Instalação

```bash
# Clone o repositório
git clone <repo-url>
cd Reso

# Instale as dependências PHP
composer install
```

### Configuração

1. Crie um banco de dados MySQL e execute o script `bdresoluton.sql`.
2. Crie um arquivo `.env` na raiz do projeto com as variáveis:
   ```
   dbhost=localhost
   dbuser=SEU_USUARIO
   dbpassword=SUA_SENHA
   dbname=db_resoluton
   ```
3. Configure o servidor web apontando para a pasta do projeto.

### Execução

- Acesse `http://localhost/Reso` no navegador.
- O sistema não utiliza scripts automáticos de start, apenas o servidor web configurado.

---

## Variáveis de Ambiente

| Variável   | Descrição                 |
| ---------- | ------------------------- |
| dbhost     | Host do banco de dados    |
| dbuser     | Usuário do banco de dados |
| dbpassword | Senha do banco de dados   |
| dbname     | Nome do banco de dados    |

---

## API / Endpoints

O sistema utiliza rotas PHP internas (não REST). Exemplos de rotas:

| Método | Rota                | Finalidade                |
| ------ | ------------------- | ------------------------- |
| GET    | /                   | Landing page              |
| GET    | /login              | Tela de login             |
| GET    | /registro           | Tela de registro          |
| GET    | /unidades           | Gerenciamento de unidades |
| GET    | /painel             | Dashboard administrativo  |
| GET    | /painelChamados     | Listagem de chamados      |
| GET    | /painelUsuarios     | Listagem de usuários      |
| GET    | /painelEquipamentos | Listagem de equipamentos  |
| GET    | /painelSalas        | Listagem de salas         |
| GET    | /painelCategorias   | Listagem de categorias    |
| GET    | /painelChatChamado  | Chat do chamado           |
| GET    | /config             | Configuração de perfil    |
| GET    | /logout             | Logout                    |

---

## Banco de Dados

Principais tabelas:

- **tb_usuario:** Usuários do sistema (nome, e-mail, senha, cargo, status, imagem de perfil)
- **tb_unidade:** Unidades organizacionais
- **tb_usuario_unidade:** Relacionamento usuário-unidade-cargo
- **tb_cargo_reso / tb_cargo_unidade:** Cargos globais e por unidade
- **tb_sala:** Salas físicas ou virtuais
- **tb_equipamento:** Equipamentos cadastrados
- **tb_equipamento_categoria:** Categorias de equipamentos
- **tb_chamado:** Chamados de suporte
- **tb_st_chamado:** Status dos chamados (Aberto, Andamento, Concluído)
- **tb_chat:** Mensagens de chat vinculadas a chamados
- **tb_recuperacao_senha:** Tokens de recuperação de senha

---

## Interface do Sistema

- **Landing Page:** Apresentação do sistema e acesso ao login/registro.
- **Registro/Login:** Cadastro de usuário, autenticação e verificação por e-mail.
- **Painel:** Dashboard com gráficos, estatísticas e relatórios.
- **Unidades:** Gerenciamento de unidades, conexão e criação.
- **Salas:** Cadastro e gerenciamento de salas.
- **Equipamentos:** Cadastro, edição e exclusão de equipamentos.
- **Categorias:** Gerenciamento de categorias de equipamentos.
- **Chamados:** Abertura, acompanhamento, chat, conclusão e avaliação.
- **Perfil:** Edição de dados pessoais e foto de perfil.
- **Recuperação de Senha:** Fluxo de redefinição via e-mail.

---

## Segurança

- Autenticação de usuários por sessão PHP.
- Verificação de e-mail no cadastro.
- Controle de acesso por cargo (criador, admin, suporte, comum).
- Proteção de rotas via validação de sessão.
- Hash de senha com SHA-256.
- Recuperação de senha com token e expiração.
- Filtros de entrada e validação de dados.

---

## Melhorias Futuras

- Implementação de API RESTful para integração externa.
- Logs de auditoria de ações administrativas.
- Notificações em tempo real.
- Upload de arquivos em chamados.
- Melhorias na responsividade e acessibilidade.
- Internacionalização (i18n).

---

## Autor

<table>
  <tr>
    <td align="center"><img src="./assets/img/Lais.jpg" width="100px;" alt="Foto Laís"/><br /><b>Laís Liborio</b><br />Documentação e elaboração<br /><a href="#">GitHub</a> | <a href="#">LinkedIn</a></td>
    <td align="center"><img src="./assets/img/Victor.jpg" width="100px;" alt="Foto Victor"/><br /><b>Victor Ramos</b><br />Backend e funcionalidades<br /><a href="http://Github.com/Ramos-Victor">GitHub</a> | <a href="https://www.linkedin.com/in/victor-ramos-2a9ab1291">LinkedIn</a></td>
    <td align="center"><img src="./assets/img/Marcio.jpg" width="100px;" alt="Foto Marcio"/><br /><b>Marcio Gustavo</b><br />Frontend e design<br /><a href="https://github.com/Marcio-gustavoI">GitHub</a> | <a href="https://www.linkedin.com/in/marcio-gustavo-i-2b9496286">LinkedIn</a></td>
  </tr>
</table>

---

Desenvolvido com dedicação por Laís Liborio, Victor Ramos e Marcio Gustavo.
