# insight de consultas 

> Resumen por consulta. Cada línea indica **qué se observa** o **para qué sirve** el resultado; el detalle técnico y las queries completas están en `Svript-consultas_BBDD.sql`.

---

- **Q01.** El esquema muestra llaves/relaciones clave; base para todos los JOIN puente.
- **Q02.** Listado completo de pelis con rating **R**; facilita localizar títulos de esa clasificación.
- **Q03.** Muestra el tramo de actores con **id 30–40**; útil como muestreo ordenado.
- **Q04.** No devuelve filas: `original_language_id` está **NULL** en todo el catálogo.
- **Q05.** Orden ascendente de duración; permite identificar **mínimos** y el rango **corto**.
- **Q06.** Filtro por apellido “Allen”; devuelve solo los actores que lo contienen.
- **Q07.** Distribución por **rating**: **PG-13** es la más frecuente; **G** la menos.
- **Q08.** Predominan **PG-13**; algunos títulos entran por **>180 min** aunque tengan otro rating.
- **Q09.** Variación **moderada**: los costes se desvían ~**6** unidades de la media.
- **Q10.** El catálogo va de **46** a **185** minutos; existen títulos **muy largos**.
- **Q11.** Un **registro por día**: coste del **3.º** alquiler más reciente de cada fecha.
- **Q12.** Pelis **no** NC-17 ni G; listado complementario ordenado por título.
- **Q13.** Media por rating: **PG-13** la mayor, **G** la menor (≈9 min de diferencia).
- **Q14.** Muestra solo **largometrajes** (>180 min); es una **minoría** del catálogo.
- **Q15.** Suma global de **ingresos**; referencia para KPI de facturación.
- **Q16.** Top 10 por **customer_id** más alto; **no** implica mejores clientes.
- **Q17.** Reparte el elenco de **“EGG IGBY”**; actores ordenados alfabéticamente.
- **Q18.** Confirma **títulos únicos** en el catálogo (DISTINCT).
- **Q19.** Comedias **>180 min**: conjunto **muy reducido** de títulos.
- **Q20.** Categorías con **promedio** de duración >110; identifica géneros de **metraje largo**.
- **Q21.** Media de **días permitidos** de alquiler por película.
- **Q22.** Presenta **nombre completo** de actores; mejora legibilidad de resultados.
- **Q23.** **Alquileres por día**; se aprecian picos de demanda diarios.
- **Q24.** Pelis **por encima** de la media de duración: la **mitad superior** del catálogo.
- **Q25.** **Alquileres por mes**; muestra estacionalidad y tendencia temporal.
- **Q26.** Estadísticos de **amount**: media y dispersión de pagos realizados.
- **Q27.** Títulos con **precio** de alquiler **> media**; identifica oferta **premium**.
- **Q28.** Actores con **>40** pelis; ranking de **mayor productividad**.
- **Q29.** Copias **en inventario** por título; incluye **0** para sin stock.
- **Q30.** Nº de pelis por actor; ranking de **participación**.
- **Q31.** Todas las pelis con sus actores; incluye títulos **sin reparto** si existieran.
- **Q32.** Todos los actores con sus pelis; incluye actores **sin participación**.
- **Q33.** Películas **que tenemos** (inventario) y **todos** sus alquileres históricos.
- **Q34.** **Top‑5** clientes por gasto total; identifica clientes **más valiosos**.
- **Q35.** Filtro de **nombre** “Johnny”; útil para homónimos.
- **Q36.** Alias **Nombre/Apellido**; salida más **amigable**.
- **Q37.** **Rango** de ids de actor: mínimo y máximo existentes (no requiere LIMIT).
- **Q38.** **Total** de actores en la base de datos.
- **Q39.** **Directorio** alfabético de actores por apellido.
- **Q40.** Primeras **5** pelis (por id); muestra **de referencia**.
- **Q41.** **Nombre** de pila más repetido entre actores (top‑1).
- **Q42.** Alquileres con **nombre de cliente**; vista transaccional legible.
- **Q43.** Todos los **clientes** y, si tienen, sus alquileres (incluye **sin** alquiler).
- **Q44.** **CROSS JOIN** film×category: combinaciones teóricas; **no aporta** análisis directo.
- **Q45.** Actores con participación en **Action**; listado **único**.
- **Q46.** En Sakila **no hay** actores sin películas; consulta **vacía** esperada.
- **Q47.** Actores con **nº de pelis**; ranking descendente.
- **Q48.** **Vista** con nº de pelis por actor; reusable en informes y validaciones.
- **Q49.** **Alquileres totales** por cliente; mide **actividad** individual.
- **Q50.** **Metraje total** del género **Action**.
- **Q51.** **CTE/tabla temporal**: total de alquileres por cliente, listo para unir.
- **Q52.** Títulos con **≥10** alquileres; identifica **alta rotación**.
- **Q53.** Pelis **pendientes** de devolución de **Tammy Sanders**; orden alfabético.
- **Q54.** Actores con al menos una peli **Sci‑Fi**; orden por apellido.
- **Q55.** Actores de pelis alquiladas **después** del primer alquiler de *Spartacus Cheaper*.
- **Q56.** Actores **sin** participación en **Music** (NOT EXISTS).
- **Q57.** Títulos con alquileres de **>8 días**; estancias **largas**.
- **Q58.** Pelis de la misma **categoría** que **Animation**.
- **Q59.** Pelis con la **misma duración** que **“DANCING FEVER”** (excluye esa).
- **Q60.** Clientes con **≥7** pelis **distintas**; indicador de **variedad/fidelidad**.
- **Q61.** **Recuento** de alquileres por **categoría**; muestra demanda por género.
- **Q62.** Nº de pelis por categoría **estrenadas en 2006** (mix de catálogo por año).
- **Q63.** Todas las combinaciones **staff×store** (producto cartesiano).
- **Q64.** **Alquileres totales por cliente** con id y nombre completo (ranking).

---

> Nota: Algunas consultas devuelven 0 filas por la naturaleza del dataset (p. ej., `original_language_id` casi siempre es NULL; no hay actores sin películas).