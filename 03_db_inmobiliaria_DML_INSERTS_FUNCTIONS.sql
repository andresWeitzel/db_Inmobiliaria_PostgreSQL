/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML INSERTS FUNCTIONS=============
 */



-- -------------
-- ---Tablas----
-- -------------

-- logs_inserts
drop function if exists listado_logs_inserts();


-- oficinas
drop function if exists listado_oficinas();
drop function if exists insertar_registro_oficinas();
drop function if exists insertar_registros_oficinas();

-- oficinas_detalles
drop function if exists listado_oficinas_detalles();
drop function if exists insertar_registro_oficinas_detalles();
drop function if exists insertar_registros_oficinas_detalles();

-- empleados
drop function if exists listado_empleados();
drop function if exists insertar_registro_empleados();
drop function if exists insertar_registros_empleados();

-- propietarios_inmuebles
drop function if exists listado_propietarios_inmuebles(); 
drop function if exists insertar_registro_propietarios_inmuebles();
drop function if exists insertar_registros_propietarios_inmuebles();


-- inmuebles_descripciones
drop function if exists listado_inmuebles_descripciones();
drop function if exists insertar_registro_inmuebles_descripciones();
drop function if exists insertar_registros_inmuebles_descripciones();


-- inmuebles_medidas
drop function if exists listado_inmuebles_medidas();
drop function if exists insertar_registro_inmuebles_medidas();
drop function if exists insertar_registros_inmuebles_medidas();


-- inmuebles
drop function if exists listado_inmuebles();
drop function if exists insertar_registro_inmuebles();
drop function if exists insertar_registros_inmuebles();













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


drop function if exists listado_oficinas();

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

-- --------------------------------------------------------------------------



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





-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================================
-- ======= TABLA OFICINAS_DETALLES ===========
-- ================================================




select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';




-- =================================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA OFICINAS_DETALLES -------
-- ==================================================================================



create or replace function listado_oficinas_detalles() returns setof oficinas_detalles as $$

declare

	registro_actual_of_det RECORD;

begin 
	
	for registro_actual_of_det in (select * from oficinas_detalles) loop
	
		return next registro_actual_of_det;
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;




-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA OFICINAS_DETALLES ------------
-- =======================================================================



select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';

/*
drop function if exists insertar_registro_oficinas_detalles(
id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum
, estado_of_input estado_oficina_enum, sup_total_input decimal, cant_amb_input smallint 
,  cant_sanit_input smallint , antig_input smallint , sitio_web_input varchar
);*/

create or replace function insertar_registro_oficinas_detalles(

id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum
, estado_of_input estado_oficina_enum, sup_total_input decimal, cant_amb_input smallint 
,  cant_sanit_input smallint , antig_input smallint , sitio_web_input varchar

) returns void as $$



declare


-- TABLA oficinas_detalles

-- Comprobamos que exista un id y cual es el ultimo
id_last_of_det_check boolean;
id_last_of_det int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos Localidad, Tipo de Oficina y Superficie Total
loc_tipo_sup_total_of_det_check boolean := exists(
select localidad, tipo_oficina , superficie_total from oficinas_detalles
where ((localidad = loc_input) and (tipo_oficina = tipo_of_input::tipo_oficina_enum) and
(superficie_total = sup_total_input)));


-- TABLA LOGS_INSERTS

uuid_registro_of_det uuid;
nombre_tabla_of_det varchar := 'oficinas_detalles';
accion_of_det varchar := 'insert';
fecha_of_det date ;
hora_of_det time ;
usuario_of_det varchar;
usuario_sesion_of_det varchar;
db_of_det varchar;
db_version_of_det varchar;



begin
	


	if((loc_tipo_sup_total_of_det_check = true)) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR LOCALIDAD / TIPO / SUPERFICIE TOTAL DE LA OFICINA -------------';
		

	
	elsif (
		((loc_tipo_sup_total_of_det_check = false))
		and
		((id_of_input > 0) and (loc_input_input > 0))
		and 
		((tipo_of_input = 'PEQUEÑA') or (tipo_of_input = 'ESTANDAR') or (tipo_of_input = 'EJECUTIVA')) 
		and
		((estado_of_input = 'ALQUILADA') or (estado_of_input = 'PROPIA'))
		and
		((sup_total_input > 0.0) and (cantidad_amb_input > 0))
		and 
		((cantidad_sanit_input > 0) and (antig_input > 0))
		and 
		((sitio_web_input <> ''))
		) then
	
		

		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA OFICINAS_DETALLES  -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into oficinas_detalles (
		id_oficina, localidad , tipo_oficina , estado_oficina , superficie_total 
		,cantidad_ambientes , cantidad_sanitarios , antiguedad , sitio_web ) values
		
		(id_of_input::int , loc_input::varchar , tipo_of_input::tipo_oficina_enum 
		, estado_of_input::estado_oficina_enum, sup_total_input::decimal 
		, cant_amb_input::smallint , cant_sanit_input::smallint , antig_input::smallint 
		, sitio_web_input::varchar);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_of_det_check := exists(select id from oficinas_detalles);
	
		-- Comprobacion id
		if (id_last_of_det_check = true) then
			
			id_last_of_det := (select max(id) from oficinas_detalles);
		
		else 
			
			id_last_of_det := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '----------------------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "oficinas_detalles" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID Oficinas Detalles: %' , id_last_of_det;
		raise notice 'ID Oficina: %' , id_of_input;
		raise notice 'Localidad : %', loc_input;
	 	raise notice 'Tipo de Oficina : %', tipo_of_input;
	  	raise notice 'Estado de la Oficina : %', estado_of_input;
	  	raise notice 'Superficie Total : %', sup_total_input;
	  	raise notice 'Cantidad de Ambientes: %', cant_amb_input;
	  	raise notice 'Cantidad de Sanitarios : %', cant_sanit_input;
	  	raise notice 'Antiguedad : %', antig_input;
	   	raise notice 'Sitio Web : %', sitio_web_input;
	   	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA OFICINAS_DETALLES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS -------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_of_det , nombre_tabla_of_det , accion_of_det);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of_det := (select uuid_registro from logs_inserts where id_registro = id_last_of_det);
		fecha_of_det := (select fecha from logs_inserts where id_registro = id_last_of_det);
		hora_of_det := (select hora from logs_inserts where id_registro = id_last_of_det);
		usuario_of_det := (select usuario from logs_inserts where id_registro = id_last_of_det);
		usuario_sesion_of_det := (select usuario_sesion from logs_inserts where id_registro = id_last_of_det);	
		db_of_det := (select db from logs_inserts where id_registro = id_last_of_det);
	 	db_version_of_det := (select db_version from logs_inserts where id_registro = id_last_of_det);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_of_det;
		raise notice 'UUID Registro : %', uuid_registro_of_det;
		raise notice 'Tabla : %', nombre_tabla_of_det;
		raise notice 'Acción : %', accion_of_det;
		raise notice 'Fecha : %', fecha_of_det;
		raise notice 'Hora : %', hora_of_det;
     	raise notice 'Usuario : %', usuario_of_det;
        raise notice 'Sesión de Usuario : %', usuario_sesion_of_det;
        raise notice 'DB : %', db_of_det;
        raise notice 'Versión DB : %', db_version_of_det;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS -------------------------------
		-- -------------------------------------------------------------------------------------

	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_oficinas_detalles() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;




-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------






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
		((edad_input <= 80) and (edad_input >=18 ))
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
	
		raise exception '========= SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_empleados() =========='
						using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
					
	end if;
	

end;
	
$$ language plpgsql;





-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------



-- =========================================================================
-- ----------- INSERCION DE 2 REGISTROS TABLA EMPLEADOS -------------------- 
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


) returns void as $$



declare

-- TABLA EMPLEADOS

-- Comprobamos que exista un id y cual es el ultimo
id_last_empl_check boolean;
id_last_empl int;


--Nos aseguramos que el id de oficinas exista
id_of_check_01 boolean := exists(select id from oficinas where id = id_of_input_01);
id_of_check_02 boolean := exists(select id from oficinas where id = id_of_input_02);

-- Nos aseguramos que no exista un registro repetido con mismo nombre y apellido 
 nombre_apellido_empl_check_01 boolean := exists(select nombre,apellido from empleados where ((nombre = nombre_input_01) and (apellido = apellido_input_01)));
 nombre_apellido_empl_check_02 boolean := exists(select nombre,apellido from empleados where ((nombre = nombre_input_02) and (apellido = apellido_input_02)));

 -- Nos aseguramos que no exista un registro repetido con mismo nro de doc y cuil 
 nro_doc_cuil_empl_check_01 boolean := exists(select nro_documento, cuil from empleados where ((nro_documento = nro_doc_input_01) and (cuil = cuil_input_01)));
 nro_doc_cuil_empl_check_02 boolean := exists(select nro_documento, cuil from empleados where ((nro_documento = nro_doc_input_02) and (cuil = cuil_input_02)));


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
		((id_of_check_01 = false) and (id_of_check_02 = false))
		
		)then
		
		raise exception '======= NO SE PUEDE INGRESAR UN EMPLEADO SIN UNA OFICINA EXISTENTE ======'
						using hint = '------- REVISAR EL ID DE LA OFICINA ASIGNADA -----------';
						
	
	
	elsif( 
		((nombre_apellido_empl_check_01 = true) or (nro_doc_cuil_empl_check_01 = true))
		or
		((nombre_apellido_empl_check_02 = true) or (nro_doc_cuil_empl_check_02 = true)) 
	
	) then
	
	
		raise exception ' ======== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========='
						using hint = '------------ REVISAR NOMBRE Y APELLIDO DE LOS EMPLEADO -------------'
									'------------- REVISAR NRO. DE DOCUMENTO Y CUIL DE LOS EMPLEADO ------------';
		
	
	elsif (
		((id_of_check_01 = true) and (nombre_apellido_empl_check_01 = false) and (nro_doc_cuil_empl_check_01 = false))			
		and 
		((id_of_check_02 = true) and (nombre_apellido_empl_check_02 = false) and (nro_doc_cuil_empl_check_02 = false))
		and 
		(
		(nombre_input_01 <> '') and (apellido_input_01 <> '') and 
		(edad_input_01 >= 18) and (edad_input_01 <= 60) and
		(fecha_nac_input_01 <= current_date) and (tipo_doc_input_01 <> '') and 
		(nro_doc_input_01 <> '') and (cuil_input_01 <> '') and (direc_input_01 <> '') and 
		(nro_tel_princ_input_01 <> '') and (nro_tel_sec_input_01 <> '') and 
		(email_input_01 <> '') and (cargo_input_01 <> '') and (antig_input_01 >= 0) and
		(fecha_ingreso_input_01 <= current_date) and (sal_anual_input_01 >= 30000)
		)
		and 
		(
		(nombre_input_02 <> '') and (apellido_input_02 <> '') and 
		(edad_input_02 >= 18) and (edad_input_02 <= 60) and
		(fecha_nac_input_02 <= current_date) and (tipo_doc_input_02 <> '') and 
		(nro_doc_input_02 <> '') and (cuil_input_02 <> '') and (direc_input_02 <> '') and
		(nro_tel_princ_input_02 <> '') and (nro_tel_sec_input_02 <> '') and
		(email_input_02 <> '') and (cargo_input_02 <> '') and (antig_input_02 >= 0) and
		(fecha_ingreso_input_02 <= current_date) and (sal_anual_input_02 >= 30000)
		)
		) then

		
		
		raise notice '';
		raise notice '------------------------------------------------';
		raise notice '-- Inserción de 2 Registros Tabla "empleados" --';
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


	
	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registros_empleados() ==========='
						using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
		
	
	end if;
	

end;
	
$$ language plpgsql;
			


-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------



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



