// Follow this setup guide to integrate the Deno runtime and Supabase Functions:
// https://supabase.com/docs/guides/functions/quickstart

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { corsHeaders } from "../_shared/cors.ts"

console.log("Hello from Functions!")

serve(async (req) => {
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { name } = await req.json()
    const data = {
      message: `Hello ${name}!`,
    }

    return new Response(
      JSON.stringify(data),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } },
    )
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
 * curl -i --location --request POST 'https://xioagfysenbeufyuuuyw.supabase.co/functions/v1/hello-world' \
 *   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhpb2FnZnlzZW5iZXVmeXV1dXl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2NzI2MzYsImV4cCI6MjA1NjI0ODYzNn0.hGiUY5CBONaYO62AVdngL2A-VZoqpRpY9ailliC_MfY' \
 *   --header 'Content-Type: application/json' \
 *   --data '{"name":"Functions"}'
 */