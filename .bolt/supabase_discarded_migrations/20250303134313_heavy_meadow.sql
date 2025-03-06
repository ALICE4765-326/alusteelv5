-- Testimonial Media Table
CREATE TABLE IF NOT EXISTS testimonial_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  testimonial_id uuid REFERENCES testimonials(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE testimonial_media ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to testimonial media"
  ON testimonial_media
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage testimonial media"
  ON testimonial_media
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create index for better performance
CREATE INDEX testimonial_media_testimonial_id_idx ON testimonial_media(testimonial_id);