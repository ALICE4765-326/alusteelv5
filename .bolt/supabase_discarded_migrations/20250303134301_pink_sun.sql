-- Project Media Table
CREATE TABLE IF NOT EXISTS project_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid REFERENCES projects(id) ON DELETE CASCADE,
  media_type text NOT NULL CHECK (media_type IN ('image', 'video')),
  url text NOT NULL,
  position integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE project_media ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to project media"
  ON project_media
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow authenticated users to manage project media"
  ON project_media
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create index for better performance
CREATE INDEX project_media_project_id_idx ON project_media(project_id);