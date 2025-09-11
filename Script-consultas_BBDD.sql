
/* 2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’*/

SELECT "film_id", "title", "rating"
FROM "film" AS f
WHERE "rating" = 'R'
ORDER BY "title";

-- Lista las películas con rating 'R', ordenadas alfabéticamente por título.

/*3.nombres de los actores que tengan un “actor_id” entre 30 y 40. */

SELECT "actor_id",
		CONCAT(a."first_name",' ',a."last_name")
FROM "actor" AS a
WHERE "actor_id" BETWEEN '30' AND '40'
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

/* 5. Ordena las películas por duración de forma ascendente.*/

SELECT "film_id","title","length"
FROM "film" AS f
ORDER BY f."length" ASC;

-- Lista todas las películas ordenadas por duración (ascendente).

/* 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.*/

SELECT "actor_id", "first_name", "last_name"
FROM "actor" AS a
WHERE a.last_name ILIKE '%Allen%'
ORDER BY a."last_name", a."first_name";

-- Actores cuyo apellido contiene 'Allen'.

/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla 
“film” y muestra la clasificación junto con el recuento.*/

SELECT f."rating", COUNT(*) AS "total_films"
FROM "film" f
GROUP BY f."rating"
ORDER BY "total_films" ASC;

-- Recuento de películas por clasificación (rating), ordenado de menor a mayor.

/* 8.Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.*/

SELECT "film_id", "title","rating","length"
FROM "film" AS f
WHERE f."rating" = 'PG-13' OR f."length" > 180
ORDER BY f."title" ASC;

-- Títulos de pelis con rating 'PG-13' o duración > 180 min (orden alfabético)

/* 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.*/

SELECT
  ROUND(VARIANCE(f."replacement_cost"),2)  AS "var_replacement_cost",
  ROUND(STDDEV_SAMP(f."replacement_cost"),2) AS "sd_replacement_cost"
FROM "film" AS f;

-- Variabilidad del coste de reemplazo: varianza (muestral) y desviación típica

/* 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.*/

SELECT MIN ("length") AS "Minima_duracion", 
		MAX("length") AS "Maxima_duracion"
FROM "film" f ;

-- Duración mínima y máxima de las películas (en minutos).

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
ORDER BY rk.rental_day;

-- Obtiene el coste del antepenúltimo alquiler de cada día, ordenando los alquileres por fecha y hora descendente.


/* 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.*/

SELECT "film_id","title","rating"
FROM "film" AS f
WHERE f."rating" NOT IN ('NC-17', 'G')
ORDER BY f."title" ASC;

-- Pelis cuyo rating NO es 'NC-17' ni 'G'; ordenadas por título.

/*13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.*/

SELECT f."rating", ROUND(AVG (f."length" ),2) AS "average_duration"
FROM "film" f
GROUP BY f."rating"
ORDER BY "average_duration"  ASC;

-- Media de duración por clasificación (AVG length, 2 decimales), orden de menor a mayor.

/* 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.*/

SELECT "film_id","title","length"
FROM "film" AS f
WHERE f."length">180;

-- Películas con duración > 180 minutos; muestra id, título y minutos

/* 15. ¿Cuánto dinero ha generado en total la empresa?*/

SELECT ROUND (SUM(p."amount"),2) AS "total_revenue"
FROM "payment"AS p;

-- Ingresos totales: SUM(payment.amount) redondeado a 2 decimales.

/* 16. Muestra los 10 clientes con mayor valor de id.*/

SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
ORDER BY c.customer_id DESC
LIMIT 10;

-- Top 10 customer_id más altos (orden descendente por id).

/* 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’.*/

SELECT a."actor_id", a."first_name", a."last_name", f."title" 
FROM "film" AS f
JOIN "film_actor" AS fa ON fa."film_id" = f."film_id"
JOIN "actor" AS a ON a."actor_id" = fa."actor_id"
WHERE f."title" = 'EGG IGBY'
ORDER BY a."last_name", a."first_name";

--Actores de 'EGG IGBY' (film ⟷ film_actor ⟷ actor), ordenados por apellido y nombre.