create or replace function listado_propietarios_inmuebles() returns setof propietarios_inmuebles as $$

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
, fecha_nac_input date, tipo_doc_input varchar, nro_doc_input varchar 
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
		((nombre_input <> '') and (apellido_input <> ''))
		and 
		((edad_input >= 18) and (edad_input <= 200)) 
		and
		((fecha_nac_input <= current_date))
		and 
		((tipo_doc_input <> '') and (nro_doc_input <> ''))
		and 
		((direc_input <> '') and (nro_tel_princ_input <> ''))
		and 
		((nro_tel_sec_input <> '') and (email_input <> ''))
		
		) then
	
		
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA PROPIETARIOS_INMUEBLES  -------------------------------
		
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
	  	raise notice 'Direccion : %', direc_input;
	  	raise notice 'Número de Teléfono Principal : %', nro_tel_princ_input;
	   	raise notice 'Número de Teléfono Secundario : %', nro_tel_sec_input;
		raise notice 'Email : %', email_input;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
		
		-- ------------------------- FIN TABLA PROPIETARIOS_INMUEBLES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS -------------------------------
		
	
	
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
		raise notice '----------------------------------------------';
		raise notice '-- Inserción Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
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
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS -------------------------------
		-- -------------------------------------------------------------------------------------

	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_propiedades_inmuebles() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;

-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 2 REGISTROS TABLA PROPIETARIOS_INMUEBLES ------------
-- =======================================================================



select * from propietarios_inmuebles;


create or replace function insertar_registros_propietarios_inmuebles(

nombre_input_01 varchar, apellido_input_01 varchar, edad_input_01 int
, fecha_nac_input_01 date, tipo_doc_input_01 varchar, nro_doc_input_01 varchar 
, direc_input_01 varchar, nro_tel_princ_input_01 varchar, nro_tel_sec_input_01 varchar
, email_input_01 varchar
, nombre_input_02 varchar, apellido_input_02 varchar, edad_input_02 int
, fecha_nac_input_02 date, tipo_doc_input_02 varchar, nro_doc_input_02 varchar 
, direc_input_02 varchar, nro_tel_princ_input_02 varchar, nro_tel_sec_input_02 varchar
, email_input_02 varchar


) returns void as $$



declare


-- TABLA PROPIETARIOS_INMUEBLES

-- Comprobamos que exista un id y cual es el ultimo
id_last_prop_inm_check boolean;
id_last_prop_inm int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
nombre_apellido_prop_inm_check_01 boolean := exists(select nombre,apellido from propietarios_inmuebles 
where ((nombre = nombre_input_01) and (apellido = apellido_input_01)));

nombre_apellido_prop_inm_check_02 boolean := exists(select nombre,apellido from propietarios_inmuebles 
where ((nombre = nombre_input_02) and (apellido = apellido_input_02)));


tipo_nro_doc_prop_inm_check_01 boolean := exists(select tipo_documento, nro_documento from propietarios_inmuebles 
where ((tipo_documento = tipo_doc_input_01) and (nro_documento = nro_doc_input_01)));

tipo_nro_doc_prop_inm_check_02 boolean := exists(select tipo_documento, nro_documento from propietarios_inmuebles 
where ((tipo_documento = tipo_doc_input_02) and (nro_documento = nro_doc_input_02)));


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
	((nombre_apellido_prop_inm_check_01 = true) or (tipo_nro_doc_prop_inm_check_01 = true))
	or
	((nombre_apellido_prop_inm_check_02 = true) or (tipo_nro_doc_prop_inm_check_02 = true))
	)
	then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR NOMBRES Y APELLIDOS DE LOS PROPIETARIOS -------------'
					'-------- REVISAR TIPOS Y NÚMEROS DE DOCUMENTOS DE LOS PROPIETARIOS ------';
		

	
	elsif (
		((nombre_apellido_prop_inm_check_01 = false) and (tipo_nro_doc_prop_inm_check_01 = false))
		and
		((nombre_apellido_prop_inm_check_02 = false) and (tipo_nro_doc_prop_inm_check_02 = false))
		and
		((nombre_input_01 <> '') and (apellido_input_01 <> ''))
		and
		((nombre_input_02 <> '') and (apellido_input_02 <> ''))
		and
		((edad_input_01 >= 18) and (edad_input_01 <= 200)) 
		and
		((edad_input_02 >= 18) and (edad_input_02 <= 200))
		and
		((fecha_nac_input_01 <= current_date))
		and
		((fecha_nac_input_02 <= current_date))
		and
		((tipo_doc_input_01 <> '') and (nro_doc_input_01 <> ''))
		and
		((tipo_doc_input_02 <> '') and (nro_doc_input_02 <> ''))
		and 
		((direc_input_01 <> '') and (nro_tel_princ_input_01 <> ''))
		and 
		((direc_input_02 <> '') and (nro_tel_princ_input_02 <> ''))
		and 
		((nro_tel_sec_input_01 <> '') and (email_input_01 <> ''))
		and 
		((nro_tel_sec_input_02 <> '') and (email_input_02 <> ''))
		
		) then
	

		
			
		-- ----------------------------------------------------------------
		-- --------------------- PRIMER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA PROPIETARIOS_INMUEBLES 1ER REGISTRO -------------------------------
		

		insert into propietarios_inmuebles (nombre, apellido, edad, fecha_nacimiento , tipo_documento
		, nro_documento , direccion , nro_telefono_principal, nro_telefono_secundario , email ) values
		
		(nombre_input_01 , apellido_input_01 , edad_input_01 , fecha_nac_input_01, tipo_doc_input_01
		, nro_doc_input_01, direc_input_01, nro_tel_princ_input_01, nro_tel_sec_input_01 , email_input_01);
	
	
	
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
		raise notice '-- Inserción del 1er Registro Tabla "propietarios_inmuebles" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_prop_inm;
		raise notice 'Nombre : %', nombre_input_01;
	 	raise notice 'Apellido : %', apellido_input_01;
	  	raise notice 'Edad : %', edad_input_01;
	  	raise notice 'Fecha de Nacimiento : %', fecha_nac_input_01;
	  	raise notice 'Tipo de Documento : %', tipo_doc_input_01;
	  	raise notice 'Número de Documento : %', nro_doc_input_01;
	  	raise notice 'Direccion : %', direc_input_01;
	  	raise notice 'Número de Teléfono Principal : %', nro_tel_princ_input_01;
	   	raise notice 'Número de Teléfono Secundario : %', nro_tel_sec_input_01;
		raise notice 'Email : %', email_input_01;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	
	
		-- ------------------------- FIN TABLA PROPIETARIOS_INMUEBLES 1ER REGISTRO -------------------------------
		-- --------------------------------------------------------------------------------------------------

	
	
			
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 1ER REGISTRO -------------------------------
	
	
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
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';

	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro de Propietario: %' , id_last_prop_inm;
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
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO -------------------------------
		-- --------------------------------------------------------------------------------------------------

	
	
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA PROPIETARIOS_INMUEBLES 2DO REGISTRO -------------------------------
		

		insert into propietarios_inmuebles (nombre, apellido, edad, fecha_nacimiento , tipo_documento
		, nro_documento , direccion , nro_telefono_principal, nro_telefono_secundario , email ) values
		
		(nombre_input_02 , apellido_input_02 , edad_input_02 , fecha_nac_input_02, tipo_doc_input_02
		, nro_doc_input_02, direc_input_02, nro_tel_princ_input_02, nro_tel_sec_input_02 , email_input_02);
	
	
	
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
		raise notice '-- Inserción del 2do Registro Tabla "propietarios_inmuebles" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_prop_inm;
		raise notice 'Nombre : %', nombre_input_02;
	 	raise notice 'Apellido : %', apellido_input_02;
	  	raise notice 'Edad : %', edad_input_02;
	  	raise notice 'Fecha de Nacimiento : %', fecha_nac_input_02;
	  	raise notice 'Tipo de Documento : %', tipo_doc_input_02;
	  	raise notice 'Número de Documento : %', nro_doc_input_02;
	  	raise notice 'Direccion : %', direc_input_02;
	  	raise notice 'Número de Teléfono Principal : %', nro_tel_princ_input_02;
	   	raise notice 'Número de Teléfono Secundario : %', nro_tel_sec_input_02;
		raise notice 'Email : %', email_input_02;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	
	
		-- ------------------------- FIN TABLA PROPIETARIOS_INMUEBLES 2DO REGISTRO -------------------------------
		-- --------------------------------------------------------------------------------------------------

	
	
			
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA LOGS_INSERTS 2DO REGISTRO -------------------------------
	
	
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
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';

	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro de Propietario: %' , id_last_prop_inm;
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
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO -------------------------------
		-- --------------------------------------------------------------------------------------------------


	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_propiedades_inmuebles() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;


-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================================
-- ======= TABLA INMUEBLES_DESCRIPCIONES ===========
-- ================================================




select * from inmuebles_descripciones;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles_descripciones';




-- =================================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA INMUEBLES_DESCRIPCIONES -------
-- ==================================================================================



create or replace function listado_inmuebles_descripciones() returns setof inmuebles_descripciones as $$

declare

	registro_actual_inm_descr RECORD;

begin 
	
	for registro_actual_inm_descr in (select * from inmuebles_descripciones) loop
	
		return next registro_actual_inm_descr;
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;



-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA INMUEBLES_DESCRIPCIONES ------------
-- =======================================================================



select * from inmuebles_descripciones;


create or replace function insertar_registro_inmuebles_descripciones(

sup_total_input decimal, sup_cubierta_input decimal, cant_amb_input int
, cant_dorm_input int, cant_sanit_input int, cant_pat_jard_input int 
, cant_coch_input int, cant_balc_input int, antiguedad_input int

) returns void as $$



declare


-- TABLA INMUEBLES_DESCRIPCIONES

-- Comprobamos que exista un id y cual es el ultimo
id_last_inm_descr_check boolean;
id_last_inm_descr int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos superficie total, superficie cubierta y antiguedad
sup_total_cub_antig_inm_descr_check boolean := exists(
select superficie_total, superficie_cubierta, antiguedad from inmuebles_descripciones 
where ((superficie_total = sup_total_input) and (superficie_cubierta = sup_cubierta_input) and
(antiguedad = antiguedad_input)));


-- TABLA LOGS_INSERTS

uuid_registro_inm_descr uuid;
nombre_tabla_inm_descr varchar := 'inmuebles_descripciones';
accion_inm_descr varchar := 'insert';
fecha_inm_descr date ;
hora_inm_descr time ;
usuario_inm_descr varchar;
usuario_sesion_inm_descr varchar;
db_inm_descr varchar;
db_version_inm_descr varchar;



