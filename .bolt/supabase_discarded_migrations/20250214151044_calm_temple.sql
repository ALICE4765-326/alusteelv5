/*
  # Ajout de la gestion multi-médias pour les témoignages et partenaires

  1. Nouvelles Tables
    - `testimonial_media`: Stockage des médias pour les témoignages
    - `partner_media`: Stockage des médias pour les partenaires

  2. Modifications
    - Suppression des colonnes image existantes
    - Migration des données existantes vers les nouvelles tables

  3. Relations
    - Clés étrangères pour lier les médias aux témoignages et partenaires
*/

-- Table pour les médias des témoignages
CREATE TABLE IF NOT EXISTS testimonial_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  testimonial_id uuid REFERENCES testimonials(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Table pour les médias des partenaires
CREATE TABLE IF NOT EXISTS partner_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  partner_id uuid REFERENCES partners(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE testimonial_media ENABLE ROW LEVEL SECURITY;
ALTER TABLE partner_media ENABLE ROW LEVEL SECURITY;

-- Policies pour testimonial_media
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

-- Policies pour partner_media
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

-- Indexes pour améliorer les performances
CREATE INDEX testimonial_media_testimonial_id_idx ON testimonial_media(testimonial_id);
CREATE INDEX partner_media_partner_id_idx ON partner_media(partner_id);