/* 18. Selecciona todos los nombres de las películas únicos.*/

SELECT DISTINCT("title")
FROM "film" AS f
ORDER BY f."title" ;

--Lista de títulos únicos del catálogo (DISTINCT), orden alfabético.

/* 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.*/

SELECT f."film_id",
       f."title",
       f."length" AS duration,
       c."name"  AS category
FROM "film" f
JOIN "film_category" fc ON f."film_id" = fc."film_id"
JOIN "category" c       ON fc."category_id" = c."category_id"
WHERE f."length" > 180
  AND c."name" = 'Comedy';

-- Películas 'Comedy' con duración > 180 min (film ⟷ film_category ⟷ category).

/* 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/

SELECT c."name" AS category,
       ROUND(AVG(f."length"),2) AS average_duration
FROM "film" f
JOIN "film_category" fc ON fc."film_id" = f."film_id"
JOIN "category" c       ON c."category_id" = fc."category_id"
GROUP BY c."name"
HAVING AVG(f."length") > 110
ORDER BY average_duration DESC;

-- Promedio de duración por categoría (>110 min) con HAVING; film ⟷ film_category ⟷ category.

/* 21. ¿Cuál es la media de duración del alquiler de las películas?.*/

SELECT AVG("rental_duration") AS "rental_duration_average"
FROM "film" f;

-- Media de días de alquiler permitidos (AVG film.rental_duration).

/* 22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.*/

SELECT "actor_id",
		CONCAT ("first_name", ' ', "last_name") AS "full_name"
FROM "actor" a;

--  Nombre completo de actores: CONCAT(first_name, ' ', last_name).

/* 23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.*/

SELECT DATE_TRUNC('day', r."rental_date") AS day, COUNT(*) AS rentals
FROM "rental" AS r
GROUP BY day
ORDER BY "rentals" DESC, day DESC;

-- Alquileres por día: COUNT(*) agrupado por fecha; orden por rentals DESC.

/* 24. Encuentra las películas con una duración superior al promedio.*/

SELECT f."film_id", f."title", f."length"
FROM "film" AS f
WHERE f."length" > (SELECT AVG("length") FROM "film");

--  Películas con length > (media global de length) mediante subconsulta escalar.

/* 25. Averigua el número de alquileres registrados por mes.*/

SELECT TO_CHAR(r."rental_date", 'YYYY-MM') AS month, 
       COUNT(*) AS rentals
FROM "rental" r
GROUP BY TO_CHAR(r."rental_date", 'YYYY-MM')
ORDER BY month;

--  Alquileres por mes (YYYY-MM): COUNT(*) agrupado por mes y orden cronológico.

/* 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.*/

SELECT  ROUND (AVG("amount"),2) AS "promedio",
		ROUND(STDDEV("amount"),2) AS "desviacion_estandar",
		ROUND(VARIANCE ("amount"),2) AS "varianza"
FROM "payment" p;

-- Estadísticos del importe pagado: media, desviación típica y varianza (muestrales), con 2 decimales

/* 27. ¿Qué películas se alquilan por encima del precio medio?.*/

SELECT f."film_id", f."title", f."rental_rate"
FROM "film" f
WHERE f."rental_rate" > (SELECT AVG("rental_rate") FROM "film");

-- Películas con rental_rate por encima de la media del catálogo (subconsulta escalar).

/* 28. Muestra el id de los actores que hayan participado en más de 40
películas.*/

SELECT a."actor_id", a."first_name", a."last_name", COUNT(fa."film_id") AS "films"
FROM "actor" a
JOIN "film_actor" fa ON fa."actor_id" = a."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name"
HAVING COUNT(fa."film_id") > 40
ORDER BY "films" DESC;

-- Actores con >40 películas: COUNT(film_actor) por actor, ordenado de mayor a menor.

/* 29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.*/

SELECT f."film_id", f."title", COUNT(i."inventory_id") AS "copies"
FROM "film" f
LEFT JOIN "inventory" AS i 
				ON i."film_id" = f."film_id"
