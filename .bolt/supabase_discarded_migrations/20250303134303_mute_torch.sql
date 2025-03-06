-- Project Documents Table
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