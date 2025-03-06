// Follow this setup guide to integrate the Deno runtime and Supabase Functions:
// https://supabase.com/docs/guides/functions/quickstart

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { corsHeaders } from "../_shared/cors.ts"
import { createSupabaseClient } from "../_shared/supabaseClient.ts"

console.log("Admin function initialized")

serve(async (req) => {
  // Handle CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabase = createSupabaseClient(req)
    const { action, data } = await req.json()
    
    // Check if user is admin
    const { data: userData, error: userError } = await supabase.auth.getUser()
    if (userError) throw new Error('Unauthorized')
    
    const { data: adminData, error: adminError } = await supabase
      .from('admin_users')
      .select('role')
      .eq('user_id', userData.user.id)
      .single()
    
    if (adminError || !adminData || adminData.role !== 'admin') {
      throw new Error('Unauthorized: Admin access required')
    }
    
    // Handle content management actions
    if (action === 'getContent') {
      const { data: content, error } = await supabase
        .from('content_text')
        .select('*')
        .eq('section', data.section)
      
      if (error) throw error
      
      return new Response(
        JSON.stringify({ content }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    if (action === 'updateContent') {
      const { data: content, error } = await supabase
        .from('content_text')
        .update(data.content)
        .eq('id', data.id)
        .select()
      
      if (error) throw error
      
      // Log activity
      await supabase
        .from('admin_logs')
        .insert({
          user_id: userData.user.id,
          action: 'update_content',
          details: { id: data.id, section: data.content.section, key: data.content.key }
        })
      
      return new Response(
        JSON.stringify({ content }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    if (action === 'createContent') {
      const { data: content, error } = await supabase
        .from('content_text')
        .insert(data.content)
        .select()
      
      if (error) throw error
      
      // Log activity
      await supabase
        .from('admin_logs')
        .insert({
          user_id: userData.user.id,
          action: 'create_content',
          details: { section: data.content.section, key: data.content.key }
        })
      
      return new Response(
        JSON.stringify({ content }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      )
    }
    
    if (action === 'deleteContent') {
      const { error } = await supabase
        .from('content_text')
        .delete()
        .eq('id', data.id)
      
      if (error) throw error
      
      // Log activity
      await supabase
        .from('admin_logs')
        .insert({
          user_id: userData.user.id,
          action: 'delete_content',
          details: { id: data.id }
        })
      
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
 * curl -i --location --request POST 'https://xioagfysenbeufyuuuyw.supabase.co/functions/v1/admin' \
 *   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhpb2FnZnlzZW5iZXVmeXV1dXl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2NzI2MzYsImV4cCI6MjA1NjI0ODYzNn0.hGiUY5CBONaYO62AVdngL2A-VZoqpRpY9ailliC_MfY' \
 *   --header 'Content-Type: application/json' \
 *   --data '{"action":"getContent","data":{"section":"home"}}'
 */