GROUP BY f."film_id", f.title
ORDER BY "copies" DESC, f."title";

-- Copias en inventario por película (incluye 0): LEFT JOIN film↔inventory y COUNT(inventory_id).

/* 30. Obtener los actores y el número de películas en las que ha actuado.*/

SELECT a."actor_id", a."first_name", a."last_name", COUNT(fa."film_id") AS "films"
FROM "actor" a
LEFT JOIN "film_actor" fa 
			ON fa."actor_id" = a."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY "films" DESC;

-- Nº de películas por actor (incluye actores con 0): LEFT JOIN film_actor y COUNT(film_id).

/* 31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.*/

SELECT f."film_id", f."title", a."actor_id", a."first_name", a."last_name"
FROM "film" f
LEFT JOIN "film_actor" fa 
			ON fa."film_id" = f."film_id"
LEFT JOIN "actor" a 
			ON a."actor_id" = fa."actor_id"
ORDER BY f."title", a."last_name" NULLS LAST;

-- Todas las pelis y sus actores (incluye pelis sin actores): LEFT JOINs y orden por título; apellidos NULL al final.

/* 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.*/

SELECT a."actor_id", a."first_name", a."last_name", f."film_id", f."title"
FROM "actor" a
LEFT JOIN "film_actor" fa 
			ON fa."actor_id" = a."actor_id"
LEFT JOIN "film" f 
			ON f."film_id" = fa."film_id"
ORDER BY a."last_name", a."first_name", f."title" NULLS LAST;

-- Todos los actores y sus películas (LEFT JOINs; incluye actores sin películas); orden: apellido, nombre, título (NULLS LAST).

/* 33. Obtener todas las películas que tenemos y todos los registros de
alquiler.*/

SELECT
  f."film_id",
  f."title",
  i."inventory_id",
  r."rental_id",
  r."rental_date"
FROM "inventory" i
JOIN "film"     f ON f."film_id"      = i."film_id"
LEFT JOIN "rental" r ON r."inventory_id" = i."inventory_id"
ORDER BY f."title", r."rental_date";

--  Películas que TENEMOS (inventory) y TODOS sus alquileres (incluye sin alquiler): 
-- inventory → film (INNER) y inventory → rental (LEFT)

/* 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/

SELECT c."customer_id", c."first_name", c."last_name", ROUND(SUM(p."amount"), 2) AS "total_spent"
FROM "customer" c
JOIN "payment" p 
			ON p."customer_id" = c."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY "total_spent" DESC
LIMIT 5;

-- Top 5 clientes por gasto total (SUM(payment.amount) por cliente; descendente).

/* 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.*/

SELECT "actor_id", "first_name", "last_name"
FROM "actor" a 
WHERE a."first_name" ILIKE'Johnny';

--  Actores con first_name = 'Johnny' (case-insensitive con ILIKE).

/* 36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.*/

SELECT "first_name" AS nombre,"last_name" AS "apellido"
FROM "actor" a;

--  Proyección de actor con alias: first_name AS nombre, last_name AS apellido.

/* 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.*/

SELECT  MIN ("actor_id") AS "Id_lower",
		MAX ("actor_id") AS "Id_Higher"
FROM "actor" a 
LIMIT 1;

--  Id mínimo y máximo en actor (MIN y MAX); no requiere LIMIT.

/* 38. Cuenta cuántos actores hay en la tabla “actor”.*/

SELECT COUNT("actor_id") AS "Total_actors"
FROM "actor" a;

-- Total de actores (COUNT(actor_id) en tabla actor).

/* 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.*/

SELECT "actor_id", "first_name", "last_name"
FROM "actor" a 
ORDER BY a."last_name" ASC;

-- Listado de actores ordenado por apellido (ASC).

/* 40. Selecciona las primeras 5 películas de la tabla “film”.*/

SELECT "film_id", "title"
FROM "film" f 
LIMIT 5;

-- Primeras 5 películas por film_id (ORDER BY film_id ASC LIMIT 5).

/* 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?.*/

