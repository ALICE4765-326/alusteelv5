/*
  # Mise à jour de la gestion des bannières

  1. Modifications
    - Ajout de la colonne `banner_color` à la table `pages`
    - Mise à jour des valeurs par défaut pour les pages existantes
*/

-- Mise à jour des pages existantes
UPDATE pages 
SET banner_color = CASE 
  WHEN path = '/' THEN '#1a365d'
  WHEN path = '/contact' THEN '#1a365d'
  ELSE banner_color
END
WHERE path IN ('/', '/contact');