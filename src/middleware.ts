import { defineMiddleware } from 'astro:middleware';

// Définition du middleware
export const onRequest = defineMiddleware((context, next) => {
  // Logique personnalisée ici (optionnel)
  console.log('Requête interceptée !');
  return next(); // Passe au traitement suivant
});