SELECT a."first_name", COUNT(*) AS n
FROM "actor" a
GROUP BY a."first_name"
ORDER BY n DESC, a."first_name"
LIMIT 1;

--  Nombre de actor más repetido: GROUP BY first_name, orden por COUNT DESC y toma el 1º.

/* 42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.*/

SELECT r."rental_id", r."rental_date", c."customer_id", c."first_name", c."last_name"
FROM "rental" r
JOIN "customer" c 
			ON c."customer_id" = r."customer_id"
ORDER BY r."rental_date" DESC;

-- Todos los alquileres con el nombre del cliente (JOIN rental ↔ customer), ordenados por fecha DESC.

/* 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.*/

SELECT c."customer_id", c."first_name", c."last_name", r."rental_id", r."rental_date"
FROM "customer" c
LEFT JOIN "rental" r 
			ON r."customer_id" = c."customer_id"
ORDER BY c."customer_id", r."rental_date" NULLS LAST;

--  Todos los clientes y, si los hay, sus alquileres (LEFT JOIN; incluye clientes sin alquiler).

/* 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/

SELECT f."title", c."name" AS "Category"
FROM "film" f
CROSS JOIN "category" c;

--  Producto cartesiano film × category (CROSS JOIN); útil solo para combinaciones teóricas, no para análisis directo.

/* 45. Encuentra los actores que han participado en películas de la categoría
'Action'.*/

SELECT DISTINCT a."actor_id", a."first_name", a."last_name"
FROM "actor"a
JOIN "film_actor" fa 
			ON fa."actor_id" =a."actor_id"
JOIN "film_category" fc
			ON fc."film_id" = fa."film_id"
JOIN "category" c 
			ON c."category_id" = fc."category_id"
WHERE c."name" = 'Action'
ORDER BY a."last_name", a."first_name";

-- Actores que han participado en pelis de 'Action' (actor ↔ film_actor ↔ film_category ↔ category), únicos y ordenados.

/* 46. Encuentra todos los actores que no han participado en películas.*/

SELECT a."actor_id", a."first_name", a."last_name"
FROM "actor" a
LEFT JOIN "film_actor" fa 
			ON fa."actor_id" = a."actor_id"
WHERE fa."actor_id" IS NULL;

-- En este dataset, todos los actores ha participado al menos en una película, por eso no aparece ningún resultado 

/* 47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.*/

SELECT a."actor_id", a."first_name", a."last_name", COUNT(fa."film_id") AS "film_count"
FROM actor a
LEFT JOIN "film_actor" fa 
			ON fa."actor_id" = a."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY "film_count" DESC;

-- Actores y nº de películas en que han participado (LEFT JOIN + COUNT), ordenado de mayor a menor.

/* 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.*/

--Vista 

CREATE OR REPLACE VIEW actor_num_peliculas AS
SELECT a."actor_id",
       a."first_name",
       a."last_name",
       COUNT(fa."film_id") AS film_count
FROM "actor" a
LEFT JOIN "film_actor" fa
       ON fa."actor_id" = a."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name";

--Comprobación de la vista 

SELECT * FROM actor_num_peliculas ORDER BY film_count DESC;

/* 49. Calcula el número total de alquileres realizados por cada cliente.*/

SELECT c."customer_id", c."first_name", c."last_name", COUNT(r."rental_id") AS "rentals"
FROM "customer" AS c
LEFT JOIN "rental" AS r 
			ON r."customer_id" = c."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY "rentals" DESC;

-- Nº total de alquileres por cliente (LEFT JOIN rental y COUNT(rental_id)); ordenado por rentals DESC.

/* 50. Calcula la duración total de las películas en la categoría 'Action'.*/

SELECT SUM(f."length") AS total_duration_action
FROM "film" f
JOIN "film_category" fc ON fc."film_id" = f."film_id"
JOIN "category" c       ON c."category_id" = fc."category_id"
WHERE c."name" = 'Action';

-- Duración total de las pelis de la categoría 'Action' (film ↔ film_category ↔ category).

/* 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.*/

