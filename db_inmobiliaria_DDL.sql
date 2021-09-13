
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

drop table if exists oficinas;
drop table if exists inmuebles;


-- ======= TABLA OFICINAS ===========

create table oficinas(
	
id int primary key,
nombre varchar(30) not null,
direccion varchar(40) not null,
telefono varchar(40) not null,
email varchar(40),
sitioWeb varchar(40)

);

-- ======= RESTRICCIONES TABLA OFICINAS ===========

alter table oficinas 
add constraint UNIQUE_oficinas_id
unique(id);

alter table oficinas 
add constraint UNIQUE_oficinas_direccion
unique(direccion);

alter table oficinas 
add constraint UNIQUE_oficinas_telefono
unique(telefono);





-- ======= TABLA INMUEBLES ===========

create table inmuebles(
	
id int primary key,
id_oficinas int not null,
descripcion varchar(40) not null,-- ej: semipiso de 3 Amb en Palermo
tipo varchar(20) not null, -- depto, casa, etc
direccion varchar(40) not null,-- San sarasa 123
ubicacion varchar(40) not null, -- zona:palermo, recoleta, etc
sitioWeb varchar(40)-- link de la pag de la descripcion

);


-- ======= TABLA INMUEBLES DESCRIPCION ===========

create table inmuebles_descripcion(
	
id int primary key,
id_inmuebles int not null,
superficie_total varchar(40) not null,-- ej: 92 m^2 Total
cantidad_ambientes char(3) not null, -- 1,2,3
cantidad_dormitorios char(3) not null,-- 1,2,3
cantidad_baños char(3) not null,-- 1,2,3
cochera char(3) ,-- si no tiene  0 o null
balcon char(3) ,-- si no tiene  0 o null
antiguedad char(4) not null, -- 20 años, etc


);



-- ======= TABLA INMUEBLES MEDIDAS ===========
-- Pueden no estar estipuladas

create table inmuebles_medidas(
	
id int primary key,
id_inmuebles int not null,
living_comedor varchar(40),-- ej: 8,05 x 3,4
cocina varchar(60), -- Cocina 1: 3,25 x 1,55
dormitorio/s varchar(100), -- Dormitorio 1: 23 x 2,9 | Dormitorio 2: 43 x 1,9
cocina/s varchar(100),
baño/s varchar(150), 
balcon varchar(60)



);




select * from pg_catalog.pg_tables 
where  schemaname != 'information_schema' 
and schemaname != 'pg_catalog';
 
 
 
 select * from oficinas;


