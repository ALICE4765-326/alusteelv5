/*
  # Tabelas de mídia para projetos e blog

  1. Novas Tabelas
    - `project_media` - Tabela para armazenar mídias dos projetos
    - `blog_media` - Tabela para armazenar mídias dos artigos do blog
  2. Segurança
    - Ativar RLS em ambas as tabelas
    - Adicionar políticas para leitura pública e escrita autenticada
  3. Índices
    - Adicionar índices para melhorar o desempenho das consultas
*/

-- Tabela para os mídias dos projetos
CREATE TABLE IF NOT EXISTS project_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid REFERENCES projects(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image', 'video')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Tabela para os mídias dos artigos de blog
CREATE TABLE IF NOT EXISTS blog_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  blog_post_id uuid REFERENCES blog_posts(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image', 'video')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE project_media ENABLE ROW LEVEL SECURITY;
ALTER TABLE blog_media ENABLE ROW LEVEL SECURITY;

-- Políticas para project_media
CREATE POLICY "Allow public read access to project media"
  ON project_media
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage project media"
  ON project_media
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Políticas para blog_media
CREATE POLICY "Allow public read access to blog media"
  ON blog_media
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage blog media"
  ON blog_media
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Índices para melhorar as performances
CREATE INDEX IF NOT EXISTS project_media_project_id_idx ON project_media(project_id);
CREATE INDEX IF NOT EXISTS blog_media_blog_post_id_idx ON blog_media(blog_post_id);