WITH "cliente_rentas_temporal" AS (
  SELECT r."customer_id", COUNT(*) AS "total_rentas"
  FROM "rental" AS r
  GROUP BY r."customer_id"
)
SELECT c."customer_id", c."first_name", c."last_name", crt."total_rentas"
FROM "cliente_rentas_temporal" AS crt
JOIN "customer" AS c 
			ON c."customer_id" = crt."customer_id"
ORDER BY crt."total_rentas" DESC;

-- Total de alquileres por cliente (CTE 'cliente_rentas_temporal'); unido a customer y ordenado por total_rentas DESC.

/* 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.*/

WITH "peliculas_alquiladas" AS (
  SELECT i."film_id", COUNT(*) AS "veces_alquilada"
  FROM "rental" AS r
  JOIN "inventory" AS i 
  			ON i."inventory_id" = r."inventory_id"
  GROUP BY i."film_id"
  HAVING COUNT(*) >= 10
)
SELECT f."film_id", f."title", pa."veces_alquilada"
FROM "peliculas_alquiladas" AS pa
JOIN "film" AS f 
			ON f."film_id" = pa."film_id"
ORDER BY pa."veces_alquilada" DESC;

-- Películas con ≥10 alquileres (rental→inventory, CTE 'peliculas_alquiladas'); orden por veces_alquilada DESC.

/* 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/

SELECT DISTINCT f."film_id", f."title"
FROM "customer" c
JOIN "rental"   r ON r."customer_id"  = c."customer_id"
JOIN "inventory" i ON i."inventory_id" = r."inventory_id"
JOIN "film"     f ON f."film_id"      = i."film_id"
WHERE c."first_name" ILIKE 'tammy'
  AND c."last_name"  ILIKE 'sanders'
  AND r."return_date" IS NULL
ORDER BY f."title";

-- Películas alquiladas por 'Tammy Sanders' y aún no devueltas; orden alfabético por título.

/* 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.*/

SELECT DISTINCT a."actor_id", a."first_name", a."last_name"
FROM "actor" AS a
JOIN "film_actor" AS fa 
			ON fa."actor_id" = a."actor_id"
JOIN "film_category" AS fc 
			ON fc."film_id" = fa."film_id"
JOIN "category" AS c 
			ON c."category_id" = fc."category_id"
WHERE c."name" = 'Sci-Fi'
ORDER BY a."last_name", a."first_name";

-- Actores con ≥1 película 'Sci-Fi' (actor↔film_actor↔film_category↔category); únicos y ordenados por apellido.

/* 55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.*/

WITH first_rent AS (
  SELECT MIN(r."rental_date") AS first_date
  FROM "rental" r
  JOIN "inventory" i ON i."inventory_id" = r."inventory_id"
  JOIN "film" f      ON f."film_id"      = i."film_id"
  WHERE f."title" = 'SPARTACUS CHEAPER'
)
SELECT DISTINCT a."actor_id", a."first_name", a."last_name"
FROM "rental" r
JOIN "inventory"   i  ON i."inventory_id" = r."inventory_id"
JOIN "film"        f  ON f."film_id"      = i."film_id"
JOIN "film_actor"  fa ON fa."film_id"     = f."film_id"
JOIN "actor"       a  ON a."actor_id"     = fa."actor_id"
CROSS JOIN first_rent fr
WHERE r."rental_date" > fr.first_date
ORDER BY a."last_name", a."first_name";

-- Actores de películas alquiladas después del primer alquiler de "SPARTACUS CHEAPER"

/* 56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.*/

  SELECT a."actor_id", a."first_name", a."last_name"
FROM "actor" AS a
WHERE NOT EXISTS (
  SELECT 1
  FROM "film_actor" AS fa
  JOIN "film_category" AS fc
  				ON fc."film_id" = fa."film_id"
  JOIN "category" AS ct 
  				ON ct."category_id" = fc."category_id"
  WHERE fa."actor_id" = a."actor_id"
    AND ct."name" = 'Music'
);

--  Actores que no han participado en 'Music' (NOT EXISTS sobre actor→film_actor→film_category→category).

/* 57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.*/

