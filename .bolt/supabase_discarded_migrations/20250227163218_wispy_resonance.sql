/*
  # Create Partners Table

  1. New Tables
    - `partners` - Table to store partner information
      - `id` (uuid, primary key)
      - `name` (text, not null)
      - `description` (text)
      - `icon` (text)
      - `created_at` (timestamptz)
  2. Security
    - Enable RLS on the table
    - Add policies for public read access and authenticated user management
*/

-- Create partners table
CREATE TABLE IF NOT EXISTS partners (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  icon text,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE partners ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to partners"
  ON partners
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage partners"
  ON partners
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Insert sample data
INSERT INTO partners (name, description, icon)
VALUES 
  ('ProPoseAlu', 'Spécialiste de la pose, ProPoseAlu assure une installation soignée et professionnelle de nos menuiseries et éléments de serrurerie, partout en France.', 'M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z'),
  ('Portails en Kits', 'Expert en kits de portails, portillons et accessoires d''entretien, Portails en Kits propose des solutions simples à monter, robustes et adaptées à tous les besoins.', 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z'),
  ('Premium à Juste Prix', 'Portails, portillons, pergolas et carports : Premium à Juste Prix offre des produits haut de gamme à des tarifs accessibles, avec une commande en ligne et une livraison partout en France.', 'M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z'),
  ('VProBâtiment', 'VProBâtiment est le partenaire idéal pour vos projets de construction et de rénovation, alliant expertise et qualité d''exécution.', 'M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4')
ON CONFLICT DO NOTHING;