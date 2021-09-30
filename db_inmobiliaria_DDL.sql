
/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DDL =============
 */

/*
https://www.tutorialesprogramacionya.com/postgresqlya/temarios/descripcion.php?inicio=0&cod=159&punto=1
*/

drop table if exists inmuebles cascade;
drop table if exists inmuebles_descripciones cascade;
drop table if exists inmuebles_medidas cascade;
drop table if exists facturas cascade;
drop table if exists ventas_compras cascade;
drop table if exists propietarios_inmuebles cascade;
drop table if exists administradores cascade; -- planeacion, organizacion, etc
drop table if exists gerentes cascade;-- metas y procedimientos, control administracion
drop table if exists vendedores cascade;-- ventas inmuebles, entrevistas, etc
drop table if exists compradores_clientes cascade;
drop table if exists compradores cascade;
drop table if exists clientes cascade;
drop table if exists empleados cascade;
drop table if exists oficinas cascade;

drop sequence if exists id_seq;



-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA OFICINAS ===========

create table oficinas(
	
id int primary key,
nombre varchar(30) not null,
direccion varchar(40) not null,
telefono varchar(40) not null,
email varchar(40),
sitio_web varchar(40)

);

-- ======= Restricciones Tabla Oficinas ===========

-- UNIQUE ID
alter table oficinas 
add constraint UNIQUE_oficinas_id
unique(id);

-- UNIQUE DIRECCION
alter table oficinas 
add constraint UNIQUE_oficinas_direccion
unique(direccion);

-- UNIQUE TELEFONO
alter table oficinas 
add constraint UNIQUE_oficinas_telefono
unique(telefono);

-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------

-- ======= TABLA PROPIETARIOS_INMUEBLES ===========


create table propietarios_inmuebles(

id int primary key,
nombre varchar(30) not null,
apellido varchar(30) not null,
edad int not null,
fecha_nacimiento date not null,
tipo_documento varchar(20) not null,
nro_documento varchar(20) not null,
direccion varchar(40) not null, 
telefono_principal varchar(40) not null,
telefono_secundario varchar(40),
email varchar(40)

);

-- ======= Restricciones Tabla propietarios_inmuebles ===========

-- UNIQUE ID
alter table propietarios_inmuebles 
add constraint UNIQUE_propietarios_inmuebles_id
unique(id);



-- UNIQUE NOMBRE/APELLIDO
alter table propietarios_inmuebles 
add constraint UNIQUE_propietarios_inmuebles_nombre_apellido
unique(nombre,apellido);


-- CHECK EDAD
alter table propietarios_inmuebles 
add constraint CHECK_propietarios_inmuebles_edad
check (edad >= 18);


-- CHECK FECHA_NACIMIENTO
alter table propietarios_inmuebles 
add constraint CHECK_propietarios_inmuebles_fecha_nacimiento
check (current_date > fecha_nacimiento);


--- UNIQUE NRO_DOCUMENTO
alter table propietarios_inmuebles 
add constraint UNIQUE_propietarios_inmuebles_nro_documento
unique(nro_documento);



-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA INMUEBLES DESCRIPCIONES ===========


create table inmuebles_descripciones(
	
id int primary key,
id_inmueble int not null,
superficie_total float(10) not null,-- ej: 92 m^2 Total.
cantidad_ambientes smallint not null, -- 1,2,3,etc | smallint-->2bytes, int-->4bytes |
cantidad_dormitorios smallint not null,-- 1,2,3
cantidad_baños smallint not null,-- 1,2,3
cantidad_patios_jardines smallint , -- patio casa, jardin piso/semipiso
cantidad_cocheras smallint ,-- si no tiene  0 o null
cantidad_balcones smallint ,-- si no tiene  0 o null
antiguedad smallint -- 20 años, etc

);


-- ======= Restricciones Tabla Inmuebles Descripción ===========

-- UNIQUE ID
alter table inmuebles_descripciones
add constraint UNIQUE_inmuebles_descripciones_id
unique(id);


-- CHECK SUPERFICIE_TOTAL
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_superficie_total
check (superficie_total > 0 );

