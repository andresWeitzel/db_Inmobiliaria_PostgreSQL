/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML INSERTS FUNCTIONS=============
 */




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =================================
-- ======= TABLA OFICINAS ===========
-- ==================================

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';




-- =======================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA OFICINAS -------
-- =======================================================================

create or replace function listado_oficinas() returns setof oficinas as $$

declare

	registro_actual_oficinas RECORD;

begin 
	
	for registro_actual_oficinas in (select * from oficinas) loop
	
		return next registro_actual_oficinas;-- Por cada iteracion se guarda el registro completo
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;


-- https://www.postgresqltutorial.com/postgresql-uuid/
-- https://www.palomargc.com/posts/Introducci%C3%B3n-a-la-administraci%C3%B3n-de-PostgreSQL/


-- -----------------------------------------------------------------------------
-- --------------------------------------------------------------------------------

-- =======================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA LOGS_INSERTS -------
-- =======================================================================

create or replace function listado_logs_inserts() returns setof logs_inserts as $$

declare

	registro_actual_logs_inserts RECORD;

begin 
	
	for registro_actual_logs_inserts in (select * from logs_inserts) loop
	
		return next registro_actual_logs_inserts;-- Por cada iteracion se guarda el registro completo
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;

-- --------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------
/*
-- =======================================================================
-- ----------- SELECT DE ALGUNOS REGISTROS DE LA TABLA OFICINAS -------
-- =======================================================================  

create or replace function listado_oficinas( out id int, out nombre varchar , out direccion varchar, out nro_telefono varchar
, out email varchar) returns setof RECORD as $$

declare

	registro_actual RECORD;
	

begin 
	
	for registro_actual in (select * from oficinas) loop
	
		id 				:= registro_actual.id;
		nombre			:= registro_actual.nombre;
		direccion 		:= registro_actual.direccion;
		nro_telefono	:= registro_actual.nro_telefono;
		email			:= registro_actual.email;
		
		return next;-- Por cada iteracion se guarda el registro completo
	end loop;
	return;
	
end;

	
$$ language plpgsql;

*/




-- ---------------------------------------------------------------------
-- --------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA OFICINAS ------------
-- =======================================================================

select * from oficinas ;


create or replace function insertar_registro_oficinas(

nombre_input varchar, dir_input varchar, nro_tel_input varchar, email_input varchar

) returns void as $$



declare


-- TABLA OFICINAS

-- Comprobamos que exista un id y cual es el ultimo
id_last_of_check boolean;
id_last_of int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
 nombre_of_check boolean := exists(select nombre from oficinas where nombre = nombre_input);
 direccion_of_check boolean := exists(select direccion from oficinas where direccion = dir_input);



-- TABLA LOGS_INSERTS

uuid_registro_of uuid;
nombre_tabla_of varchar := 'oficinas';
accion_of varchar := 'insert';
fecha_of date ;
hora_of time ;
usuario_of varchar;
usuario_sesion_of varchar;
db_of varchar;
db_version_of varchar;



begin

	if(
	(nombre_of_check = true) or (direccion_of_check = true)
	
	) then
	
		raise exception '===== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ===== '
						using hint=	    '------- REVISAR NOMBRE Y DIRECCION DE LA OFICINA -------';
										
									
	
	elsif (
		
		((nombre_of_check = false) and (direccion_of_check = false))
		and (nombre_input <> '') 
		and (dir_input <> '') 
		and (nro_tel_input <> '') 
		and (email_input <> '')
		
		) then
	
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "oficinas" --';
		raise notice '----------------------------------------------';
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into oficinas(nombre, direccion, nro_telefono, email) values 
		(nombre_input , dir_input , nro_tel_input , email_input);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		
	
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_of_check := exists(select id from oficinas);
	
		-- Comprobacion id
		if (id_last_of_check = true) then
			
			id_last_of := (select max(id) from oficinas);
		
		else 
			
			id_last_of := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';
	
		raise notice 'ID : %' , id_last_of;
		raise notice 'Nombre : %', nombre_input;
		raise notice 'Dirección : %', dir_input;
		raise notice 'Nro Telefono : %', nro_tel_input;
		raise notice 'Email : %', email_input;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	
	
	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_of , nombre_tabla_of, accion_of);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts where id_registro = id_last_of);
		fecha_of := (select fecha from logs_inserts where id_registro = id_last_of);
		hora_of := (select hora from logs_inserts where id_registro = id_last_of);
		usuario_of := (select usuario from logs_inserts where id_registro = id_last_of);
		usuario_sesion_of := (select usuario_sesion from logs_inserts where id_registro = id_last_of);	
		db_of := (select db from logs_inserts where id_registro = id_last_of);
	 	db_version_of := (select db_version from logs_inserts where id_registro = id_last_of);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_of;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Acción : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesión de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versión DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	


	else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_oficinas() ====='
						using hint = '------- insertar_registros_oficinas(nombre varchar, direccion varchar, nro_telefono varchar, email varchar); ------- ';
		
	end if;
	

end;
	
$$ language plpgsql;

-- ----------------------------------------------------------------------------


-- ---------------------------------------------------------------------------



-- =======================================================================
-- ----------- INSERCION DE 2 REGISTROS TABLA OFICINAS ------------
-- =======================================================================


create or replace function insertar_registros_oficinas(

nombre_input_01 varchar, dir_input_01 varchar, nro_tel_input_01 varchar, email_input_01 varchar
,nombre_input_02 varchar, dir_input_02 varchar, nro_tel_input_02 varchar, email_input_02 varchar

) returns void as $$

declare

-- TABLA OFICINAS

-- Comprobamos que exista un id y cual es el ultimo
id_last_of_check boolean;
id_last_of int;


-- Nos aseguramos que no se inserten registros repetidos en la db ademas del check de la db
 nombre_of_check_01 boolean := exists(select nombre from oficinas where nombre = nombre_input_01);
 nombre_of_check_02 boolean := exists(select nombre from oficinas where nombre = nombre_input_02);

 direccion_of_check_01 boolean := exists(select direccion from oficinas where direccion = dir_input_01);
 direccion_of_check_02 boolean := exists(select direccion from oficinas where direccion = dir_input_02);





-- TABLA LOGS_INSERTS

uuid_registro_of uuid;
nombre_tabla_of varchar := 'oficinas';
accion_of varchar := 'insert';
fecha_of date ;
hora_of time ;
usuario_of varchar;
usuario_sesion_of varchar;
db_of varchar;
db_version_of varchar;



							
			