begin
	


	if((sup_total_cub_antig_inm_descr_check = true)) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR SUPERFICIE TOTAL / CUBIERTA DEL INMUEBLE -------------'
					'-------- REVISAR ANTIGUEDAD DEL INMUEBLE ------';
		

	
	elsif (
		(sup_total_cub_antig_inm_descr_check = false)
		and
		((sup_total_input > 0) and (sup_cubierta_input > 0))
		and 
		((cant_amb_input > 0) and (cant_dorm_input > 0)) 
		and
		((cant_sanit_input > 0) and (cant_pat_jard_input > 0))
		and 
		((cant_coch_input > 0) and (cant_balc_input > 0))
		and 
		((antiguedad_input > 0))
		) then
	
	
		
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES_DESCRIPCIONES  -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into inmuebles_descripciones (
		superficie_total, superficie_cubierta , cantidad_ambientes , cantidad_dormitorios 
		, cantidad_sanitarios , cantidad_patios_jardines , cantidad_cocheras 
		, cantidad_balcones , antiguedad ) values
		
		(sup_total_input , sup_cubierta_input , cant_amb_input , cant_dorm_input 
		, cant_sanit_input , cant_pat_jard_input , cant_coch_input , cant_balc_input 
		, antiguedad_input);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_descr_check := exists(select id from inmuebles_descripciones);
	
		-- Comprobacion id
		if (id_last_inm_descr_check = true) then
			
			id_last_inm_descr := (select max(id) from inmuebles_descripciones);
		
		else 
			
			id_last_inm_descr := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '----------------------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "inmuebles_descripciones" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_inm_descr;
		raise notice 'Superficie Total : %', sup_total_input;
	 	raise notice 'Superficie Cubierta : %', sup_cubierta_input;
	  	raise notice 'Cantidad de Ambientes : %', cant_amb_input;
	  	raise notice 'Cantidad de Dormitorios : %', cant_dorm_input;
	  	raise notice 'Cantidad de Sanitarios : %', cant_sanit_input;
	  	raise notice 'Cantidad de Patios/Jardines : %', cant_pat_jard_input;
	  	raise notice 'Cantidad de Cocheras : %', cant_coch_input;
	  	raise notice 'Cantidad de Balcones : %', cant_balc_input;
	   	raise notice 'Antiguedad : %', antiguedad_input;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	
		-- ------------------------- FIN TABLA INMUEBLES_DESCRIPCIONES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS -------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm_descr , nombre_tabla_inm_descr , accion_inm_descr);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm_descr := (select uuid_registro from logs_inserts where id_registro = id_last_inm_descr);
		fecha_inm_descr := (select fecha from logs_inserts where id_registro = id_last_inm_descr);
		hora_inm_descr := (select hora from logs_inserts where id_registro = id_last_inm_descr);
		usuario_inm_descr := (select usuario from logs_inserts where id_registro = id_last_inm_descr);
		usuario_sesion_inm_descr := (select usuario_sesion from logs_inserts where id_registro = id_last_inm_descr);	
		db_inm_descr := (select db from logs_inserts where id_registro = id_last_inm_descr);
	 	db_version_inm_descr := (select db_version from logs_inserts where id_registro = id_last_inm_descr);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm_descr;
		raise notice 'UUID Registro : %', uuid_registro_inm_descr;
		raise notice 'Tabla : %', nombre_tabla_inm_descr;
		raise notice 'Acción : %', accion_inm_descr;
		raise notice 'Fecha : %', fecha_inm_descr;
		raise notice 'Hora : %', hora_inm_descr;
     	raise notice 'Usuario : %', usuario_inm_descr;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm_descr;
        raise notice 'DB : %', db_inm_descr;
        raise notice 'Versión DB : %', db_version_inm_descr;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS -------------------------------
		-- -------------------------------------------------------------------------------------

	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_inmuebles_descripciones() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 2 REGISTROS TABLA INMUEBLES_DESCRIPCIONES ------------
-- =======================================================================



select * from inmuebles_descripciones;


create or replace function insertar_registros_inmuebles_descripciones(

sup_total_input_01 decimal, sup_cubierta_input_01 decimal, cant_amb_input_01 int
, cant_dorm_input_01 int, cant_sanit_input_01 int, cant_pat_jard_input_01 int 
, cant_coch_input_01 int, cant_balc_input_01 int, antiguedad_input_01 int

,sup_total_input_02 decimal, sup_cubierta_input_02 decimal, cant_amb_input_02 int
, cant_dorm_input_02 int, cant_sanit_input_02 int, cant_pat_jard_input_02 int 
, cant_coch_input_02 int, cant_balc_input_02 int, antiguedad_input_02 int


) returns void as $$



declare


-- TABLA INMUEBLES_DESCRIPCIONES

-- Comprobamos que exista un id y cual es el ultimo
id_last_inm_descr_check boolean;
id_last_inm_descr int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos superficie total, superficie cubierta y antiguedad
sup_total_cub_antig_inm_descr_check_01 boolean := exists(
select superficie_total, superficie_cubierta, antiguedad from inmuebles_descripciones 
where ((superficie_total = sup_total_input_01) and (superficie_cubierta = sup_cubierta_input_01) and
(antiguedad = antiguedad_input_01)));


sup_total_cub_antig_inm_descr_check_02 boolean := exists(
select superficie_total, superficie_cubierta, antiguedad from inmuebles_descripciones 
where ((superficie_total = sup_total_input_02) and (superficie_cubierta = sup_cubierta_input_02) and
(antiguedad = antiguedad_input_02)));



-- TABLA LOGS_INSERTS

uuid_registro_inm_descr uuid;
nombre_tabla_inm_descr varchar := 'inmuebles_descripciones';
accion_inm_descr varchar := 'insert';
fecha_inm_descr date ;
hora_inm_descr time ;
usuario_inm_descr varchar;
usuario_sesion_inm_descr varchar;
db_inm_descr varchar;
db_version_inm_descr varchar;



begin
	


	if(
	(sup_total_cub_antig_inm_descr_check_01 = true) or (sup_total_cub_antig_inm_descr_check_02 = true)
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR SUPERFICIE TOTAL / CUBIERTA DEL INMUEBLE -------------'
					'-------- REVISAR ANTIGUEDAD DEL INMUEBLE ------';
		

	
	elsif (
		((sup_total_cub_antig_inm_descr_check_01 = false) and (sup_total_cub_antig_inm_descr_check_02 = false))
		and
		((sup_total_input_01 > 0) and (sup_total_input_02 > 0)) 
		and 
		((sup_cubierta_input_01 > 0) and (sup_cubierta_input_02 > 0))
		and 
		((cant_amb_input_01 > 0) and (cant_amb_input_02 > 0))
		and 
		((cant_dorm_input_01 > 0) and (cant_dorm_input_02 > 0)) 
		and
		((cant_sanit_input_01 > 0) and (cant_sanit_input_02 > 0)) 
		and 
		((cant_pat_jard_input_01 >= 0) and (cant_pat_jard_input_02 >= 0))
		and 
		((cant_coch_input_01 >= 0) and (cant_coch_input_02 >= 0)) 
		and 
		((cant_balc_input_01 >= 0) and (cant_balc_input_02 >= 0))
		and 
		((antiguedad_input_01 > 0) and (antiguedad_input_02 > 0))
		) then
	
	
		
			
		-- ----------------------------------------------------------------
		-- --------------------- PRIMER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES_DESCRIPCIONES 1ER REGISTRO -------------------------------
		
		--------------------------------------- INSERCION 1ER REGISTRO ----------------------------------------
	
	
		insert into inmuebles_descripciones (
		superficie_total, superficie_cubierta , cantidad_ambientes , cantidad_dormitorios 
		, cantidad_sanitarios , cantidad_patios_jardines , cantidad_cocheras 
		, cantidad_balcones , antiguedad ) values
		
		(sup_total_input_01 , sup_cubierta_input_01 , cant_amb_input_01 , cant_dorm_input_01 
		, cant_sanit_input_01 , cant_pat_jard_input_01 , cant_coch_input_01 , cant_balc_input_01 
		, antiguedad_input_01);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_descr_check := exists(select id from inmuebles_descripciones);
	
		-- Comprobacion id
		if (id_last_inm_descr_check = true) then
			
			id_last_inm_descr := (select max(id) from inmuebles_descripciones);
		
		else 
			
			id_last_inm_descr := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '----------------------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "inmuebles_descripciones" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_inm_descr;
		raise notice 'Superficie Total : %', sup_total_input_01;
	 	raise notice 'Superficie Cubierta : %', sup_cubierta_input_01;
	  	raise notice 'Cantidad de Ambientes : %', cant_amb_input_01;
	  	raise notice 'Cantidad de Dormitorios : %', cant_dorm_input_01;
	  	raise notice 'Cantidad de Sanitarios : %', cant_sanit_input_01;
	  	raise notice 'Cantidad de Patios/Jardines : %', cant_pat_jard_input_01;
	  	raise notice 'Cantidad de Cocheras : %', cant_coch_input_01;
	  	raise notice 'Cantidad de Balcones : %', cant_balc_input_01;
	   	raise notice 'Antiguedad : %', antiguedad_input_01;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	
		-- ------------------------- FIN TABLA INMUEBLES_DESCRIPCIONES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION 1ER REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm_descr , nombre_tabla_inm_descr , accion_inm_descr);
	

	
		--------------------------------------- FIN INSERCION 1ER REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm_descr := (select uuid_registro from logs_inserts where id_registro = id_last_inm_descr);
		fecha_inm_descr := (select fecha from logs_inserts where id_registro = id_last_inm_descr);
		hora_inm_descr := (select hora from logs_inserts where id_registro = id_last_inm_descr);
		usuario_inm_descr := (select usuario from logs_inserts where id_registro = id_last_inm_descr);
		usuario_sesion_inm_descr := (select usuario_sesion from logs_inserts where id_registro = id_last_inm_descr);	
		db_inm_descr := (select db from logs_inserts where id_registro = id_last_inm_descr);
	 	db_version_inm_descr := (select db_version from logs_inserts where id_registro = id_last_inm_descr);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm_descr;
		raise notice 'UUID Registro : %', uuid_registro_inm_descr;
		raise notice 'Tabla : %', nombre_tabla_inm_descr;
		raise notice 'Acción : %', accion_inm_descr;
		raise notice 'Fecha : %', fecha_inm_descr;
		raise notice 'Hora : %', hora_inm_descr;
     	raise notice 'Usuario : %', usuario_inm_descr;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm_descr;
        raise notice 'DB : %', db_inm_descr;
        raise notice 'Versión DB : %', db_version_inm_descr;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------

	

			
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES_DESCRIPCIONES 2DO REGISTRO -------------------------------
		
		--------------------------------------- INSERCION 2DO REGISTRO ----------------------------------------
	
	
		insert into inmuebles_descripciones (
		superficie_total, superficie_cubierta , cantidad_ambientes , cantidad_dormitorios 
		, cantidad_sanitarios , cantidad_patios_jardines , cantidad_cocheras 
		, cantidad_balcones , antiguedad ) values
		
		(sup_total_input_02 , sup_cubierta_input_02 , cant_amb_input_02 , cant_dorm_input_02 
		, cant_sanit_input_02 , cant_pat_jard_input_02 , cant_coch_input_02 , cant_balc_input_02 
		, antiguedad_input_02);
	
		--------------------------------------- FIN INSERCION 2DO REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_descr_check := exists(select id from inmuebles_descripciones);
	
		-- Comprobacion id
		if (id_last_inm_descr_check = true) then
			
			id_last_inm_descr := (select max(id) from inmuebles_descripciones);
		
		else 
			
			id_last_inm_descr := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '----------------------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "inmuebles_descripciones" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_inm_descr;
		raise notice 'Superficie Total : %', sup_total_input_02;
	 	raise notice 'Superficie Cubierta : %', sup_cubierta_input_02;
	  	raise notice 'Cantidad de Ambientes : %', cant_amb_input_02;
	  	raise notice 'Cantidad de Dormitorios : %', cant_dorm_input_02;
	  	raise notice 'Cantidad de Sanitarios : %', cant_sanit_input_02;
	  	raise notice 'Cantidad de Patios/Jardines : %', cant_pat_jard_input_02;
	  	raise notice 'Cantidad de Cocheras : %', cant_coch_input_02;
	  	raise notice 'Cantidad de Balcones : %', cant_balc_input_02;
	   	raise notice 'Antiguedad : %', antiguedad_input_02;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	
		-- ------------------------- FIN TABLA INMUEBLES_DESCRIPCIONES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION 2DO REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm_descr , nombre_tabla_inm_descr , accion_inm_descr);
	

	
		--------------------------------------- FIN INSERCION 2DO REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm_descr := (select uuid_registro from logs_inserts where id_registro = id_last_inm_descr);
		fecha_inm_descr := (select fecha from logs_inserts where id_registro = id_last_inm_descr);
		hora_inm_descr := (select hora from logs_inserts where id_registro = id_last_inm_descr);
		usuario_inm_descr := (select usuario from logs_inserts where id_registro = id_last_inm_descr);
		usuario_sesion_inm_descr := (select usuario_sesion from logs_inserts where id_registro = id_last_inm_descr);	
		db_inm_descr := (select db from logs_inserts where id_registro = id_last_inm_descr);
	 	db_version_inm_descr := (select db_version from logs_inserts where id_registro = id_last_inm_descr);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm_descr;
		raise notice 'UUID Registro : %', uuid_registro_inm_descr;
		raise notice 'Tabla : %', nombre_tabla_inm_descr;
		raise notice 'Acción : %', accion_inm_descr;
		raise notice 'Fecha : %', fecha_inm_descr;
		raise notice 'Hora : %', hora_inm_descr;
     	raise notice 'Usuario : %', usuario_inm_descr;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm_descr;
        raise notice 'DB : %', db_inm_descr;
        raise notice 'Versión DB : %', db_version_inm_descr;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registros_inmuebles_descripciones() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;



