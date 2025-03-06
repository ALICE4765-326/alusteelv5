/*
  # Create settings table and storage

  1. New Tables
    - `settings`
      - `id` (int, primary key)
      - `contacts` (jsonb)
      - `updated_at` (timestamp)

  2. Storage
    - Create bucket for public assets

  3. Security
    - Enable RLS on settings table
    - Add policies for authenticated users
*/

-- Create settings table
CREATE TABLE IF NOT EXISTS settings (
  id int PRIMARY KEY,
  contacts jsonb DEFAULT '{}'::jsonb,
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow authenticated users to read settings"
  ON settings
  FOR SELECT
  TO authenticated
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

-- Create storage bucket
INSERT INTO storage.buckets (id, name)
VALUES ('public', 'public')
ON CONFLICT DO NOTHING;

-- Create storage policies
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