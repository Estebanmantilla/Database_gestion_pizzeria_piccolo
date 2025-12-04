-- 1 Clientes con pedidos entre dos fechas (BETWEEN).
select c.* from cliente c left join pedido p on c.id = p.id_cliente where p.fecha between '2025-12-03' and '2025-12-09';

-- 2 Pizzas más vendidas (GROUP BY y COUNT) 
select p.nombre, count(pp.id_pizza) as total_vendidas from pizza p left join pizza_pedido pp on p.id = pp.id_pizza group by p.id, p.nombre order by total_vendidas desc;


-- 3 Pedidos por repartidor (JOIN).
select p.nombre as repartidor, count(d.id_pedido) AS total_pedidos from persona p left join repartidor on r.id = p.id =left join domicilio d on r.id = d.id_repartidor group by r.id, r.nombre order by total_pedidos desc; 


-- 4 Promedio de entrega por zona (AVG y JOIN).

select d.zona, avg(timestampdiff(minute, p.hora_salida, p.hora_entrega)) as promedio_minutos from domicilio d left join pedido p on d.id_pedido = p.id where p.hora_entrega is not null group by d.zona;

-- 5 Clientes que gastaron más de un monto (HAVING).

select c.id,pe.nombre, sum(d.valor_venta) as total_gastado from persona pe left join cliente c on c.id = pe.id left join pedido p on p.id_cliente = c.id left join domicilio d on d.id_pedido = p.id group by c.id, pe.nombre having total_gastado > 50000; 

-- 6 Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
select * from pizza where nombre like '%pep%';

-- 7 Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales).
select id from cliente where numero_pedidos > 5;