-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================================
-- ======= TABLA INMUEBLES_MEDIDAS ===========
-- ================================================




select * from inmuebles_medidas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles_medidas';




-- =================================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA INMUEBLES_MEDIDAS -------
-- ==================================================================================



create or replace function listado_inmuebles_medidas() returns setof inmuebles_medidas as $$

declare

	registro_actual_inm_med RECORD;

begin 
	
	for registro_actual_inm_med in (select * from inmuebles_medidas) loop
	
		return next registro_actual_inm_med;
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;




-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA INMUEBLES_MEDIDAS ------------
-- =======================================================================



select * from inmuebles_medidas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles_medidas';



create or replace function insertar_registro_inmuebles_medidas(

liv_com_input varchar, cocina_input varchar, dormitorio_input varchar
, sanitario_input varchar, patio_jardin_input varchar, cochera_input varchar 
,balcon_input varchar

) returns void as $$



declare


-- TABLA INMUEBLES_MEDIDAS

-- Comprobamos que exista un id y cual es el ultimo
id_last_inm_med_check boolean;
id_last_inm_med int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos Cocina, Dormitorio y Sanitario
cocina_dorm_sanit_inm_med_check boolean := exists(
select cocina, dormitorio, sanitario from inmuebles_medidas 
where ((cocina = cocina_input) and (dormitorio = dormitorio_input) and
(sanitario = sanitario_input)));


-- TABLA LOGS_INSERTS

uuid_registro_inm_med uuid;
nombre_tabla_inm_med varchar := 'inmuebles_medidas';
accion_inm_med varchar := 'insert';
fecha_inm_med date ;
hora_inm_med time ;
usuario_inm_med varchar;
usuario_sesion_inm_med varchar;
db_inm_med varchar;
db_version_inm_med varchar;



begin
	


	if((cocina_dorm_sanit_inm_med_check = true)) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR COCINA / DORMITORIO / SANITARIO DEL INMUEBLE -------------';
		

	
	elsif (
		(cocina_dorm_sanit_inm_med_check = false)
		and
		((liv_com_input <> '') and (cocina_input <> ''))
		and 
		((dormitorio_input <> '') and (sanitario_input <> '')) 
		and
		((patio_jardin_input <> '') and (cochera_input <> ''))
		and 
		((balcon_input <> '')) 
		) then
	
	
		
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES_MEDIDAS  -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into inmuebles_medidas (
		living_comedor, cocina , dormitorio , sanitario , patio_jardin 
		, cochera , balcon ) values
		(liv_com_input , cocina_input , dormitorio_input , sanitario_input 
		, patio_jardin_input , cochera_input , balcon_input );
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_med_check := exists(select id from inmuebles_medidas);
	
		-- Comprobacion id
		if (id_last_inm_med_check = true) then
			
			id_last_inm_med := (select max(id) from inmuebles_medidas);
		
		else 
			
			id_last_inm_med := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '----------------------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "inmuebles_medidas" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_inm_med;
		raise notice 'Living Comedor : %', liv_com_input;
	 	raise notice 'Cocina : %', cocina_input;
	  	raise notice 'Dormitorio : %', dormitorio_input;
	  	raise notice 'Sanitario : %', sanitario_input;
	  	raise notice 'Patio/Jardin : %', patio_jardin_input;
	  	raise notice 'Cochera : %', cochera_input;
	  	raise notice 'Balcon : %', balcon_input;
	   	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
		-- ------------------------- FIN TABLA INMUEBLES_MEDIDAS  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS -------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm_med , nombre_tabla_inm_med , accion_inm_med);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm_med := (select uuid_registro from logs_inserts where id_registro = id_last_inm_med);
		fecha_inm_med := (select fecha from logs_inserts where id_registro = id_last_inm_med);
		hora_inm_med := (select hora from logs_inserts where id_registro = id_last_inm_med);
		usuario_inm_med := (select usuario from logs_inserts where id_registro = id_last_inm_med);
		usuario_sesion_inm_med := (select usuario_sesion from logs_inserts where id_registro = id_last_inm_med);	
		db_inm_med := (select db from logs_inserts where id_registro = id_last_inm_med);
	 	db_version_inm_med := (select db_version from logs_inserts where id_registro = id_last_inm_med);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm_med;
		raise notice 'UUID Registro : %', uuid_registro_inm_med;
		raise notice 'Tabla : %', nombre_tabla_inm_med;
		raise notice 'Acción : %', accion_inm_med;
		raise notice 'Fecha : %', fecha_inm_med;
		raise notice 'Hora : %', hora_inm_med;
     	raise notice 'Usuario : %', usuario_inm_med;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm_med;
        raise notice 'DB : %', db_inm_med;
        raise notice 'Versión DB : %', db_version_inm_med;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS -------------------------------
		-- -------------------------------------------------------------------------------------

	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_inmuebles_medidas() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;




-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 2 REGISTROS TABLA INMUEBLES_MEDIDAS ------------
-- =======================================================================



select * from inmuebles_medidas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles_medidas';



create or replace function insertar_registros_inmuebles_medidas(

liv_com_input_01 varchar, cocina_input_01 varchar, dormitorio_input_01 varchar
, sanitario_input_01 varchar, patio_jardin_input_01 varchar, cochera_input_01 varchar 
,balcon_input_01 varchar

,liv_com_input_02 varchar, cocina_input_02 varchar, dormitorio_input_02 varchar
, sanitario_input_02 varchar, patio_jardin_input_02 varchar, cochera_input_02 varchar 
,balcon_input_02 varchar

) returns void as $$



declare


-- TABLA INMUEBLES_MEDIDAS

-- Comprobamos que exista un id y cual es el ultimo
id_last_inm_med_check boolean;
id_last_inm_med int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos Cocina, Dormitorio y Sanitario
cocina_dorm_sanit_inm_med_check_01 boolean := exists(
select cocina, dormitorio, sanitario from inmuebles_medidas 
where ((cocina = cocina_input_01) and (dormitorio = dormitorio_input_01) and
(sanitario = sanitario_input_01)));


cocina_dorm_sanit_inm_med_check_02 boolean := exists(
select cocina, dormitorio, sanitario from inmuebles_medidas 
where ((cocina = cocina_input_02) and (dormitorio = dormitorio_input_02) and
(sanitario = sanitario_input_02)));



-- TABLA LOGS_INSERTS

uuid_registro_inm_med uuid;
nombre_tabla_inm_med varchar := 'inmuebles_medidas';
accion_inm_med varchar := 'insert';
fecha_inm_med date ;
hora_inm_med time ;
usuario_inm_med varchar;
usuario_sesion_inm_med varchar;
db_inm_med varchar;
db_version_inm_med varchar;



begin
	


	if(
	((cocina_dorm_sanit_inm_med_check_01 = true) and (cocina_dorm_sanit_inm_med_check_02 = true))
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UNO O AMBOS REGISTRO/S REPETIDO/S ========'
						using hint = 
					'-------- REVISAR COCINA / DORMITORIO / SANITARIO DEL INMUEBLE -------------';
		

	
	elsif (
		((cocina_dorm_sanit_inm_med_check_01 = false) and (cocina_dorm_sanit_inm_med_check_02 = false))
		and
		((liv_com_input_01 <> '') and (liv_com_input_02 <> '')) 
		and 
		((cocina_input_01 <> '') and (cocina_input_02 <> ''))
		and 
		((dormitorio_input_01 <> '') and (dormitorio_input_02 <> '')) 
		and 
		((sanitario_input_01 <> '') and (sanitario_input_02 <> '')) 
		and
		((patio_jardin_input_01 <> '') and (patio_jardin_input_02 <> '')) 
		and
		((cochera_input_01 <> '') and (cochera_input_02 <> ''))
		and 
		((balcon_input_01 <> '') and (balcon_input_02 <> '')) 
		) then
	
	
			
		-- ----------------------------------------------------------------
		-- --------------------- PRIMER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES_MEDIDAS 1ER REGISTRO-------------------------------
		
		--------------------------------------- INSERCION 1ER REGISTRO ----------------------------------------
	
	
		insert into inmuebles_medidas (
		living_comedor, cocina , dormitorio , sanitario , patio_jardin 
		, cochera , balcon ) values
		(liv_com_input_01 , cocina_input_01 , dormitorio_input_01 , sanitario_input_01 
		, patio_jardin_input_01 , cochera_input_01 , balcon_input_01 );
	
		--------------------------------------- FIN INSERCION 1ER REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_med_check := exists(select id from inmuebles_medidas);
	
		-- Comprobacion id
		if (id_last_inm_med_check = true) then
			
			id_last_inm_med := (select max(id) from inmuebles_medidas);
		
		else 
			
			id_last_inm_med := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '----------------------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "inmuebles_medidas" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_inm_med;
		raise notice 'Living Comedor : %', liv_com_input_01;
	 	raise notice 'Cocina : %', cocina_input_01;
	  	raise notice 'Dormitorio : %', dormitorio_input_01;
	  	raise notice 'Sanitario : %', sanitario_input_01;
	  	raise notice 'Patio/Jardin : %', patio_jardin_input_01;
	  	raise notice 'Cochera : %', cochera_input_01;
	  	raise notice 'Balcon : %', balcon_input_01;
	   	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
		-- ------------------------- FIN TABLA INMUEBLES_MEDIDAS 1ER REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION 1ER REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm_med , nombre_tabla_inm_med , accion_inm_med);
	

	
		--------------------------------------- FIN INSERCION 1ER REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm_med := (select uuid_registro from logs_inserts where id_registro = id_last_inm_med);
		fecha_inm_med := (select fecha from logs_inserts where id_registro = id_last_inm_med);
		hora_inm_med := (select hora from logs_inserts where id_registro = id_last_inm_med);
		usuario_inm_med := (select usuario from logs_inserts where id_registro = id_last_inm_med);
		usuario_sesion_inm_med := (select usuario_sesion from logs_inserts where id_registro = id_last_inm_med);	
		db_inm_med := (select db from logs_inserts where id_registro = id_last_inm_med);
	 	db_version_inm_med := (select db_version from logs_inserts where id_registro = id_last_inm_med);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm_med;
		raise notice 'UUID Registro : %', uuid_registro_inm_med;
		raise notice 'Tabla : %', nombre_tabla_inm_med;
		raise notice 'Acción : %', accion_inm_med;
		raise notice 'Fecha : %', fecha_inm_med;
		raise notice 'Hora : %', hora_inm_med;
     	raise notice 'Usuario : %', usuario_inm_med;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm_med;
        raise notice 'DB : %', db_inm_med;
        raise notice 'Versión DB : %', db_version_inm_med;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
			
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES_MEDIDAS 2DO REGISTRO-------------------------------
		
		--------------------------------------- INSERCION 2DO REGISTRO ----------------------------------------
	
	
		insert into inmuebles_medidas (
		living_comedor, cocina , dormitorio , sanitario , patio_jardin 
		, cochera , balcon ) values
		(liv_com_input_02 , cocina_input_02 , dormitorio_input_02 , sanitario_input_02 
		, patio_jardin_input_02 , cochera_input_02 , balcon_input_02 );
	
		--------------------------------------- FIN INSERCION 2DO REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_med_check := exists(select id from inmuebles_medidas);
	
		-- Comprobacion id
		if (id_last_inm_med_check = true) then
			
			id_last_inm_med := (select max(id) from inmuebles_medidas);
		
		else 
			
			id_last_inm_med := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '----------------------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "inmuebles_medidas" --';
		raise notice '----------------------------------------------------------';
	
	
		raise notice 'ID : %' , id_last_inm_med;
		raise notice 'Living Comedor : %', liv_com_input_02;
	 	raise notice 'Cocina : %', cocina_input_02;
	  	raise notice 'Dormitorio : %', dormitorio_input_02;
	  	raise notice 'Sanitario : %', sanitario_input_02;
	  	raise notice 'Patio/Jardin : %', patio_jardin_input_02;
	  	raise notice 'Cochera : %', cochera_input_02;
	  	raise notice 'Balcon : %', balcon_input_02;
	   	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
		-- ------------------------- FIN TABLA INMUEBLES_MEDIDAS 2DO REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION 2DO REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm_med , nombre_tabla_inm_med , accion_inm_med);

		--------------------------------------- FIN INSERCION 2DO REGISTRO ----------------------------------------

	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm_med := (select uuid_registro from logs_inserts where id_registro = id_last_inm_med);
		fecha_inm_med := (select fecha from logs_inserts where id_registro = id_last_inm_med);
		hora_inm_med := (select hora from logs_inserts where id_registro = id_last_inm_med);
		usuario_inm_med := (select usuario from logs_inserts where id_registro = id_last_inm_med);
		usuario_sesion_inm_med := (select usuario_sesion from logs_inserts where id_registro = id_last_inm_med);	
		db_inm_med := (select db from logs_inserts where id_registro = id_last_inm_med);
	 	db_version_inm_med := (select db_version from logs_inserts where id_registro = id_last_inm_med);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm_med;
		raise notice 'UUID Registro : %', uuid_registro_inm_med;
		raise notice 'Tabla : %', nombre_tabla_inm_med;
		raise notice 'Acción : %', accion_inm_med;
		raise notice 'Fecha : %', fecha_inm_med;
		raise notice 'Hora : %', hora_inm_med;
     	raise notice 'Usuario : %', usuario_inm_med;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm_med;
        raise notice 'DB : %', db_inm_med;
        raise notice 'Versión DB : %', db_version_inm_med;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registros_inmuebles_medidas() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;




