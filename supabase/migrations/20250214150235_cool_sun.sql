/*
  # Ajout de la gestion des bannières et couleurs de fond

  1. Nouvelles Tables
    - `pages`
      - `id` (uuid, primary key)
      - `name` (text, non null)
      - `path` (text, unique, non null)
      - `visible` (boolean, default true)
      - `banner` (text, nullable)
      - `banner_color` (text, non null, default '#1a365d')
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)

  2. Sécurité
    - Enable RLS sur la table `pages`
    - Ajout de policies pour la lecture et la modification par les utilisateurs authentifiés
*/

-- Create pages table
CREATE TABLE IF NOT EXISTS pages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  path text UNIQUE NOT NULL,
  visible boolean DEFAULT true,
  banner text,
  banner_color text NOT NULL DEFAULT '#1a365d',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE pages ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to pages"
  ON pages
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to update pages"
  ON pages
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create function to update timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for updated_at
CREATE TRIGGER update_pages_updated_at
  BEFORE UPDATE ON pages
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Insert default pages
INSERT INTO pages (name, path) VALUES
  ('Accueil', '/'),
  ('Nos Métiers', '/nos-metiers'),
  ('Nos Chantiers', '/nos-chantiers'),
  ('Nos Partenaires', '/nos-partenaires'),
  ('Témoignages', '/temoignages'),
  ('Blog', '/blog'),
  ('Contact', '/contact')
ON CONFLICT (path) DO NOTHING;