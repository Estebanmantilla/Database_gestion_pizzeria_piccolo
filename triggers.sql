-- 1 Trigger de actualización automática de stock de ingredientes cuando se realiza un pedido.

delimiter //
create Trigger actualizar_stock
after insert on pizza_pedido
for each row 
begin 

 update ingrediente i left join pizza_ingrediente pi on pi.id_ingrediente = i.id set i.cantidad = i.cantidad - (1 * new.cantidad) where pi.id_pizza = new.id_pizza;
end ; //
delimiter ;

-- 2 Trigger de auditoría que registre en una tabla historial_precios cada vez que se modifique el precio de una pizza.
delimiter //
create trigger auditoria_precios
after update on pizza
for each row
begin 
    if OLD.precio <> NEW.precio then
        insert into auditoria (nombre_pizza, precio_anterior, precio_nuevo, fecha_cambio)
        values (OLD.nombre, OLD.precio, NEW.precio, now());
    end if;


end; //
delimiter ;

-- 3 Trigger para marcar repartidor como “disponible” nuevamente cuando termina un domicilio.
delimiter //
create trigger marcar_repartidor_disponible
after update on pedido
for each row
begin
    
    if NEW.estado = 'entregado' then

        update repartidor r left join domicilio d on r.id = d.id_repartidor set r.estado = 'disponible' where d.id_pedido = NEW.id;

    end if;
end; //
delimiter ;