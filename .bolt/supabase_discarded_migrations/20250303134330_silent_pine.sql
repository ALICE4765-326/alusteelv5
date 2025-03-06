-- Content Text Table
CREATE TABLE IF NOT EXISTS content_text (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  section text NOT NULL,
  key text NOT NULL,
  value text NOT NULL,
  description text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(section, key)
);

-- Enable RLS
ALTER TABLE content_text ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to content_text"
  ON content_text
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage content_text"
  ON content_text
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE user_id = auth.uid() AND role = 'admin'
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE user_id = auth.uid() AND role = 'admin'
    )
  );

-- Create trigger for updated_at
CREATE TRIGGER update_content_text_updated_at
  BEFORE UPDATE ON content_text
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Insert initial content
INSERT INTO content_text (section, key, value, description)
VALUES
  ('home', 'hero_title', 'Alusteel', 'Homepage hero title'),
  ('home', 'hero_subtitle', 'A excelência ao serviço dos seus projetos', 'Homepage hero subtitle'),
  ('home', 'hero_description', 'Precisa de carpintaria e soluções em alumínio sob medida, com qualidade, preço justo e rapidez? Podemos ajudá-lo!', 'Homepage hero description')
ON CONFLICT (section, key) DO NOTHING;