begin
	
	if(
		((nombre_of_check_01 = true) and (direccion_of_check_01 = true))
		or 
		((nombre_of_check_02 = true) and (direccion_of_check_02 = true))
		or 
		(dir_input_01 = dir_input_02)
	
	) then
	
				raise exception '===== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ===== '
						using hint=	    '------- REVISAR NOMBRES Y DIRECCIONES DE LA OFICINA -------';
					
	
	elsif ( 
		(direccion_of_check_01 = false) and (direccion_of_check_02 = false)
		and 
		((nombre_input_01 <> '') and (dir_input_01 <> '') and (nro_tel_input_01 <> '') and (email_input_01 <> ''))
		and 
		((nombre_input_02 <> '') and (dir_input_02 <> '') and (nro_tel_input_02 <> '') and (email_input_02 <> ''))
		
		) then
		
		
		
		-- ================================================================
		-- ===================== PRIMER REGISTRO =========================
		-- ================================================================
		
		
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA OFICINAS 1ER REGISTRO -------------------------------
		
		
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de 2 Registros Tabla "oficinas" --';
		raise notice '----------------------------------------------';
	
		--------------------------------------- INSERCION 1ER REGISTRO ----------------------------------------
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input_01 , dir_input_01 , nro_tel_input_01 , email_input_01);
	
		--------------------------------------- FIN INSERCION 1ER REGISTRO ----------------------------------------
	

		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_of_check := exists(select id from oficinas);
	
		-- Comprobacion id
		if (id_last_of_check = true) then
			
			id_last_of := (select max(id) from oficinas);
		
		else 
			id_last_of := 0;
			
		end if;

	
		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción Tabla "oficinas" Número 1--';
		raise notice '';
		raise notice 'Id : %', id_last_of;
		raise notice 'Nombre : %', nombre_input_01;
		raise notice 'Dirección : %', dir_input_01;
		raise notice 'Nro Telefono : %', nro_tel_input_01;
		raise notice 'Email : %', email_input_01;

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';
	
		
		-- ------------------------- FIN TABLA OFICINAS 1ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 1ER REGISTRO -------------------------------
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_of , nombre_tabla_of, accion_of);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts where id_registro = id_last_of);
		fecha_of := (select fecha from logs_inserts where id_registro = id_last_of);
		hora_of := (select hora from logs_inserts where id_registro = id_last_of);
		usuario_of := (select usuario from logs_inserts where id_registro = id_last_of);
		usuario_sesion_of := (select usuario_sesion from logs_inserts where id_registro = id_last_of);	
		db_of := (select db from logs_inserts where id_registro = id_last_of);
	 	db_version_of := (select db_version from logs_inserts where id_registro = id_last_of);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_of;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Acción : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesión de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versión DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------
	
	
		
			
	
	
	
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA OFICINAS 2DO REGISTRO -------------------------------
		
	
	
		--------------------------------------- INSERCION 2DO REGISTRO ----------------------------------------
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input_02 , dir_input_02 , nro_tel_input_02 , email_input_02);
	
		--------------------------------------- FIN INSERCION 2DO REGISTRO ----------------------------------------
	
		
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_of_check := exists(select id from oficinas);
	
		-- Comprobacion id
		if (id_last_of_check = true) then
			
			id_last_of := (select max(id) from oficinas);
		
		else 
			id_last_of := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción Tabla "oficinas" Número 2--';
		raise notice '';
		raise notice 'Id: %', id_last_of;
		raise notice 'Nombre : %', nombre_input_02;
		raise notice 'Dirección : %', dir_input_02;
		raise notice 'Nro Telefono : %', nro_tel_input_02;
		raise notice 'Email : %', email_input_02;
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- FIN TABLA OFICINAS 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		-- ------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_of , nombre_tabla_of, accion_of);
	
	
		-- ------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts where id_registro = id_last_of);
		fecha_of := (select fecha from logs_inserts where id_registro = id_last_of);
		hora_of := (select hora from logs_inserts where id_registro = id_last_of);
		usuario_of := (select usuario from logs_inserts where id_registro = id_last_of);
		usuario_sesion_of := (select usuario_sesion from logs_inserts where id_registro = id_last_of);	
		db_of := (select db from logs_inserts where id_registro = id_last_of);
	 	db_version_of := (select db_version from logs_inserts where id_registro = id_last_of);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_of;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Acción : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesión de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versión DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
		else
			
			raise exception '====== SE DEBEN AGREGAR TODOS LOS VALORES DE LOS REGISTRO PARA LA FUNCIÓN insertar_registros_oficinas() ======'
						using hint = '------ insertar_registros_oficinas(nombre_01 varchar, direccion_01 varchar, nro_telefono_01 varchar, email_01 varchar,nombre_02 varchar, direccion_02 varchar, nro_telefono_02 varchar, email_02 varchar); -------- ';
					
					
		end if;

	


end;
	
$$ language plpgsql;



-- -------------------------------------------------------------------------------------


-- -------------------------------------------------------------------------------------



-- =======================================================================
-- ----------- INSERCION DE 4 REGISTROS TABLA OFICINAS ------------
-- =======================================================================

-- APLICAMOS SOBRECARGA DE METODOS
create or replace function insertar_registros_oficinas(

nombre_input_01 varchar, dir_input_01 varchar, nro_tel_input_01 varchar, email_input_01 varchar
, nombre_input_02 varchar, dir_input_02 varchar, nro_tel_input_02 varchar, email_input_02 varchar
, nombre_input_03 varchar, dir_input_03 varchar, nro_tel_input_03 varchar, email_input_03 varchar
, nombre_input_04 varchar, dir_input_04 varchar, nro_tel_input_04 varchar, email_input_04 varchar

) returns void as $$


declare



-- TABLA OFICINAS

-- Comprobamos que exista un id y cual es el ultimo
id_last_of_check boolean;
id_last_of int;


-- Nos aseguramos que no se inserten registros repetidos en la db ademas del check de la db
 nombre_of_check_01 boolean := exists(select nombre from oficinas where nombre = nombre_input_01);
 nombre_of_check_02 boolean := exists(select nombre from oficinas where nombre = nombre_input_02);
 nombre_of_check_03 boolean := exists(select nombre from oficinas where nombre = nombre_input_03);
 nombre_of_check_04 boolean := exists(select nombre from oficinas where nombre = nombre_input_04);

 direccion_of_check_01 boolean := exists(select direccion from oficinas where direccion = dir_input_01);
 direccion_of_check_02 boolean := exists(select direccion from oficinas where direccion = dir_input_02);
 direccion_of_check_03 boolean := exists(select direccion from oficinas where direccion = dir_input_03);
 direccion_of_check_04 boolean := exists(select direccion from oficinas where direccion = dir_input_04);



-- TABLA LOGS_INSERTS

uuid_registro_of uuid;
nombre_tabla_of varchar := 'oficinas';
accion_of varchar := 'insert';
fecha_of date ;
hora_of time ;
usuario_of varchar;
usuario_sesion_of varchar;
db_of varchar;
db_version_of varchar;





