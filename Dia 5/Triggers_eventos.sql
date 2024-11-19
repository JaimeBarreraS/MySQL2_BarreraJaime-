CREATE DATABASE triggers_eventos_t2 ;
USE triggers_eventos_t2;

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(50)
);

CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(50),
    state_province VARCHAR(50),
    country_id CHAR(2),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(50),
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id INT,
    salary DECIMAL(10, 2),
    manager_id INT,
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE dependents (
    dependent_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    relationship VARCHAR(50),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Insertar regiones
INSERT INTO regions (region_id, region_name) VALUES 
(1, 'North America'),
(2, 'Europe'),
(3, 'Asia'),
(4, 'South America');

-- Insertar países
INSERT INTO countries (country_id, country_name, region_id) VALUES 
('US', 'United States', 1),
('CA', 'Canada', 1),
('FR', 'France', 2),
('JP', 'Japan', 3);

-- Insertar ubicaciones
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES 
(100, '123 Main St', '12345', 'New York', 'NY', 'US'),
(101, '456 Elm St', '67890', 'Toronto', 'ON', 'CA'),
(102, '789 Maple Ave', '54321', 'Paris', 'IDF', 'FR');

-- Insertar departamentos
INSERT INTO departments (department_id, department_name, location_id) VALUES 
(10, 'Finance', 100),
(20, 'Marketing', 101),
(30, 'IT', 102);

-- Insertar trabajos
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES 
(1, 'Accountant', 50000, 90000),
(2, 'Software Developer', 60000, 120000),
(3, 'HR Manager', 70000, 150000);

-- Insertar empleados
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES 
(1, 'John', 'Doe', 'johndoe@example.com', '555-1234', '2020-01-15', 1, 75000, NULL, 10),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-5678', '2021-06-01', 2, 80000, 1, 20),
(3, 'Alice', 'Johnson', 'alicej@example.com', '555-9012', '2019-03-10', 3, 95000, 1, 30);

-- Insertar dependientes
INSERT INTO dependents (dependent_id, first_name, last_name, relationship, employee_id) VALUES 
(1, 'Emily', 'Doe', 'Daughter', 1),
(2, 'Michael', 'Doe', 'Son', 1),
(3, 'Sophia', 'Smith', 'Spouse', 2);

-- ##### CONSULTAS SIMPLES ########
-- 1. Listar todos los paises:
select * from countries;

-- 2. Obtenes todos los departamentos:
select * from deparments;

-- 3. Mostrar el titulo y salario minimo de todos los trabajos:
select job_title, min_salary from jobs;

-- 4. Lista de dependientes juntos con los datos de los empleados a los que esten asociados
select * from dependents where employee_id;

-- 5. Salario promedio por departamento y ciudad
select department_id, 
job_id, 
avg(salary) as salary_average 
from employees
group by department_id, job_id
order by department_id, job_id; 
-- 6. lista de empleados con su trabajo, departamento y ubicacion

-- #### FUNCIONES #####
-- 1. Obtener el nombre de un pais por su ID
DELIMITER // 
create function ObtenerPais_Nombre(country_id_i char (2))
returns varchar(50) deterministic
begin
	declare country_name_r varchar(50);
    select country_name into country_name_r
    from countries
    where country_id=country_id_i;
    return country_name_r;
end //
DELIMITER ;
select ObtenerPais_Nombre('US');

-- #### PROCEDIMIENTOS #####
-- 1. Insertar una nueva region.
-- insert into regions(region_name) values("Africa");

DELIMITER // 
create procedure insertRegion(in nombre_region varchar(50))
begin
insert into regions(region_name) values(nombre_region);
end
// DELIMITER ; 

call insertRegion("Africa");

select * from regions;
