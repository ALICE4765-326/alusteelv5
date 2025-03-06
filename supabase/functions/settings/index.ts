// Follow this setup guide to integrate the Deno runtime and Supabase Functions:
// https://supabase.com/docs/guides/functions/quickstart

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { corsHeaders } from "../_shared/cors.ts"
import { createSupabaseClient } from "../_shared/supabaseClient.ts"

console.log("Settings function initialized")

serve(async (req) => {
  // Handle CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabase = createSupabaseClient(req)
    
    // GET request - fetch settings
    if (req.method === 'GET') {
      const { data, error } = await supabase
        .from('settings')
        .select('*')
        .eq('id', 1)
        .single()
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ data }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    // PUT request - update settings
    if (req.method === 'PUT') {
      const settingsData = await req.json()
      
      const { data, error } = await supabase
        .from('settings')
        .update(settingsData)
        .eq('id', 1)
        .select()
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ data }),
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
 * curl -i --location --request GET 'https://xioagfysenbeufyuuuyw.supabase.co/functions/v1/settings' \
 *   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhpb2FnZnlzZW5iZXVmeXV1dXl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2NzI2MzYsImV4cCI6MjA1NjI0ODYzNn0.hGiUY5CBONaYO62AVdngL2A-VZoqpRpY9ailliC_MfY'
 */