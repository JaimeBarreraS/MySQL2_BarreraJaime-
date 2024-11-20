USE ventas;

-- 1) OBTENER EL TOTAL DE PEDIDOS REALIZADOS POR UN CLIENTE

DELIMITER //
create function total_pedidos(id_cliente int)
returns int deterministic
begin
	declare total_pedidos int;
    select count(*) into total_pedidos
    from pedido 
    where id_cliente = id_cliente;
    return total_pedidos;
end //
DELIMITER ;
select total_pedidos(1) as total_pedidos;

-- 2) CALCULAR LA COMISION TOTAL GANADA POR UN COMERCIAL.

DELIMITER //
create function calcular_comision(id_comercial int)
returns float deterministic
begin
	declare comision_total float;
    select sum(p.cantidad * (c.comision/100)) into comision_total
    from pedido p
    join comercial c on p.id_comercial = c.id
    where p.id_comercial = id_comercial;
    return ifnull(comision_total, 0);
end //
DELIMITER ;
select calcular_comision(1) as comision_total;

-- 3) OBTENER EL CLIENTE CON MAYOR TOTAL EN PEDIDOS.

