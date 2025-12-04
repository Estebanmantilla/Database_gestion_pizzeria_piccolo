-- creacion base de datos
create database pizzeria_piccolo;
use pizzeria_piccolo;
-- creacion de tablas
create table persona (
id int auto_increment primary key,
nombre varchar(50) not null,
telefono varchar(10) not null
);

create table cliente (
id int primary key,
direccion varchar(50) not null,
correo varchar(50) not null,
numero_pedidos int,
foreign key (id) references persona (id) on delete cascade on update cascade
);

create table repartidor (
id int primary key,
zona varchar(50) not null,
estado enum('disponible','no disponible'),
foreign key (id) references persona (id) on delete cascade on update cascade
);

create table pedido (
id int auto_increment primary key,
id_cliente int,
fecha datetime ,
cantidad_pizza_cla int ,
metodo_pa enum('efectivo','tarjeta','app') not null,
estado enum('pendiente','en preparacion','entregado','cancelado') not null,
cantidad_pizza_esp int ,
total int not null default 0
);

create table domicilio (
id int auto_increment primary key,
id_pedido int ,
id_repartidor int ,
hora_salida datetime not null,
hora_entrega datetime not null,
distancia_aprox varchar(50) not null,
valor int not null,
foreign key (id_pedido) references pedido (id),
foreign key (id_repartidor) references repartidor (id)
);


create table pizza (
id int auto_increment primary key,
nombre varchar(50) not null,
size enum('small','mediana','grande'),
tipo enum ('clasica','especial','vegetariana'),
precio int not null 
);

create table pizza_pedido(
id int auto_increment primary key,
id_pedido int ,
id_pizza int ,
foreign key (id_pedido) references pedido (id),
foreign key (id_pizza) references pizza (id)
);


create table ingrediente (
id int auto_increment primary key,
nombre varchar(50) not null,
cantidad int not null,
disponibilidad varchar(50) not null
);

create table pizza_ingre(
id int auto_increment primary key,
id_pizza int,
id_ingrediente int,
foreign key (id_pizza) references pizza (id),
foreign key (id_ingrediente) references ingrediente (id)
);

-- insercciones en tablas 
INSERT INTO persona (nombre, telefono) VALUES
('Carlos Gomez', '3001111111'),
('Ana Torres', '3002222222'),
('Luis Ramirez', '3003333333'),
('Maria Lopez', '3004444444'),
('Javier Ortiz', '3005555555'),

('Pedro Castro', '3006666666'),
('Laura Diaz', '3007777777'),
('Santiago Arias', '3008888888'),
('Daniela Ruiz', '3009999999'),
('Felipe Morales', '3001010101');

INSERT INTO pizza (nombre, size, tipo, precio) VALUES
('Margarita', 'mediana', 'clasica', 20000),
('Pepperoni', 'grande', 'clasica', 20000),
('Hawaiana', 'small', 'clasica', 20000),

('Mexicana', 'mediana', 'especial', 25000),
('BBQ Pollo', 'grande', 'especial', 25000),
('Cuatro Quesos', 'small', 'especial', 25000),

('Veggie Mix', 'mediana', 'vegetariana', 20000),
('Champiñón Lovers', 'grande', 'vegetariana', 20000),
('Pesto Green', 'small', 'vegetariana', 20000);

INSERT INTO ingrediente (nombre, cantidad, disponibilidad) VALUES
('Queso', 50, 'Disponible'),
('Tomate', 40, 'Disponible'),
('Pepperoni', 30, 'Disponible'),
('Piña', 20, 'Disponible'),
('Pollo', 25, 'Disponible'),
('Champiñón', 35, 'Disponible'),
('Cebolla', 45, 'Disponible'),
('Pimentón', 30, 'Disponible'),
('Aceitunas', 15, 'Disponible'),
('Pesto', 10, 'Disponible');