begin
	
	if(
	((nombre_of_check_01 = true) and (direccion_of_check_01 = true))
	or 
	((nombre_of_check_02 = true) and (direccion_of_check_02 = true))
	or 
	((nombre_of_check_03 = true) and (direccion_of_check_03 = true))
	or 
	((dir_input_01 = dir_input_02) or (dir_input_01 = dir_input_03) or (dir_input_01 = dir_input_04)) 
	or 
	((dir_input_02 = dir_input_03) or (dir_input_02 = dir_input_04) or (dir_input_03 = dir_input_04))
	
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========='
						using hint = '------- REVISAR NOMBRES Y DIRECCIONES DE LA OFICINA ---------';
						
		
	
	elsif ( 
		((direccion_of_check_01 = false) and (direccion_of_check_02 = false)) 
		and 
		((direccion_of_check_03 = false) and (direccion_of_check_04 = false))
		and 
		((nombre_input_01 <> '') and (dir_input_01 <> '') and (nro_tel_input_01 <> '') and (email_input_01 <> ''))
		and 
		((nombre_input_02 <> '') and (dir_input_02 <> '') and (nro_tel_input_02 <> '') and (email_input_02 <> ''))
		and 
		((nombre_input_03 <> '') and (dir_input_03 <> '') and (nro_tel_input_03 <> '') and (email_input_03 <> ''))
		) then
			
			raise notice '';
			raise notice '----------------------------------------------';
			raise notice '-- Inserción de 4 Registros Tabla "oficinas" --';
			raise notice '----------------------------------------------';
		
		
		
		
			
		
		-- ----------------------------------------------------------------
		-- --------------------- PRIMER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA OFICINAS 1ER REGISTRO -------------------------------
		
		
		--------------------------------------- INSERCION OFICINAS ----------------------------------------
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input_01 , dir_input_01 , nro_tel_input_01 , email_input_01);
	
		--------------------------------------- FIN INSERCION OFICINAS ----------------------------------------
	

		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_of_check := exists(select id from oficinas);
	
		-- Comprobacion id
		if (id_last_of_check = true) then
			
			id_last_of := (select max(id) from oficinas);
		
		else 
			id_last_of := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción Tabla "oficinas" Número 1--';
		raise notice '';
		raise notice 'Id : %', id_last_of;
		raise notice 'Nombre : %', nombre_input_01;
		raise notice 'Dirección : %', dir_input_01;
		raise notice 'Nro Telefono : %', nro_tel_input_01;
		raise notice 'Email : %', email_input_01;

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';
	
		
		-- ------------------------- FIN TABLA OFICINAS 1ER REGISTRO ---------------------------
		-- -------------------------------------------------------------------------------------
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 1ER REGISTRO ---------------------------
		
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		-- ------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_of , nombre_tabla_of, accion_of);
	
	
		-- ------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts where id_registro = id_last_of);
		fecha_of := (select fecha from logs_inserts where id_registro = id_last_of);
		hora_of := (select hora from logs_inserts where id_registro = id_last_of);
		usuario_of := (select usuario from logs_inserts where id_registro = id_last_of);
		usuario_sesion_of := (select usuario_sesion from logs_inserts where id_registro = id_last_of);	
		db_of := (select db from logs_inserts where id_registro = id_last_of);
	 	db_version_of := (select db_version from logs_inserts where id_registro = id_last_of);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_of;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Acción : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesión de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versión DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO -----------------------
		-- -------------------------------------------------------------------------------------
	
	
		
			
	
	
	
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA OFICINAS 2DO REGISTRO -------------------------------
		
		
	
		--------------------------------------- INSERCION 2DO REGISTRO ----------------------------------------
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input_02 , dir_input_02 , nro_tel_input_02 , email_input_02);
	
		--------------------------------------- FIN INSERCION 2DO REGISTRO ----------------------------------------
	
		
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_of_check := exists(select id from oficinas);
	
		-- Comprobacion id
		if (id_last_of_check = true) then
			
			id_last_of := (select max(id) from oficinas);
		
		else 
			id_last_of := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción Tabla "oficinas" Número 2--';
		raise notice '';
		raise notice 'Id: %', id_last_of;
		raise notice 'Nombre : %', nombre_input_02;
		raise notice 'Dirección : %', dir_input_02;
		raise notice 'Nro Telefono : %', nro_tel_input_02;
		raise notice 'Email : %', email_input_02;
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';
		
		
		-- ------------------------- FIN TABLA OFICINAS 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------
		
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 2DO REGISTRO -------------------------------
		

		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		-- ------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_of , nombre_tabla_of, accion_of);
	
	
		-- ------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts where id_registro = id_last_of);
		fecha_of := (select fecha from logs_inserts where id_registro = id_last_of);
		hora_of := (select hora from logs_inserts where id_registro = id_last_of);
		usuario_of := (select usuario from logs_inserts where id_registro = id_last_of);
		usuario_sesion_of := (select usuario_sesion from logs_inserts where id_registro = id_last_of);	
		db_of := (select db from logs_inserts where id_registro = id_last_of);
	 	db_version_of := (select db_version from logs_inserts where id_registro = id_last_of);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_of;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Acción : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesión de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versión DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

		
	
	
	
		-- ----------------------------------------------------------------
		-- --------------------- TERCER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA OFICINAS 3ER REGISTRO -------------------------------
		

	
		--------------------------------------- INSERCION 3ER REGISTRO ----------------------------------------
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input_03 , dir_input_03 , nro_tel_input_03 , email_input_03);
	
		--------------------------------------- FIN INSERCION 3ER REGISTRO ----------------------------------------
	
		
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_of_check := exists(select id from oficinas);
	
		-- Comprobacion id
		if (id_last_of_check = true) then
			
			id_last_of := (select max(id) from oficinas);
		
		else 	
			id_last_of := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción Tabla "oficinas" Número 3--';
		raise notice '';
		raise notice 'Id: %', id_last_of;
		raise notice 'Nombre : %', nombre_input_03;
		raise notice 'Dirección : %', dir_input_03;
		raise notice 'Nro Telefono : %', nro_tel_input_03;
		raise notice 'Email : %', email_input_03;
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';
	
		
		-- ------------------------- FIN TABLA OFICINAS 3ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 3ER REGISTRO -------------------------------
		

		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 3er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
	
		-- ------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_of , nombre_tabla_of, accion_of);
	
	
		-- ------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts where id_registro = id_last_of);
		fecha_of := (select fecha from logs_inserts where id_registro = id_last_of);
		hora_of := (select hora from logs_inserts where id_registro = id_last_of);
		usuario_of := (select usuario from logs_inserts where id_registro = id_last_of);
		usuario_sesion_of := (select usuario_sesion from logs_inserts where id_registro = id_last_of);	
		db_of := (select db from logs_inserts where id_registro = id_last_of);
	 	db_version_of := (select db_version from logs_inserts where id_registro = id_last_of);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_of;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Acción : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesión de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versión DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
			
		-- ------------------------- FIN TABLA LOGS_INSERTS 3ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

		
		-- ----------------------------------------------------------------
		-- --------------------- CUARTO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA OFICINAS 4TO REGISTRO -------------------------------
	
	
		--------------------------------------- INSERCION 4TO REGISTRO ----------------------------------------
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input_04 , dir_input_04 , nro_tel_input_04 , email_input_04);
	
		--------------------------------------- FIN INSERCION 3ER REGISTRO ----------------------------------------
	
		
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_of_check:= exists(select id from oficinas);
	
		-- Comprobacion id
		if (id_last_of_check = true) then
			
			id_last_of := (select max(id) from oficinas);
		
		else 	
			id_last_of := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción Tabla "oficinas" Número 4--';
		raise notice '';
		raise notice 'Id: %', id_last_of;
		raise notice 'Nombre : %', nombre_input_04;
		raise notice 'Dirección : %', dir_input_04;
		raise notice 'Nro Telefono : %', nro_tel_input_04;
		raise notice 'Email : %', email_input_04;
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';
	
		
		-- ------------------------- FIN TABLA OFICINAS 4TO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 4TO REGISTRO -------------------------------
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 4to Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
	
		-- ------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_of , nombre_tabla_of, accion_of);
	
	
		-- ------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts where id_registro = id_last_of);
		fecha_of := (select fecha from logs_inserts where id_registro = id_last_of);
		hora_of := (select hora from logs_inserts where id_registro = id_last_of);
		usuario_of := (select usuario from logs_inserts where id_registro = id_last_of);
		usuario_sesion_of := (select usuario_sesion from logs_inserts where id_registro = id_last_of);	
		db_of := (select db from logs_inserts where id_registro = id_last_of);
	 	db_version_of := (select db_version from logs_inserts where id_registro = id_last_of);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_of;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Acción : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesión de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versión DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
		
		-- ------------------------- FIN TABLA LOGS_INSERTS 4TO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
		else
			
			raise exception '====== SE DEBEN AGREGAR TODOS LOS VALORES DE LOS REGISTROS PARA LA FUNCIÓN insertar_registros_oficinas() ========'
							using hint = '---------- insertar_registros_oficinas(nombre_01 varchar, direccion_01 varchar, nro_telefono_01 varchar, email_01 varchar,nombre_02 varchar, direccion_02 varchar, nro_telefono_02 varchar, email_02 varchar,nombre_03 varchar, direccion_03 varchar, nro_telefono_03 varchar, email_03 varchar,nombre_04 varchar , direccion_04 varchar, nro_telefono_04 varchar, email_04 varchar); ---------';
			
		end if;
	

end;
	
$$ language plpgsql;




