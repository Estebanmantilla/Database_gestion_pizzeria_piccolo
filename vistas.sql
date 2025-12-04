-- 1 Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).
create view vista_resumen_pedidos_cliente as
select c.id as id_cliente, pe.nombre as nombre_cliente, count(p.id) as cantidad_pedidos, sum(d.valor_venta) as total_gastado from persona pe left join cliente c on c.id = pe.id left join pedido p on c.id = p.id_cliente left join domicilio d on p.id = d.id_pedido group by c.id, pe.nombre;

-- 2 Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).
create view vista_desempeno_repartidores as
select r.id as id_repartidor, p.nombre as nombre_repartidor, r.zona, count(d.id) as numero_entregas, avg(timestampdiff(minute, d.hora_salida, d.hora_entrega)) as tiempo_promedio_min from repartidor r left join persona p on r.id = p.id left join domicilio d on r.id = d.id_repartidor group by r.id, p.nombre, r.zona;

-- 3 Vista de stock de ingredientes por debajo del mínimo permitido.
create view vista_stock_bajo as
select id, nombre, cantidad, minimo, (minimo - cantidad) as faltante from ingrediente where cantidad < minimo;