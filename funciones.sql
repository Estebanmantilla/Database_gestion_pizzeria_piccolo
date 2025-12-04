-- 1 Función para calcular el total de un pedido (sumando precios de pizzas + costo de envío + IVA).
delimiter //
create function total_pedido(id_domicilio int)
returns double
not deterministic 
reads sql data 
begin 

declare valor_pedido double;
declare valor_domicilio double;

select d.valor, p.total into valor_domicilio, valor_pedido from domicilio d LEFT join pedido p on d.id_pedido = p.id where d.id = id_domicilio;

return ((valor_pedido + valor_domicilio) * 1.19);



end; //
delimiter ;

-- 2 Función para calcular la ganancia neta diaria (ventas - costos de ingredientes).
delimiter //
create Function ganacia_neta (fecha_dia date)
returns double
not deterministic
reads sql data 
begin 
declare ganacia_diaria double default 0;
declare valor_ingredientes double default 0;
declare ganancia double default 0;


select sum(valor_venta) into ganacia_diaria from domicilio d left join pedido p on d.id_pedido = p.id where date(p.fecha) = fecha_dia;

select sum(i.costo) into valor_ingredientes from pedido p left join pizza_pedido pp on p.id = pp.id_pedido left join pizza_ingre pi on pp.id_pizza = pi.id_pizza left join ingrediente i on pi.id_ingrediente = i.id where date(p.fecha) = fecha_dia;

set ganancia = ganacia_diaria - valor_ingredientes;

return ganancia;

end ; //
delimiter ;

-- 3 Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.
delimiter //
create procedure estado_pedido(in id_pedido_entra int)
begin 
    declare existe int default 0;

    select count(*)
    into existe
    from domicilio d
    left join pedido p on d.id_pedido = p.id
    where d.id_pedido = id_pedido_entra
      and date(d.hora_entrega) = date(now());

    if existe > 0 then
        update pedido 
        set estado = 'entregado' 
        where id = id_pedido_entra;
    end if;

end //
delimiter ;