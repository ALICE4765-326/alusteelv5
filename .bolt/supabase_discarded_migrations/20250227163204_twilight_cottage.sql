/*
  # Create Blog Posts Table

  1. New Tables
    - `blog_posts` - Table to store blog post information
      - `id` (uuid, primary key)
      - `title` (text, not null)
      - `excerpt` (text)
      - `content` (text)
      - `category` (text)
      - `published_at` (date)
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
  2. Security
    - Enable RLS on the table
    - Add policies for public read access and authenticated user management
*/

-- Create blog_posts table
CREATE TABLE IF NOT EXISTS blog_posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  excerpt text,
  content text,
  category text,
  published_at date,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE blog_posts ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to blog posts"
  ON blog_posts
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage blog posts"
  ON blog_posts
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create trigger for updated_at
CREATE TRIGGER update_blog_posts_updated_at
  BEFORE UPDATE ON blog_posts
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data
INSERT INTO blog_posts (title, excerpt, content, category, published_at)
VALUES 
  ('Les tendances menuiserie 2025', 'Découvrez les dernières innovations en matière de menuiserie aluminium et PVC.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Tendances', '2025-03-15'),
  ('Comment choisir ses fenêtres ?', 'Guide complet pour sélectionner les fenêtres adaptées à votre habitat.', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'Guides', '2025-03-10'),
  ('La sécurité avant tout', 'Les solutions de serrurerie modernes pour protéger votre maison.', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 'Sécurité', '2025-03-05')
ON CONFLICT DO NOTHING;