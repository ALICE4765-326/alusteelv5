import { supabase } from './supabase';

// Base URL for Supabase Edge Functions
const FUNCTIONS_URL = 'https://xioagfysenbeufyuuuyw.supabase.co/functions/v1';

// Helper function to make authenticated requests to Edge Functions
async function fetchWithAuth(endpoint: string, options: RequestInit = {}) {
  try {
    // Get the current session
    const { data } = await supabase.auth.getSession();
    const token = data.session?.access_token;
    
    // Set up headers with authentication
    const headers = {
      ...options.headers,
      'Content-Type': 'application/json',
      'Authorization': token ? `Bearer ${token}` : ''
    };
    
    // Make the request
    const response = await fetch(`${FUNCTIONS_URL}/${endpoint}`, {
      ...options,
      headers
    });
    
    // Parse the response
    const result = await response.json();
    
    // Check for errors
    if (!response.ok) {
      throw new Error(result.error || 'An error occurred');
    }
    
    return result;
  } catch (error) {
    console.error(`Error in API call to ${endpoint}:`, error);
    throw error;
  }
}

// Projects API
export const projectsApi = {
  getAll: async () => {
    return fetchWithAuth('projects');
  },
  
  getById: async (id: string) => {
    return fetchWithAuth(`projects/${id}`);
  },
  
  create: async (data: { name: string; description?: string }) => {
    return fetchWithAuth('projects', {
      method: 'POST',
      body: JSON.stringify(data)
    });
  },
  
  update: async (id: string, data: { name?: string; description?: string }) => {
    return fetchWithAuth(`projects/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data)
    });
  },
  
  delete: async (id: string) => {
    return fetchWithAuth(`projects/${id}`, {
      method: 'DELETE'
    });
  }
};

// Auth API
export const authApi = {
  signUp: async (data: { email: string; password: string; accessCode: string }) => {
    return fetchWithAuth('auth/signup', {
      method: 'POST',
      body: JSON.stringify(data)
    });
  },
  
  signIn: async (data: { email: string; password: string }) => {
    return fetchWithAuth('auth/signin', {
      method: 'POST',
      body: JSON.stringify(data)
    });
  },
  
  signOut: async () => {
    return fetchWithAuth('auth/signout', {
      method: 'POST'
    });
  },
  
  getUser: async () => {
    return fetchWithAuth('auth/user');
  },
  
  getSession: async () => {
    return fetchWithAuth('auth/session');
  }
};

// Settings API
export const settingsApi = {
  get: async () => {
    return fetchWithAuth('settings');
  },
  
  update: async (data: { contacts: { phone: string; email: string; address: string } }) => {
    return fetchWithAuth('settings', {
      method: 'PUT',
      body: JSON.stringify(data)
    });
  }
};