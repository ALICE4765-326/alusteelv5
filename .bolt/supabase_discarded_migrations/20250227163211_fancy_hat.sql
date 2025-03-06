/*
  # Create Testimonials Table

  1. New Tables
    - `testimonials` - Table to store testimonial information
      - `id` (uuid, primary key)
      - `name` (text, not null)
      - `role` (text)
      - `content` (text, not null)
      - `rating` (integer)
      - `created_at` (timestamptz)
  2. Security
    - Enable RLS on the table
    - Add policies for public read access and authenticated user management
*/

-- Create testimonials table
CREATE TABLE IF NOT EXISTS testimonials (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  role text,
  content text NOT NULL,
  rating integer CHECK (rating >= 1 AND rating <= 5),
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to testimonials"
  ON testimonials
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage testimonials"
  ON testimonials
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Insert sample data
INSERT INTO testimonials (name, role, content, rating)
VALUES 
  ('Marie Dupont', 'Propriétaire', 'Une équipe professionnelle et à l''écoute. La qualité des menuiseries est exceptionnelle et l''installation a été parfaite.', 5),
  ('Jean Martin', 'Architecte', 'Je travaille régulièrement avec Alusteel pour mes projets. Leur expertise et leur réactivité sont des atouts majeurs.', 5),
  ('Sophie Lambert', 'Décoratrice d''intérieur', 'Des produits haut de gamme et un service client irréprochable. Je recommande vivement !', 5)
ON CONFLICT DO NOTHING;