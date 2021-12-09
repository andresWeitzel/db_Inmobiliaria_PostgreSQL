
/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DDL LOGS FUNCTIONS =============
 */

drop table if exists logs_inserts cascade;
drop table if exists logs_updates cascade;
drop table if exists logs_deletes cascade;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- Módulo de PostgreSql para uuid
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";



-- ======= TABLA LOGS INSERTS ===========

create table logs_inserts(


	id 					int 		 primary key,
	id_registro			int 		 not null,
	uuid_registro 		uuid 		 default 	uuid_generate_v4 (),-- 32 digitos hex
	nombre_tabla		varchar(30)  not null,
	accion				varchar(30)  not null,
	fecha				date		 default	 current_date,
	hora 				time		 default	 current_time,
	usuario				varchar(50)	 not null,
	rol_nivel			varchar(50),
	motor_db			varchar(50)

);



-- ======= TABLA LOGS UPDATES ===========

create table logs_updates(


	id 					int 		 primary key,
	id_registro			int 		 not null,
	uuid_registro 		uuid 		 default 	uuid_generate_v4 (),-- 32 digitos hex
	nombre_tabla		varchar(30)  not null,
	campo_tabla			varchar(50)	 not null,
	accion				varchar(30)  not null,
	fecha				date		 default	 current_date,
	hora 				time		 default	 current_time,
	usuario				varchar(50)	 not null,
	rol_nivel			varchar(50),
	motor_db			varchar(50)

);


-- ======= TABLA LOGS DELETES ===========

create table logs_deletes(


	id 					int 		 primary key,
	id_registro			int 		 not null,
	uuid_registro 		uuid 		 default 	uuid_generate_v4 (),-- 32 digitos hex
	nombre_tabla		varchar(30)  not null,
	accion				varchar(30)  not null,
	fecha				date		 default	 current_date,
	hora 				time		 default	 current_time,
	usuario				varchar(50)	 not null,
	rol_nivel			varchar(50),
	motor_db			varchar(50)

);




-- ======== TODOS LOS ID´S PK DE LAS TABLAS COMO AUTO_INCREMENT =======

alter table logs_inserts alter id set default nextval('id_secuencia');
alter table logs_updates alter id set default nextval('id_secuencia');
alter table logs_deletes alter id set default nextval('id_secuencia');

