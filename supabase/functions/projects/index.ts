// Follow this setup guide to integrate the Deno runtime and Supabase Functions:
// https://supabase.com/docs/guides/functions/quickstart

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { corsHeaders } from "../_shared/cors.ts"
import { createSupabaseClient } from "../_shared/supabaseClient.ts"

console.log("Projects function initialized")

serve(async (req) => {
  // Handle CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabase = createSupabaseClient(req)
    const url = new URL(req.url)
    const id = url.searchParams.get('id')
    
    // GET request - fetch projects
    if (req.method === 'GET') {
      let query = supabase.from('projects').select('*')
      
      // If ID is provided, get specific project
      if (id) {
        query = query.eq('id', id).single()
      } else {
        // Otherwise get all projects with optional filters
        const category = url.searchParams.get('category')
        if (category && category !== 'Tous') {
          query = query.eq('category', category)
        }
        
        // Add ordering
        query = query.order('created_at', { ascending: false })
      }
      
      const { data, error } = await query
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ data }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    // POST request - create project
    if (req.method === 'POST') {
      const projectData = await req.json()
      
      const { data, error } = await supabase
        .from('projects')
        .insert(projectData)
        .select()
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ data }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    // PUT request - update project
    if (req.method === 'PUT') {
      if (!id) throw new Error('Project ID is required')
      
      const projectData = await req.json()
      
      const { data, error } = await supabase
        .from('projects')
        .update(projectData)
        .eq('id', id)
        .select()
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ data }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    // DELETE request - delete project
    if (req.method === 'DELETE') {
      if (!id) throw new Error('Project ID is required')
      
      const { error } = await supabase
        .from('projects')
        .delete()
        .eq('id', id)
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ success: true }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    // If we get here, the method is not supported
    throw new Error(`Method ${req.method} not supported`)
    
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { 
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" } 
      },
    )
  }
})

/* To invoke:
 * curl -i --location --request GET 'https://xioagfysenbeufyuuuyw.supabase.co/functions/v1/projects' \
 *   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhpb2FnZnlzZW5iZXVmeXV1dXl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2NzI2MzYsImV4cCI6MjA1NjI0ODYzNn0.hGiUY5CBONaYO62AVdngL2A-VZoqpRpY9ailliC_MfY'
 */