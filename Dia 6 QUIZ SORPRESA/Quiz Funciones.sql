USE ventas;

############################################################
-- 1) OBTENER EL TOTAL DE PEDIDOS REALIZADOS POR UN CLIENTE
DELIMITER //
create function pedidos_cliente(cliente_id int)
returns double deterministic
begin
    declare total_pedidos double;
    
    select sum(total)
	into total_pedidos
    from pedido
    where id_cliente = cliente_id;
    
    return total_pedidos;
end //
DELIMITER ;
select pedidos_cliente(2);
select * from pedido;
############################################################
-- 2) CALCULAR LA COMISION TOTAL GANADA POR UN COMERCIAL.
DELIMITER //
create function comision_comercial(comercial_id int)
returns double deterministic
begin
    declare comision_total double;
    
    select sum(p.total * c.comision)
    into comision_total
    from pedido p
    join comercial c on p.id_comercial = c.id
    where c.id = comercial_id;
    
    return comision_total;
end //
DELIMITER ;
select comision_comercial(3);
select * from pedido; 
############################################################
-- 3) OBTENER EL CLIENTE CON MAYOR TOTAL EN PEDIDOS.
DELIMITER //
create function cliente_mayor_total()
returns int deterministic
begin
    declare cliente_id int;
    
    select id_cliente
    into cliente_id
    from pedido
    group by id_cliente
    order by sum(total) desc
    limit 1;
    
    return cliente_id;
end //
DELIMITER ;
SELECT cliente_mayor_total();
select * from pedido; 
############################################################
-- 4. CONTAR LA CANTIDAD DE PEDIDOS REALIZADOS EN UN AÑO
DELIMITER //
create function pedidos_año(año int)
returns int deterministic
begin
    declare cantidad_pedidos int;
    
    select count(*)
    into cantidad_pedidos
    from pedido
    where year(fecha) = año;
    
    return cantidad_pedidos;
end //
DELIMITER ;
SELECT pedidos_año(2024);
select * from pedido; 
############################################################
-- 5) OBTENER EL PROMEDIO DE TOTAL DE PEDIDOS POR CLIENTE
DELIMITER //
create function promedio_cliente()
returns double deterministic
begin
    declare promedio_total double;
    
    select avg(total)
    into promedio_total
    from pedido;
    
    return promedio_total;
end //
DELIMITER ;
select promedio_cliente(); 
select * from pedido; 