-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ===================================
-- ======= TABLA INMUEBLES ===========
-- ===================================




select * from inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles';




-- =================================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA INMUEBLES --------- -------
-- ==================================================================================



create or replace function listado_inmuebles() returns setof inmuebles as $$

declare

	registro_actual_inm RECORD;

begin 
	
	for registro_actual_inm in (select * from inmuebles) loop
	
		return next registro_actual_inm;
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;



-- VACUUM FULL inmuebles; 


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA INMUEBLES -------------------
-- =======================================================================



select * from inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles';

/*
drop function insertar_registro_inmuebles(
id_prop_inm_input int, id_inm_med_input int, id_inm_descr_input int
, id_of_input int, descr_input varchar, tipo_input varchar 
,estado_inm_input estado_inmueble_enum , precio_inm_usd_input decimal
,direc_input varchar , ubic_input varchar , sitio_web_input varchar);
*/


create or replace function insertar_registros_inmuebles(

id_prop_inm_input int, id_inm_med_input int, id_inm_descr_input int
, id_of_input int, descr_input varchar, tipo_input varchar 
,estado_inm_input estado_inmueble_enum , precio_inm_usd_input decimal
,direc_input varchar , ubic_input varchar , sitio_web_input varchar

) returns void as $$



declare



-- TABLA INMUEBLES

-- Comprobamos que exista un id y cual es el ultimo
id_last_inm_check boolean;
id_last_inm int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos ID del Propietario, ID de Medidas e ID de Descripcion del Inmueble
id_prop_med_descr_inm_check boolean := exists(
select id_propietario_inmueble , id_inmueble_medidas , id_inmueble_descripcion from inmuebles 
where ((id_propietario_inmueble = id_prop_inm_input) and (id_inmueble_medidas = id_inm_med_input) 
and(id_inmueble_descripcion = id_inm_descr_input)));


-- TABLA LOGS_INSERTS

uuid_registro_inm uuid;
nombre_tabla_inm varchar := 'inmuebles';
accion_inm varchar := 'insert';
fecha_inm date ;
hora_inm time ;
usuario_inm varchar;
usuario_sesion_inm varchar;
db_inm varchar;
db_version_inm varchar;



begin
	


	if(
	(id_prop_med_descr_inm_check = true)
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR ID DE PROPIETARIO DEL INMUEBLE -------------'
					'-------- REVISAR ID DE MEDIDAS DEL INMUEBLE -------------'
					'-------- REVISAR ID DE DESCRIPCIÓN DEL INMUEBLE -------------';	
		

	
	elsif (
		((id_prop_med_descr_inm_check = false))
		and
		((id_prop_inm_input > 0) and ( id_inm_med_input > 0))
		and 
		((id_inm_descr_input > 0) and (id_of_input > 0)) 
		and
		(( descr_input  <> '') and (tipo_input <> ''))
		and 
		((precio_inm_usd_input > 0.0))
		and 
		((direc_input <> '') and (ubic_input <> ''))
		and 
		((sitio_web_input <> ''))		
		) then
	
	
		
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES  -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
		
	
		insert into inmuebles (
		id_propietario_inmueble, id_inmueble_medidas , id_inmueble_descripcion 
		, id_oficina , descripcion , tipo , estado_inmueble, precio_inmueble_usd 
		, direccion , ubicacion , sitio_web ) values
		
		(id_prop_inm_input , id_inm_med_input , id_inm_descr_input , id_of_input 
		, descr_input , tipo_input ,estado_inm_input::estado_inmueble_enum , precio_inm_usd_input
		,direc_input , ubic_input  , sitio_web_input
		);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_check := exists(select id from inmuebles);
	
		-- Comprobacion id
		if (id_last_inm_check = true) then
			
			id_last_inm := (select max(id) from inmuebles);
		
		else 
			
			id_last_inm := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "inmuebles" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID del Inmueble: %' , id_last_inm;
		raise notice 'ID Propietario Inmueble: %' , id_prop_inm_input;
		raise notice 'ID Inmueble Medidas : %', id_inm_med_input;
	 	raise notice 'ID Inmueble Descripcion : %', id_inm_descr_input;
	  	raise notice 'ID Oficina : %', id_of_input;
	  	raise notice 'Descripción : %', descr_input;
	  	raise notice 'Tipo : %', tipo_input;
	  	raise notice 'Estado del Inmueble : %', estado_inm_input;
	  	raise notice 'Precio del Inmueble en USD : %', precio_inm_usd_input;
	   	raise notice 'Dirección : %', direc_input;
	    raise notice 'Ubicación : %', ubic_input;
	  	raise notice 'Sitio Web : %', sitio_web_input;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA INMUEBLES_MEDIDAS  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS -------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm , nombre_tabla_inm , accion_inm);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm := (select uuid_registro from logs_inserts where id_registro = id_last_inm);
		fecha_inm := (select fecha from logs_inserts where id_registro = id_last_inm);
		hora_inm := (select hora from logs_inserts where id_registro = id_last_inm);
		usuario_inm := (select usuario from logs_inserts where id_registro = id_last_inm);
		usuario_sesion_inm := (select usuario_sesion from logs_inserts where id_registro = id_last_inm);	
		db_inm := (select db from logs_inserts where id_registro = id_last_inm);
	 	db_version_inm := (select db_version from logs_inserts where id_registro = id_last_inm);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm;
		raise notice 'UUID Registro : %', uuid_registro_inm;
		raise notice 'Tabla : %', nombre_tabla_inm;
		raise notice 'Acción : %', accion_inm;
		raise notice 'Fecha : %', fecha_inm;
		raise notice 'Hora : %', hora_inm;
     	raise notice 'Usuario : %', usuario_inm;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm;
        raise notice 'DB : %', db_inm;
        raise notice 'Versión DB : %', db_version_inm;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS -------------------------------
		-- -------------------------------------------------------------------------------------

	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_inmuebles() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;




-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- =======================================================================
-- ----------- INSERCION DE 2 REGISTROS TABLA INMUEBLES -------------------
-- =======================================================================



select * from inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles';



create or replace function insertar_registros_inmuebles(

id_prop_inm_input_01 int, id_inm_med_input_01 int, id_inm_descr_input_01 int
, id_of_input_01 int, descr_input_01 varchar, tipo_input_01 varchar 
, estado_inm_input_01 estado_inmueble_enum , precio_inm_usd_input_01 decimal
, direc_input_01 varchar , ubic_input_01 varchar , sitio_web_input_01 varchar

, id_prop_inm_input_02 int, id_inm_med_input_02 int, id_inm_descr_input_02 int
, id_of_input_02 int, descr_input_02 varchar, tipo_input_02 varchar 
, estado_inm_input_02 estado_inmueble_enum , precio_inm_usd_input_02 decimal
, direc_input_02 varchar , ubic_input_02 varchar , sitio_web_input_02 varchar

) returns void as $$



declare



-- TABLA INMUEBLES

-- Comprobamos que exista un id y cual es el ultimo
id_last_inm_check boolean;
id_last_inm int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos ID del Propietario, ID de Medidas e ID de Descripcion del Inmueble
id_prop_med_descr_inm_check_01 boolean := exists(
select id_propietario_inmueble , id_inmueble_medidas , id_inmueble_descripcion from inmuebles 
where ((id_propietario_inmueble = id_prop_inm_input_01) and (id_inmueble_medidas = id_inm_med_input_01) 
and (id_inmueble_descripcion = id_inm_descr_input_01)));


id_prop_med_descr_inm_check_02 boolean := exists(
select id_propietario_inmueble , id_inmueble_medidas , id_inmueble_descripcion from inmuebles 
where ((id_propietario_inmueble = id_prop_inm_input_02) and (id_inmueble_medidas = id_inm_med_input_02) 
and (id_inmueble_descripcion = id_inm_descr_input_02)));



-- TABLA LOGS_INSERTS

uuid_registro_inm uuid;
nombre_tabla_inm varchar := 'inmuebles';
accion_inm varchar := 'insert';
fecha_inm date ;
hora_inm time ;
usuario_inm varchar;
usuario_sesion_inm varchar;
db_inm varchar;
db_version_inm varchar;



