/*
  # Ajout de la vidéo en bannière

  1. Modifications
    - Ajout de la colonne `banner_video` à la table `pages`
    - Ajout de la colonne `banner_type` pour gérer le type de bannière (image, vidéo, couleur)
*/

-- Ajout du type de bannière
ALTER TABLE pages ADD COLUMN IF NOT EXISTS banner_type text DEFAULT 'color' CHECK (banner_type IN ('color', 'image', 'video'));

-- Ajout de l'URL de la vidéo
ALTER TABLE pages ADD COLUMN IF NOT EXISTS banner_video text;

-- Mise à jour de la page d'accueil
UPDATE pages 
SET banner_type = 'color'
WHERE path = '/';