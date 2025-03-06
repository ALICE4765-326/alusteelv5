-- Settings Table
CREATE TABLE IF NOT EXISTS settings (
  id int PRIMARY KEY,
  contacts jsonb DEFAULT '{}'::jsonb,
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to settings"
  ON settings
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to update settings"
  ON settings
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow authenticated users to insert settings"
  ON settings
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Insert default settings
INSERT INTO settings (id, contacts)
VALUES (
  1,
  '{
    "phone": "XX XX XX XX XX",
    "email": "contacto@alusteel.pt",
    "address": "A definir"
  }'::jsonb
) ON CONFLICT (id) DO UPDATE
SET contacts = EXCLUDED.contacts;