/*



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ==========================================
-- ======= TABLA OFICINAS_DETALLES===========
-- ==========================================





-- -------------------------------------------------------------------------------
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA OFICINAS_DETALLES -------


select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';




create or replace function listado_oficinas_detalles() returns setof oficinas_detalles as $$

declare

	registro_actual RECORD;

begin 

		for registro_actual in (select * from oficinas_detalles) loop
		
			return next registro_actual;
		
		end loop;

		return;
		
	
end;

	
$$ language plpgsql;











-- ----------- INSERCION DE 1 REGISTRO TABLA OFICINAS_DETALLES ------------ 
-- ------------------------------------------------------------------------

-- ENUMERADOS DECLARADOS
--  estado_oficina_enum ('ALQUILADA','PROPIA'); 
--   tipo_oficina_enum ('PEQUEÑA','ESTANDAR','EJECUTIVA'); 


select * from oficinas_detalles;

--drop function insertar_registro_oficinas_detalles(id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum, estado_of_input estado_oficina_enum
--, sup_total_input decimal , cant_amb_input smallint , cant_sanit_input smallint, antiguedad_input smallint
--, sitio_web_input varchar); 

create or replace function insertar_registro_oficinas_detalles(

id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum, estado_of_input estado_oficina_enum
, sup_total_input decimal , cant_amb_input smallint , cant_sanit_input smallint, antiguedad_input smallint
, sitio_web_input varchar

) returns void as $$

declare 


 id_of_check boolean:= exists(select id from oficinas where id=id_of_input);

begin
	
	if( id_of_check = false ) then
	
		raise exception 'LA OFICINA CON EL ID INGRESADO NO EXISTE'
						using hint = ' | DETALLE | --> insertar_registro_oficinas_detalles(
							id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum, estado_of_input estado_oficina_enum
							, sup_total_input decimal, cant_amb_input int, cant_sanit_input int, antiguedad_input int, sitio_web_input varchar
							);';
						
		
	
	elsif ( 
		id_of_input <> null 
		and loc_input <> ''
		and (tipo_of_input = 'PEQUEÑA' or tipo_of_input = 'ESTANDAR' or tipo_of_input = 'EJECUTIVA')
		and (estado_of_input = 'ALQUILADA' or estado_of_input ='PROPIA') 
		and sup_total_input <> null 
		and cant_amb_input <> null 
		and cant_sanit_input <> null 
		and sitio_web_input <> ''
		) then
	
		
		raise notice '';
		raise notice '-----------------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "oficinas_detalles" --';
		raise notice '-----------------------------------------------------';
	
	
	
	
			
		insert into oficinas_detalles (id_oficina, localidad, tipo_oficina, estado_oficina
		, superficie_total, cantidad_ambientes, cantidad_sanitarios, antiguedad, sitio_web) values
		
		(id_of_input, loc_input, tipo_of_input, estado_of_input, sup_total_input, cant_amb_input
		, cant_sanit_input, antiguedad_input, sitio_web_input );
		
		-- Casteamos algunas variables, para que postgresql las interprete correctamente
		--(id_of_input, loc_input , tipo_of_input::tipo_oficina_enum, estado_of_input::estado_oficina_enum
		--, sup_total_input, cant_amb_input, cant_sanit_input, antiguedad_input
		--, sitio_web_input);
	
	

	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';
	
		
		raise notice 'Id de Oficina : %', id_of_input;
		raise notice 'Localidad : %', loc_input;
		raise notice 'Tipo de Oficina : %', tipo_of_input;
		raise notice 'Estado de la Oficina : %', estado_of_input;
		raise notice 'Superficie Total : %', sup_total_input;
		raise notice 'Cantidad de Ambientes : %', cant_amb_input;
		raise notice 'Cantidad de Sanitarios : %', cant_sanit_input;
		raise notice 'Antiguedad : %', antiguedad_input;
		raise notice 'Sitio Web : %', sitio_web_input;
	
	
	
		
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	else
	
		--raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_oficinas_detalles()'
			--			using hint = ' | DETALLE | --> insertar_registro_oficinas_detalles(
				--			id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum, estado_of_input estado_oficina_enum
						--	, sup_total_input decimal, cant_amb_input int, cant_sanit_input int, antiguedad_input int, sitio_web_input varchar
					--		);';
						
	end if;
	

end;
	
$$ language plpgsql;




*/







-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
 






-- ===================================
-- ======= TABLA EMPLEADOS ===========
-- ===================================

select * from empleados;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'empleados';





-- =======================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA EMPLEADOS -------
-- =======================================================================


create or replace function listado_empleados() returns setof empleados as $$

declare

	registro_actual RECORD;

begin 

		for registro_actual in (select * from empleados) loop
		
			return next registro_actual;
		
		end loop;

		return;
		
	
end;

	
$$ language plpgsql;




-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA EMPLEADOS -------------------- 
-- =======================================================================

create or replace function insertar_registro_empleados(

id_of_input int, nombre_input varchar, apellido_input varchar, edad_input int
, fecha_nac_input date, tipo_doc_input varchar, nro_doc_input varchar
, cuil_input varchar, direc_input varchar, nro_tel_princ_input varchar
, nro_tel_sec_input varchar, email_input varchar, cargo_input varchar
, antig_input int, fecha_ingreso_input date, sal_anual_input decimal

) returns void as $$



declare

-- TABLA EMPLEADOS

-- Comprobamos que exista un id y cual es el ultimo
id_last_empl_check boolean;
id_last_empl int;

--Nos aseguramos que el id de oficinas exista
id_of_check boolean := exists(select id from oficinas where id = id_of_input);


-- Nos aseguramos que no exista un registro repetido ademas del check de la db
 nombre_apellido_empl_check boolean := exists(select nombre,apellido from empleados where ((nombre = nombre_input) and (apellido = apellido_input)));
 nro_doc_cuil_empl_check boolean := exists(select nro_documento, cuil from empleados where ((nro_documento = nro_doc_input) and (cuil = cuil_input)));
 


-- TABLA LOGS_INSERTS

uuid_registro_empl uuid;
nombre_tabla_empl varchar := 'empleados';
accion_empl varchar := 'insert';
fecha_empl date ;
hora_empl time ;
usuario_empl varchar;
usuario_sesion_empl varchar;
db_empl varchar;
db_version_empl varchar;





begin
	
	if (id_of_check = false)then
		
		raise exception '===== NO SE PUEDE INGRESAR UN EMPLEADO SIN UNA OFICINA EXISTENTE ====='
						using hint = '	--------- REVISAR EL ID DE LA OFICINA ASIGNADA ---------';
						
	
	elsif( 
		((nombre_apellido_empl_check = true) or (nro_doc_cuil_empl_check = true))
	) then
	
		raise exception '===== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ===== '
						using hint=	    '------- REVISAR NOMBRE Y APELLIDO DEL EMPLEADO -------'
										'------- REVISAR NRO. DE DOCUMENTO Y CUIL DEL EMPLEADO ------';
									  
						
		
	elsif (
		((id_of_check = true))
		and 
		((nombre_apellido_empl_check = false) and (nro_doc_cuil_empl_check = false))
		and 
		((nombre_input <> '') and (apellido_input <> ''))
		and 
		((fecha_nac_input <= current_date) and (direc_input <> ''))
		and 
		((tipo_doc_input <> '') and (nro_doc_input <> ''))
		and
		((nro_tel_princ_input <> '') and (nro_tel_sec_input <> ''))
		and 
		((email_input <> '') and (cargo_input <> ''))
		and 
		((edad_input <= 80) and (edad_input > 0))
		and
		((antig_input <= 60) and (antig_input > 0))
		and 
		((fecha_ingreso_input <= current_date) and (sal_anual_input > 0))
		) then
		
		
		
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "empleados" --';
		raise notice '----------------------------------------------';
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------

		insert into empleados (id_oficina, nombre, apellido, edad, fecha_nacimiento
		, tipo_documento, nro_documento, cuil, direccion, nro_telefono_principal
		, nro_telefono_secundario, email, cargo, antiguedad, fecha_ingreso, salario_anual)
		values
		(id_of_input, nombre_input, apellido_input, edad_input, fecha_nac_input, tipo_doc_input
		, nro_doc_input, cuil_input, direc_input, nro_tel_princ_input, nro_tel_sec_input
		, email_input, cargo_input, antig_input, fecha_ingreso_input, sal_anual_input);

		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		
	
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_empl_check := exists(select id from empleados);
	
		-- Comprobacion id
		if (id_last_empl_check = true) then
			
			id_last_empl := (select max(id) from empleados);
		
		else 
			
			id_last_empl := 0;
			
		end if;
		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';
	
		raise notice 'Id Empleado : %',id_last_empl;
		raise notice 'Id Oficina : %',id_of_input;
		raise notice 'Nombre : %', nombre_input;
		raise notice 'Apellido : %', apellido_input;
		raise notice 'Edad : %', edad_input;
		raise notice 'Fecha Nacimiento : %', fecha_nac_input;
		raise notice 'Tipo de Documento : %', tipo_doc_input;
		raise notice 'Número de Documento : %', nro_doc_input;
		raise notice 'Cuil : %', cuil_input;
		raise notice 'Dirección : %', direc_input;
		raise notice 'Nro Telefono Principal : %', nro_tel_princ_input;
		raise notice 'Nro Telefono Secundario : %', nro_tel_sec_input;
		raise notice 'Email : %', email_input;
		raise notice 'Cargo : %', cargo_input;
		raise notice 'Antiguedad : %', antig_input;
		raise notice 'Fecha de Ingreso  : %', fecha_ingreso_input;
		raise notice 'Salario Anual : %', sal_anual_input;
		
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	

	
	
	
	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_empl , nombre_tabla_empl , accion_empl);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
					-- Traemos los valores del Registro Insertado
		uuid_registro_empl := (select uuid_registro from logs_inserts where id_registro = id_last_empl);
		fecha_empl := (select fecha from logs_inserts where id_registro = id_last_empl);
		hora_empl := (select hora from logs_inserts where id_registro = id_last_empl);
		usuario_empl := (select usuario from logs_inserts where id_registro = id_last_empl);
		usuario_sesion_empl := (select usuario_sesion from logs_inserts where id_registro = id_last_empl);	
		db_empl := (select db from logs_inserts where id_registro = id_last_empl);
	 	db_version_empl := (select db_version from logs_inserts where id_registro = id_last_empl);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_empl;
		raise notice 'UUID Registro : %', uuid_registro_empl;
		raise notice 'Tabla : %', nombre_tabla_empl;
		raise notice 'Acción : %', accion_empl;
		raise notice 'Fecha : %', fecha_empl;
		raise notice 'Hora : %', hora_empl;
     	raise notice 'Usuario : %', usuario_empl;
        raise notice 'Sesión de Usuario : %', usuario_sesion_empl;
        raise notice 'DB : %', db_empl;
        raise notice 'Versión DB : %', db_version_empl;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	

	else
	
		raise exception '========= SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_oficinas() =========='
						using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
					
	end if;
	