begin
	


	if(
	((id_prop_med_descr_inm_check_01 = true) and (id_prop_med_descr_inm_check_02 = true))
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UNO O VARIOS REGISTRO/S REPETIDO/S ========'
						using hint = 
					'-------- REVISAR ID DE PROPIETARIO DEL INMUEBLE -------------'
					'-------- REVISAR ID DE MEDIDAS DEL INMUEBLE -------------'
					'-------- REVISAR ID DE DESCRIPCIÓN DEL INMUEBLE -------------';	
		

	
	elsif (
		((id_prop_med_descr_inm_check_01 = false) and (id_prop_med_descr_inm_check_02 = false))
		and
		((id_prop_inm_input_01 > 0) and (id_prop_inm_input_02 > 0)) 
		and 
		((id_inm_med_input_01 > 0) and (id_inm_med_input_02 > 0))
		and 
		((id_inm_descr_input_01 > 0) and (id_inm_descr_input_02 > 0)) 
		and
		((id_of_input_01 > 0) and (id_of_input_02 > 0)) 
		and
		((descr_input_01  <> '') and (descr_input_02  <> '')) 
		and 
		((tipo_input_01 <> '') and (tipo_input_02 <> ''))
		and 
		((precio_inm_usd_input_01 > 0.0) and (precio_inm_usd_input_02 > 0.0))
		and 
		((direc_input_01 <> '') and (direc_input_02 <> '')) 
		and 
		((ubic_input_01 <> '') and (ubic_input_02 <> ''))
		and 
		((sitio_web_input_01 <> '') and (sitio_web_input_02 <> ''))		
		) then
	
	
		
		-- ----------------------------------------------------------------
		-- --------------------- PRIMER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
	
		
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES 1ER REGISTRO  -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
		
	
		insert into inmuebles (
		id_propietario_inmueble, id_inmueble_medidas , id_inmueble_descripcion 
		, id_oficina , descripcion , tipo , estado_inmueble, precio_inmueble_usd 
		, direccion , ubicacion , sitio_web ) values
		
		(id_prop_inm_input_01 , id_inm_med_input_01 , id_inm_descr_input_01 , id_of_input_01 
		, descr_input_01 , tipo_input_01 ,estado_inm_input_01::estado_inmueble_enum , precio_inm_usd_input_01
		,direc_input_01 , ubic_input_01  , sitio_web_input_01
		);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_check := exists(select id from inmuebles);
	
		-- Comprobacion id
		if (id_last_inm_check = true) then
			
			id_last_inm := (select max(id) from inmuebles);
		
		else 
			
			id_last_inm := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "inmuebles" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID del Inmueble: %' , id_last_inm;
		raise notice 'ID Propietario Inmueble: %' , id_prop_inm_input_01;
		raise notice 'ID Inmueble Medidas : %', id_inm_med_input_01;
	 	raise notice 'ID Inmueble Descripcion : %', id_inm_descr_input_01;
	  	raise notice 'ID Oficina : %', id_of_input_01;
	  	raise notice 'Descripción : %', descr_input_01;
	  	raise notice 'Tipo : %', tipo_input_01;
	  	raise notice 'Estado del Inmueble : %', estado_inm_input_01;
	  	raise notice 'Precio del Inmueble en USD : %', precio_inm_usd_input_01;
	   	raise notice 'Dirección : %', direc_input_01;
	    raise notice 'Ubicación : %', ubic_input_01;
	  	raise notice 'Sitio Web : %', sitio_web_input_01;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA INMUEBLES 1ER REGISTRO  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm , nombre_tabla_inm , accion_inm);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm := (select uuid_registro from logs_inserts where id_registro = id_last_inm);
		fecha_inm := (select fecha from logs_inserts where id_registro = id_last_inm);
		hora_inm := (select hora from logs_inserts where id_registro = id_last_inm);
		usuario_inm := (select usuario from logs_inserts where id_registro = id_last_inm);
		usuario_sesion_inm := (select usuario_sesion from logs_inserts where id_registro = id_last_inm);	
		db_inm := (select db from logs_inserts where id_registro = id_last_inm);
	 	db_version_inm := (select db_version from logs_inserts where id_registro = id_last_inm);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm;
		raise notice 'UUID Registro : %', uuid_registro_inm;
		raise notice 'Tabla : %', nombre_tabla_inm;
		raise notice 'Acción : %', accion_inm;
		raise notice 'Fecha : %', fecha_inm;
		raise notice 'Hora : %', hora_inm;
     	raise notice 'Usuario : %', usuario_inm;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm;
        raise notice 'DB : %', db_inm;
        raise notice 'Versión DB : %', db_version_inm;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------
	
	
	
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA INMUEBLES 2DO REGISTRO  -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
		
	
		insert into inmuebles (
		id_propietario_inmueble, id_inmueble_medidas , id_inmueble_descripcion 
		, id_oficina , descripcion , tipo , estado_inmueble, precio_inmueble_usd 
		, direccion , ubicacion , sitio_web ) values
		
		(id_prop_inm_input_02 , id_inm_med_input_02 , id_inm_descr_input_02 , id_of_input_02 
		, descr_input_02 , tipo_input_02 ,estado_inm_input_02::estado_inmueble_enum , precio_inm_usd_input_02
		,direc_input_02 , ubic_input_02  , sitio_web_input_02
		);
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		

	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_inm_check := exists(select id from inmuebles);
	
		-- Comprobacion id
		if (id_last_inm_check = true) then
			
			id_last_inm := (select max(id) from inmuebles);
		
		else 
			
			id_last_inm := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "inmuebles" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID del Inmueble: %' , id_last_inm;
		raise notice 'ID Propietario Inmueble: %' , id_prop_inm_input_02;
		raise notice 'ID Inmueble Medidas : %', id_inm_med_input_02;
	 	raise notice 'ID Inmueble Descripcion : %', id_inm_descr_input_02;
	  	raise notice 'ID Oficina : %', id_of_input_02;
	  	raise notice 'Descripción : %', descr_input_02;
	  	raise notice 'Tipo : %', tipo_input_02;
	  	raise notice 'Estado del Inmueble : %', estado_inm_input_02;
	  	raise notice 'Precio del Inmueble en USD : %', precio_inm_usd_input_02;
	   	raise notice 'Dirección : %', direc_input_02;
	    raise notice 'Ubicación : %', ubic_input_02;
	  	raise notice 'Sitio Web : %', sitio_web_input_02;
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA INMUEBLES 2DO REGISTRO  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_inm , nombre_tabla_inm , accion_inm);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm := (select uuid_registro from logs_inserts where id_registro = id_last_inm);
		fecha_inm := (select fecha from logs_inserts where id_registro = id_last_inm);
		hora_inm := (select hora from logs_inserts where id_registro = id_last_inm);
		usuario_inm := (select usuario from logs_inserts where id_registro = id_last_inm);
		usuario_sesion_inm := (select usuario_sesion from logs_inserts where id_registro = id_last_inm);	
		db_inm := (select db from logs_inserts where id_registro = id_last_inm);
	 	db_version_inm := (select db_version from logs_inserts where id_registro = id_last_inm);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_inm;
		raise notice 'UUID Registro : %', uuid_registro_inm;
		raise notice 'Tabla : %', nombre_tabla_inm;
		raise notice 'Acción : %', accion_inm;
		raise notice 'Fecha : %', fecha_inm;
		raise notice 'Hora : %', hora_inm;
     	raise notice 'Usuario : %', usuario_inm;
        raise notice 'Sesión de Usuario : %', usuario_sesion_inm;
        raise notice 'DB : %', db_inm;
        raise notice 'Versión DB : %', db_version_inm;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------
	
	
	
	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registros_inmuebles() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;





-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ===================================
-- ======= TABLA CLIENTES ===========
-- ===================================




select * from clientes;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'clientes';




-- =================================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA CLIENTES --------- -------
-- ==================================================================================



create or replace function listado_clientes() returns setof clientes as $$

declare

	registro_actual_cli RECORD;

begin 
	
	for registro_actual_cli in (select * from clientes) loop
	
		return next registro_actual_cli;
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;




-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA CLIENTES -------------------
-- =======================================================================





select * from clientes;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'clientes';





create or replace function insertar_registro_clientes(

nom_input varchar, apell_input varchar, edad_input int
, fech_nac_input date, tip_doc_input varchar
, nro_doc_input varchar , direc_input varchar
, nro_tel_princ_input varchar , nro_tel_sec_input varchar
, email_input varchar , fecha_alta_input date

) returns void as $$



declare



-- TABLA clientes

-- Comprobamos que exista un id y cual es el ultimo
id_last_cli_check boolean;
id_last_cli int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos Nombre, Apellido y Nro de Documento  
nom_apell_nro_doc_cli_check boolean := exists(
select nombre, apellido, nro_documento from clientes 
where ((nombre = nom_input) and (apellido = apell_input) 
and(nro_documento = nro_doc_input)));


-- TABLA LOGS_INSERTS

uuid_registro_cli uuid;
nombre_tabla_cli varchar := 'clientes';
accion_cli varchar := 'insert';
fecha_cli date ;
hora_cli time ;
usuario_cli varchar;
usuario_sesion_cli varchar;
db_cli varchar;
db_version_cli varchar;



begin
	


	if(
	(nom_apell_nro_doc_cli_check = true)
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR NOMBRE Y/O APELLIDO DEL CLIENTE -------------'
					'-------- REVISAR NÚMERO DE DOCUMENTO DEL CLIENTE -------------';
						
		

	
	elsif (
		((nom_input <> '') and (apell_input <> ''))
		and
		((edad_input > 0) and ( fech_nac_input <=  current_date))
		and 
		((tip_doc_input <> '') and (nro_doc_input <> '')) 
		and 
		((direc_input <> ''))
		and
		((nro_tel_princ_input <> '') and (nro_tel_sec_input <> '')) 
		and
		((email_input <> '') and (fecha_alta_input <= current_date))
		) then
			
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA CLIENTES -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
		
	
		insert into clientes (
		nombre , apellido , edad , fecha_nacimiento , tipo_documento 
		, nro_documento , direccion , nro_telefono_principal 
		, nro_telefono_secundario , email , fecha_alta ) values
		
		(nom_input , apell_input , edad_input, fech_nac_input::date
		, tip_doc_input, nro_doc_input , direc_input , nro_tel_princ_input 
		, nro_tel_sec_input , email_input , fecha_alta_input::date);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_cli_check := exists(select id from clientes);
	
		-- Comprobacion id
		if (id_last_cli_check = true) then
			
			id_last_cli := (select max(id) from clientes);
		
		else 
			
			id_last_cli := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción Registro Tabla "clientes" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID del Cliente: %' , id_last_cli;
		raise notice 'Nombre: %' , nom_input;
		raise notice 'Apellido: %', apell_input;
	 	raise notice 'Edad : %', edad_input;
	  	raise notice 'Fecha de Nacimiento : %', fech_nac_input;
	  	raise notice 'Tipo de Documento : %', tip_doc_input;
	  	raise notice 'Número de Documento : %', nro_doc_input;
	  	raise notice 'Dirección : %', direc_input;
	  	raise notice 'Número Telefono Principal : %', nro_tel_princ_input;
	  	raise notice 'Número Telefono Secundario: %', nro_tel_sec_input;
	  	raise notice 'Email: %', email_input;
		raise notice 'Fecha de Alta: %', fecha_alta_input;
	  	raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA CLIENTES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS -------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_cli , nombre_tabla_cli , accion_cli);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_cli := (select uuid_registro from logs_inserts where id_registro = id_last_cli);
		fecha_cli := (select fecha from logs_inserts where id_registro = id_last_cli);
		hora_cli := (select hora from logs_inserts where id_registro = id_last_cli);
		usuario_cli := (select usuario from logs_inserts where id_registro = id_last_cli);
		usuario_sesion_cli := (select usuario_sesion from logs_inserts where id_registro = id_last_cli);	
		db_cli := (select db from logs_inserts where id_registro = id_last_cli);
	 	db_version_cli := (select db_version from logs_inserts where id_registro = id_last_cli);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_cli;
		raise notice 'UUID Registro : %', uuid_registro_cli;
		raise notice 'Tabla : %', nombre_tabla_cli;
		raise notice 'Acción : %', accion_cli;
		raise notice 'Fecha : %', fecha_cli;
		raise notice 'Hora : %', hora_cli;
     	raise notice 'Usuario : %', usuario_cli;
        raise notice 'Sesión de Usuario : %', usuario_sesion_cli;
        raise notice 'DB : %', db_cli;
        raise notice 'Versión DB : %', db_version_cli;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS -------------------------------
		-- -------------------------------------------------------------------------------------

	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_clientes() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;





-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------



-- =======================================================================
-- ----------- INSERCION DE 2 REGISTROS TABLA CLIENTES -------------------
-- =======================================================================





create or replace function insertar_registros_clientes(

nom_input_01 varchar, apell_input_01 varchar, edad_input_01 int
, fech_nac_input_01 date, tip_doc_input_01 varchar
, nro_doc_input_01 varchar , direc_input_01 varchar
, nro_tel_princ_input_01 varchar , nro_tel_sec_input_01 varchar
, email_input_01 varchar , fecha_alta_input_01 date

, nom_input_02 varchar, apell_input_02 varchar, edad_input_02 int
, fech_nac_input_02 date, tip_doc_input_02 varchar
, nro_doc_input_02 varchar, direc_input_02 varchar
, nro_tel_princ_input_02 varchar , nro_tel_sec_input_02 varchar
, email_input_02 varchar , fecha_alta_input_02 date


) returns void as $$



declare



-- TABLA clientes

-- Comprobamos que exista un id y cual es el ultimo
id_last_cli_check boolean;
id_last_cli int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos Nombre, Apellido y Nro de Documento  
nom_apell_nro_doc_cli_check_01 boolean := exists(
select nombre, apellido, nro_documento from clientes 
where ((nombre = nom_input_01) and (apellido = apell_input_01) 
and(nro_documento = nro_doc_input_01)));

nom_apell_nro_doc_cli_check_02 boolean := exists(
select nombre, apellido, nro_documento from clientes 
where ((nombre = nom_input_02) and (apellido = apell_input_02) 
and(nro_documento = nro_doc_input_02)));