-- CHECK CANTIDAD AMBIENTES
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_ambientes
check (cantidad_ambientes > 0 );

-- CHECK CANTIDAD DORMITORIOS
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_dormitorios
check (cantidad_dormitorios > 0 );

-- CHECK CANTIDAD BAÑOS
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_baños
check (cantidad_baños > 0 );

-- CHECK CANTIDAD PATIOS/JARDINES
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_patios_jardines
check (cantidad_patios_jardines >= 0 or cantidad_patios_jardines = null );

-- CHECK CANTIDAD COCHERAS
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_cocheras
check (cantidad_cocheras >= 0 or cantidad_cocheras = null ); -- Puede ser nulleable

-- CHECK CANTIDAD BALCONES
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_balcones
check (cantidad_balcones >= 0 or cantidad_balcones = null ); -- Puede ser nulleable

-- CHECK ANTIGUEDAD
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_antiguedad
check (antiguedad >= 0 or antiguedad = null ); -- Puede ser nulleable

-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES MEDIDAS ===========
-- Pueden no estar estipuladas

create table inmuebles_medidas(-- ALTO X ANCHO

id int primary key,
living_comedor varchar(100),-- ej: 8,05 x 3,4
cocina varchar(100), -- Cocina 1: 3,25 x 1,55
dormitorio varchar(100), -- Dormitorio 1: 23 x 2,9 | Dormitorio 2: 43 x 1,9
baño varchar(100),
patio_jardin varchar(100),
cochera varchar(50),
balcon varchar(50)

);


-- ======= Restricciones Tabla Inmuebles Medidas ===========

-- UNIQUE ID
alter table inmuebles_medidas
add constraint UNIQUE_inmuebles_medidas_id
unique(id);



-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES ===========

create table inmuebles(
	
id int primary key,
id_propietario_inmueble int not null,
id_inmueble_medidas int not null,
id_inmueble_descripcion int not null,
id_oficina int not null,
descripcion varchar(40) not null,-- ej: semipiso de 3 Amb en Palermo
tipo varchar(20) not null, -- depto, casa, etc
direccion varchar(40) not null,-- San sarasa 123
ubicacion varchar(40) not null, -- zona:palermo, recoleta, etc
sitioWeb varchar(40)-- link de la pag de la descripcion

);

-- ======= Restricciones Tabla Inmuebles ===========

-- UNIQUE ID
alter table inmuebles 
add constraint UNIQUE_inmuebles_id
unique(id);

-- UNIQUE ID_INMUEBLE_MEDIDAS
alter table inmuebles
add constraint UNIQUE_inmuebles_id_inmueble_medidas
unique(id_inmueble_medidas);


-- UNIQUE ID_INMUEBLE_DESCRIPCION
alter table inmuebles
add constraint UNIQUE_inmuebles_id_inmueble_descripcion
unique(id_inmueble_descripcion);



-- FK ID_INMUEBLES_MEDIDAS
alter table inmuebles
add constraint FK_inmuebles_id_inmueble_medidas
foreign key(id_inmueble_medidas)
references inmuebles_medidas(id);

-- FK ID_INMUEBLE_DESCRIPCIONES
alter table inmuebles
add constraint FK_inmuebles_id_inmueble_descripciones
foreign key(id_inmueble_descripcion)
references inmuebles_descripciones(id);

--FK ID_PROPIETARIO_INMUEBLE
alter table inmuebles 
add constraint FK_inmuebles_id_propietario_inmueble
foreign key(id_propietario_inmueble)
references propietarios_inmuebles(id);


--FK ID_OFICINA
alter table inmuebles 
add constraint FK_inmuebles_id_oficina
foreign key(id_oficina)
references oficinas(id);



-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

create table empleados(
	
id int primary key,
id_oficina int not null,
nombre varchar(30) not null,
apellido varchar(30) not null,
edad int not null,
fecha_nacimiento date not null,
tipo_documento varchar(20) not null,
nro_documento varchar(20) not null,
direccion varchar(40) not null, 
telefono_principal varchar(40) not null,
telefono_secundario varchar(40),
email varchar(40),
cargo varchar(40) not null,
antiguedad int,
fecha_ingreso date not null,
salario_anual float not null


);

