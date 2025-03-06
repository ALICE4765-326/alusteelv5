-- Partner Media Table
CREATE TABLE IF NOT EXISTS partner_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  partner_id uuid REFERENCES partners(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE partner_media ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to partner media"
  ON partner_media
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage partner media"
  ON partner_media
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create index for better performance
CREATE INDEX partner_media_partner_id_idx ON partner_media(partner_id);