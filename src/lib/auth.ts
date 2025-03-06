import { supabase } from './supabase';

// Authentication functions
export const auth = {
  signIn: async (email: string, password: string) => {
    return await supabase.auth.signInWithPassword({ email, password });
  },

  signOut: async () => {
    return await supabase.auth.signOut();
  },

  getSession: async () => {
    return await supabase.auth.getSession();
  },

  getUser: async () => {
    return await supabase.auth.getUser();
  },

  isAuthenticated: async () => {
    const { data } = await supabase.auth.getSession();
    return data.session !== null;
  }
};

// Helper function to check if user is authenticated on client side
export function checkClientAuth() {
  // First try to get session from Supabase
  supabase.auth.getSession().then(({ data }) => {
    if (!data.session) {
      // If no Supabase session, check for local session
      const session = localStorage.getItem('alusteel_session');
      if (!session) {
        window.location.href = '/admin/login';
        return false;
      }
    }
  }).catch(() => {
    // If error, fall back to local session check
    const session = localStorage.getItem('alusteel_session');
    if (!session) {
      window.location.href = '/admin/login';
      return false;
    }
  });
  
  return true;
}

// Fallback authentication for development
export const localAuth = {
  signIn: async (email: string, password: string, accessCode: string) => {
    // Check credentials
    if (email === 'admin@alusteel.pt' && password === 'Admin123!' && accessCode === 'ALUSTEEL2025') {
      const session = {
        user: {
          id: '1',
          email: email,
          role: 'admin'
        }
      };
      
      // Store in localStorage
      localStorage.setItem('alusteel_session', JSON.stringify(session));
      
      // Set cookie
      document.cookie = `alusteel_session=${JSON.stringify(session)}; path=/; max-age=86400`;
      
      return { data: { session }, error: null };
    }
    
    return { data: { session: null }, error: 'Invalid credentials' };
  }
};