end;
	
$$ language plpgsql;







-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------



-- =========================================================================
-- ----------- INSERCION DE 4 REGISTROS TABLA EMPLEADOS -------------------- 
-- =========================================================================



create or replace function insertar_registros_empleados(

id_of_input_01 int, nombre_input_01 varchar, apellido_input_01 varchar
, edad_input_01 int, fecha_nac_input_01 date, tipo_doc_input_01 varchar
, nro_doc_input_01 varchar, cuil_input_01 varchar, direc_input_01 varchar
, nro_tel_princ_input_01 varchar, nro_tel_sec_input_01 varchar
, email_input_01 varchar, cargo_input_01 varchar, antig_input_01 int
, fecha_ingreso_input_01 date, sal_anual_input_01 decimal

,id_of_input_02 int, nombre_input_02 varchar, apellido_input_02 varchar
, edad_input_02 int, fecha_nac_input_02 date, tipo_doc_input_02 varchar
, nro_doc_input_02 varchar, cuil_input_02 varchar, direc_input_02 varchar
, nro_tel_princ_input_02 varchar, nro_tel_sec_input_02 varchar
, email_input_02 varchar, cargo_input_02 varchar, antig_input_02 int
, fecha_ingreso_input_02 date, sal_anual_input_02 decimal

,id_of_input_03 int, nombre_input_03 varchar, apellido_input_03 varchar
, edad_input_03 int, fecha_nac_input_03 date, tipo_doc_input_03 varchar
, nro_doc_input_03 varchar, cuil_input_03 varchar, direc_input_03 varchar
, nro_tel_princ_input_03 varchar, nro_tel_sec_input_03 varchar
, email_input_03 varchar, cargo_input_03 varchar, antig_input_03 int
, fecha_ingreso_input_03 date, sal_anual_input_03 decimal

,id_of_input_04 int, nombre_input_04 varchar, apellido_input_04 varchar
, edad_input_04 int, fecha_nac_input_04 date, tipo_doc_input_04 varchar
, nro_doc_input_04 varchar, cuil_input_04 varchar, direc_input_04 varchar
, nro_tel_princ_input_04 varchar, nro_tel_sec_input_04 varchar
, email_input_04 varchar, cargo_input_04 varchar, antig_input_04 int
, fecha_ingreso_input_04 date, sal_anual_input_04 decimal



) returns void as $$



declare

-- TABLA EMPLEADOS

-- Comprobamos que exista un id y cual es el ultimo
id_last_empl_check boolean;
id_last_empl int;


--Nos aseguramos que el id de oficinas exista
id_of_check_01 boolean := exists(select id from oficinas where id = id_of_input_01);
id_of_check_02 boolean := exists(select id from oficinas where id = id_of_input_02);
id_of_check_03 boolean := exists(select id from oficinas where id = id_of_input_03);
id_of_check_04 boolean := exists(select id from oficinas where id = id_of_input_04);

-- Nos aseguramos que no exista un registro repetido con mismo nombre y apellido 
 nombre_apellido_empl_check_01 boolean := exists(select nombre,apellido from empleados where ((nombre = nombre_input_01) and (apellido = apellido_input_01)));
 nombre_apellido_empl_check_02 boolean := exists(select nombre,apellido from empleados where ((nombre = nombre_input_02) and (apellido = apellido_input_02)));
 nombre_apellido_empl_check_03 boolean := exists(select nombre,apellido from empleados where ((nombre = nombre_input_03) and (apellido = apellido_input_03)));
 nombre_apellido_empl_check_04 boolean := exists(select nombre,apellido from empleados where ((nombre = nombre_input_04) and (apellido = apellido_input_04)));

 -- Nos aseguramos que no exista un registro repetido con mismo nro de doc y cuil 
 nro_doc_cuil_empl_check_01 boolean := exists(select nro_documento, cuil from empleados where ((nro_documento = nro_doc_input_01) and (cuil = cuil_input_01)));
 nro_doc_cuil_empl_check_02 boolean := exists(select nro_documento, cuil from empleados where ((nro_documento = nro_doc_input_02) and (cuil = cuil_input_02)));
 nro_doc_cuil_empl_check_03 boolean := exists(select nro_documento, cuil from empleados where ((nro_documento = nro_doc_input_03) and (cuil = cuil_input_03)));
 nro_doc_cuil_empl_check_04 boolean := exists(select nro_documento, cuil from empleados where ((nro_documento = nro_doc_input_04) and (cuil = cuil_input_04)));



-- TABLA LOGS_INSERTS

uuid_registro_empl uuid;
nombre_tabla_empl varchar := 'empleados';
accion_empl varchar := 'insert';
fecha_empl date ;
hora_empl time ;
usuario_empl varchar;
usuario_sesion_empl varchar;
db_empl varchar;
db_version_empl varchar;

 





