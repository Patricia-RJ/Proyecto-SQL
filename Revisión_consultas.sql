
/*3.nombres de los actores que tengan un “actor_id” entre 30 y 40. */

SELECT "actor_id",
		CONCAT(a."first_name",' ',a."last_name")
FROM "actor" AS a
WHERE "actor_id" BETWEEN 30 AND 40
ORDER BY a."actor_id";

 -- Muestra los actores con id 30–40 y su nombre completo, ordenados por id.

/* 4.Obtén las películas cuyo idioma coincide con el idioma original*/

-- Idiomas de todas las películas 
SELECT f."film_id", f."title", l."language_id", l."name"
FROM "film" AS f
JOIN "language" AS l ON f."language_id" = l.language_id;
-- Comparación del idioma de las peliculas con el idioma original 
SELECT f."film_id", f."title", f."language_id", l."name"
FROM "film" AS f
JOIN "language" AS l 
  ON f."language_id" = l.language_id
WHERE f."language_id" = f."original_language_id";

-- No dedvuelve resultados debido a que "riginal_language_id" siempre es NULL, por lo que esta consulta devolverá 0 filas.


/* 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.*/

WITH ranked AS (
  SELECT
      r.rental_id,
      r.rental_date::date AS rental_day,
      r.rental_date,
      ROW_NUMBER() OVER (
        PARTITION BY r.rental_date::date
        ORDER BY r.rental_date DESC, r.rental_id DESC
      ) AS rn
  FROM rental r
)
SELECT
    rk.rental_day,
    p.amount AS cost
FROM ranked rk
JOIN payment p
  ON p.rental_id = rk.rental_id
WHERE rk.rn = 3
ORDER BY rk.rental_date DESC;

-- Obtiene el coste del antepenúltimo alquiler de cada día, ordenando los alquileres por fecha y hora descendente.

/* 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.*/

SELECT  MIN ("actor_id") AS "Id_lower",
		MAX ("actor_id") AS "Id_Higher"
FROM "actor" a ;

--  Id mínimo y máximo en actor (MIN y MAX).

/* 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/

WITH "rentas" AS (
  				SELECT r."customer_id", COUNT(DISTINCT i."film_id") AS "pelis_distintas"
  				FROM "rental" AS r
 				JOIN "inventory" AS i 
 						ON i."inventory_id" = r."inventory_id"
 			 	GROUP BY r."customer_id"
)
SELECT c."customer_id", c."first_name", c."last_name", rentas."pelis_distintas"
FROM "rentas"
JOIN "customer" AS c USING ("customer_id")
WHERE rentas."pelis_distintas" >= 7
ORDER BY rentas."pelis_distintas" DESC;

-- Clientes con ≥7 películas distintas (COUNT DISTINCT film_id); ordenar por last_name, first_name.

