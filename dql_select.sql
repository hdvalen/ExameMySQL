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
SELECT c.nombre, c.apellidos FROM cliente c
INNER JOIN alquiler a ON c.id_cliente= a.id_cliente
INNER JOIN inventario i ON a.id_inventario=i.id_inventario
INNER JOIN pelicula p ON i.id_pelicula=p.id_pelicula
INNER JOIN categoria ca ON p.id_categoria=ca.id_categoria
WHERE ca.nombre='Acción';
-- 6. Lista las tres ciudades con más clientes activos en el último trimestre. 
SELECT d.ciudad FROM direccion d
INNER JOIN cliente c ON d.id_direccion=c.id_direccion
WHERE c.activo=1
GROUP BY d.ciudad
ORDER BY COUNT(c.id_cliente) DESC
LIMIT 3;
-- 7. Muestra las cinco categorías con menos alquileres registrados en el último año. 
SELECT ca.nombre FROM categoria ca
INNER JOIN pelicula p ON ca.id_categoria=p.id_categoria
INNER JOIN inventario i ON p.id_pelicula=i.id_pelicula
INNER JOIN alquiler a ON i.id_inventario=a.id_inventario
WHERE fecha_alquiler='2005'
GROUP BY ca.nombre
ORDER BY COUNT(a.id_alquiler) ASC
LIMIT 5;
-- 8. Calcula el promedio de días que un cliente tarda en devolver las películas alquiladas. 
SELECT AVG(DATEDIFF(a.fecha_devolucion, a.fecha_alquiler)) AS promedio_dias FROM alquiler a
WHERE a.fecha_devolucion IS NOT NULL;
-- 9. Encuentra los cinco empleados que gestionaron más alquileres en la categoría de Acción.
SELECT e.nombre, e.apellidos FROM empleado e
INNER JOIN alquiler a ON e.id_empleado=a.id_empleado
INNER JOIN inventario i ON a.id_inventario=i.id_inventario
INNER JOIN pelicula p ON i.id_pelicula=p.id_pelicula
INNER JOIN categoria ca ON p.id_categoria=ca.id_categoria
WHERE ca.nombre='Acción'
GROUP BY e.id_empleado
ORDER BY COUNT(a.id_alquiler) DESC
LIMIT 5; 
-- 10. Genera un informe de los clientes con alquileres más recurrentes.
SELECT c.nombre, c.apellidos FROM cliente c
INNER JOIN alquiler a ON c.id_cliente= a.id_cliente
INNER JOIN inventario i ON a.id_inventario=i.id_inventario
INNER JOIN pelicula p ON i.id_pelicula=p.id_pelicula
INNER JOIN categoria ca ON p.id_categoria=ca.id_categoria
WHERE ca.nombre='Acción'
GROUP BY c.id_cliente
ORDER BY COUNT(a.id_alquiler) DESC;
-- 11. Calcula el costo promedio de alquiler por idioma de las películas. 
SELECT AVG(p.precio) AS costo_promedio, i.nombre FROM pelicula p
INNER JOIN idioma i ON p.id_idioma=i.id_idioma
GROUP BY i.nombre;
-- 12. Lista las cinco películas con mayor duración alquiladas en el último año. 
SELECT p.titulo FROM pelicula p
INNER JOIN inventario i ON p.id_pelicula=i.id_pelicula
INNER JOIN alquiler a ON i.id_inventario=a.id_inventario
WHERE fecha_alquiler='2005'
ORDER BY p.duracion DESC
LIMIT 5;
-- 13. Muestra los clientes que más alquilaron películas de Comedia.
SELECT c.nombre, c.apellidos FROM cliente c
INNER JOIN alquiler a ON c.id_cliente= a.id_cliente
INNER JOIN inventario i ON a.id_inventario=i.id_inventario
INNER JOIN pelicula p ON i.id_pelicula=p.id_pelicula
INNER JOIN categoria ca ON p.id_categoria=ca.id_categoria
WHERE ca.nombre='Comedia'
GROUP BY c.id_cliente
ORDER BY COUNT(a.id_alquiler) DESC;
-- 14. Encuentra la cantidad total de días alquilados por cada cliente en el último mes. 
SELECT c.nombre, c.apellidos, SUM(DATEDIFF(a.fecha_devolucion, a.fecha_alquiler)) AS total_dias FROM cliente c
INNER JOIN alquiler a ON c.id_cliente= a.id_cliente
WHERE a.fecha_alquiler>='2023-09-01' AND a.fecha_alquiler<='2023-09-30'
GROUP BY c.id_cliente;
-- 15. Muestra el número de alquileres diarios en cada almacén durante el último trimestre. 
SELECT a.id_almacen, COUNT(a.id_alquiler) AS total_alquileres FROM alquiler a
WHERE a.fecha_alquiler>='2023-07-01' AND a.fecha_alquiler<='2023-09-30'
GROUP BY a.id_almacen, DATE(a.fecha_alquiler);
-- 16. Calcula los ingresos totales generados por cada almacén en el último semestre. 
SELECT a.id_almacen, SUM(p.total) AS total_ingresos FROM alquiler a
INNER JOIN pago p ON a.id_alquiler=p.id_alquiler
WHERE a.fecha_alquiler>='2023-04-01' AND a.fecha_alquiler<='2023-09-30'
GROUP BY a.id_almacen;
-- 17.  Encuentra el cliente que ha realizado el alquiler más caro en el último año. 
SELECT c.nombre, c.apellidos, MAX(p.total) AS alquiler_mas_caro FROM cliente c
INNER JOIN alquiler a ON c.id_cliente= a.id_cliente
INNER JOIN pago p ON a.id_alquiler=p.id_alquiler
WHERE a.fecha_alquiler>='2023-01-01' AND a.fecha_alquiler<='2023-12-31'
GROUP BY c.id_cliente
ORDER BY alquiler_mas_caro DESC
LIMIT 1;
-- 18. Lista las cinco categorías con más ingresos generados durante los últimos tres meses. 
SELECT ca.nombre, SUM(p.total) AS total_ingresos FROM categoria ca
INNER JOIN pelicula p ON ca.id_categoria=p.id_categoria
INNER JOIN inventario i ON p.id_pelicula=i.id_pelicula
INNER JOIN alquiler a ON i.id_inventario=a.id_inventario
INNER JOIN pago p ON a.id_alquiler=p.id_alquiler
WHERE a.fecha_alquiler>='2023-07-01' AND a.fecha_alquiler<='2023-09-30'
GROUP BY ca.nombre
ORDER BY total_ingresos DESC
LIMIT 5;
-- 19. Obtén la cantidad de películas alquiladas por cada idioma en el último mes.
SELECT i.nombre, COUNT(a.id_alquiler) AS total_alquileres FROM idioma i
INNER JOIN pelicula p ON i.id_idioma=p.id_idioma
INNER JOIN inventario inv ON p.id_pelicula=inv.id_pelicula
INNER JOIN alquiler a ON inv.id_inventario=a.id_inventario
WHERE a.fecha_alquiler>='2023-09-01' AND a.fecha_alquiler<='2023-09-30'
GROUP BY i.nombre; 
-- 20. Lista los clientes que no han realizado ningún alquiler en el último año.
SELECT c.nombre, c.apellidos FROM cliente c
LEFT JOIN alquiler a ON c.id_cliente= a.id_cliente
WHERE a.fecha_alquiler IS NULL OR a.fecha_alquiler<'2023-01-01';