-- ======= Restricciones Tabla Empleados ===========

-- UNIQUE ID
alter table empleados 
add constraint UNIQUE_empleados_id
unique(id);

-- FK ID_OFICINA
alter table empleados 
add constraint FK_empleados_id_oficina
foreign key(id_oficina)
references oficinas(id);


-- UNIQUE NOMBRE/APELLIDO
alter table empleados 
add constraint UNIQUE_empleados_nombre_apellido
unique(nombre,apellido);


-- CHECK EDAD
alter table empleados 
add constraint CHECK_empleados_edad
check (edad >= 18);

-- CHECK ANTIGUEDAD
alter table empleados 
add constraint CHECK_empleados_antiguedad
check (antiguedad >= 0 or antiguedad=null);

--- UNIQUE NRO_DOCUMENTO
alter table empleados 
add constraint UNIQUE_empleados_nro_documento
unique(nro_documento);


-- CHECK FECHA_NACIMIENTO Y FECHA_INGRESO
alter table empleados 
add constraint CHECK_empleados_fecha_nacimiento_ingreso
check (current_date > fecha_nacimiento and current_date >= fecha_ingreso );

-- CHECK SALARIO_ANUAL
alter table empleados 
add constraint CHECK_empleados_salario_anual
check (salario_anual > 300);



-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------


-- ======= TABLA ADMINISTRADORES ===========

create table administradores(
	
id int primary key,
id_empleado int not null,
tipo_inmueble varchar(20),-- casa, depto, etc
certificaciones varchar(50),-- administracion zonas residenciales, rurales, etc
experiencia varchar(30),-- bueno,alto,excelente
cualidades varchar(50)-- flexibilidad, confianza,etc

);

-- ======= Restricciones Tabla Administradores ===========

-- UNIQUE ID
alter table administradores 
add constraint UNIQUE_administradores_id
unique(id);

-- UNIQUE ID_EMPLEADO
alter table administradores 
add constraint UNIQUE_administradores_id_empleado
unique(id_empleado);

-- FK ID_EMPLEADO
alter table administradores
add constraint FK_administradores_id_empleado
foreign key(id_empleado)
references empleados(id);




-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA GERENTES ===========

create table gerentes(-- Cargo de Directores, etc
	
id int primary key,
id_empleado int not null,
titulo varchar(30) not null,
experiencia_laboral float not null, -- 1.2 años, etc
competencias varchar(50),-- planeamiento Estrategico, comunicacion efectiva, liderazgo, trabajo en equipo, orientacion a resultados,etc  
beneficios varchar(100),--Viajes, Horario flexible, home office,etc 
monto_adicional_anual float not null

);

-- ======= Restricciones Tabla Gerentes ===========

-- UNIQUE ID
alter table gerentes 
add constraint UNIQUE_gerentes_id
unique(id);

-- UNIQUE ID_EMPLEADO
alter table gerentes 
add constraint UNIQUE_gerentes_id_empleado
unique(id_empleado);

-- FK ID_EMPLEADO
alter table gerentes
add constraint FK_gerentes_id_empleado
foreign key(id_empleado)
references empleados(id);


-- CHECK EXPERIENCIA_LABORAL
alter table gerentes 
add constraint CHECK_gerentes_expericia_laboral
check ( experiencia_laboral >= 2);-- 2 años


-- CHECK MONTO_ADICIONAL
alter table gerentes
add constraint CHECK_gerentes_monto_adicional_anual
check ( monto_adicional_anual >= 100);-- 100 dolares




-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA VENDEDORES ===========

create table vendedores(
	
id int primary key,
id_empleado int not null,
cantidad_ventas int not null,
bonificacion_ventas float,
puntuacion_ventas varchar(20),-- buena, normal, excelente
orientacion_tipo_inmueble varchar(20),-- casa, depto, etc
cualidades varchar(50)-- flexibilidad, confianza,etc

);

-- ======= Restricciones Tabla Vendedores ===========

