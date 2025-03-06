/*
  # Admin Content Management System

  1. New Tables
    - `content_text` - Stores text content for the website
    - `admin_logs` - Tracks admin actions for auditing
    - `admin_users` - Stores admin user roles and permissions
  
  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated admin users
    - Ensure proper access control
*/

-- Create content_text table for managing website text content
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

-- Create admin_logs table for activity tracking
CREATE TABLE IF NOT EXISTS admin_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id),
  action text NOT NULL,
  details jsonb DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

-- Create admin_users table for role management
CREATE TABLE IF NOT EXISTS admin_users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) UNIQUE,
  role text NOT NULL CHECK (role IN ('admin', 'editor')),
  permissions jsonb DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS on all tables
ALTER TABLE content_text ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_users ENABLE ROW LEVEL SECURITY;

-- Create policies for content_text
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

-- Create policies for admin_logs
CREATE POLICY "Allow authenticated admin users to read logs"
  ON admin_logs
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE user_id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Allow authenticated admin users to create logs"
  ON admin_logs
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE user_id = auth.uid() AND role = 'admin'
    )
  );

-- Create policies for admin_users
CREATE POLICY "Allow authenticated admin users to manage admin_users"
  ON admin_users
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

-- Create function to update timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_content_text_updated_at
  BEFORE UPDATE ON content_text
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_admin_users_updated_at
  BEFORE UPDATE ON admin_users
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Create storage bucket for media if it doesn't exist
INSERT INTO storage.buckets (id, name)
VALUES ('media', 'media')
ON CONFLICT DO NOTHING;

-- Create storage policies for media bucket
CREATE POLICY "Allow public access to media"
  ON storage.objects
  FOR SELECT
  TO public
  USING (bucket_id = 'media');

CREATE POLICY "Allow authenticated admin users to manage media"
  ON storage.objects
  FOR ALL
  TO authenticated
  USING (
    bucket_id = 'media' AND
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE user_id = auth.uid() AND role = 'admin'
    )
  )
  WITH CHECK (
    bucket_id = 'media' AND
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE user_id = auth.uid() AND role = 'admin'
    )
  );

-- Insert initial admin user (to be updated with real admin email)
INSERT INTO admin_users (user_id, role)
VALUES (
  (SELECT id FROM auth.users WHERE email = 'admin@alusteel.pt' LIMIT 1),
  'admin'
)
ON CONFLICT (user_id) DO NOTHING;

-- Insert initial content
INSERT INTO content_text (section, key, value, description)
VALUES
  ('home', 'hero_title', 'Alusteel', 'Homepage hero title'),
  ('home', 'hero_subtitle', 'A excelência ao serviço dos seus projetos', 'Homepage hero subtitle'),
  ('home', 'hero_description', 'Precisa de carpintaria e soluções em alumínio sob medida, com qualidade, preço justo e rapidez? Podemos ajudá-lo!', 'Homepage hero description')
ON CONFLICT (section, key) DO NOTHING;