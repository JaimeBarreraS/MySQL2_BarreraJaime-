USE AutoRental;

-- #######  CONSULTAS  #########

-- 1 Obtener todas las sucursales con sus datos
SELECT * FROM Sucursal;

-- 2 Listar todos los empleados de una sucursal específica
SELECT * FROM Empleado WHERE id_sucursal = 1;

-- 3 Mostrar todos los clientes registrados en la ciudad de residencia especifica
SELECT * FROM Cliente where ciudad_residencia = 'Bogotá';

-- 4 Consultar los alquileres que tienen retrasos
SELECT * FROM Alquiler WHERE fecha_llegada > fecha_esperada_llegada;

-- 5 Calcular el ingreso total generado por alquileres
SELECT SUM(valor_pagado) AS ingresos_totales FROM Alquiler;

-- 6 Cantidad de clientes por ciudad
SELECT ciudad_residencia, COUNT(*) AS total_clientes FROM Cliente GROUP BY ciudad_residencia;

-- 7 Obtener el nombre de los clientes y los vehículos que han alquilado
SELECT c.nombres AS cliente, v.referencia AS vehiculo
FROM Alquiler a
JOIN Cliente c ON a.id_cliente = c.id_cliente
JOIN Vehiculo v ON a.id_vehiculo = v.id_vehiculo;

-- 8 Listar los empleados y las sucursales donde trabajan
SELECT e.nombres AS empleado, s.ciudad AS sucursal
FROM Empleado e
JOIN Sucursal s ON e.id_sucursal = s.id_sucursal;

-- 9 Vehículos alquilados y sus fechas de alquiler
SELECT v.referencia AS vehiculo, a.fecha_salida, a.fecha_llegada
FROM Vehiculo v
JOIN Alquiler a ON v.id_vehiculo = a.id_vehiculo;

-- 10 Ver el vehículo con el alquiler más costoso
SELECT v.referencia, MAX(a.valor_pagado) AS valor_maximo
FROM Vehiculo v
JOIN Alquiler a ON v.id_vehiculo = a.id_vehiculo
GROUP BY v.referencia;

-- 11 Consultar el porcentaje promedio de descuento aplicado en los alquileres
SELECT AVG(porcentaje_descuento) AS promedio_descuento FROM Alquiler;

-- 12 Obtener la sucursal que más ingresos ha generado
SELECT s.ciudad, SUM(a.valor_pagado) AS total_ingresos
FROM Sucursal s
JOIN Alquiler a ON s.id_sucursal = a.id_sucursal_salida
GROUP BY s.id_sucursal
ORDER BY total_ingresos DESC
LIMIT 1;

-- 13 Empleados con la mayor cantidad de alquileres gestionados
SELECT e.id_empleado, e.nombres, e.apellidos, COUNT(a.id_alquiler) AS total_alquileres
FROM Empleado e
JOIN Alquiler a ON e.id_empleado = a.id_empleado
GROUP BY e.id_empleado, e.nombres, e.apellidos
ORDER BY total_alquileres DESC
LIMIT 1;

-- 14 Alquileres realizados por sucursal
SELECT s.ciudad, COUNT(a.id_alquiler) AS total_alquileres
FROM Sucursal s
JOIN Alquiler a ON s.id_sucursal = a.id_sucursal_salida
GROUP BY s.ciudad;

-- 15 Promedio de valor pagado por tipo de vehículo
SELECT v.tipo_vehiculo, AVG(a.valor_pagado) AS promedio_pagado
FROM Vehiculo v
JOIN Alquiler a ON v.id_vehiculo = a.id_vehiculo
GROUP BY v.tipo_vehiculo;

-- 16 Historial de alquileres de un cliente específico
SELECT a.id_alquiler, a.fecha_salida, a.fecha_llegada, a.valor_pagado
FROM Alquiler a
JOIN Cliente c ON a.id_cliente = c.id_cliente
WHERE c.nombres = 'Juan' AND c.apellidos = 'Pérez';

-- 17 Vehículo con el mayor valor de alquiler pagado
SELECT v.id_vehiculo, v.tipo_vehiculo, MAX(a.valor_pagado) AS valor_maximo
FROM Vehiculo v
JOIN Alquiler a ON v.id_vehiculo = a.id_vehiculo
GROUP BY v.id_vehiculo, v.tipo_vehiculo
ORDER BY valor_maximo DESC
LIMIT 1;

-- 18 Descuentos aplicados en un rango de fechas
SELECT a.id_alquiler, a.fecha_salida, a.fecha_llegada, a.porcentaje_descuento
FROM Alquiler a
WHERE a.fecha_salida BETWEEN '2024-01-01' AND '2024-12-31';

-- 19 Tiempo promedio de los alquileres por tipo de vehículo
SELECT v.tipo_vehiculo, AVG(DATEDIFF(a.fecha_llegada, a.fecha_salida)) AS dias_promedio
FROM Vehiculo v
JOIN Alquiler a ON v.id_vehiculo = a.id_vehiculo
GROUP BY v.tipo_vehiculo;

-- 20 Empleados que no han gestionado alquileres
SELECT e.id_empleado, e.nombres, e.apellidos
FROM Empleado e
LEFT JOIN Alquiler a ON e.id_empleado = a.id_empleado
WHERE a.id_empleado IS NULL;

-- 21 Clientes que entregaron vehículos con retraso
SELECT c.id_cliente, c.nombres, c.apellidos, a.fecha_llegada, a.fecha_esperada_llegada
FROM Cliente c
JOIN Alquiler a ON c.id_cliente = a.id_cliente
WHERE a.fecha_llegada > a.fecha_esperada_llegada;

-- 22 Clientes con el mayor porcentaje de descuento acumulado
SELECT c.id_cliente, c.nombres, c.apellidos, SUM(a.porcentaje_descuento) AS total_descuento
FROM Cliente c
JOIN Alquiler a ON c.id_cliente = a.id_cliente
GROUP BY c.id_cliente, c.nombres, c.apellidos
ORDER BY total_descuento DESC
LIMIT 5;

-- 23 Vehículo más alquilado por tipo
SELECT v.tipo_vehiculo, v.referencia, COUNT(a.id_alquiler) AS total_alquileres
FROM Vehiculo v
JOIN Alquiler a ON v.id_vehiculo = a.id_vehiculo
GROUP BY v.tipo_vehiculo, v.referencia
ORDER BY total_alquileres DESC
LIMIT 1;

-- 24 Sucursales con el mayor número de vehículos disponibles
SELECT s.id_sucursal, s.ciudad, COUNT(v.id_vehiculo) AS vehiculos_disponibles
FROM Sucursal s
JOIN Vehiculo v ON v.id_vehiculo NOT IN (
    SELECT a.id_vehiculo 
    FROM Alquiler a 
    WHERE a.fecha_llegada IS NULL
)
WHERE v.id_vehiculo IN (
    SELECT a.id_vehiculo
    FROM Alquiler a
    WHERE a.id_sucursal_llegada = s.id_sucursal
)
GROUP BY s.id_sucursal, s.ciudad
ORDER BY vehiculos_disponibles DESC;

-- 25 Alquileres más costosos realizados
SELECT a.id_alquiler, c.nombres AS cliente, c.apellidos AS apellido, 
       v.tipo_vehiculo, v.referencia, a.valor_pagado
FROM Alquiler a
JOIN Cliente c ON a.id_cliente = c.id_cliente
JOIN Vehiculo v ON a.id_vehiculo = v.id_vehiculo
ORDER BY a.valor_pagado DESC
LIMIT 3;