begin
	
	if (
		(id_of_check_01 = false) and (id_of_check_02 = false)and
		(id_of_check_03 = false) and (id_of_check_04 = false)
		
		)then
		
		raise exception '======= NO SE PUEDE INGRESAR UN EMPLEADO SIN UNA OFICINA EXISTENTE ======'
						using hint = '------- REVISAR EL ID DE LA OFICINA ASIGNADA -----------';
						
	
	
	elsif( 
		((nombre_apellido_empl_check_01 = true) or (nro_doc_cuil_empl_check_01 = true))
		or
		((nombre_apellido_empl_check_02 = true) or (nro_doc_cuil_empl_check_02 = true))
		or 
		((nombre_apellido_empl_check_03 = true) or (nro_doc_cuil_empl_check_03 = true)) 
		or
		((nombre_apellido_empl_check_04 = true) or (nro_doc_cuil_empl_check_04 = true))
	) then
	
	
		raise exception ' ======== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========='
						using hint = '------------ REVISAR NOMBRE Y APELLIDO DE LOS EMPLEADO -------------'
									'------------- REVISAR NRO. DE DOCUMENTO Y CUIL DE LOS EMPLEADO ------------';
		
	
	elsif (
		((id_of_check_01 = true) and (nombre_apellido_empl_check_01 = false) and (nro_doc_cuil_empl_check_01 = false))			
		or 
		((id_of_check_02 = true) and (nombre_apellido_empl_check_02 = false) and (nro_doc_cuil_empl_check_02 = false))
		or 
		((id_of_check_03 = true) and (nombre_apellido_empl_check_03 = false) and (nro_doc_cuil_empl_check_03 = false))
		or
		((id_of_check_04 = true) and (nombre_apellido_empl_check_04 = false) and (nro_doc_cuil_empl_check_04 = false))
		or 
		(
		(nombre_input_01 <> '') and (apellido_input_01 <> '') and (edad_input_01 <> null) and
		(fecha_nac_input_01 <= current_date) and (tipo_doc_input_01 <> '') and 
		(nro_doc_input_01 <> '') and (cuil_input_01 <> '') and (direc_input_01 <> '') and 
		(nro_tel_princ_input_01 <> '') and (nro_tel_sec_input_01 <> '') and 
		(email_input_01 <> '') and (cargo_input_01 <> '') and (antig_input_01 <> null) and
		(fecha_ingreso_input_01 <= current_date) and (sal_anual_input_01 <> null)
		)
		or 
		(
		(nombre_input_02 <> '') and (apellido_input_02 <> '') and (edad_input_02 <> null) and
		(fecha_nac_input_02 <= current_date) and (tipo_doc_input_02 <> '') and 
		(nro_doc_input_02 <> '') and (cuil_input_02 <> '') and (direc_input_02 <> '') and
		(nro_tel_princ_input_02 <> '') and (nro_tel_sec_input_02 <> '') and
		(email_input_02 <> '') and (cargo_input_02 <> '') and (antig_input_02 <> null) and
		(fecha_ingreso_input_02 <= current_date) and (sal_anual_input_02 <> null)
		)
		or 
		(
		(nombre_input_03 <> '') and (apellido_input_03 <> '') and (edad_input_03 <> null) and
		(fecha_nac_input_03 <= current_date) and (tipo_doc_input_03 <> '') and 
		(nro_doc_input_03 <> '') and (cuil_input_03 <> '') and (direc_input_03 <> '') and 
		(nro_tel_princ_input_03 <> '') and (nro_tel_sec_input_03 <> '') and
		(email_input_03 <> '') and (cargo_input_03 <> '') and (antig_input_03 <> null) and
		(fecha_ingreso_input_03 <= current_date) and (sal_anual_input_03 <> null)
		)
		or 
		(
		(nombre_input_04 <> '') and (apellido_input_04 <> '') and (edad_input_04 <> null) and
		(fecha_nac_input_04 <= current_date) and (tipo_doc_input_04 <> '') and 
		(nro_doc_input_04 <> '') and (cuil_input_04 <> '') and (direc_input_04 <> '') and 
		(nro_tel_princ_input_04 <> '') and (nro_tel_sec_input_04 <> '') and
		(email_input_04 <> '') and (cargo_input_04 <> '') and (antig_input_04 <> null) and
		(fecha_ingreso_input_04 <= current_date) and (sal_anual_input_04 <> null)
		)
		
		) then

		
		
		raise notice '';
		raise notice '------------------------------------------------';
		raise notice '-- Inserción de 4 Registros Tabla "empleados" --';
		raise notice '------------------------------------------------';
	
	
		
		
		-- ----------------------------------------------------------------
		-- --------------------- PRIMER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA EMPLEADOS 1ER REGISTRO -------------------------------
		

		--------------------------------------- INSERCION 1ER REGISTRO ----------------------------------------
		
		
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------

		insert into empleados (id_oficina, nombre, apellido, edad, fecha_nacimiento
		, tipo_documento, nro_documento, cuil, direccion, nro_telefono_principal
		, nro_telefono_secundario, email, cargo, antiguedad, fecha_ingreso, salario_anual)
		values
		(id_of_input_01, nombre_input_01, apellido_input_01, edad_input_01
		, fecha_nac_input_01, tipo_doc_input_01, nro_doc_input_01, cuil_input_01
		, direc_input_01, nro_tel_princ_input_01, nro_tel_sec_input_01
		, email_input_01, cargo_input_01, antig_input_01, fecha_ingreso_input_01
		, sal_anual_input_01);


		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		
	
		--------------------------------------- FIN INSERCION 1ER REGISTRO ----------------------------------------
	

		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_empl_check := exists(select id from empleados);
	
		-- Comprobacion id
		if (id_last_empl_check = true) then
			
			id_last_empl := (select max(id) from empleados);
		
		else 
			
			id_last_empl := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción 01 Tabla "empleados" --';
		raise notice '';
	
		raise notice 'Id Empleado: %',id_last_empl;
		raise notice 'Id Oficina : %',id_of_input_01;
		raise notice 'Nombre : %', nombre_input_01;
		raise notice 'Apellido : %', apellido_input_01;
		raise notice 'Edad : %', edad_input_01;
		raise notice 'Fecha Nacimiento : %', fecha_nac_input_01;
		raise notice 'Tipo de Documento : %', tipo_doc_input_01;
		raise notice 'Número de Documento : %', nro_doc_input_01;
		raise notice 'Cuil : %', cuil_input_01;
		raise notice 'Dirección : %', direc_input_01;
		raise notice 'Nro Telefono Principal : %', nro_tel_princ_input_01;
		raise notice 'Nro Telefono Secundario : %', nro_tel_sec_input_01;
		raise notice 'Email : %', email_input_01;
		raise notice 'Cargo : %', cargo_input_01;
		raise notice 'Antiguedad : %', antig_input_01;
		raise notice 'Fecha de Ingreso  : %', fecha_ingreso_input_01;
		raise notice 'Salario Anual : %', sal_anual_input_01;
		
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	

		
		-- ------------------------- FIN TABLA EMPLEADOS 1ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
			
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		

		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_empl , nombre_tabla_empl , accion_empl);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_empl := (select uuid_registro from logs_inserts where id_registro = id_last_empl);
		fecha_empl := (select fecha from logs_inserts where id_registro = id_last_empl);
		hora_empl := (select hora from logs_inserts where id_registro = id_last_empl);
		usuario_empl := (select usuario from logs_inserts where id_registro = id_last_empl);
		usuario_sesion_empl := (select usuario_sesion from logs_inserts where id_registro = id_last_empl);	
		db_empl := (select db from logs_inserts where id_registro = id_last_empl);
	 	db_version_empl := (select db_version from logs_inserts where id_registro = id_last_empl);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_empl;
		raise notice 'UUID Registro : %', uuid_registro_empl;
		raise notice 'Tabla : %', nombre_tabla_empl;
		raise notice 'Acción : %', accion_empl;
		raise notice 'Fecha : %', fecha_empl;
		raise notice 'Hora : %', hora_empl;
     	raise notice 'Usuario : %', usuario_empl;
        raise notice 'Sesión de Usuario : %', usuario_sesion_empl;
        raise notice 'DB : %', db_empl;
        raise notice 'Versión DB : %', db_version_empl;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
		
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------


	
	
		
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA EMPLEADOS 2DO REGISTRO -------------------------------
		

		--------------------------- INSERCION 2DO REGISTRO ----------------------------------------
		
		insert into empleados (id_oficina, nombre, apellido, edad, fecha_nacimiento
		, tipo_documento, nro_documento, cuil, direccion, nro_telefono_principal
		, nro_telefono_secundario, email, cargo, antiguedad, fecha_ingreso, salario_anual)
		values
		(id_of_input_02, nombre_input_02, apellido_input_02, edad_input_02
		, fecha_nac_input_02, tipo_doc_input_02, nro_doc_input_02, cuil_input_02
		, direc_input_02, nro_tel_princ_input_02, nro_tel_sec_input_02
		, email_input_02, cargo_input_02, antig_input_02, fecha_ingreso_input_02
		, sal_anual_input_02);

		---------------------------- FIN INSERCION 2DO REGISTRO ----------------------------------------

		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_empl_check := exists(select id from empleados);
	
		-- Comprobacion id
		if (id_last_empl_check = true) then
			
			id_last_empl := (select max(id) from empleados);
		
		else 
			
			id_last_empl := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción 02 Tabla "empleados" --';
		raise notice '';
	
		raise notice 'Id Empleado: %',id_last_empl;
		raise notice 'Id Oficina : %',id_of_input_02;
		raise notice 'Nombre : %', nombre_input_02;
		raise notice 'Apellido : %', apellido_input_02;
		raise notice 'Edad : %', edad_input_02;
		raise notice 'Fecha Nacimiento : %', fecha_nac_input_02;
		raise notice 'Tipo de Documento : %', tipo_doc_input_02;
		raise notice 'Número de Documento : %', nro_doc_input_02;
		raise notice 'Cuil : %', cuil_input_02;
		raise notice 'Dirección : %', direc_input_02;
		raise notice 'Nro Telefono Principal : %', nro_tel_princ_input_02;
		raise notice 'Nro Telefono Secundario : %', nro_tel_sec_input_02;
		raise notice 'Email : %', email_input_02;
		raise notice 'Cargo : %', cargo_input_02;
		raise notice 'Antiguedad : %', antig_input_02;
		raise notice 'Fecha de Ingreso  : %', fecha_ingreso_input_02;
		raise notice 'Salario Anual : %', sal_anual_input_02;
		
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	

		
		-- ------------------------- FIN TABLA EMPLEADOS 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
			
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		

		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_empl , nombre_tabla_empl , accion_empl);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
			-- Traemos los valores del Registro Insertado
		uuid_registro_empl := (select uuid_registro from logs_inserts where id_registro = id_last_empl);
		fecha_empl := (select fecha from logs_inserts where id_registro = id_last_empl);
		hora_empl := (select hora from logs_inserts where id_registro = id_last_empl);
		usuario_empl := (select usuario from logs_inserts where id_registro = id_last_empl);
		usuario_sesion_empl := (select usuario_sesion from logs_inserts where id_registro = id_last_empl);	
		db_empl := (select db from logs_inserts where id_registro = id_last_empl);
	 	db_version_empl := (select db_version from logs_inserts where id_registro = id_last_empl);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_empl;
		raise notice 'UUID Registro : %', uuid_registro_empl;
		raise notice 'Tabla : %', nombre_tabla_empl;
		raise notice 'Acción : %', accion_empl;
		raise notice 'Fecha : %', fecha_empl;
		raise notice 'Hora : %', hora_empl;
     	raise notice 'Usuario : %', usuario_empl;
        raise notice 'Sesión de Usuario : %', usuario_sesion_empl;
        raise notice 'DB : %', db_empl;
        raise notice 'Versión DB : %', db_version_empl;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------


			
		
		-- ----------------------------------------------------------------
		-- --------------------- TERCER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA EMPLEADOS 3ER REGISTRO -------------------------------
		

		--------------------------- INSERCION 3ER REGISTRO ----------------------------------------
		
		insert into empleados (id_oficina, nombre, apellido, edad, fecha_nacimiento
		, tipo_documento, nro_documento, cuil, direccion, nro_telefono_principal
		, nro_telefono_secundario, email, cargo, antiguedad, fecha_ingreso, salario_anual)
		values
		(id_of_input_03, nombre_input_03, apellido_input_03, edad_input_03
		, fecha_nac_input_03, tipo_doc_input_03, nro_doc_input_03, cuil_input_03
		, direc_input_03, nro_tel_princ_input_03, nro_tel_sec_input_03
		, email_input_03, cargo_input_03, antig_input_03, fecha_ingreso_input_03
		, sal_anual_input_03);

		---------------------------- FIN INSERCION 3ER REGISTRO ----------------------------------------

		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_empl_check := exists(select id from empleados);
	
		-- Comprobacion id
		if (id_last_empl_check = true) then
			
			id_last_empl := (select max(id) from empleados);
		
		else 
			
			id_last_empl := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción 03 Tabla "empleados" --';
		raise notice '';
	
		raise notice 'Id Empleado: %',id_last_empl;
		raise notice 'Id Oficina : %',id_of_input_03;
		raise notice 'Nombre : %', nombre_input_03;
		raise notice 'Apellido : %', apellido_input_03;
		raise notice 'Edad : %', edad_input_03;
		raise notice 'Fecha Nacimiento : %', fecha_nac_input_03;
		raise notice 'Tipo de Documento : %', tipo_doc_input_03;
		raise notice 'Número de Documento : %', nro_doc_input_03;
		raise notice 'Cuil : %', cuil_input_03;
		raise notice 'Dirección : %', direc_input_03;
		raise notice 'Nro Telefono Principal : %', nro_tel_princ_input_03;
		raise notice 'Nro Telefono Secundario : %', nro_tel_sec_input_03;
		raise notice 'Email : %', email_input_03;
		raise notice 'Cargo : %', cargo_input_03;
		raise notice 'Antiguedad : %', antig_input_03;
		raise notice 'Fecha de Ingreso  : %', fecha_ingreso_input_03;
		raise notice 'Salario Anual : %', sal_anual_input_03;
		
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	

		
		-- ------------------------- FIN TABLA EMPLEADOS 3ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
			
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 3ER REGISTRO -------------------------------
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_empl , nombre_tabla_empl , accion_empl);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
			-- Traemos los valores del Registro Insertado
		uuid_registro_empl := (select uuid_registro from logs_inserts where id_registro = id_last_empl);
		fecha_empl := (select fecha from logs_inserts where id_registro = id_last_empl);
		hora_empl := (select hora from logs_inserts where id_registro = id_last_empl);
		usuario_empl := (select usuario from logs_inserts where id_registro = id_last_empl);
		usuario_sesion_empl := (select usuario_sesion from logs_inserts where id_registro = id_last_empl);	
		db_empl := (select db from logs_inserts where id_registro = id_last_empl);
	 	db_version_empl := (select db_version from logs_inserts where id_registro = id_last_empl);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_empl;
		raise notice 'UUID Registro : %', uuid_registro_empl;
		raise notice 'Tabla : %', nombre_tabla_empl;
		raise notice 'Acción : %', accion_empl;
		raise notice 'Fecha : %', fecha_empl;
		raise notice 'Hora : %', hora_empl;
     	raise notice 'Usuario : %', usuario_empl;
        raise notice 'Sesión de Usuario : %', usuario_sesion_empl;
        raise notice 'DB : %', db_empl;
        raise notice 'Versión DB : %', db_version_empl;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';		
		
		-- ------------------------- FIN TABLA LOGS_INSERTS 3ER REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------
		
	
			
		-- ----------------------------------------------------------------
		-- --------------------- CUARTO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA EMPLEADOS 4TO REGISTRO -------------------------------
		

		--------------------------- INSERCION 4TO REGISTRO ----------------------------------------
		
		insert into empleados (id_oficina, nombre, apellido, edad, fecha_nacimiento
		, tipo_documento, nro_documento, cuil, direccion, nro_telefono_principal
		, nro_telefono_secundario, email, cargo, antiguedad, fecha_ingreso, salario_anual)
		values
		(id_of_input_04, nombre_input_04, apellido_input_04, edad_input_04
		, fecha_nac_input_04, tipo_doc_input_04, nro_doc_input_04, cuil_input_04
		, direc_input_04, nro_tel_princ_input_04, nro_tel_sec_input_04
		, email_input_04, cargo_input_04, antig_input_04, fecha_ingreso_input_04
		, sal_anual_input_04);

		---------------------------- FIN INSERCION 4TO REGISTRO ----------------------------------------

		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_empl_check := exists(select id from empleados);
	
		-- Comprobacion id
		if (id_last_empl_check = true) then
			
			id_last_empl := (select max(id) from empleados);
		
		else 
			
			id_last_empl := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción 04 Tabla "empleados" --';
		raise notice '';
	
		raise notice 'Id Empleado: %',id_last_empl;
		raise notice 'Id Oficina : %',id_of_input_04;
		raise notice 'Nombre : %', nombre_input_04;
		raise notice 'Apellido : %', apellido_input_04;
		raise notice 'Edad : %', edad_input_04;
		raise notice 'Fecha Nacimiento : %', fecha_nac_input_04;
		raise notice 'Tipo de Documento : %', tipo_doc_input_04;
		raise notice 'Número de Documento : %', nro_doc_input_04;
		raise notice 'Cuil : %', cuil_input_04;
		raise notice 'Dirección : %', direc_input_04;
		raise notice 'Nro Telefono Principal : %', nro_tel_princ_input_04;
		raise notice 'Nro Telefono Secundario : %', nro_tel_sec_input_04;
		raise notice 'Email : %', email_input_04;
		raise notice 'Cargo : %', cargo_input_04;
		raise notice 'Antiguedad : %', antig_input_04;
		raise notice 'Fecha de Ingreso  : %', fecha_ingreso_input_04;
		raise notice 'Salario Anual : %', sal_anual_input_04;
		
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	

		
		-- ------------------------- FIN TABLA EMPLEADOS 4TO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	

		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 4TO REGISTRO -------------------------------
	
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_empl , nombre_tabla_empl , accion_empl);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
				-- Traemos los valores del Registro Insertado
		uuid_registro_empl := (select uuid_registro from logs_inserts where id_registro = id_last_empl);
		fecha_empl := (select fecha from logs_inserts where id_registro = id_last_empl);
		hora_empl := (select hora from logs_inserts where id_registro = id_last_empl);
		usuario_empl := (select usuario from logs_inserts where id_registro = id_last_empl);
		usuario_sesion_empl := (select usuario_sesion from logs_inserts where id_registro = id_last_empl);	
		db_empl := (select db from logs_inserts where id_registro = id_last_empl);
	 	db_version_empl := (select db_version from logs_inserts where id_registro = id_last_empl);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_empl;
		raise notice 'UUID Registro : %', uuid_registro_empl;
		raise notice 'Tabla : %', nombre_tabla_empl;
		raise notice 'Acción : %', accion_empl;
		raise notice 'Fecha : %', fecha_empl;
		raise notice 'Hora : %', hora_empl;
     	raise notice 'Usuario : %', usuario_empl;
        raise notice 'Sesión de Usuario : %', usuario_sesion_empl;
        raise notice 'DB : %', db_empl;
        raise notice 'Versión DB : %', db_version_empl;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS -------------------------------
		-- -------------------------------------------------------------------------------------

	
	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_oficinas() ==========='
						using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
		
	
	end if;
	