-- UNIQUE ID
alter table vendedores 
add constraint UNIQUE_vendedores_id
unique(id);

-- UNIQUE ID_EMPLEADO
alter table vendedores 
add constraint UNIQUE_vendedores_id_empleado
unique(id_empleado);

-- FK ID_EMPLEADO
alter table vendedores 
add constraint FK_vendedores_id_empleado
foreign key(id_empleado)
references empleados(id);


-- CHECK CANTIDAD_VENTAS
alter table vendedores 
add constraint CHECK_vendedores_cantidad_ventas
check ( cantidad_ventas >= 0);

-- CHECK BONIFICACION_VENTAS
alter table vendedores 
add constraint CHECK_vendedores_bonificacion_ventas
check ( bonificacion_ventas >= 0);


-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA CLIENTES ===========

create table clientes(
	
id int primary key,
nombre varchar(30) not null,
apellido varchar(30) not null,
edad int not null,
fecha_nacimiento date not null,
tipo_documento varchar(20) not null,
nro_documento varchar(20) not null,
direccion varchar(40) not null, 
telefono_principal varchar(40) not null,
telefono_secundario varchar(40),
email varchar(40),
fecha_alta date not null


);

-- ======= Restricciones Tabla Clientes ===========

-- UNIQUE ID
alter table clientes 
add constraint UNIQUE_clientes_id
unique(id);


-- UNIQUE NOMBRE/APELLIDO
alter table clientes 
add constraint UNIQUE_clientes_nombre_apellido
unique(nombre,apellido);


-- CHECK EDAD
alter table clientes 
add constraint CHECK_clientes_edad
check (edad >= 18);


--- UNIQUE NRO_DOCUMENTO
alter table clientes 
add constraint UNIQUE_clientes_nro_documento
unique(nro_documento);


-- CHECK FECHA_NACIMIENTO Y FECHA_ALTA
alter table clientes 
add constraint CHECK_clientes_fecha_nacimiento_alta
check (current_date > fecha_nacimiento and current_date >= fecha_alta );



-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA COMPRADORES ===========

create table compradores(
	
id int primary key ,
cantidad_inmuebles_comprados int not null,
importe_maximo_por_compra float not null,
importe_total_compra float not null,
beneficios_compras varchar(60) not null,
descuento_cliente float not null
);

-- ======= Restricciones Tabla Compradores ===========

-- ID AUTO_INCREMENT
CREATE SEQUENCE id_seq;
ALTER TABLE compradores ALTER id SET DEFAULT NEXTVAL('id_seq');

-- UNIQUE ID
alter table compradores
add constraint UNIQUE_compradores_id
unique(id);


-- CHECK CANTIDAD_INMUEBLES_COMPRADOS
alter table compradores 
add constraint CHECK_compradores_cantidad_inmuebles_comprados
check ( cantidad_inmuebles_comprados > 0);

-- CHECK IMPORTE_MAXIMO_POR_COMPRA
alter table compradores
add constraint CHECK_compradores_importe_maximo_por_compra
check ( importe_maximo_por_compra > 0);


-- CHECK IMPORTE_TOTAL_COMPRA
alter table compradores
add constraint CHECK_compradores_importe_total_compra
check ( importe_total_compra > 0);



-- CHECK DESCUENTO_CLIENTE
alter table compradores
add constraint CHECK_compradores_descuento_cliente
check ( descuento_cliente >= 0);





-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA COMPRADORES_CLIENTES ===========

create table compradores_clientes(
	
id int primary key,
id_cliente int ,
id_comprador int 

);

-- ======= Restricciones Tabla compradores_clientes ===========

-- UNIQUE ID
alter table compradores_clientes
add constraint UNIQUE_compradores_clientes_id
unique(id);

-- UNIQUE ID_CLIENTE
alter table compradores_clientes
add constraint UNIQUE_compradores_clientes_id_cliente
unique(id_cliente);


-- UNIQUE ID_CLIENTE
alter table compradores_clientes
add constraint UNIQUE_compradores_clientes_id_comprador
unique(id_comprador);


