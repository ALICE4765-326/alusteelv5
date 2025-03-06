/*
  # Insert test data

  1. Test Data
    - Insert test settings with contact information
    - Insert test admin user
*/

-- Insert test settings
INSERT INTO settings (id, contacts)
VALUES (
  1,
  '{
    "phone": "01 23 45 67 89",
    "email": "contact@alusteel.fr",
    "address": "123 Avenue des Menuisiers\n75001 Paris"
  }'::jsonb
) ON CONFLICT (id) DO UPDATE
SET contacts = EXCLUDED.contacts;

-- Insert test admin user (à exécuter dans l'interface Supabase)
-- Email: admin@alusteel.fr
-- Password: Admin123!