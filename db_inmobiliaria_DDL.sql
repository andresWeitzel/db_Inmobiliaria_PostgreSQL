
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


drop table if exists inmuebles_descripciones;
drop table if exists inmuebles_medidas;
drop table if exists inmuebles;
drop table if exists administracion; -- planeacion, organizacion, etc
drop table if exists gerencia;-- metas y procedimientos, control administracion
drop table if exists vendedores;-- ventas inmuebles, entrevistas, etc
drop table if exists empleados;
drop table if exists oficinas;


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

-- ======= TABLA INMUEBLES ===========

create table inmuebles(
	
id int primary key,
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

--FK ID_OFICINA
alter table inmuebles 
add constraint FK_inmuebles_id_oficina
foreign key(id_oficina)
references oficinas(id);

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

-- FK ID_INMUEBLE
alter table inmuebles_descripciones
add constraint FK_inmuebles_descripciones_id_inmueble
foreign key(id_inmueble)
references inmuebles(id);

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
id_inmueble int not null,
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

-- FK ID_INMUEBLES
alter table inmuebles_medidas
add constraint FK_inmuebles_medidas_id_inmueble
foreign key(id_inmueble)
references inmuebles(id);

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
nro_documento varchar(20) not null,
direccion varchar(40) not null, 
telefono varchar(40) not null,
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


-- ======= TABLA ADMINISTRACION ===========

create table administracion(
	
id int primary key,
id_empleado int not null,
tipo_inmueble varchar(20),-- casa, depto, etc
certificaciones varchar(50),-- administracion zonas residenciales, rurales, etc
experiencia varchar(30),-- bueno,alto,excelente
cualidades varchar(50)-- flexibilidad, confianza,etc

);

-- ======= Restricciones Tabla Administracion ===========

-- UNIQUE ID
alter table administracion 
add constraint UNIQUE_administracion_id
unique(id);

-- FK ID_EMPLEADO
alter table administracion 
add constraint FK_administracion_id_empleado
foreign key(id_empleado)
references empleados(id);




-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA GERENCIA ===========

create table gerencia(-- Cargo de Directores, etc
	
id int primary key,
id_empleado int not null,
titulo varchar(30) not null,
experiencia_laboral float not null, -- 1.2 años, etc
competencias varchar(50),-- planeamiento Estrategico, comunicacion efectiva, liderazgo, trabajo en equipo, orientacion a resultados,etc  
beneficios varchar(100),--Viajes, Horario flexible, home office,etc 
monto_adicional_anual float not null

);

-- ======= Restricciones Tabla Gerencia ===========

-- UNIQUE ID
alter table gerencia 
add constraint UNIQUE_gerencia_id
unique(id);

-- FK ID_EMPLEADO
alter table gerencia 
add constraint FK_gerencia_id_empleado
foreign key(id_empleado)
references empleados(id);


-- CHECK EXPERIENCIA_LABORAL
alter table gerencia 
add constraint CHECK_gerencia_expericia_laboral
check ( experiencia_laboral >= 2);-- 2 años


-- CHECK MONTO_ADICIONAL
alter table gerencia 
add constraint CHECK_gerencia_monto_adicional_anual
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



select * from pg_catalog.pg_tables 
where  schemaname != 'information_schema' 
and schemaname != 'pg_catalog';
 
 
 
select * from oficinas;
select * from inmuebles;
select * from inmuebles_descripciones;
select * from inmuebles_medidas;
select * from empleados;
select * from administracion;
select * from gerencia;
select * from vendedores;


