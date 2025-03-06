import { supabase } from './supabase';

export interface Project {
  id: string;
  name: string;
  description: string | null;
  created_at: string;
}

export async function getProjects() {
  const { data, error } = await supabase
    .from('projects')
    .select('*')
    .order('created_at', { ascending: false });
  
  if (error) {
    console.error('Erro ao buscar projetos:', error);
    return [];
  }
  
  return data as Project[];
}

export async function getProject(id: string) {
  const { data, error } = await supabase
    .from('projects')
    .select('*')
    .eq('id', id)
    .single();
  
  if (error) {
    console.error(`Erro ao buscar projeto ${id}:`, error);
    return null;
  }
  
  return data as Project;
}

export async function createProject(project: Omit<Project, 'id' | 'created_at'>) {
  const { data, error } = await supabase
    .from('projects')
    .insert(project)
    .select()
    .single();
  
  if (error) {
    console.error('Erro ao criar projeto:', error);
    throw error;
  }
  
  return data as Project;
}

export async function updateProject(id: string, project: Partial<Omit<Project, 'id' | 'created_at'>>) {
  const { data, error } = await supabase
    .from('projects')
    .update(project)
    .eq('id', id)
    .select()
    .single();
  
  if (error) {
    console.error(`Erro ao atualizar projeto ${id}:`, error);
    throw error;
  }
  
  return data as Project;
}

export async function deleteProject(id: string) {
  const { error } = await supabase
    .from('projects')
    .delete()
    .eq('id', id);
  
  if (error) {
    console.error(`Erro ao excluir projeto ${id}:`, error);
    throw error;
  }
  
  return true;
}