-- Create storage bucket
INSERT INTO storage.buckets (id, name)
VALUES ('media', 'media')
ON CONFLICT DO NOTHING;

-- Create storage policies for media bucket
CREATE POLICY "Allow public access to media"
  ON storage.objects
  FOR SELECT
  TO public
  USING (bucket_id = 'media');

CREATE POLICY "Allow authenticated users to manage media"
  ON storage.objects
  FOR ALL
  TO authenticated
  USING (bucket_id = 'media')
  WITH CHECK (bucket_id = 'media');

-- Create public bucket
INSERT INTO storage.buckets (id, name)
VALUES ('public', 'public')
ON CONFLICT DO NOTHING;

-- Create storage policies for public bucket
CREATE POLICY "Allow public access to assets"
  ON storage.objects
  FOR SELECT
  TO public
  USING (bucket_id = 'public');

CREATE POLICY "Allow authenticated users to upload assets"
  ON storage.objects
  FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'public');

CREATE POLICY "Allow authenticated users to update assets"
  ON storage.objects
  FOR UPDATE
  TO authenticated
  USING (bucket_id = 'public');