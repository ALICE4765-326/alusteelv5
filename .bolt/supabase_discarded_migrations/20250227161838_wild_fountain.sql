/*
  # Criar tabelas de projetos e posts de blog se não existirem

  1. Verificação e Criação de Tabelas
    - Verifica se as tabelas existem antes de tentar criar
    - Cria as tabelas projects e blog_posts se não existirem
  2. Adição de Colunas
    - Adiciona coluna video_url às tabelas
  3. Segurança
    - Ativa RLS nas tabelas
    - Adiciona políticas de segurança
*/

-- Verificar e criar a tabela projects se não existir
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'projects'
  ) THEN
    CREATE TABLE projects (
      id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
      name text NOT NULL,
      title text,
      category text,
      description text,
      city text,
      video_url text,
      created_at timestamptz DEFAULT now(),
      updated_at timestamptz DEFAULT now()
    );
    
    -- Ativar RLS
    ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
    
    -- Criar políticas
    CREATE POLICY "Allow public read access to projects"
      ON projects
      FOR SELECT
      TO public
      USING (true);
    
    CREATE POLICY "Allow authenticated users to manage projects"
      ON projects
      FOR ALL
      TO authenticated
      USING (true)
      WITH CHECK (true);
    
    -- Criar trigger para atualização do timestamp
    CREATE TRIGGER update_projects_updated_at
      BEFORE UPDATE ON projects
      FOR EACH ROW
      EXECUTE FUNCTION update_updated_at_column();
  END IF;
END
$$;

-- Verificar e criar a tabela blog_posts se não existir
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'blog_posts'
  ) THEN
    CREATE TABLE blog_posts (
      id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
      title text NOT NULL,
      excerpt text,
      content text,
      category text,
      video_url text,
      published_at timestamptz,
      created_at timestamptz DEFAULT now(),
      updated_at timestamptz DEFAULT now()
    );
    
    -- Ativar RLS
    ALTER TABLE blog_posts ENABLE ROW LEVEL SECURITY;
    
    -- Criar políticas
    CREATE POLICY "Allow public read access to blog posts"
      ON blog_posts
      FOR SELECT
      TO public
      USING (true);
    
    CREATE POLICY "Allow authenticated users to manage blog posts"
      ON blog_posts
      FOR ALL
      TO authenticated
      USING (true)
      WITH CHECK (true);
    
    -- Criar trigger para atualização do timestamp
    CREATE TRIGGER update_blog_posts_updated_at
      BEFORE UPDATE ON blog_posts
      FOR EACH ROW
      EXECUTE FUNCTION update_updated_at_column();
  END IF;
END
$$;

-- Garantir que as colunas video_url existem em ambas as tabelas
ALTER TABLE projects ADD COLUMN IF NOT EXISTS video_url text;
ALTER TABLE blog_posts ADD COLUMN IF NOT EXISTS video_url text;