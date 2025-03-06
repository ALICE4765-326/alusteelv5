import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://alusteel.pt',
  server: {
    host: true, // Listen on all addresses, including LAN and public addresses
    port: 4321, // Specify a port to avoid conflicts
  },
  integrations: [
    tailwind(),
    sitemap()
  ],
  output: 'static'
});