
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
drop table if exists oficinas;

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


-- ======= TABLA INMUEBLES DESCRIPCIONES ===========
-- Notar que 

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


select * from pg_catalog.pg_tables 
where  schemaname != 'information_schema' 
and schemaname != 'pg_catalog';
 
 
 
select * from oficinas;
select * from inmuebles;
select * from inmuebles_descripciones;
select * from inmuebles_medidas;


