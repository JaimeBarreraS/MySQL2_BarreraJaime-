USE universidad_T2;

-- CONSULTAS REPASO


-- Devuelve todos los datos del alumno más joven.

select * from alumno;
select * from alumno where fecha_nacimiento = '2000-10-05';

-- Devuelve un listado con los profesores que no están asociados a un departamento.

select * from profesor;
select * from profesor where id_departamento = 'null';

-- Devuelve un listado con los departamentos que no tienen profesores asociados.

select * from profesor;
select * from departamento d left join profesor p 
on d.id = p.id_departamento where p.id is null; 

-- Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.

select * from profesor;
select * from asignatura;
select p.* from profesor p
left join asignatura a on p.id = a.id_profesor
where p.id_departamento is not null and a.id is null;

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.

select * from asignatura;
select * from asignatura where id_profesor is null;

-- Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.

-- Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).

select * from grado;
select * from departamento;
select * from profesor;
select distinct d.nombre from departamento d
join profesor p on d.id = p.id_departamento
join asignatura a on p.id = a.id_profesor
join grado g on a.id_grado = g.id
where g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

/*
Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. 
El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado.
El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor.
El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.
*/
select * from departamento;
select * from profesor;
select d.nombre as nombre_departamento, p.apellido1, p.apellido2, p.nombre as nombre_profesor
from profesor p
left join departamento d on p.id_departamento = d.id
order by d.nombre, p.apellido1, p.apellido2, p.nombre;

-- Devuelve un listado con los profesores que no están asociados a un departamento.

select * from profesor;
select * from profesor where id_departamento = 'null';

-- Devuelve un listado con los departamentos que no tienen profesores asociados.

select * from profesor;
select * from departamento d left join profesor p 
on d.id = p.id_departamento where p.id is null; 

-- Devuelve un listado con los profesores que no imparten ninguna asignatura.

select * from profesor;
select * from asignatura;
select p.* from profesor p
left join asignatura a on p.id = a.id_profesor
where p.id_departamento is not null and a.id is null;

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.

select * from asignatura;
select * from asignatura where id_profesor is null;

-- Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. 

select distinct d.nombre as nombre_departamento, a.nombre as nombre_asignatura
from departamento d
join profesor p on d.id = p.id_departamento
join asignatura a on p.id = a.id_profesor
left join alumno_se_matricula_asignatura am on a.id = am.id_asignatura
where am.id_curso_escolar is null;

-- El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.