CREATE DATABASE AutoRental ;
USE AutoRental;

CREATE TABLE Sucursal (
    id_sucursal INT PRIMARY KEY,
    ciudad VARCHAR(100),
    direccion VARCHAR(255),
    telefono_fijo VARCHAR(20),
    telefono_celular VARCHAR(20),
    correo_electronico VARCHAR(100)
);

CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY ,
    id_sucursal INT,
    cedula VARCHAR(20) UNIQUE,
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    direccion VARCHAR(255),
    ciudad_residencia VARCHAR(100),
    celular VARCHAR(20),
    correo_electronico VARCHAR(100),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal)
);

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    cedula VARCHAR(20) UNIQUE,
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    direccion VARCHAR(255),
    ciudad_residencia VARCHAR(100),
    celular VARCHAR(20),
    correo_electronico VARCHAR(100)
);

CREATE TABLE Vehiculo (
    id_vehiculo INT PRIMARY KEY,
    tipo_vehiculo VARCHAR(50),
    placa VARCHAR(20) UNIQUE,
    referencia VARCHAR(50),
    modelo INT,
    puertas INT,
    capacidad INT,
    sunroof BOOLEAN,
    motor VARCHAR(50),
    color VARCHAR(30)
);

CREATE TABLE Alquiler (
    id_alquiler INT PRIMARY KEY,
    id_cliente INT,
    id_vehiculo INT,
    id_empleado INT,
    id_sucursal_salida INT,
    fecha_salida DATE,
    id_sucursal_llegada INT,
    fecha_llegada DATE,
    fecha_esperada_llegada DATE,
    valor_alquiler_por_semana DECIMAL(10, 2),
    valor_alquiler_por_dia DECIMAL(10, 2),
    porcentaje_descuento DECIMAL(5, 2),
    valor_cotizado DECIMAL(10, 2),
    valor_pagado DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_sucursal_salida) REFERENCES Sucursal(id_sucursal),
    FOREIGN KEY (id_sucursal_llegada) REFERENCES Sucursal(id_sucursal)
);
show tables;


