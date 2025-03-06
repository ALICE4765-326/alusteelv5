/*
  # Tabelas para testemunhos e parceiros

  1. Novas Tabelas
    - `testimonials` - Tabela para armazenar testemunhos de clientes
    - `partners` - Tabela para armazenar parceiros
    - `testimonial_media` - Tabela para armazenar mídias dos testemunhos
    - `partner_media` - Tabela para armazenar mídias dos parceiros
  2. Segurança
    - Ativar RLS em todas as tabelas
    - Adicionar políticas para leitura pública e escrita autenticada
*/

-- Tabela para testemunhos
CREATE TABLE IF NOT EXISTS testimonials (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  role text,
  content text NOT NULL,
  rating integer NOT NULL DEFAULT 5 CHECK (rating BETWEEN 1 AND 5),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Tabela para parceiros
CREATE TABLE IF NOT EXISTS partners (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  icon text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Tabela para os mídias dos testemunhos
CREATE TABLE IF NOT EXISTS testimonial_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  testimonial_id uuid REFERENCES testimonials(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Tabela para os mídias dos parceiros
CREATE TABLE IF NOT EXISTS partner_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  partner_id uuid REFERENCES partners(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;
ALTER TABLE partners ENABLE ROW LEVEL SECURITY;
ALTER TABLE testimonial_media ENABLE ROW LEVEL SECURITY;
ALTER TABLE partner_media ENABLE ROW LEVEL SECURITY;

-- Políticas para testimonials
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

-- Políticas para partners
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

-- Políticas para testimonial_media
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

-- Políticas para partner_media
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

-- Triggers para updated_at
CREATE TRIGGER update_testimonials_updated_at
  BEFORE UPDATE ON testimonials
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_partners_updated_at
  BEFORE UPDATE ON partners
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Índices para melhorar as performances
CREATE INDEX IF NOT EXISTS testimonial_media_testimonial_id_idx ON testimonial_media(testimonial_id);
CREATE INDEX IF NOT EXISTS partner_media_partner_id_idx ON partner_media(partner_id);