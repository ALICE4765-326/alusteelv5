/*
  # Create Project Documents Table

  1. New Tables
    - `project_documents` - Table to store project document information
      - `id` (uuid, primary key)
      - `project_id` (uuid, foreign key to projects)
      - `name` (text, not null)
      - `description` (text)
      - `url` (text, not null)
      - `created_at` (timestamptz)
  2. Security
    - Enable RLS on the table
    - Add policies for public read access and authenticated user management
*/

-- Create project_documents table
CREATE TABLE IF NOT EXISTS project_documents (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid REFERENCES projects(id) ON DELETE CASCADE,
  name text NOT NULL,
  description text,
  url text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE project_documents ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to project documents"
  ON project_documents
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage project documents"
  ON project_documents
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create index for better performance
CREATE INDEX project_documents_project_id_idx ON project_documents(project_id);

-- Insert sample data
INSERT INTO project_documents (project_id, name, description, url)
SELECT 
  id, 
  'Fiche technique', 
  'Caractéristiques techniques des fenêtres en aluminium',
  '/documents/fiche-technique-alu.pdf'
FROM projects 
WHERE title = 'Menuiserie aluminium'
ON CONFLICT DO NOTHING;