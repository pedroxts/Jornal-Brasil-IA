-- Execute este script no SQL Editor do seu projeto Supabase.
create extension if not exists pgcrypto;
create table if not exists public.articles (
 id uuid primary key default gen_random_uuid(),
 title text not null check (char_length(title) between 1 and 180),
 summary text not null check (char_length(summary) between 1 and 280),
 content text not null,
 category text not null default 'Brasil' check (category in ('Brasil','Política','Economia','Tecnologia','Esportes','Mundo','Entretenimento','Saúde')),
 image_url text,
 status text not null default 'draft' check (status in ('draft','published')),
 author_id uuid not null references auth.users(id) on delete restrict,
 published_at timestamptz,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create index if not exists articles_published_at_idx on public.articles (published_at desc) where status = 'published';
alter table public.articles enable row level security;
drop policy if exists "Anyone can read published articles" on public.articles;
create policy "Anyone can read published articles" on public.articles for select using (status = 'published' or auth.uid() = author_id);
drop policy if exists "Authenticated authors can insert articles" on public.articles;
create policy "Authenticated authors can insert articles" on public.articles for insert to authenticated with check (auth.uid() = author_id);
drop policy if exists "Authors can update their articles" on public.articles;
create policy "Authors can update their articles" on public.articles for update to authenticated using (auth.uid() = author_id) with check (auth.uid() = author_id);
drop policy if exists "Authors can delete their articles" on public.articles;
create policy "Authors can delete their articles" on public.articles for delete to authenticated using (auth.uid() = author_id);
