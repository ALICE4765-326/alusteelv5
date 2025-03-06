// Follow this setup guide to integrate the Deno runtime and Supabase Functions:
// https://supabase.com/docs/guides/functions/quickstart

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { corsHeaders } from "../_shared/cors.ts"
import { createSupabaseClient } from "../_shared/supabaseClient.ts"

console.log("Auth function initialized")

serve(async (req) => {
  // Handle CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabase = createSupabaseClient(req)
    const { action } = await req.json()
    
    // Get current user
    if (action === 'getUser') {
      const { data: { user }, error } = await supabase.auth.getUser()
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ user }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    // Sign out
    if (action === 'signOut') {
      const { error } = await supabase.auth.signOut()
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ success: true }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    // If we get here, the action is not supported
    throw new Error(`Action ${action} not supported`)
    
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
 * curl -i --location --request POST 'https://xioagfysenbeufyuuuyw.supabase.co/functions/v1/auth' \
 *   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhpb2FnZnlzZW5iZXVmeXV1dXl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2NzI2MzYsImV4cCI6MjA1NjI0ODYzNn0.hGiUY5CBONaYO62AVdngL2A-VZoqpRpY9ailliC_MfY' \
 *   --header 'Content-Type: application/json' \
 *   --data '{"action":"getUser"}'
 */