-- TABLA LOGS_INSERTS

uuid_registro_cli uuid;
nombre_tabla_cli varchar := 'clientes';
accion_cli varchar := 'insert';
fecha_cli date ;
hora_cli time ;
usuario_cli varchar;
usuario_sesion_cli varchar;
db_cli varchar;
db_version_cli varchar;



begin
	


	if(
	((nom_apell_nro_doc_cli_check_01 = true) and (nom_apell_nro_doc_cli_check_02 = true))
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR NOMBRE Y/O APELLIDO DE LOS CLIENTES -------------'
					'-------- REVISAR NÚMERO DE DOCUMENTO DE LOS CLIENTES -------------';
						
		

	
	elsif (
		((nom_input_01 <> '') and (nom_input_02 <> '')) 
		and 
		((apell_input_01 <> '') and (apell_input_02 <> ''))
		and
		((edad_input_01 > 0) and (edad_input_02 > 0)) 
		and 
		((fech_nac_input_01 <=  current_date) and (fech_nac_input_02 <=  current_date))
		and 
		((tip_doc_input_01 <> '') and (tip_doc_input_02 <> ''))
		and 
		((nro_doc_input_01 <> '') and (nro_doc_input_02 <> '')) 
		and 
		((direc_input_01 <> '') and (direc_input_02 <> ''))
		and
		((nro_tel_princ_input_01 <> '') and (nro_tel_princ_input_02 <> ''))
		and 
		((nro_tel_sec_input_01 <> '') and (nro_tel_sec_input_02 <> '')) 
		and
		((email_input_01 <> '') and (email_input_02 <> ''))
		and 
		((fecha_alta_input_01 <= current_date) and (fecha_alta_input_02 <= current_date))
		) then
			
		
		
		
		-- ----------------------------------------------------------------
		-- --------------------- PRIMER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA CLIENTES -------------------------------
		
		--------------------------------------- INSERCION 1ER REGISTRO ----------------------------------------
		
	
		insert into clientes (
		nombre , apellido , edad , fecha_nacimiento , tipo_documento 
		, nro_documento , direccion , nro_telefono_principal 
		, nro_telefono_secundario , email , fecha_alta ) values
		
		(nom_input_01 , apell_input_01 , edad_input_01, fech_nac_input_01::date
		, tip_doc_input_01, nro_doc_input_01 , direc_input_01 , nro_tel_princ_input_01
		, nro_tel_sec_input_01 , email_input_01 , fecha_alta_input_01::date);
	
	
		--------------------------------------- FIN INSERCION 1ER REGISTRO ----------------------------------------
		
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_cli_check := exists(select id from clientes);
	
		-- Comprobacion id
		if (id_last_cli_check = true) then
			
			id_last_cli := (select max(id) from clientes);
		
		else 
			
			id_last_cli := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción 1 er Registro Tabla "clientes" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID del Cliente: %' , id_last_cli;
		raise notice 'Nombre: %' , nom_input_01;
		raise notice 'Apellido: %', apell_input_01;
	 	raise notice 'Edad : %', edad_input_01;
	  	raise notice 'Fecha de Nacimiento : %', fech_nac_input_01;
	  	raise notice 'Tipo de Documento : %', tip_doc_input_01;
	  	raise notice 'Número de Documento : %', nro_doc_input_01;
	  	raise notice 'Dirección : %', direc_input_01;
	  	raise notice 'Número Telefono Principal : %', nro_tel_princ_input_01;
	  	raise notice 'Número Telefono Secundario: %', nro_tel_sec_input_01;
	  	raise notice 'Email: %', email_input_01;
		raise notice 'Fecha de Alta: %', fecha_alta_input_01;
	  	raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA CLIENTES 1ER REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_cli , nombre_tabla_cli , accion_cli);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_cli := (select uuid_registro from logs_inserts where id_registro = id_last_cli);
		fecha_cli := (select fecha from logs_inserts where id_registro = id_last_cli);
		hora_cli := (select hora from logs_inserts where id_registro = id_last_cli);
		usuario_cli := (select usuario from logs_inserts where id_registro = id_last_cli);
		usuario_sesion_cli := (select usuario_sesion from logs_inserts where id_registro = id_last_cli);	
		db_cli := (select db from logs_inserts where id_registro = id_last_cli);
	 	db_version_cli := (select db_version from logs_inserts where id_registro = id_last_cli);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_cli;
		raise notice 'UUID Registro : %', uuid_registro_cli;
		raise notice 'Tabla : %', nombre_tabla_cli;
		raise notice 'Acción : %', accion_cli;
		raise notice 'Fecha : %', fecha_cli;
		raise notice 'Hora : %', hora_cli;
     	raise notice 'Usuario : %', usuario_cli;
        raise notice 'Sesión de Usuario : %', usuario_sesion_cli;
        raise notice 'DB : %', db_cli;
        raise notice 'Versión DB : %', db_version_cli;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------
		
	
	
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA CLIENTES -------------------------------
		
		--------------------------------------- INSERCION 2DO REGISTRO ----------------------------------------
		
	
		insert into clientes (
		nombre , apellido , edad , fecha_nacimiento , tipo_documento 
		, nro_documento , direccion , nro_telefono_principal 
		, nro_telefono_secundario , email , fecha_alta ) values
		
		(nom_input_02 , apell_input_02 , edad_input_02, fech_nac_input_02::date
		, tip_doc_input_02, nro_doc_input_02 , direc_input_02 , nro_tel_princ_input_02
		, nro_tel_sec_input_02 , email_input_02 , fecha_alta_input_02::date);
	
	
		--------------------------------------- FIN INSERCION 2D0 REGISTRO ----------------------------------------
		
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_cli_check := exists(select id from clientes);
	
		-- Comprobacion id
		if (id_last_cli_check = true) then
			
			id_last_cli := (select max(id) from clientes);
		
		else 
			
			id_last_cli := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "clientes" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID del Cliente: %' , id_last_cli;
		raise notice 'Nombre: %' , nom_input_02;
		raise notice 'Apellido: %', apell_input_02;
	 	raise notice 'Edad : %', edad_input_02;
	  	raise notice 'Fecha de Nacimiento : %', fech_nac_input_02;
	  	raise notice 'Tipo de Documento : %', tip_doc_input_02;
	  	raise notice 'Número de Documento : %', nro_doc_input_02;
	  	raise notice 'Dirección : %', direc_input_02;
	  	raise notice 'Número Telefono Principal : %', nro_tel_princ_input_02;
	  	raise notice 'Número Telefono Secundario: %', nro_tel_sec_input_02;
	  	raise notice 'Email: %', email_input_02;
		raise notice 'Fecha de Alta: %', fecha_alta_input_02;
	  	raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA CLIENTES 2DO REGISTRO -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_cli , nombre_tabla_cli , accion_cli);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_cli := (select uuid_registro from logs_inserts where id_registro = id_last_cli);
		fecha_cli := (select fecha from logs_inserts where id_registro = id_last_cli);
		hora_cli := (select hora from logs_inserts where id_registro = id_last_cli);
		usuario_cli := (select usuario from logs_inserts where id_registro = id_last_cli);
		usuario_sesion_cli := (select usuario_sesion from logs_inserts where id_registro = id_last_cli);	
		db_cli := (select db from logs_inserts where id_registro = id_last_cli);
	 	db_version_cli := (select db_version from logs_inserts where id_registro = id_last_cli);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_cli;
		raise notice 'UUID Registro : %', uuid_registro_cli;
		raise notice 'Tabla : %', nombre_tabla_cli;
		raise notice 'Acción : %', accion_cli;
		raise notice 'Fecha : %', fecha_cli;
		raise notice 'Hora : %', hora_cli;
     	raise notice 'Usuario : %', usuario_cli;
        raise notice 'Sesión de Usuario : %', usuario_sesion_cli;
        raise notice 'DB : %', db_cli;
        raise notice 'Versión DB : %', db_version_cli;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------
		

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registros_clientes() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;





-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ===================================
-- ======= TABLA CITAS_INMUEBLES ===========
-- ===================================




select * from citas_inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'citas_inmuebles';




-- =================================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA CITAS_INMUEBLES --------- -------
-- ==================================================================================



create or replace function listado_citas_inmuebles() returns setof citas_inmuebles as $$

declare

	registro_actual_cit_inm RECORD;

begin 
	
	for registro_actual_cit_inm in (select * from citas_inmuebles) loop
	
		return next registro_actual_cit_inm;
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;





-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 1 REGISTRO TABLA CITAS_INMUEBLES -------------------
-- =======================================================================





select * from citas_inmuebles;


select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'citas_inmuebles';





create or replace function insertar_registro_citas_inmuebles(

id_inm_input int, id_empl_input int, id_cli_input int
, est_cit_input estado_cita_enum, descr_cit_input varchar
, fecha_cit_input date , hora_cit_input time

) returns void as $$



declare



-- TABLA citas_inmuebles

-- Comprobamos que exista un id y cual es el ultimo
id_last_cit_inm_check boolean;
id_last_cit_inm int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos ID del Inmueble, Fecha y Hora de Cita  
id_inm_fecha_hora_cita_inm_check boolean := exists(
select id_inmueble , fecha_cita , hora_cita from citas_inmuebles 
where ((id_inmueble = id_inm_input) and (fecha_cita = fecha_cit_input) 
and(hora_cita = hora_cit_input)));


-- TABLA LOGS_INSERTS

uuid_registro_cit_inm uuid;
nombre_tabla_cit_inm varchar := 'citas_inmuebles';
accion_cit_inm varchar := 'insert';
fecha_cit_inm date ;
hora_cit_inm time ;
usuario_cit_inm varchar;
usuario_sesion_cit_inm varchar;
db_cit_inm varchar;
db_version_cit_inm varchar;



begin
	


	if(
	(id_inm_fecha_hora_cita_inm_check = true)
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN REGISTRO REPETIDO ========'
						using hint = 
					'-------- REVISAR ID DEL INMUEBLE -------------'
					'-------- REVISAR FECHA Y/O HORA DE LA CITA DEL INMUEBLE -------------';
						
		

	
	elsif (
		((id_inm_fecha_hora_cita_inm_check = false))
		and
		((id_inm_input > 0) and ( id_empl_input > 0))
		and 
		((id_cli_input > 0)) 
		and 
		((est_cit_input = 'PENDIENTE') or (est_cit_input = 'COMPLETADA') or
		(est_cit_input = 'INCOMPLETA')) 
		and
		((descr_cit_input <> ''))
		and 
		((fecha_cit_input <= current_date) or (fecha_cit_input >= current_date))	
		) then
			
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA CITAS_INMUEBLES  -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
		
	
		insert into citas_inmuebles (
		id_inmueble, id_empleado , id_cliente, estado_cita , descripcion_cita
		, fecha_cita , hora_cita) values
		
		(id_inm_input , id_empl_input , id_cli_input, est_cit_input::estado_cita_enum
		, descr_cit_input, fecha_cit_input::date , hora_cit_input::time);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_cit_inm_check := exists(select id from citas_inmuebles);
	
		-- Comprobacion id
		if (id_last_cit_inm_check = true) then
			
			id_last_cit_inm := (select max(id) from citas_inmuebles);
		
		else 
			
			id_last_cit_inm := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción Registro Tabla "citas_inmuebles" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID de la Cita: %' , id_last_cit_inm;
		raise notice 'ID del Inmueble: %' , id_inm_input;
		raise notice 'ID del Empleado : %', id_empl_input;
	 	raise notice 'ID del Cliente : %', id_cli_input;
	  	raise notice 'Estado de la Cita : %', est_cit_input;
	  	raise notice 'Descripción de la Cita : %', descr_cit_input;
	  	raise notice 'Fecha de la Cita : %', fecha_cit_input;
	  	raise notice 'Hora de la Cita : %', hora_cit_input;
	  	raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA CITAS_INMUEBLES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS -------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_cit_inm , nombre_tabla_cit_inm , accion_cit_inm);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_cit_inm := (select uuid_registro from logs_inserts where id_registro = id_last_cit_inm);
		fecha_cit_inm := (select fecha from logs_inserts where id_registro = id_last_cit_inm);
		hora_cit_inm := (select hora from logs_inserts where id_registro = id_last_cit_inm);
		usuario_cit_inm := (select usuario from logs_inserts where id_registro = id_last_cit_inm);
		usuario_sesion_cit_inm := (select usuario_sesion from logs_inserts where id_registro = id_last_cit_inm);	
		db_cit_inm := (select db from logs_inserts where id_registro = id_last_cit_inm);
	 	db_version_cit_inm := (select db_version from logs_inserts where id_registro = id_last_cit_inm);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_cit_inm;
		raise notice 'UUID Registro : %', uuid_registro_cit_inm;
		raise notice 'Tabla : %', nombre_tabla_cit_inm;
		raise notice 'Acción : %', accion_cit_inm;
		raise notice 'Fecha : %', fecha_cit_inm;
		raise notice 'Hora : %', hora_cit_inm;
     	raise notice 'Usuario : %', usuario_cit_inm;
        raise notice 'Sesión de Usuario : %', usuario_sesion_cit_inm;
        raise notice 'DB : %', db_cit_inm;
        raise notice 'Versión DB : %', db_version_cit_inm;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS -------------------------------
		-- -------------------------------------------------------------------------------------

	

	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_citas_inmuebles() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;






