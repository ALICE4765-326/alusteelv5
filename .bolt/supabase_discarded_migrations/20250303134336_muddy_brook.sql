-- Pages Table
CREATE TABLE IF NOT EXISTS pages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  path text UNIQUE NOT NULL,
  visible boolean DEFAULT true,
  banner text,
  banner_video text,
  banner_type text DEFAULT 'color' CHECK (banner_type IN ('color', 'image', 'video')),
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