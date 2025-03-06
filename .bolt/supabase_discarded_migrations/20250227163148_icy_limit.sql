/*
  # Create Projects Table

  1. New Tables
    - `projects` - Table to store project information
      - `id` (uuid, primary key)
      - `title` (text, not null)
      - `category` (text, not null)
      - `description` (text)
      - `city` (text)
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
  2. Security
    - Enable RLS on the table
    - Add policies for public read access and authenticated user management
*/

-- Create projects table
CREATE TABLE IF NOT EXISTS projects (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  category text NOT NULL,
  description text,
  city text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Create policies
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

-- Insert sample data
INSERT INTO projects (title, category, description, city)
VALUES 
  ('Menuiserie aluminium', 'Fenêtres', 'Installation de fenêtres en aluminium pour une villa moderne', 'Lyon'),
  ('Porte d''entrée', 'Portes', 'Porte d''entrée design en aluminium noir mat', 'Paris'),
  ('Véranda moderne', 'Vérandas', 'Véranda contemporaine avec toiture plate', 'Bordeaux'),
  ('Serrurerie', 'Serrurerie', 'Installation d''un système de sécurité haute performance', 'Marseille'),
  ('Baie vitrée', 'Fenêtres', 'Baie vitrée à galandage pour une vue panoramique', 'Nice'),
  ('Porte de garage', 'Portes', 'Porte de garage sectionnelle motorisée', 'Toulouse')
ON CONFLICT DO NOTHING;