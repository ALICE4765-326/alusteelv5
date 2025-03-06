/*
  # Adicionar colunas de vídeo às tabelas existentes

  1. Verificação de Tabelas
    - Verifica se as tabelas existem antes de adicionar colunas
  2. Adição de Colunas
    - Adiciona coluna video_url às tabelas se elas existirem
*/

-- Verificar se a tabela projects existe e adicionar coluna video_url
DO $$
BEGIN
  IF EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'projects'
  ) THEN
    ALTER TABLE projects ADD COLUMN IF NOT EXISTS video_url text;
  END IF;
END
$$;

-- Verificar se a tabela blog_posts existe e adicionar coluna video_url
DO $$
BEGIN
  IF EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'blog_posts'
  ) THEN
    ALTER TABLE blog_posts ADD COLUMN IF NOT EXISTS video_url text;
  END IF;
END
$$;