INSERT INTO cliente (id, direccion, correo, numero_pedidos) VALUES
(1, 'Calle 10 #1-20', 'carlos@mail.com', 2),
(2, 'Calle 11 #2-21', 'ana@mail.com', 3),
(3, 'Calle 12 #3-22', 'luis@mail.com', 1),
(4, 'Calle 13 #4-23', 'maria@mail.com', 4),
(5, 'Calle 14 #5-24', 'javier@mail.com', 5);

INSERT INTO repartidor (id, zona, estado) VALUES
(6, 'Norte', 'disponible'),
(7, 'Sur', 'disponible'),
(8, 'Centro', 'no disponible'),
(9, 'Occidente', 'disponible'),
(10, 'Oriente', 'no disponible');

INSERT INTO pedido (id_cliente, fecha, cantidad_pizza_cla, metodo_pa, estado, cantidad_pizza_esp, total) VALUES
(1, NOW(), 1, 'efectivo', 'pendiente', 1, 45000),
(2, NOW(), 2, 'tarjeta', 'en preparacion', 0, 40000),
(3, NOW(), 0, 'app', 'pendiente', 2, 50000),
(4, NOW(), 1, 'efectivo', 'entregado', 1, 45000),
(5, NOW(), 3, 'tarjeta', 'pendiente', 0, 60000);

INSERT INTO pizza_pedido (id_pedido, id_pizza) VALUES
(1, 1),
(1, 4),
(2, 2),
(2, 1),
(3, 5),
(3, 6),
(4, 3),
(4, 5),
(5, 1),
(5, 2),
(5, 3);

INSERT INTO domicilio (id_pedido, id_repartidor, hora_salida, hora_entrega, distancia_aprox, valor) VALUES
(1, 6, NOW(), NOW() + interval 1 hour, '2 km', 5000),
(2, 7, NOW(), NOW() + interval 1 hour, '3 km', 6000),
(3, 8, NOW(), NOW() + interval 1 hour, '1.5 km', 4500),
(4, 9, NOW(), NOW() + interval 1 hour, '4 km', 7000),
(5, 10, NOW(), NOW() + interval 1 hour, '2.5 km', 5500);

INSERT INTO pizza_ingre (id_pizza, id_ingrediente) VALUES
-- Clásicas
(1, 1),
(1, 2),
(2, 1),
(2, 3), 
(3, 1),
(3, 4),

-- Especiales
(4, 1),
(4, 5),
(5, 1),
(5, 6),
(6, 1),
(6, 9),

-- Vegetarianas
(7, 1),
(7, 7),
(8, 1),
(8, 6),
(8, 7),
(9, 10);


ALTER TABLE ingrediente
ADD costo INT NOT NULL DEFAULT 0;

UPDATE ingrediente SET costo = 2500 WHERE nombre = 'Queso';
UPDATE ingrediente SET costo = 500  WHERE nombre = 'Tomate';
UPDATE ingrediente SET costo = 1800 WHERE nombre = 'Pepperoni';
UPDATE ingrediente SET costo = 700  WHERE nombre = 'Piña';
UPDATE ingrediente SET costo = 1500 WHERE nombre = 'Pollo';
UPDATE ingrediente SET costo = 1200 WHERE nombre = 'Champiñón';
UPDATE ingrediente SET costo = 400  WHERE nombre = 'Cebolla';
UPDATE ingrediente SET costo = 600  WHERE nombre = 'Pimentón';
UPDATE ingrediente SET costo = 1000 WHERE nombre = 'Aceitunas';
UPDATE ingrediente SET costo = 2000 WHERE nombre = 'Pesto';

ALTER TABLE domicilio ADD valor_venta DOUBLE;

UPDATE domicilio
SET valor_venta = total_pedido(id);


create table auditoria (
    id int auto_increment primary key,
    nombre_pizza varchar(50),
    precio_anterior int,
    precio_nuevo int,
    fecha_cambio datetime
);

ALTER TABLE ingrediente
ADD COLUMN minimo INT NOT NULL DEFAULT 5;


ALTER TABLE pizza_pedido
ADD COLUMN cantidad INT DEFAULT 1;