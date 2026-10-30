-- Execute no SQL Editor do Supabase para habilitar upload de imagens.
-- Cria um bucket público com limite de 5 MB e aceita apenas imagens.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('article-images', 'article-images', true, 5242880, array['image/jpeg','image/png','image/webp','image/gif','image/avif'])
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "Public can view article images" on storage.objects;
create policy "Public can view article images"
on storage.objects for select
to public
using (bucket_id = 'article-images');

drop policy if exists "Authors can upload article images" on storage.objects;
create policy "Authors can upload article images"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'article-images'
  and (storage.foldername(name))[1] = auth.uid()::text
);
