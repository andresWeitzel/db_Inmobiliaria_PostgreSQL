
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
	usuario				varchar(50)	 default 	 current_user, -- lo mismo que current_role
	usuario_sesion		varchar(50)	 default 	 session_user,
	db					varchar(50)  default 	 current_catalog,
	db_version			varchar(100) default 	 version()

);                                                 


-- ======= Restricciones Tabla logs_inserts ===========

-- UNIQUE ID
alter table logs_inserts
add constraint UNIQUE_logs_inserts_id
unique(id);

-- UNIQUE ID_REGISTRO
alter table logs_inserts 
add constraint UNIQUE_logs_inserts_id_registro
unique(id_registro);


-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------


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
	usuario				varchar(50)	 default 	 current_user, -- lo mismo que current_role
	usuario_sesion		varchar(50)	 default 	 session_user,
	db					varchar(50)  default 	 current_catalog,
	db_version			varchar(100) default 	 version()

);


-- ======= Restricciones Tabla logs_updates ===========

-- UNIQUE ID
alter table logs_updates
add constraint UNIQUE_logs_updates_id
unique(id);

-- UNIQUE ID_REGISTRO
alter table logs_updates 
add constraint UNIQUE_logs_updates_id_registro
unique(id_registro);

-- ---------------------------------------------------------------------------




-- ---------------------------------------------------------------------------



-- ======= TABLA LOGS DELETES ===========

create table logs_deletes(


	id 					int 		 primary key,
	id_registro			int 		 not null,
	uuid_registro 		uuid 		 default 	uuid_generate_v4 (),-- 32 digitos hex
	nombre_tabla		varchar(30)  not null,
	campo_tabla			varchar(50)	 not null,
	accion				varchar(30)  not null,
	fecha				date		 default	 current_date,
	hora 				time		 default	 current_time,
	usuario				varchar(50)	 default 	 current_user, -- lo mismo que current_role
	usuario_sesion		varchar(50)	 default 	 session_user,
	db					varchar(50)  default 	 current_catalog,
	db_version			varchar(100) default 	 version()

);

-- ======= Restricciones Tabla logs_deletes ===========

-- UNIQUE ID
alter table logs_deletes
add constraint UNIQUE_logs_deletes_id
unique(id);

-- UNIQUE ID_REGISTRO
alter table logs_deletes 
add constraint UNIQUE_logs_deletes_id_registro
unique(id_registro);


-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------




-- ======== TODOS LOS ID´S PK DE LAS TABLAS COMO AUTO_INCREMENT =======

alter table logs_inserts alter id set default nextval('id_secuencia');
alter table logs_updates alter id set default nextval('id_secuencia');
alter table logs_deletes alter id set default nextval('id_secuencia');

