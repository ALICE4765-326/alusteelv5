import { createClient } from '@supabase/supabase-js';

// Create a Supabase client with admin privileges
// This client should only be used in admin-protected routes
export const createAdminClient = () => {
  const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
  const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;
  
  if (!supabaseUrl || !supabaseAnonKey) {
    throw new Error('Missing Supabase credentials');
  }
  
  return createClient(supabaseUrl, supabaseAnonKey);
};

// Helper functions for admin operations

// Content Management
export const contentManagement = {
  // Text content
  async getTextContent(section: string) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('content_text')
      .select('*')
      .eq('section', section);
    
    if (error) throw error;
    return data;
  },
  
  async updateTextContent(id: string, content: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('content_text')
      .update(content)
      .eq('id', id)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async createTextContent(content: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('content_text')
      .insert(content)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async deleteTextContent(id: string) {
    const supabase = createAdminClient();
    const { error } = await supabase
      .from('content_text')
      .delete()
      .eq('id', id);
    
    if (error) throw error;
    return true;
  },
  
  // Media content (images, videos)
  async uploadMedia(file: File, path: string) {
    const supabase = createAdminClient();
    const fileExt = file.name.split('.').pop();
    const fileName = `${Math.random().toString(36).substring(2, 15)}.${fileExt}`;
    const filePath = `${path}/${fileName}`;
    
    const { data, error } = await supabase.storage
      .from('media')
      .upload(filePath, file, {
        cacheControl: '3600',
        upsert: false
      });
    
    if (error) throw error;
    
    // Get public URL
    const { data: publicUrlData } = supabase.storage
      .from('media')
      .getPublicUrl(filePath);
    
    return {
      path: filePath,
      url: publicUrlData.publicUrl
    };
  },
  
  async deleteMedia(path: string) {
    const supabase = createAdminClient();
    const { error } = await supabase.storage
      .from('media')
      .remove([path]);
    
    if (error) throw error;
    return true;
  },
  
  async listMedia(folder: string) {
    const supabase = createAdminClient();
    const { data, error } = await supabase.storage
      .from('media')
      .list(folder);
    
    if (error) throw error;
    return data;
  },
  
  // Projects management
  async getProjects() {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('projects')
      .select(`
        *,
        project_media(*)
      `)
      .order('created_at', { ascending: false });
    
    if (error) throw error;
    return data;
  },
  
  async getProject(id: string) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('projects')
      .select(`
        *,
        project_media(*),
        project_documents(*)
      `)
      .eq('id', id)
      .single();
    
    if (error) throw error;
    return data;
  },
  
  async createProject(project: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('projects')
      .insert(project)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async updateProject(id: string, project: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('projects')
      .update(project)
      .eq('id', id)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async deleteProject(id: string) {
    const supabase = createAdminClient();
    const { error } = await supabase
      .from('projects')
      .delete()
      .eq('id', id);
    
    if (error) throw error;
    return true;
  },
  
  // Project media
  async addProjectMedia(projectId: string, mediaType: 'image' | 'video', url: string, position: number = 0) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('project_media')
      .insert({
        project_id: projectId,
        media_type: mediaType,
        url: url,
        position: position
      })
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async deleteProjectMedia(id: string) {
    const supabase = createAdminClient();
    const { error } = await supabase
      .from('project_media')
      .delete()
      .eq('id', id);
    
    if (error) throw error;
    return true;
  },
  
  // Blog posts management
  async getBlogPosts() {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('blog_posts')
      .select(`
        *,
        blog_media(*)
      `)
      .order('published_at', { ascending: false });
    
    if (error) throw error;
    return data;
  },
  
  async getBlogPost(id: string) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('blog_posts')
      .select(`
        *,
        blog_media(*)
      `)
      .eq('id', id)
      .single();
    
    if (error) throw error;
    return data;
  },
  
  async createBlogPost(post: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('blog_posts')
      .insert(post)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async updateBlogPost(id: string, post: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('blog_posts')
      .update(post)
      .eq('id', id)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async deleteBlogPost(id: string) {
    const supabase = createAdminClient();
    const { error } = await supabase
      .from('blog_posts')
      .delete()
      .eq('id', id);
    
    if (error) throw error;
    return true;
  },
  
  // Testimonials management
  async getTestimonials() {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('testimonials')
      .select(`
        *,
        testimonial_media(*)
      `)
      .order('created_at', { ascending: false });
    
    if (error) throw error;
    return data;
  },
  
  async createTestimonial(testimonial: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('testimonials')
      .insert(testimonial)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async updateTestimonial(id: string, testimonial: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('testimonials')
      .update(testimonial)
      .eq('id', id)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async deleteTestimonial(id: string) {
    const supabase = createAdminClient();
    const { error } = await supabase
      .from('testimonials')
      .delete()
      .eq('id', id);
    
    if (error) throw error;
    return true;
  },
  
  // Partners management
  async getPartners() {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('partners')
      .select(`
        *,
        partner_media(*)
      `)
      .order('name');
    
    if (error) throw error;
    return data;
  },
  
  async createPartner(partner: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('partners')
      .insert(partner)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async updatePartner(id: string, partner: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('partners')
      .update(partner)
      .eq('id', id)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  async deletePartner(id: string) {
    const supabase = createAdminClient();
    const { error } = await supabase
      .from('partners')
      .delete()
      .eq('id', id);
    
    if (error) throw error;
    return true;
  },
  
  // Settings management
  async getSettings() {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('settings')
      .select('*')
      .eq('id', 1)
      .single();
    
    if (error) throw error;
    return data;
  },
  
  async updateSettings(settings: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('settings')
      .update(settings)
      .eq('id', 1)
      .select();
    
    if (error) throw error;
    return data;
  },
  
  // Activity logging
  async logActivity(action: string, details: any) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('admin_logs')
      .insert({
        action,
        details,
        user_id: (await supabase.auth.getUser()).data.user?.id
      })
      .select();
    
    if (error) {
      console.error('Failed to log activity:', error);
      // Don't throw error for logging failures
    }
    
    return data;
  },
  
  async getActivityLogs(limit = 50) {
    const supabase = createAdminClient();
    const { data, error } = await supabase
      .from('admin_logs')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(limit);
    
    if (error) throw error;
    return data;
  }
};

// Authentication and user management
export const authManagement = {
  async getCurrentUser() {
    const supabase = createAdminClient();
    const { data, error } = await supabase.auth.getUser();
    
    if (error) throw error;
    return data.user;
  },
  
  async signIn(email: string, password: string) {
    const supabase = createAdminClient();
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password
    });
    
    if (error) throw error;
    return data;
  },
  
  async signOut() {
    const supabase = createAdminClient();
    const { error } = await supabase.auth.signOut();
    
    if (error) throw error;
    return true;
  },
  
  async isAdmin() {
    try {
      const supabase = createAdminClient();
      const { data } = await supabase.auth.getUser();
      
      if (!data.user) return false;
      
      // Check if user has admin role
      const { data: roleData, error } = await supabase
        .from('admin_users')
        .select('role')
        .eq('user_id', data.user.id)
        .single();
      
      if (error || !roleData) return false;
      
      return roleData.role === 'admin';
    } catch (error) {
      console.error('Error checking admin status:', error);
      return false;
    }
  }
};