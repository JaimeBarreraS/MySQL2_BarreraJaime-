USE AutoRental;

-- FUNCIONES

/*
1 SI UN CLIENTE ENTREGA EL VEHICULO PASADA LA FECHA DE ENTREGA CONTRATADA
SE COBRARA LOS DIAS ADICIONALES CON UN INCREMENTO DEL 8% 
*/

DELIMITER //

CREATE FUNCTION CalcularCobroAdicional(
    p_id_alquiler INT
) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE cobro_adicional DECIMAL(10, 2);

    SELECT 
        CASE 
            WHEN fecha_llegada > fecha_esperada_llegada THEN 
                DATEDIFF(fecha_llegada, fecha_esperada_llegada) * valor_alquiler_por_dia * 1.08
            ELSE 0
        END
    INTO cobro_adicional
    FROM Alquiler
    WHERE id_alquiler = p_id_alquiler;

    RETURN cobro_adicional;
END//

DELIMITER ;

select id_alquiler, id_cliente, fecha_llegada, fecha_esperada_llegada, CalcularCobroAdicional(id_alquiler) as Cobro_Adicional from Alquiler;

/*
2. CALCULAR EL EL VALOR TOTAL SIN RETRASOS. ESTA FUNCION CALCULA EL COSTO TOTAL DE UN ALQUILER 
SIN TENER EN CUENTA NI RETRASOS NI DESCUENTOS
*/

DELIMITER //

CREATE FUNCTION CalcularValorAlquiler(
    p_id_alquiler INT
) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE valor_total DECIMAL(10, 2);

    SELECT 
        (DATEDIFF(fecha_esperada_llegada, fecha_salida) DIV 7) * valor_alquiler_por_semana +
        (DATEDIFF(fecha_esperada_llegada, fecha_salida) MOD 7) * valor_alquiler_por_dia
    INTO valor_total
    FROM Alquiler
    WHERE id_alquiler = p_id_alquiler;

    RETURN valor_total;
END//

DELIMITER ;

select id_alquiler, id_cliente, fecha_llegada, fecha_esperada_llegada, CalcularValorAlquiler(id_alquiler) as Valor_Alquiler from Alquiler;

/*
3. OBTENER LA CANTIDAD DE VEHICULOS DISPONIBLES POR TIPO
DEVUELVE EL NUMERO DE VEHICULOS DISPONIBLES EN LA BASE DATOS POR TIPO
*/

DELIMITER //

CREATE FUNCTION ContarVehiculosPorTipo(
    p_tipo_vehiculo VARCHAR(50)
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(*)
    INTO cantidad
    FROM Vehiculo v
    WHERE NOT EXISTS (
        SELECT 1
        FROM Alquiler a
        WHERE a.id_vehiculo = v.id_vehiculo 
        AND a.fecha_llegada IS NULL
    )
    AND tipo_vehiculo = p_tipo_vehiculo;

    RETURN cantidad;
END//

DELIMITER ;

select  id_vehiculo, tipo_vehiculo, ContarVehiculosPorTipo(tipo_vehiculo) as Vehiculos_Por_Tipo from Vehiculo;

/*
4. CALCULAR EL TOTAL DE INGRESOS POR SUCURSAL
DEVUELVE EL TOTAL INGRESOS GENERADOS POR UNA SUCURSAL ESPECIFICA
*/

DELIMITER //

CREATE FUNCTION CalcularIngresosSucursal(
    p_id_sucursal INT
) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_ingresos DECIMAL(10, 2);

    SELECT SUM(valor_pagado)
    INTO total_ingresos
    FROM Alquiler
    WHERE id_sucursal_salida = p_id_sucursal;

    RETURN total_ingresos;
END//

DELIMITER ;

select id_sucursal, ciudad, CalcularIngresosSucursal(id_sucursal) as Ingresos_Sucursal from Sucursal;

/*
5. DETERMINAR SI UN CLIENTE ES FRECUENTE 
EVALUA SI UN CLIENTE SE CONSIDERA FRECUENTE SEGUN UN UMBRAL DE ALQUILERES
*/

DELIMITER //

CREATE FUNCTION CalcularPromedioDiasAlquiler(
    p_id_cliente INT
) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE promedio_dias DECIMAL(10, 2);

    SELECT AVG(DATEDIFF(
        COALESCE(fecha_llegada, CURDATE()), -- Usa la fecha actual si el vehículo no ha sido devuelto
        fecha_salida
    ))
    INTO promedio_dias
    FROM Alquiler
    WHERE id_cliente = p_id_cliente;

    RETURN IFNULL(promedio_dias, 0); -- Si no tiene alquileres, devuelve 0
END//

DELIMITER ;

select id_cliente, cedula, nombres, apellidos, CalcularPromedioDiasAlquiler(id_cliente) as Dia_Alquilados from cliente;


