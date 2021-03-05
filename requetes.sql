/* Obtenir la liste des 10 villes les plus peuplées en 2012 */

SELECT ville_id, ville_nom, ville_population_2012 
FROM villes_france_free
ORDER BY ville_population_2012 DESC
LIMIT 10; 

/* Obtenir la liste des 50 villes ayant la plus faible superficie */

SELECT ville_id, ville_nom, ville_surface
FROM villes_france_free
ORDER BY ville_surface ASC
LIMIT 50;

/* Obtenir la liste des départements d’outres-mer, c’est-à-dire ceux dont le numéro de département commencent par “97” */


SELECT departement_code, departement_nom
FROM departement
WHERE departement_code LIKE "97%";


/* Obtenir le nom des 10 villes les plus peuplées en 2012, ainsi que le nom du département associé */

SELECT ville_id, ville_nom, departement_nom_uppercase, ville_population_2012 
FROM villes_france_free v INNER JOIN departement d ON v.ville_departement = d.departement_code
ORDER BY ville_population_2012 DESC
LIMIT 10; 

/* Obtenir la liste du nom de chaque département, associé à son code et du nombre de commune au sein de ces département, en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes */

SELECT departement_code, departement_nom, COUNT(*) AS total_ville
FROM departement d INNER JOIN villes_france_free v ON d.departement_code = v.ville_departement
GROUP BY v.ville_departement;
ORDER BY total_ville DESC;

/* Obtenir la liste des 10 plus grands départements, en terme de superficie */

SELECT departement_nom, ROUND(SUM(ville_surface),2) AS superficie
FROM departement d INNER JOIN villes_france_free v ON d.departement_code = v.ville_departement
GROUP BY v.ville_departement
ORDER BY superficie DESC
LIMIT 10;

/* Compter le nombre de villes dont le nom commence par “Saint” */

SELECT COUNT(*) AS nombre_villes_saint
FROM villes_france_free
WHERE ville_nom LIKE "Saint%";

/* Obtenir la liste des villes qui ont un nom existants plusieurs fois, et trier afin d’obtenir en premier celles dont le nom est le plus souvent utilisé par plusieurs communes */

SELECT ville_nom, COUNT(*) AS nombre
FROM villes_france_free
GROUP BY ville_nom
HAVING nombre > 1
ORDER BY nombre DESC;

/* Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieure à la superficie moyenne */

SELECT ville_nom, ville_surface, ROUND((SELECT AVG(ville_surface) AS moyenne_superficie FROM villes_france_free), 2) AS moyenne_superficie
FROM villes_france_free
HAVING ville_surface > moyenne_superficie;


/* Obtenir la liste des départements qui possèdent plus de 2 millions d’habitants */

SELECT departement_nom, SUM(ville_population_2012) AS nombre_habitants 
FROM departement d INNER JOIN villes_france_free v ON d.departement_code = v.ville_departement
GROUP BY v.ville_departement
HAVING nombre_habitants > 2000000

/* Remplacez les tirets par un espace vide, pour toutes les villes commençant par “SAINT-” (dans la colonne qui contient les noms en majuscule) */

UPDATE villes_france_free
SET ville_nom = REPLACE(ville_nom, "-", " ")
WHERE ville_nom LIKE "SAINT-%"
