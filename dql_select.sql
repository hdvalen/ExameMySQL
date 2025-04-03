-- CONSULTAS SQL ---

-- 1. Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 6 meses. 
SELECT c.nombre, c.apellidos FROM cliente c
INNER JOIN alquiler a ON c.id_cliente= a.id_cliente
WHERE fecha_alquiler>6;
-- 2. Lista las cinco películas más alquiladas durante el último año. 
SELECT p.titulo FROM pelicula p
INNER JOIN inventario i ON p.id_pelicula=i.id_pelicula
INNER JOIN alquiler a ON i.id_inventario=a.id_inventario
WHERE fecha_alquiler='2005'
-- 3. Obtén el total de ingresos y la cantidad de alquileres realizados por cada categoría de película. 
-- 4. Calcula el número total de clientes que han realizado alquileres por cada idioma disponible en un mes específico. 
SELECT c.nombre, c.apellidos FROM cliente c
INNER JOIN alquiler a ON c.id_cliente= a.id_cliente
INNER JOIN inventario i ON a.id_inventario=i.id_inventario
INNER JOIN pelicula p ON i.id_pelicula=p.id_pelicula
INNER JOIN idioma i ON p.id_idioma=i.id_idioma
WHERE fecha_alquiler='2005-05-01';
-- 5. Encuentra a los clientes que han alquilado todas las películas de una misma categoría. 
-- 6. Lista las tres ciudades con más clientes activos en el último trimestre. 
-- 7. Muestra las cinco categorías con menos alquileres registrados en el último año. 
-- 8. Calcula el promedio de días que un cliente tarda en devolver las películas alquiladas. 
-- 9. Encuentra los cinco empleados que gestionaron más alquileres en la categoría de Acción. 
-- 10. Genera un informe de los clientes con alquileres más recurrentes. 
-- 11. Calcula el costo promedio de alquiler por idioma de las películas. 
-- 12. Lista las cinco películas con mayor duración alquiladas en el último año. 
-- 13. Muestra los clientes que más alquilaron películas de Comedia.
-- 14. Encuentra la cantidad total de días alquilados por cada cliente en el último mes. 
-- 15. Muestra el número de alquileres diarios en cada almacén durante el último trimestre. 
-- 16. Calcula los ingresos totales generados por cada almacén en el último semestre. 
-- 17.  Encuentra el cliente que ha realizado el alquiler más caro en el último año. 
-- 18. Lista las cinco categorías con más ingresos generados durante los últimos tres meses. 
-- 19. Obtén la cantidad de películas alquiladas por cada idioma en el último mes. 
-- 20. Lista los clientes que no han realizado ningún alquiler en el último año.