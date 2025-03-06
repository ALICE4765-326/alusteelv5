-- Correction de la table des témoignages
DO $$
BEGIN
  -- Vérifier si la table testimonials existe
  IF EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'testimonials'
  ) THEN
    -- Vérifier si la colonne id est de type uuid
    IF NOT EXISTS (
      SELECT FROM information_schema.columns
      WHERE table_schema = 'public' AND table_name = 'testimonials' AND column_name = 'id' AND data_type = 'uuid'
    ) THEN
      -- Créer une table temporaire avec la structure correcte
      CREATE TABLE testimonials_new (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        name text NOT NULL,
        role text,
        content text NOT NULL,
        rating integer NOT NULL DEFAULT 5 CHECK (rating BETWEEN 1 AND 5),
        created_at timestamptz DEFAULT now(),
        updated_at timestamptz DEFAULT now()
      );
      
      -- Copier les données existantes si possible
      BEGIN
        INSERT INTO testimonials_new (name, role, content, rating, created_at, updated_at)
        SELECT name, role, content, rating, created_at, created_at
        FROM testimonials;
        
        EXCEPTION WHEN OTHERS THEN
          -- En cas d'erreur, ne pas copier les données
          RAISE NOTICE 'Impossible de copier les données existantes, création d''une table vide';
      END;
      
      -- Supprimer l'ancienne table
      DROP TABLE testimonials;
      
      -- Renommer la nouvelle table
      ALTER TABLE testimonials_new RENAME TO testimonials;
      
      -- Recréer les index et contraintes
      ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;
      
      -- Recréer les politiques
      CREATE POLICY "Allow public read access to testimonials"
        ON testimonials
        FOR SELECT
        TO public
        USING (true);
      
      CREATE POLICY "Allow authenticated users to manage testimonials"
        ON testimonials
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
      
      -- Recréer le trigger pour updated_at
      CREATE TRIGGER update_testimonials_updated_at
        BEFORE UPDATE ON testimonials
        FOR EACH ROW
        EXECUTE FUNCTION update_updated_at_column();
    END IF;
  ELSE
    -- Créer la table si elle n'existe pas
    CREATE TABLE testimonials (
      id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
      name text NOT NULL,
      role text,
      content text NOT NULL,
      rating integer NOT NULL DEFAULT 5 CHECK (rating BETWEEN 1 AND 5),
      created_at timestamptz DEFAULT now(),
      updated_at timestamptz DEFAULT now()
    );
    
    -- Activer RLS
    ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;
    
    -- Créer les politiques
    CREATE POLICY "Allow public read access to testimonials"
      ON testimonials
      FOR SELECT
      TO public
      USING (true);
    
    CREATE POLICY "Allow authenticated users to manage testimonials"
      ON testimonials
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
    
    -- Créer le trigger pour updated_at
    CREATE TRIGGER update_testimonials_updated_at
      BEFORE UPDATE ON testimonials
      FOR EACH ROW
      EXECUTE FUNCTION update_updated_at_column();
  END IF;
  
  -- Vérifier si la table testimonial_media existe
  IF EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'testimonial_media'
  ) THEN
    -- Vérifier si la colonne testimonial_id est de type uuid
    IF NOT EXISTS (
      SELECT FROM information_schema.columns
      WHERE table_schema = 'public' AND table_name = 'testimonial_media' AND column_name = 'testimonial_id' AND data_type = 'uuid'
    ) THEN
      -- Créer une table temporaire avec la structure correcte
      CREATE TABLE testimonial_media_new (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        testimonial_id uuid REFERENCES testimonials(id) ON DELETE CASCADE,
        media_type text NOT NULL CHECK (media_type IN ('image')),
        url text NOT NULL,
        position integer NOT NULL DEFAULT 0,
        created_at timestamptz DEFAULT now()
      );
      
      -- Supprimer l'ancienne table
      DROP TABLE testimonial_media;
      
      -- Renommer la nouvelle table
      ALTER TABLE testimonial_media_new RENAME TO testimonial_media;
      
      -- Recréer les index et contraintes
      ALTER TABLE testimonial_media ENABLE ROW LEVEL SECURITY;
      CREATE INDEX testimonial_media_testimonial_id_idx ON testimonial_media(testimonial_id);
      
      -- Recréer les politiques
      CREATE POLICY "Allow public read access to testimonial media"
        ON testimonial_media
        FOR SELECT
        TO public
        USING (true);
      
      CREATE POLICY "Allow authenticated users to manage testimonial media"
        ON testimonial_media
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
    END IF;
  ELSE
    -- Créer la table si elle n'existe pas
    CREATE TABLE testimonial_media (
      id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
      testimonial_id uuid REFERENCES testimonials(id) ON DELETE CASCADE,
      media_type text NOT NULL CHECK (media_type IN ('image')),
      url text NOT NULL,
      position integer NOT NULL DEFAULT 0,
      created_at timestamptz DEFAULT now()
    );
    
    -- Activer RLS
    ALTER TABLE testimonial_media ENABLE ROW LEVEL SECURITY;
    CREATE INDEX testimonial_media_testimonial_id_idx ON testimonial_media(testimonial_id);
    
    -- Créer les politiques
    CREATE POLICY "Allow public read access to testimonial media"
      ON testimonial_media
      FOR SELECT
      TO public
      USING (true);
    
    CREATE POLICY "Allow authenticated users to manage testimonial media"
      ON testimonial_media
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
  END IF;
END
$$;

-- Insérer des témoignages de test
INSERT INTO testimonials (name, role, content, rating)
VALUES 
  ('Maria Duarte', 'Proprietária', 'Uma equipa profissional e atenta. A qualidade das carpintarias é excepcional e a instalação foi perfeita.', 5),
  ('João Martins', 'Arquiteto', 'Trabalho regularmente com a Alusteel para os meus projetos. A sua expertise e reatividade são trunfos importantes.', 5),
  ('Sofia Lopes', 'Decoradora de interiores', 'Produtos de alta qualidade e um serviço ao cliente irrepreensível. Recomendo vivamente!', 5)
ON CONFLICT DO NOTHING;