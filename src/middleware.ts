import { defineMiddleware } from 'astro:middleware';

export const onRequest = defineMiddleware((context, next) => {
  console.log('Requête interceptée'); // Optionnel, pour tester
  return next();
});