end;
	
$$ language plpgsql;







-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================================
-- ======= TABLA PROPIETARIOS_INMUEBLES ===========
-- ================================================




select * from propietarios_inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'propietarios_inmuebles';




-- =================================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA PROPIETARIOS_INMUEBLES -------
-- ==================================================================================


create or replace function listado_propietarios_inmuebles() returns setof oficinas as $$

declare

	registro_actual_prop_inm RECORD;

begin 
	
	for registro_actual_prop_inm in (select * from propietarios_inmuebles) loop
	
		return next registro_actual_prop_inm;-- Por cada iteracion se guarda el registro completo
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA PROPIETARIOS_INMUEBLES ------------
-- =======================================================================



select * from propietarios_inmuebles;


create or replace function insertar_registro_propietarios_inmuebles(

nombre_input varchar, apellido_input varchar, edad_input int
, fecha_nac_input varchar, tipo_doc_input varchar, nro_doc_input varchar 
, direc_input varchar, nro_tel_princ_input varchar, nro_tel_sec_input varchar
, email_input varchar

) returns void as $$



declare


-- TABLA PROPIETARIOS_INMUEBLES

-- Comprobamos que exista un id y cual es el ultimo
id_last_prop_inm_check boolean;
id_last_prop_inm int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
nombre_apellido_prop_inm_check boolean := exists(select nombre,apellido from propietarios_inmuebles 
where ((nombre = nombre_input) and (apellido = apellido_input)));


