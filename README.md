# 📀 Proyecto-SQL
## 🧭 Descripción
Repositorio del proyecto de **Lógica SQL** sobre una base de datos de videoclub.  
El objetivo ha sido **resolver 64 consultas** aplicando joins, subconsultas, CTEs, vistas y funciones agregadas/analíticas, y documentar los hallazgos en un informe.

## 🗂️ Archivos del proyecto
├── README.md                         # este documento
├── Script-consultas_BBDD.sql         # Q01–Q64 con número + enunciado + comentario
├── Informe de Resultados SQL.pdf     # informe con metodología y resultados
├── Esquema BBDD.png                  # diagrama entidad–relación
└── insights_consultas.md             # frases de insight por consulta

## ⚙️ Herramientas 
Este proyecto usa Posgressql como motor de base de datos con puerto local 5432 y Dbeaver como gestor visual.

## 🔎 Resumen muy breve de hallazgos

- Catálogo equilibrado por **rating**, con ligera mayoría **PG‑13**.  
- Duraciones entre **46–185 min**; los títulos **>180 min** son minoría.  
- **Coste de reemplazo** con dispersión moderada (desv. típica ≈ **6**).  
- Alquileres por mes con **patrón estacional** (picos en verano).  
- En el dataset no aparecen **actores sin películas**; `original_language_id` no está poblado.  
- Identifiqué títulos de **alta rotación** (≥10 alquileres) y el **Top‑5** de clientes por gasto.

> El detalle ampliado (consultas, gráficos y tablas) está en **`Informe de Resultados SQL.pdf`**.  
> Si quieres el resumen rápido por consulta, lo tienes en **`insights_consultas.md`**.

## 🔄 Próximos Pasos
- Stock: reforzar inventario en títulos de alta rotación y en categorías con mayor demanda; revisar títulos con copias nulas.
- Comercial: orientar promociones estacionales (verano) y planes de fidelización sobre el Top-clientes.
- Operación: seguimiento proactivo de devoluciones y de alquileres largos.o
- Datos: priorizar el enriquecimiento de atributos infrautilizados (idioma original) y mantener el script versionado para reproducibilidad.

  ## Contribuciones
 Las contribuciones son bienvenidas. Si deseas mejorar el proyecto, por favor 
abre un pull request o una issue.

## Patricia Romo Jiménez 
https://github.com/Patricia-RJ
