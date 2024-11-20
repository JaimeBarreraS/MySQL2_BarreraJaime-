USE AutoRental;

-- 1. Añadir una sucursal ##############################
DELIMITER //
CREATE PROCEDURE AñadirSucursal (
    IN p_ciudad VARCHAR(100),
    IN p_direccion VARCHAR(255),
    IN p_telefono_fijo VARCHAR(20),
    IN p_telefono_celular VARCHAR(20),
    IN p_correo_electronico VARCHAR(100)
)
BEGIN
    INSERT INTO Sucursal (ciudad, direccion, telefono_fijo, telefono_celular, correo_electronico)
    VALUES (p_ciudad, p_direccion, p_telefono_fijo, p_telefono_celular, p_correo_electronico);
END //
DELIMITER ;

CALL AñadirSucursal (
    'Tibu', 
    'Av. Barrio Largo Sur 1234', 
    '55-1234-5678', 
    '55-9876-5432', 
    'contacto@sucursal.com'
);
select * from Sucursal;

-- #######################################################
-- 2. Actualizar los datos de una sucursal ##############################
DELIMITER //
CREATE PROCEDURE ActualizarSucursal (
    IN p_id_sucursal INT,
    IN p_ciudad VARCHAR(100),
    IN p_direccion VARCHAR(255),
    IN p_telefono_fijo VARCHAR(20),
    IN p_telefono_celular VARCHAR(20),
    IN p_correo_electronico VARCHAR(100)
)
BEGIN
    UPDATE Sucursal
    SET ciudad = p_ciudad,
        direccion = p_direccion,
        telefono_fijo = p_telefono_fijo,
        telefono_celular = p_telefono_celular,
        correo_electronico = p_correo_electronico
    WHERE id_sucursal = p_id_sucursal;
END //
DELIMITER ;

CALL ActualizarSucursal(
    5, 
    'Cucuta', 
    'Av. Motiles calle 20 #13-35', 
    '55-1234-5678', 
    '55-9876-5432', 
    'contacto@cucuta.com'
);
select * from Sucursal;

-- #######################################################
-- 3. Eliminar Surcursal ##############################
DELIMITER //
CREATE PROCEDURE EliminarSucursal (IN p_id_sucursal INT)
BEGIN
    DELETE FROM Sucursal WHERE id_sucursal = p_id_sucursal;
END //
DELIMITER ;
CALL EliminarSucursal(6);
select * from Sucursal;

-- #######################################################
-- 4. Actualizar la disponibilidad de un vehículo ##############################
DELIMITER //
CREATE PROCEDURE DisponibilidadVehiculo(
    IN p_id_vehiculo INT,
    IN p_disponibilidad BOOLEAN
)
BEGIN
    UPDATE Vehiculo
    SET disponibilidad = p_disponibilidad
    WHERE id_vehiculo = p_id_vehiculo;
END //
DELIMITER ;
CALL DisponibilidadVehiculo(3, TRUE);
select * from Vehiculo;

-- #######################################################
-- 5. Calcular el total facturado por alquiler en un fecha especifica ##############################
DELIMITER //
CREATE PROCEDURE CalcularTotalFacturado(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
        SUM(a.valor_pagado) AS total_facturado
    FROM Alquiler a
    WHERE a.fecha_salida BETWEEN p_fecha_inicio AND p_fecha_fin;
END //
DELIMITER ;
CALL CalcularTotalFacturado('2024-11-01', '2025-01-31');

-- #######################################################
-- 6. Actualizar la Salida de Sucursal ##############################
DELIMITER //
CREATE PROCEDURE ActualizarSucursalSalida(
    IN p_id_alquiler INT,
    IN p_id_sucursal_salida INT
)
BEGIN
    UPDATE Alquiler
    SET id_sucursal_salida = p_id_sucursal_salida
    WHERE id_alquiler = p_id_alquiler;
END //
DELIMITER ;
CALL ActualizarSucursalSalida(1, 4);
select * from Alquiler;

-- #######################################################
-- 7. Actualizar la llegada de Sucursal ##############################
DELIMITER //
CREATE PROCEDURE ActualizarSucursalLlegada(
    IN p_id_alquiler INT,
    IN p_id_sucursal_llegada INT
)
BEGIN
    UPDATE Alquiler
    SET id_sucursal_llegada = p_id_sucursal_llegada
    WHERE id_alquiler = p_id_alquiler;
END //
DELIMITER ;
CALL ActualizarSucursalLlegada(1, 4);
select * from Alquiler;

-- #######################################################
-- 8. Actualizar el valor cotizado: ##############################
DELIMITER //
CREATE PROCEDURE ActualizarValorCotizado(
    IN p_id_alquiler INT,
    IN p_valor_cotizado DECIMAL(10, 2)
)
BEGIN
    UPDATE Alquiler
    SET valor_cotizado = p_valor_cotizado
    WHERE id_alquiler = p_id_alquiler;
END //
DELIMITER ;
CALL ActualizarValorCotizado(1, 1500.00);
select * from Alquiler;

-- #######################################################
-- 9. Actualizar el valor pagado: ##############################
DELIMITER //
CREATE PROCEDURE ActualizarValorPagado(
    IN p_id_alquiler INT,
    IN p_valor_pagado DECIMAL(10, 2)
)
BEGIN
    UPDATE Alquiler
    SET valor_pagado = p_valor_pagado
    WHERE id_alquiler = p_id_alquiler;
END //
DELIMITER ;
CALL ActualizarValorPagado(1, 1400.00);
select * from Alquiler;