-- FK ID_CLIENTE
alter table compradores_clientes
add constraint FK_compradores_clientes_id_cliente
foreign key(id_cliente)
references clientes(id);



-- FK ID_COMPRADOR
alter table compradores_clientes 
add constraint FK_compradores_clientes_id_ccomprador
foreign key(id_comprador)
references compradores(id);

-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA VENTAS_COMPRAS ===========

create table ventas_compras(
	
id int primary key,
id_vendedor int not null,
id_comprador int not null,
id_inmueble int not null,
fecha_venta timestamp not null

);

-- ======= Restricciones Tabla ventas_compras ===========

-- UNIQUE ID
alter table ventas_compras
add constraint UNIQUE_ventas_compras_id
unique(id);

-- FK ID_VENDEDOR
alter table ventas_compras 
add constraint FK_ventas_compras_id_vendedor
foreign key(id_vendedor)
references vendedores(id);

-- FK ID_COMPRADOR
alter table ventas_compras 
add constraint FK_ventas_compras_id_comprador
foreign key(id_comprador)
references compradores(id);

-- FK ID_INMUEBLE
alter table ventas_compras 
add constraint FK_ventas_compras_id_inmuebles
foreign key(id_inmueble)
references inmuebles(id);


-- CHECK FECHA_VENTA
alter table ventas_compras 
add constraint CHECK_ventas_compras_fecha_venta
check (fecha_venta >= current_date );


-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------

-- Los enumerados deben estar declarados fuera de la creacion de tabla 

drop type if exists tipoFactura;
drop type if exists tipoPago;

create type tipoFactura as enum('A','B','C','D');
create type tipoPago as enum('EFECTIVO','CHEQUE','TARJETA');



-- ======= TABLA FACTURAS ===========

create table facturas(
	
id int primary key,
id_venta_compra int not null,
tipo tipoFactura not null,
nro_factura int not null,
fecha_emision timestamp not null,
cantidad_inmuebles int not null,
descripcion_factura varchar(60) not null,-- venta departamento inscripto en la partida N° 14567..
precio_unitario float not null,
valor_venta float not null,-- iva + extra + etc
total_venta float not null, -- + impuestos + costos + etc
medioDePago tipoPago not null,
descripcion_pago varchar(40) not null

);

-- ======= Restricciones Tabla Facturas ===========

-- UNIQUE ID
alter table facturas 
add constraint UNIQUE_facturas_id
unique(id);

-- FK ID_VENTA_COMPRA
alter table facturas 
add constraint FK_facturas_id_venta_compra
foreign key(id_venta_compra)
references ventas_compras(id);

-- UNIQUE NRO_FACTURA 
alter table facturas 
add constraint UNIQUE_nro_factura
unique(nro_factura);

-- CHECK FECHA_EMISION
alter table facturas 
add constraint CHECK_facturas_fecha_emision
check (fecha_emision >= current_date );

-- CHECK CANTIDAD_INMUEBLES
alter table facturas
add constraint CHECK_facturas_cantidad_inmuebles
check (cantidad_inmuebles > 0);

-- CHECK PRECIO_UNITARIO
alter table facturas
add constraint CHECK_facturas_precio_unitario
check( precio_unitario < total_venta and precio_unitario > 0);

-- CHECK VALOR_VENTA
alter table facturas
add constraint CHECK_facturas_valor_venta
check ( valor_venta < total_venta and valor_venta > 0);

-- CHECK TOTAL_VENTA
alter table facturas
add constraint CHECK_facturas_total_venta
check ( total_venta > precio_unitario and total_venta > 0);


-- ---------------------------------------------------------------------------




-- ---------------------------------------------------------------------------



select * from pg_catalog.pg_tables 
where  schemaname != 'information_schema' 
and schemaname != 'pg_catalog';
 
 
 
select * from oficinas;
select * from inmuebles;
select * from inmuebles_descripciones;
select * from inmuebles_medidas;
select * from propietarios_inmuebles;
select * from empleados;
select * from clientes;
select * from administradores;
select * from gerentes;
select * from vendedores;
select * from compradores;
select * from compradores_clientes;
select * from ventas_compras;
select * from facturas;







