-- Blog Media Table
CREATE TABLE IF NOT EXISTS blog_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  blog_post_id uuid REFERENCES blog_posts(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image', 'video')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE blog_media ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to blog media"
  ON blog_media
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage blog media"
  ON blog_media
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create index for better performance
CREATE INDEX blog_media_blog_post_id_idx ON blog_media(blog_post_id);