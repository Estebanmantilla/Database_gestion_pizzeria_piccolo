# 📌 Proyecto Base de Datos - Pizzería Piccolo

Este proyecto implementa la base de datos para la Pizzería Piccolo, incluyendo su modelo relacional, tablas, relaciones, triggers, vistas y consultas SQL para la gestión de clientes, pedidos, repartidores, pizzas e inventario.

---

## 🧱 1. Descripción del Proyecto

La base de datos permite administrar:

- Registro de clientes.
- Gestión de pedidos y domicilios.
- Control de repartidores.
- Gestión de pizzas e ingredientes.
- Auditoría de precios.
- Informes mediante **vistas** y **consultas SQL**.

Incluye ejemplos de **JOIN, GROUP BY, HAVING, LIKE, AVG, COUNT, subconsultas**, y más.

---

## 🗂️ 2. Tablas y Relaciones

### 🔹 Tabla `persona`
Contiene información general de cualquier persona (clientes, repartidores, empleados).

| Campo | Descripción |
|-------|-------------|
| id | PK |
| nombre | Nombre |
| telefono | Teléfono |
| direccion | Dirección |

---

### 🔹 Tabla `cliente`
Extiende persona (herencia).

| Campo | Relación |
|-------|----------|
| id | FK → persona.id |

---

### 🔹 Tabla `repartidor`
También hereda de persona.

| Campo | Relación |
|-------|----------|
| id | FK → persona.id |
| disponibilidad | Estado del repartidor |

---

### 🔹 Tabla `pizza`
| Campo | Descripción |
|-------|-------------|
| id | PK |
| nombre | Nombre de la pizza |
| precio | Precio |

---

### 🔹 Tabla `pedido`
| Campo | Relación |
|-------|----------|
| id | PK |
| id_cliente | FK → cliente.id |
| fecha | Fecha del pedido |
| total | Total del pedido |

---

### 🔹 Tabla `detalle_pedido`
| Campo | Relación |
|-------|----------|
| id | PK |
| id_pedido | FK → pedido.id |
| id_pizza | FK → pizza.id |
| cantidad | Cantidad ordenada |

---

### 🔹 Tabla `domicilio`
| Campo | Relación |
|-------|----------|
| id | PK |
| id_pedido | FK → pedido.id |
| id_repartidor | FK → repartidor.id |
| hora_salida | Hora |
| hora_entrega | Hora |
| zona | Zona de entrega |

---

## 📊 3. Ejemplos de Consultas SQL

### ✔ Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
```sql
select * from pizza where nombre like '%pep%';
```

## 4. instrucciones para ejecutar el scrip

- ejecutar el codigo que se encuentra en el archivo database.sql para la creacion de la abse de datos y su estructura.
- ejecutar el codigo en funciones.sql
- ejecutar el codigo en triggers.sql
- ejecutar el codigo en consutas.sql
- ejecutar el codigo en vistas.sql