tipo_nro_doc_prop_inm_check boolean := exists(select tipo_documento, nro_documento from propietarios_inmuebles 
where ((tipo_documento = tipo_doc_input) and (nro_documento = nro_doc_input)));



-- TABLA LOGS_INSERTS

uuid_registro_prop_inm uuid;
nombre_tabla_prop_inm varchar := 'propietarios_inmuebles';
accion_prop_inm varchar := 'insert';
fecha_prop_inm date ;
hora_prop_inm time ;
usuario_prop_inm varchar;
usuario_sesion_prop_inm varchar;
db_prop_inm varchar;
db_version_prop_inm varchar;



begin
	


	if(
	((nombre_apellido_prop_inm_check = true) or (tipo_nro_doc_prop_inm_check = true))
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR NOMBRE Y APELLIDO DEL PROPIETARIO -------------'
					'-------- REVISAR TIPO Y NÚMERO DE DOCUMENTO DEL PROPIETARIO ------';
		

	
	elsif (
		((nombre_apellido_prop_inm_check = false) and (tipo_nro_doc_prop_inm_check = false))
		and 
		((nombre_input <> '') and (apellido_input <> '') and 
		(edad_input >= 18) and (edad_input <= 70) and
		(fecha_nac_input <= current_date) and (tipo_doc_input <> '') and
		(nro_doc_input <> '') and (direc_input <> '') and 
		(nro_tel_princ_input <> '') and (nro_tel_sec_input <> '') and
		(email_input))
		
		) then
	

		
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into propietarios_inmuebles (nombre, apellido, edad, fecha_nacimiento , tipo_documento
		, nro_documento , direccion , nro_telefono_principal, nro_telefono_secundario , email ) values
		
		(nombre_input , apellido_input , edad_input , fecha_nac_input, tipo_doc_input, nro_doc_input
		, direc_input, nro_tel_princ_input, nro_tel_sec_input , email_input);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		
	
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_prop_inm_check := exists(select id from propietarios_inmuebles);
	
		-- Comprobacion id
		if (id_last_prop_inm_check = true) then
			
			id_last_prop_inm := (select max(id) from propietarios_inmuebles);
		
		else 
			
			id_last_prop_inm := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '----------------------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "propietarios_inmuebles" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_prop_inm;
		raise notice 'Nombre : %', nombre_input;
	 	raise notice 'Apellido : %', apellido_input;
	  	raise notice 'Edad : %', edad_input;
	  	raise notice 'Fecha de Nacimiento : %', fecha_nac_input;
	  	raise notice 'Tipo de Documento : %', tipo_doc_input;
	  	raise notice 'Número de Documento : %', nro_doc_input;
	  
		raise notice 'Email : %', email_input;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	
	
	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_prop_inm , nombre_tabla_prop_inm , accion_prop_inm);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_prop_inm := (select uuid_registro from logs_inserts where id_registro = id_last_prop_inm);
		fecha_prop_inm := (select fecha from logs_inserts where id_registro = id_last_prop_inm);
		hora_prop_inm := (select hora from logs_inserts where id_registro = id_last_prop_inm);
		usuario_prop_inm := (select usuario from logs_inserts where id_registro = id_last_prop_inm);
		usuario_sesion_prop_inm := (select usuario_sesion from logs_inserts where id_registro = id_last_prop_inm);	
		db_prop_inm := (select db from logs_inserts where id_registro = id_last_prop_inm);
	 	db_version_prop_inm := (select db_version from logs_inserts where id_registro = id_last_prop_inm);
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_last_prop_inm;
		raise notice 'UUID Registro : %', uuid_registro_prop_inm;
		raise notice 'Tabla : %', nombre_tabla_prop_inm;
		raise notice 'Acción : %', accion_prop_inm;
		raise notice 'Fecha : %', fecha_prop_inm;
		raise notice 'Hora : %', hora_prop_inm;
     	raise notice 'Usuario : %', usuario_prop_inm;
        raise notice 'Sesión de Usuario : %', usuario_sesion_prop_inm;
        raise notice 'DB : %', db_prop_inm;
        raise notice 'Versión DB : %', db_version_prop_inm;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_propiedades_inmuebles() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;

-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------