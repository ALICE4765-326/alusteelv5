/*
  # Fix Database Structure

  1. New Tables
    - Ensure `projects` table exists with correct structure
    - Add missing columns to existing tables
  2. Security
    - Enable RLS on all tables
    - Add policies for public read access and authenticated user management
*/

-- Drop conflicting triggers if they exist
DROP TRIGGER IF EXISTS update_projects_updated_at ON projects;

-- Create or recreate projects table with proper structure
CREATE TABLE IF NOT EXISTS projects (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  name text,
  category text,
  description text,
  city text,
  video_url text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Make sure name column has a default value if it's required
ALTER TABLE projects 
  ALTER COLUMN name SET DEFAULT '',
  ALTER COLUMN name DROP NOT NULL;

-- Enable RLS
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Create policies if they don't exist
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

-- Create function to update timestamp if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_proc WHERE proname = 'update_updated_at_column'
  ) THEN
    CREATE FUNCTION update_updated_at_column()
    RETURNS TRIGGER AS $$
    BEGIN
      NEW.updated_at = now();
      RETURN NEW;
    END;
    $$ language 'plpgsql';
  END IF;
END
$$;

-- Create trigger for updated_at
CREATE TRIGGER update_projects_updated_at
  BEFORE UPDATE ON projects
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Create project_media table if it doesn't exist
CREATE TABLE IF NOT EXISTS project_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid REFERENCES projects(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image', 'video')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS on project_media
ALTER TABLE project_media ENABLE ROW LEVEL SECURITY;

-- Create policies for project_media
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'project_media' AND policyname = 'Allow public read access to project media'
  ) THEN
    CREATE POLICY "Allow public read access to project media"
      ON project_media
      FOR SELECT
      TO public
      USING (true);
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'project_media' AND policyname = 'Allow authenticated users to manage project media'
  ) THEN
    CREATE POLICY "Allow authenticated users to manage project media"
      ON project_media
      FOR ALL
      TO authenticated
      USING (true)
      WITH CHECK (true);
  END IF;
END
$$;

-- Create index for project_media if it doesn't exist
CREATE INDEX IF NOT EXISTS project_media_project_id_idx ON project_media(project_id);

-- Create project_documents table if it doesn't exist
CREATE TABLE IF NOT EXISTS project_documents (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid REFERENCES projects(id) ON DELETE CASCADE,
  name text NOT NULL,
  description text,
  url text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS on project_documents
ALTER TABLE project_documents ENABLE ROW LEVEL SECURITY;

-- Create policies for project_documents
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'project_documents' AND policyname = 'Allow public read access to project documents'
  ) THEN
    CREATE POLICY "Allow public read access to project documents"
      ON project_documents
      FOR SELECT
      TO public
      USING (true);
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'project_documents' AND policyname = 'Allow authenticated users to manage project documents'
  ) THEN
    CREATE POLICY "Allow authenticated users to manage project documents"
      ON project_documents
      FOR ALL
      TO authenticated
      USING (true)
      WITH CHECK (true);
  END IF;
END
$$;

-- Create index for project_documents if it doesn't exist
CREATE INDEX IF NOT EXISTS project_documents_project_id_idx ON project_documents(project_id);

-- Insert sample data if the table is empty
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM projects LIMIT 1) THEN
    INSERT INTO projects (title, category, description, city)
    VALUES 
      ('Menuiserie aluminium', 'Janelas', 'Instalação de janelas em alumínio para uma villa moderna', 'Lisboa'),
      ('Porta de entrada', 'Portas', 'Porta de entrada design em alumínio preto mate', 'Porto'),
      ('Varanda moderna', 'Varandas', 'Varanda contemporânea com telhado plano', 'Faro'),
      ('Serralharia', 'Serralharia', 'Instalação de um sistema de segurança de alto desempenho', 'Braga'),
      ('Porta de correr', 'Janelas', 'Porta de correr com sistema de ocultação para uma vista panorâmica', 'Coimbra'),
      ('Porta de garagem', 'Portas', 'Porta de garagem seccionada motorizada', 'Aveiro');
  END IF;
END
$$;