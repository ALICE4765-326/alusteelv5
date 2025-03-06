/*
  # Criar tabela de projetos

  1. Nova Tabela
    - `projects` - Tabela para armazenar projetos com campos adicionais
  2. Segurança
    - Ativar RLS na tabela
    - Adicionar políticas para leitura pública e escrita autenticada
*/

-- Adicionar campos adicionais à tabela de projetos existente
ALTER TABLE projects 
ADD COLUMN IF NOT EXISTS name text NOT NULL DEFAULT '',
ADD COLUMN IF NOT EXISTS created_at timestamptz DEFAULT now();

-- Criar índice para melhorar a performance
CREATE INDEX IF NOT EXISTS projects_name_idx ON projects(name);

-- Garantir que RLS está ativado
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Verificar e criar políticas de segurança se não existirem
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'projects' AND policyname = 'Allow public read access to projects'
  ) THEN
    CREATE POLICY "Allow public read access to projects"
      ON projects
      FOR SELECT
      TO public
      USING (true);
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'projects' AND policyname = 'Allow authenticated users to manage projects'
  ) THEN
    CREATE POLICY "Allow authenticated users to manage projects"
      ON projects
      FOR ALL
      TO authenticated
      USING (true)
      WITH CHECK (true);
  END IF;
END
$$;

-- Garantir que o trigger para atualização do timestamp existe
DROP TRIGGER IF EXISTS update_projects_updated_at ON projects;
CREATE TRIGGER update_projects_updated_at
  BEFORE UPDATE ON projects
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();