-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- =======================================================================
-- ----------- INSERCION DE 2 REGISTROS TABLA CITAS_INMUEBLES -------------------
-- =======================================================================





select * from citas_inmuebles;


select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'citas_inmuebles';





create or replace function insertar_registros_citas_inmuebles(

id_inm_input_01 int, id_empl_input_01 int, id_cli_input_01 int
, est_cit_input_01 estado_cita_enum, descr_cit_input_01 varchar
, fecha_cit_input_01 date , hora_cit_input_01 time

,id_inm_input_02 int, id_empl_input_02 int, id_cli_input_02 int
, est_cit_input_02 estado_cita_enum, descr_cit_input_02 varchar
, fecha_cit_input_02 date , hora_cit_input_02 time


) returns void as $$



declare



-- TABLA citas_inmuebles

-- Comprobamos que exista un id y cual es el ultimo
id_last_cit_inm_check boolean;
id_last_cit_inm int;

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
-- Comprobamos ID del Inmueble, Fecha y Hora de Cita  
id_inm_fecha_hora_cita_inm_check_01 boolean := exists(
select id_inmueble , fecha_cita , hora_cita from citas_inmuebles 
where ((id_inmueble = id_inm_input_01) and (fecha_cita = fecha_cit_input_01) 
and(hora_cita = hora_cit_input_01)));


id_inm_fecha_hora_cita_inm_check_02 boolean := exists(
select id_inmueble , fecha_cita , hora_cita from citas_inmuebles 
where ((id_inmueble = id_inm_input_02) and (fecha_cita = fecha_cit_input_02) 
and(hora_cita = hora_cit_input_02)));




-- TABLA LOGS_INSERTS

uuid_registro_cit_inm uuid;
nombre_tabla_cit_inm varchar := 'citas_inmuebles';
accion_cit_inm varchar := 'insert';
fecha_cit_inm date ;
hora_cit_inm time ;
usuario_cit_inm varchar;
usuario_sesion_cit_inm varchar;
db_cit_inm varchar;
db_version_cit_inm varchar;



begin
	


	if(
	((id_inm_fecha_hora_cita_inm_check_01 = true) and (id_inm_fecha_hora_cita_inm_check_02 = true))
	) then
	
		raise exception '====== NO SE PUEDE INGRESAR UN/VARIOS REGISTRO/S REPETIDO/S ========'
						using hint = 
					'-------- REVISAR ID DEL/DE LOS INMUEBLE/S -------------'
					'-------- REVISAR FECHA Y/O HORA DE LA/S CITA/S DEL/DE LOS INMUEBLE/S -------------';
						
		

	
	elsif (
		((id_inm_fecha_hora_cita_inm_check_01 = false) and (id_inm_fecha_hora_cita_inm_check_02 = false))
		and
		((id_inm_input_01 > 0) and ( id_empl_input_02 > 0))
		and 
		((id_cli_input_01 > 0) and (id_cli_input_02 > 0)) 
		and 
		((est_cit_input_01 = 'PENDIENTE') or (est_cit_input_02 = 'PENDIENTE')) 
		and 
		((est_cit_input_01 = 'COMPLETADA') or (est_cit_input_02 = 'COMPLETADA'))
		and
		((est_cit_input_01 = 'INCOMPLETA') or (est_cit_input_02 = 'INCOMPLETA')) 
		and
		((descr_cit_input_01 <> '') or (descr_cit_input_02 <> ''))
		and 
		((fecha_cit_input_01 <= current_date) or (fecha_cit_input_01 >= current_date))
		and 
		((fecha_cit_input_02 <= current_date) or (fecha_cit_input_02 >= current_date))		
		) then
			
		
		
		-- ----------------------------------------------------------------
		-- --------------------- PRIMER REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
		
		
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA CITAS_INMUEBLES 1ER REGISTRO -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
		
	
		insert into citas_inmuebles (
		id_inmueble, id_empleado , id_cliente, estado_cita , descripcion_cita
		, fecha_cita , hora_cita) values
		
		(id_inm_input_01 , id_empl_input_01 , id_cli_input_01, est_cit_input_01::estado_cita_enum
		, descr_cit_input_01, fecha_cit_input_01::date , hora_cit_input_01::time);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_cit_inm_check := exists(select id from citas_inmuebles);
	
		-- Comprobacion id
		if (id_last_cit_inm_check = true) then
			
			id_last_cit_inm := (select max(id) from citas_inmuebles);
		
		else 
			
			id_last_cit_inm := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "citas_inmuebles" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID de la Cita: %' , id_last_cit_inm;
		raise notice 'ID del Inmueble: %' , id_inm_input_01;
		raise notice 'ID del Empleado : %', id_empl_input_01;
	 	raise notice 'ID del Cliente : %', id_cli_input_01;
	  	raise notice 'Estado de la Cita : %', est_cit_input_01;
	  	raise notice 'Descripción de la Cita : %', descr_cit_input_01;
	  	raise notice 'Fecha de la Cita : %', fecha_cit_input_01;
	  	raise notice 'Hora de la Cita : %', hora_cit_input_01;
	  	raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA CITAS_INMUEBLES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_cit_inm , nombre_tabla_cit_inm , accion_cit_inm);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_cit_inm := (select uuid_registro from logs_inserts where id_registro = id_last_cit_inm);
		fecha_cit_inm := (select fecha from logs_inserts where id_registro = id_last_cit_inm);
		hora_cit_inm := (select hora from logs_inserts where id_registro = id_last_cit_inm);
		usuario_cit_inm := (select usuario from logs_inserts where id_registro = id_last_cit_inm);
		usuario_sesion_cit_inm := (select usuario_sesion from logs_inserts where id_registro = id_last_cit_inm);	
		db_cit_inm := (select db from logs_inserts where id_registro = id_last_cit_inm);
	 	db_version_cit_inm := (select db_version from logs_inserts where id_registro = id_last_cit_inm);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 1er Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_cit_inm;
		raise notice 'UUID Registro : %', uuid_registro_cit_inm;
		raise notice 'Tabla : %', nombre_tabla_cit_inm;
		raise notice 'Acción : %', accion_cit_inm;
		raise notice 'Fecha : %', fecha_cit_inm;
		raise notice 'Hora : %', hora_cit_inm;
     	raise notice 'Usuario : %', usuario_cit_inm;
        raise notice 'Sesión de Usuario : %', usuario_sesion_cit_inm;
        raise notice 'DB : %', db_cit_inm;
        raise notice 'Versión DB : %', db_version_cit_inm;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 1ER REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------
	
		
		-- ----------------------------------------------------------------
		-- --------------------- SEGUNDO REGISTRO -------------------------
		-- ----------------------------------------------------------------
	
	
		-- -------------------------------------------------------------------------------------
		-- ------------------------- TABLA CITAS_INMUEBLES 2DO REGISTRO -------------------------------
		
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
		
	
		insert into citas_inmuebles (
		id_inmueble, id_empleado , id_cliente, estado_cita , descripcion_cita
		, fecha_cita , hora_cita) values
		
		(id_inm_input_02 , id_empl_input_02 , id_cli_input_02, est_cit_input_02::estado_cita_enum
		, descr_cit_input_02, fecha_cit_input_02::date , hora_cit_input_02::time);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
		
	
		--------------------------------------- ÚLTIMO ID ----------------------------------------
		
		id_last_cit_inm_check := exists(select id from citas_inmuebles);
	
		-- Comprobacion id
		if (id_last_cit_inm_check = true) then
			
			id_last_cit_inm := (select max(id) from citas_inmuebles);
		
		else 
			
			id_last_cit_inm := 0;
			
		end if;

		--------------------------------------- FIN ÚLTIMO ID ----------------------------------------
	
			
		raise notice '';
		raise notice '---------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "citas_inmuebles" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID de la Cita: %' , id_last_cit_inm;
		raise notice 'ID del Inmueble: %' , id_inm_input_02;
		raise notice 'ID del Empleado : %', id_empl_input_02;
	 	raise notice 'ID del Cliente : %', id_cli_input_02;
	  	raise notice 'Estado de la Cita : %', est_cit_input_02;
	  	raise notice 'Descripción de la Cita : %', descr_cit_input_02;
	  	raise notice 'Fecha de la Cita : %', fecha_cit_input_02;
	  	raise notice 'Hora de la Cita : %', hora_cit_input_02;
	  	raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
		
	
		-- ------------------------- FIN TABLA CITAS_INMUEBLES  -------------------------------
		-- -------------------------------------------------------------------------------------

	
	
	
	
	
		-- -------------------------------------------------------------------------------------
		-- -------------------------TABLA LOGS_INSERTS -------------------------------
		
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_inserts(id_registro, nombre_tabla , accion) values
		
		(id_last_cit_inm , nombre_tabla_cit_inm , accion_cit_inm);
	

	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_cit_inm := (select uuid_registro from logs_inserts where id_registro = id_last_cit_inm);
		fecha_cit_inm := (select fecha from logs_inserts where id_registro = id_last_cit_inm);
		hora_cit_inm := (select hora from logs_inserts where id_registro = id_last_cit_inm);
		usuario_cit_inm := (select usuario from logs_inserts where id_registro = id_last_cit_inm);
		usuario_sesion_cit_inm := (select usuario_sesion from logs_inserts where id_registro = id_last_cit_inm);	
		db_cit_inm := (select db from logs_inserts where id_registro = id_last_cit_inm);
	 	db_version_cit_inm := (select db_version from logs_inserts where id_registro = id_last_cit_inm);
		
	 
	 	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción 2do Registro Tabla "logs_inserts" --';
		raise notice '----------------------------------------------';
	
		raise notice 'ID Registro: %' , id_last_cit_inm;
		raise notice 'UUID Registro : %', uuid_registro_cit_inm;
		raise notice 'Tabla : %', nombre_tabla_cit_inm;
		raise notice 'Acción : %', accion_cit_inm;
		raise notice 'Fecha : %', fecha_cit_inm;
		raise notice 'Hora : %', hora_cit_inm;
     	raise notice 'Usuario : %', usuario_cit_inm;
        raise notice 'Sesión de Usuario : %', usuario_sesion_cit_inm;
        raise notice 'DB : %', db_cit_inm;
        raise notice 'Versión DB : %', db_version_cit_inm;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
		-- ------------------------- FIN TABLA LOGS_INSERTS 2DO REGISTRO-------------------------------
		-- -------------------------------------------------------------------------------------
	
		
	
	
	else
	
	raise exception '======== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registros_citas_inmuebles() ==========='
								using hint = '----------- REVISAR LOS PARAMETROS INGRESADOS ----------------';
		
	end if;
	
	

end;
	
$$ language plpgsql;






-- ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

