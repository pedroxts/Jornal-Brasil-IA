# News Brasil IA

Portal jornalístico responsivo em React + Vite, com painel de administração e persistência no Supabase (Postgres + Auth). O projeto não inclui notícias fictícias.

## O que já está implementado
- Página inicial responsiva e categorias.
- Busca por título, resumo e conteúdo.
- Página individual de notícia.
- Painel com login, criação, edição, rascunho/publicação e exclusão.
- Banco persistente via Supabase e políticas Row Level Security.

## Configuração necessária uma única vez

O site ainda precisa ser ligado a um projeto Supabase e hospedado para ficar público na internet. Não coloque senhas privadas no código; a chave `anon/public` do Supabase é usada no navegador e a segurança é aplicada pelas políticas RLS.

1. Crie um projeto no Supabase: https://supabase.com/dashboard
2. No projeto, abra **SQL Editor**, cole o conteúdo de `supabase/schema.sql` e execute.
3. Em **Authentication → Users**, crie o usuário que será administrador. Use um e-mail seu e uma senha forte. O painel não tem senha padrão.
4. Em **Project Settings → API** (ou Connect), copie a **Project URL** e a chave pública **anon/publishable**.
5. Copie `.env.example` para `.env` e preencha:
   ```env
   VITE_SUPABASE_URL=https://SEU-PROJETO.supabase.co
   VITE_SUPABASE_ANON_KEY=SUA_CHAVE_PUBLICA
   ```
6. Instale Node.js LTS. Na pasta do projeto, rode:
   ```bash
   npm install
   npm run dev
   ```
7. Para publicar, importe a pasta/repositório no Vercel. Configure as mesmas duas variáveis em **Project Settings → Environment Variables**, faça o deploy e abra a URL gerada.

## Segurança importante
- Nunca use a `service_role` key no navegador ou nas variáveis `VITE_`.
- As regras RLS permitem que visitantes leiam apenas notícias publicadas e que o autor autenticado gerencie os próprios artigos.
- Se for adicionar outros jornalistas, planeje permissões de equipe antes de dar acesso a contas.
- A versão inicial aceita URL pública de imagem. Upload de arquivos pode ser acrescentado com Supabase Storage.

## Uso
Entre no site, clique em **Administração**, entre com a conta criada no Supabase e selecione **Nova notícia**. Notícias publicadas aparecem na página inicial; rascunhos ficam somente no painel do autor.