SELECT DISTINCT f."film_id", f."title", r."rental_date", r."return_date"
FROM "rental" AS r
JOIN "inventory" AS i 
				ON i."inventory_id" = r."inventory_id"
JOIN film AS f 
				ON f."film_id" = i."film_id"
WHERE r."return_date" IS NOT NULL
  AND (r."return_date" - r."rental_date") > INTERVAL '8 days';

-- Películas con alquileres de duración > 8 días (return_date - rental_date > INTERVAL '8 days').

/* 58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.*/

SELECT f."film_id", f."title"
FROM "film" AS f
WHERE f."film_id" IN (
  SELECT fc."film_id"
  FROM "film_category" AS fc
  WHERE fc."category_id" IN (
  							SELECT c."category_id" 
  							FROM "category" AS c 
  							WHERE c."name" = 'Animation')
)
ORDER BY f."title";

-- Películas de la categoría 'Animation' (subconsulta vía film_category/category); orden por título.

/* 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.*/

SELECT f2."film_id", f2."title", f2."length"
FROM "film" AS f2
WHERE f2."length" = (
						SELECT f."length"
						FROM "film" AS f 
						WHERE f."title" = 'DANCING FEVER' 
						LIMIT 1)
  AND f2."title" <> 'DANCING FEVER';

-- Películas con la misma duración que 'DANCING FEVER' (subconsulta escalar), excluyendo la propia; orden por título.

/* 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/

WITH "rentas" AS (
  				SELECT r."customer_id", COUNT(DISTINCT i."film_id") AS "pelis_distintas"
  				FROM "rental" AS r
 				JOIN "inventory" AS i 
 						ON i."inventory_id" = r."inventory_id"
 			 	GROUP BY r."customer_id"
)
SELECT c."customer_id", c."first_name", c."last_name", rentas".pelis_distintas"
FROM "rentas"
JOIN "customer" AS c USING ("customer_id")
WHERE rentas."pelis_distintas" >= 7
ORDER BY rentas."pelis_distintas" DESC;

-- Clientes con ≥7 películas distintas (COUNT DISTINCT film_id); ordenar por last_name, first_name.

/* 61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.*/

SELECT c."name" AS "category", COUNT(*) AS "rentals"
FROM "rental" AS r
JOIN "inventory" AS i 
			ON i."inventory_id" = r."inventory_id"
JOIN "film_category" AS fc 
			ON fc."film_id" = i."film_id"
JOIN "category" AS c 
			ON c."category_id" = fc."category_id"
GROUP BY c."name"
ORDER BY "rentals" DESC;

-- Recuento de alquileres por categoría (rental→inventory→film_category→category), orden DESC.

/* 62. Encuentra el número de películas por categoría estrenadas en 2006.*/

SELECT c."name" AS "category", COUNT(*) AS "rentals_2006"
FROM "rental" AS r
JOIN "inventory" AS i 
			ON i."inventory_id" = r."inventory_id"
JOIN "film_category" AS fc 
			ON fc."film_id" = i."film_id"
JOIN "category" AS c 
			ON c."category_id" = fc."category_id"
WHERE r."rental_date" >= DATE '2006-01-01'
  AND r."rental_date" <  DATE '2007-01-01'
GROUP BY c."name"
ORDER BY "rentals_2006" DESC;

-- Nº de películas por categoría con release_year=2006 (film→film_category→category), orden DESC.

/* 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.*/

SELECT s."staff_id", s."first_name", s."last_name", st."store_id"
FROM "staff" AS s
CROSS JOIN "store" AS st
ORDER BY s."staff_id", st."store_id";

-- Producto cartesiano staff × store (CROSS JOIN) ordenado por staff_id, store_id.

/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/

SELECT c."customer_id", c."first_name", c."last_name", COUNT(r."rental_id") AS "total_alquiladas"
FROM "customer" AS c
LEFT JOIN "rental" AS r 
			ON r."customer_id" = c."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY "total_alquiladas" DESC;

-- Total de alquileres por cliente (LEFT JOIN rental y COUNT(rental_id)); ordenar por total_alquiladas DESC.



