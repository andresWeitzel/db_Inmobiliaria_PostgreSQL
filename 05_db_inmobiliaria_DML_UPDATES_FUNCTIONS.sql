/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML UPDATES FUNCTIONS=============
 */



-- -----------------------------------------------------------------------------
-- --------------------------------------------------------------------------------

-- =======================================================================
-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA LOGS_UPDATES-------
-- =======================================================================

create or replace function listado_logs_updates() returns setof logs_updates as $$

declare

	registro_actual_logs_updates RECORD;

begin 
	
	for registro_actual_logs_updates in (select * from logs_updates) loop
	
		return next registro_actual_logs_updates;
	
	end loop;
	return;
	
end;

	
$$ language plpgsql;

-- --------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ===============================
-- ======= TABLA OFICINAS ========
-- ===============================


select listado_oficinas();

select descripcion_oficinas();




-- -----------TODOS LOS CAMPOS------------


create or replace function actualizar_registro_oficinas(id_input int, nombre_input varchar, dir_input varchar
, nro_tel_input varchar, email_input varchar) returns void as $$

declare 


-- Registro Anterior
 id_anterior int:= (select id from oficinas where id=id_input);
 nombre_anterior varchar:= (select nombre from oficinas where id=id_input);
 dir_anterior varchar := (select direccion from oficinas where id=id_input);
 nro_tel_anterior varchar := (select nro_telefono from oficinas where id=id_input);
 email_anterior varchar := (select email from oficinas where id=id_input);


-- TABLA LOGS_UPDATES

uuid_registro_of uuid;
nombre_tabla_of varchar := 'oficinas';
campo_tabla_of varchar := 'all';
accion_of varchar := 'update';
fecha_of date ;
hora_of time ;
usuario_of varchar;
usuario_sesion_of varchar;
db_of varchar;
db_version_of varchar;


id_last_logs_upd int;


begin
	
	
	
	if(
	(id_anterior <= 0) or (id_input <= 0) or
	(nombre_input = '') or (dir_input = '') or 
	(nro_tel_input = '') or (email_input = '')
	) then
	
		raise exception '===== NO SE PUEDE INGRESAR UN REGISTRO CON CAMPOS VACIOS ===== '
						using hint='------- REVISAR LOS CAMPOS DE LA OFICINA -------';
										
									
	
	elsif (
		(nombre_input <> '') and (dir_input <> '') and 
		(nro_tel_input <> '') and (email_input <> '') and
		(id_input > 0) and (id_anterior = id_input)
		) then
	
	
	raise notice '-----------------------------------------------------';
	raise notice '-- Modificaci�n de Todos los Campos Tabla "oficinas" --';
	raise notice '-----------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice 'Nombre : %', nombre_anterior;
	raise notice 'Direcci�n : %', dir_anterior;
	raise notice 'Nro Telefono : %', nro_tel_anterior;
	raise notice 'Email : %', email_anterior;
	
	update oficinas set nombre = nombre_input, direccion = dir_input
	, nro_telefono = nro_tel_input, email = email_input where id = id_input;
	
	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice 'Nombre : %', nombre_input;
	raise notice 'Direcci�n : %', dir_input;
	raise notice 'Nro Telefono : %', nro_tel_input;
	raise notice 'Email : %', email_input;

	raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';	



	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO LOGS_UPDATES----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_of, campo_tabla_of , accion_of);
	
	
		--------------------------------------- FIN INSERCION REGISTRO LOGS_UPDATES ----------------------------------------
	
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
	
		-- Traemos los valores del Registro Actualizado
		uuid_registro_of := (select uuid_registro from logs_updates
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		fecha_of := (select fecha from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		
		hora_of := (select hora from logs_updates
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		usuario_of := (select usuario from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		usuario_sesion_of := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		db_of := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	 	
		db_version_of := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Acci�n : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versi�n DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA ====='
						using hint = '------- actualizar_registro_oficinas(id_input int, nombre_input varchar, dir_input varchar
, nro_tel_input varchar, email_input varchar) ------- ';
		
	end if;
	

end;
	
$$ language plpgsql;






-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ----------- CAMPO NRO_TELEFONO --------------

select listado_oficinas();


-- Cambiamos el Numero a traves del id
create or replace function actualizar_nro_tel_oficinas(id_input int, nro_tel_input varchar) returns void as $$

declare 

id_anterior int := (select id from oficinas where id=id_input);
nro_tel_anterior varchar := (select nro_telefono from oficinas where id=id_input);


-- TABLA LOGS_UPDATES

uuid_registro_of uuid;
nombre_tabla_of varchar := 'oficinas';
campo_tabla_of varchar := 'nro_telefono';
accion_of varchar := 'update';
fecha_of date ;
hora_of time ;
usuario_of varchar;
usuario_sesion_of varchar;
db_of varchar;
db_version_of varchar;


id_last_logs_upd int;


begin 
	
	
	if(
	(id_input <= 0) or 
	(id_anterior <= 0) or
	(nro_tel_input = '')
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO CON CAMPOS VACIOS O QUE NO EXISTAN ===== '
						using hint='------- REVISAR LOS CAMPOS DE LA OFICINA -------';
										
									
	
	elsif (
		(id_input > 0) and 
		(id_anterior = id_input) and
		(nro_tel_input <> '')
		) then
	
	
	
	raise notice '------------------------------------------------------------';
	raise notice '-- Modificaci�n  Campo "nro_telefono" Tabla "oficinas" --';
	raise notice '------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice 'Nro Telefono : %', nro_tel_anterior;
	
	
	update oficinas set nro_telefono = nro_tel_input where id = id_input;

	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice 'Nro Telefono : %', nro_tel_input;

		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';



	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_of, campo_tabla_of , accion_of);
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		fecha_of := (select fecha from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		
		hora_of := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		usuario_of := (select usuario from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		usuario_sesion_of := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		db_of := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	 	
		db_version_of := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_of;
		raise notice 'Tabla : %', nombre_tabla_of;
		raise notice 'Campo : %', campo_tabla_of;
		raise notice 'Acci�n : %', accion_of;
		raise notice 'Fecha : %', fecha_of;
		raise notice 'Hora : %', hora_of;
     	raise notice 'Usuario : %', usuario_of;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_of;
        raise notice 'DB : %', db_of;
        raise notice 'Versi�n DB : %', db_version_of;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '-------actualizar_nro_tel_oficinas(id_input int, nro_tel_input varchar)------- ';
		
	end if;
	

end;



$$ language plpgsql;











-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ----------- DEPURACION GENERAL CAMPO NRO_TELEFONO --------------


select listado_oficinas();


-- Cambiamos el Numero a traves del id
create or replace function depurar_nro_tel_oficinas() returns void as $$

declare 

-- TABLA OFICINAS
id_anterior int;



begin 
	
	id_anterior := (select max(id) from oficinas);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		(id_anterior > 0)
		) then
	
	
	
	raise notice '------------------------------------------------------------';
	raise notice '-- Depuraci�n del Campo "nro_telefono" Tabla "oficinas" --';
	raise notice '------------------------------------------------------------';



	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	--update oficinas set nro_telefono = replace (nro_telefono, '011 ', '11') returning id;

	update oficinas set nro_telefono = replace (nro_telefono, '011', '11');

	-- Si no est� el +54 lo Agregamos
	update oficinas set nro_telefono = replace (nro_telefono, '11 ', '+5411');

	
	-- Reemplazamos los +54911 a +5411 (9 es caracteristica de Celular)
	update oficinas set nro_telefono = replace (nro_telefono, '+54911', '+5411');


	-- Quitamos los guiones
	update oficinas set nro_telefono = replace(nro_telefono, '-', ' ');
	
	
	-- Quitamos los puntos
	 update oficinas set nro_telefono = replace(nro_telefono, '.', ' ');
	
	
		
	-- Quitamos los espacios en Blanco
	 update oficinas set nro_telefono = replace(nro_telefono, ' ', '');
	

	
	
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '-------depurar_nro_tel_oficinas()------- ';
		
	end if;
	

end;



$$ language plpgsql;






-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ----------- DEPURACION GENERAL CAMPO DIRECCION --------------


select listado_oficinas();


-- Cambiamos el Numero a traves del id
create or replace function depurar_dir_oficinas() returns void as $$

declare 


id_anterior int;


begin 
	
	id_anterior := (select max(id) from oficinas);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		(id_anterior > 0)
		) then
	
	
	
	raise notice '---------------------------------------------------------------';
	raise notice '-- Depuraci�n General  Campo "direccion" Tabla "oficinas" --';
	raise notice '---------------------------------------------------------------';

		
	
	-- Quitamos Caracteres Especiales
	update oficinas set direccion = replace(direccion, ',', ' ');



	update oficinas set direccion = replace(direccion, 'N�', ' ');

	
	
	update oficinas set direccion = replace(direccion, '/', '-');


	



else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '-------depurar_dir_oficinas()------- ';
		
	end if;
	

end;



$$ language plpgsql;






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ========================================
-- ======= TABLA OFICINAS_DETALLES ========
-- ========================================

-- --------- CAMPO LOCALIDAD --------------

select listado_oficinas_detalles();


select descripcion_oficinas_detalles();





-- Cambiamos la localidad a traves del id
create or replace function actualizar_loc_oficinas_detalles(id_input int , loc_input varchar) returns void as $$

declare 

id_anterior int := (select id from oficinas_detalles where id=id_input);
loc_anterior varchar := (select localidad from oficinas_detalles where id=id_input);


-- TABLA LOGS_UPDATES

uuid_registro_of_det uuid;
nombre_tabla_of_det varchar := 'oficinas_detalles';
campo_tabla_of_det varchar := 'localidad';
accion_of_det varchar := 'update';
fecha_of_det date ;
hora_of_det time ;
usuario_of_det varchar;
usuario_sesion_of_det varchar;
db_of_det varchar;
db_version_of_det varchar;


id_last_logs_upd int;


begin 
	
	
	if(
	(id_anterior <= 0) or 
	(id_input <= 0)
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(loc_input <> '') and 
		(id_input > 0) and 
		(id_anterior = id_input)
		) then
	
	
	
	raise notice '---------------------------------------------------------------';
	raise notice '-- Modificaci�n  Campo "localidad" Tabla "oficinas_detalles" --';
	raise notice '---------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice 'localidad : %', loc_anterior;
	
	
	update oficinas_detalles set localidad = loc_input where id = id_input;

	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice 'Localidad : %', loc_input;

		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';



	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_of_det, campo_tabla_of_det , accion_of_det);
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of_det := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		fecha_of_det := (select fecha from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		
		hora_of_det := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		usuario_of_det := (select usuario from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		usuario_sesion_of_det := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		db_of_det := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	 	
		db_version_of_det := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_of_det;
		raise notice 'Tabla : %', nombre_tabla_of_det;
		raise notice 'Campo : %', campo_tabla_of_det;
		raise notice 'Acci�n : %', accion_of_det;
		raise notice 'Fecha : %', fecha_of_det;
		raise notice 'Hora : %', hora_of_det;
     	raise notice 'Usuario : %', usuario_of_det;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_of_det;
        raise notice 'DB : %', db_of_det;
        raise notice 'Versi�n DB : %', db_version_of_det;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- actualizar_loc_oficinas_detalles(id_input int , loc_input varchar) ------- ';
		
	end if;
	

end;

$$ language plpgsql;





-- --------- CAMPO TIPO_OFICINA --------------

select listado_oficinas_detalles();


select descripcion_oficinas_detalles();



-- Cambiamos el tipo de oficina enum
create or replace function actualizar_tipo_of_oficinas_detalles(id_input int, tipo_of_input tipo_oficina_enum) returns void as $$

declare 

id_anterior int := (select id from oficinas_detalles where id=id_input);
tipo_of_anterior varchar := (select "tipo_oficina" from oficinas_detalles where id=id_input);



-- TABLA LOGS_UPDATES

uuid_registro_of_det uuid;
nombre_tabla_of_det varchar := 'oficinas_detalles';
campo_tabla_of_det varchar := 'tipo_oficina';
accion_of_det varchar := 'update';
fecha_of_det date ;
hora_of_det time ;
usuario_of_det varchar;
usuario_sesion_of_det varchar;
db_of_det varchar;
db_version_of_det varchar;


id_last_logs_upd int;


begin 
	
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		((tipo_of_input = 'EJECUTIVA') or (tipo_of_input = 'ESTANDAR') or (tipo_of_input = 'PEQUE�A'))
		and 
		((id_input > 0) and (id_anterior = id_input))
		) then
	
	
	
	raise notice '---------------------------------------------------------------';
	raise notice '-- Modificaci�n  Campo "tipo_oficina" Tabla "oficinas_detalles" --';
	raise notice '---------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice 'Tipo Oficina : %', tipo_of_anterior;
	
	
	update oficinas_detalles set tipo_oficina  = tipo_of_input where id = id_input;

	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;	
	raise notice 'Tipo Oficina : %', tipo_of_input;
	
	

		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';



	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_of_det, campo_tabla_of_det , accion_of_det);
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of_det := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		fecha_of_det := (select fecha from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		
		hora_of_det := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		usuario_of_det := (select usuario from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		usuario_sesion_of_det := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		db_of_det := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	 	
		db_version_of_det := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_of_det;
		raise notice 'Tabla : %', nombre_tabla_of_det;
		raise notice 'Campo : %', campo_tabla_of_det;
		raise notice 'Acci�n : %', accion_of_det;
		raise notice 'Fecha : %', fecha_of_det;
		raise notice 'Hora : %', hora_of_det;
     	raise notice 'Usuario : %', usuario_of_det;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_of_det;
        raise notice 'DB : %', db_of_det;
        raise notice 'Versi�n DB : %', db_version_of_det;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- actualizar_tipo_of_oficinas_detalles(id_input int, tipo_of_input tipo_oficina_enum) ------- ';
		
	end if;
	

end;

$$ language plpgsql;







-- --------- CAMPO SUPERFICIE_TOTAL --------------

select listado_oficinas_detalles();


select descripcion_oficinas_detalles();



create or replace function actualizar_sup_total_oficinas_detalles(id_input int, sup_total_input decimal) returns void as $$

declare 

id_anterior int := (select id from oficinas_detalles where id=id_input);
sup_total_anterior varchar := (select superficie_total from oficinas_detalles where id=id_input);


-- TABLA LOGS_UPDATES

uuid_registro_of_det uuid;
nombre_tabla_of_det varchar := 'oficinas_detalles';
campo_tabla_of_det varchar := 'superficie_total';
accion_of_det varchar := 'update';
fecha_of_det date ;
hora_of_det time ;
usuario_of_det varchar;
usuario_sesion_of_det varchar;
db_of_det varchar;
db_version_of_det varchar;


id_last_logs_upd int;


begin 
	
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(sup_total_input > 0.0) and 
		(id_input > 0) and 
		(id_anterior = id_input)
		) then
	
	
	
	raise notice '----------------------------------------------------------------------';
	raise notice '-- Modificaci�n  Campo "superficie_total" Tabla "oficinas_detalles" --';
	raise notice '----------------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice 'Superficie Total : %', sup_total_anterior;
	
	
	update oficinas_detalles set superficie_total  = sup_total_input where id = id_input;

	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;	
	raise notice 'Superficie Total : %', sup_total_input;
	
	

		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';



	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_of_det, campo_tabla_of_det , accion_of_det);
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of_det := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		fecha_of_det := (select fecha from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		
		hora_of_det := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		usuario_of_det := (select usuario from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		usuario_sesion_of_det := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	
		db_of_det := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
	 	
		db_version_of_det := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'oficinas_detalles'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_of_det;
		raise notice 'Tabla : %', nombre_tabla_of_det;
		raise notice 'Campo : %', campo_tabla_of_det;
		raise notice 'Acci�n : %', accion_of_det;
		raise notice 'Fecha : %', fecha_of_det;
		raise notice 'Hora : %', hora_of_det;
     	raise notice 'Usuario : %', usuario_of_det;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_of_det;
        raise notice 'DB : %', db_of_det;
        raise notice 'Versi�n DB : %', db_version_of_det;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- actualizar_sup_total_oficinas_detalles(id_input int, sup_total_input decimal) ------- ';
		
	end if;
	

end;

$$ language plpgsql;






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- =============================================
-- ======= TABLA SERVICIOS_OFICINAS ===========
-- =============================================


-- --------- CAMPOS DESCRIPCION_SERVICIOS---------------


select listado_servicios_oficinas();


-- Depuracion general de descripcion_cita
create or replace function depurar_descripcion_servicios_oficinas() returns void as $$

declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from servicios_oficinas);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
		
	
		
	raise notice '----------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "descripcion_servicios" Tabla "servicios_inmuebles" --';
	raise notice '----------------------------------------------------------------------------------';
	

		

	-- Todas las palabras con su inicial en Mayuscula
	update servicios_oficinas set descripcion_servicios = initcap(descripcion_servicios);
	
	update servicios_oficinas set descripcion_servicios = replace(descripcion_servicios,'-','');
	
	
		
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	


	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_descripcion_servicios_oficias()  ------- ';
		
	end if;
	

end;

$$ language plpgsql;








-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ===================================
-- ======= TABLA EMPLEADOS ===========
-- ===================================


-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

select listado_empleados();

-- Depuracionn general de ambos campos
create or replace function depurar_nomb_apell_empleados() returns void as $$


	
declare 


id_anterior int;


begin 
	
	id_anterior := (select max(id) from empleados);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		(id_anterior > 0)
		) then


	
	raise notice '----------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "nombre" y Campo "apellido" Tabla "empleados" --';
	raise notice '----------------------------------------------------------------------------';

		

		

	-- Todas las palabras con su inicial en Mayuscula
	update empleados set nombre = initcap(nombre);
	update empleados set apellido = initcap(apellido);
	
	-- Quitamos los espacios
	update empleados set nombre = replace(nombre, ' ', '');
	update empleados set apellido = replace(apellido, ' ', '');


		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_nomb_apell_empleados() ------- ';
		
	end if;
	

end;




$$ language plpgsql;






-- ------------------------------------
-- --------- CAMPO CUIL ---------------
-- ------------------------------------


select listado_empleados();

-- actualizacion de cuil por id
create or replace function actualizar_cuil_empleados(id_input int, cuil_input varchar) returns void as $$

declare 

id_anterior int := (select id from empleados where id=id_input);
cuil_anterior varchar := (select cuil from empleados where id=id_input);


-- TABLA LOGS_UPDATES

uuid_registro_empl uuid;
nombre_tabla_empl varchar := 'empleados';
campo_tabla_empl varchar := 'cuil';
accion_empl varchar := 'update';
fecha_empl date ;
hora_empl time ;
usuario_empl varchar;
usuario_sesion_empl varchar;
db_empl varchar;
db_version_empl varchar;


id_last_logs_upd int;


begin 
	
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		((cuil_input <> '') and (id_input > 0) and (id_anterior = id_input))
		) then
	
	
	
	
	raise notice '--------------------------------------------------';
	raise notice '-- Modificaci�n  Campo "cuil" Tabla "empleados" --';
	raise notice '--------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice ' Cuil : %', cuil_anterior;


	--Relleno de Caracteres por la derecha a longitud especificada
	update empleados set cuil = cuil_input where id = id_input;


	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice ' Cuil : %', cuil_input;


		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';
	

	
	
		
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_empl, campo_tabla_empl , accion_empl);
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_empl := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'empleados'));
		
		fecha_empl := (select fecha from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'empleados'));
		
		
		hora_empl := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'empleados'));
		
	
		usuario_empl := (select usuario from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'empleados'));
		
	
		usuario_sesion_empl := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'empleados'));
		
	
		db_empl := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'empleados'));
		
	 	
		db_version_empl := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'empleados'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_empl;
		raise notice 'Tabla : %', nombre_tabla_empl;
		raise notice 'Campo : %', campo_tabla_empl;
		raise notice 'Acci�n : %', accion_empl;
		raise notice 'Fecha : %', fecha_empl;
		raise notice 'Hora : %', hora_empl;
     	raise notice 'Usuario : %', usuario_empl;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_empl;
        raise notice 'DB : %', db_empl;
        raise notice 'Versi�n DB : %', db_version_empl;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	
	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- actualizar_cuil_empleados(id_input int, cuil_input varchar) ------- ';
		
	end if;
	

end;

$$ language plpgsql;










-- --------- CAMPO DIRECCION ---------------

select listado_empleados();

select descripcion_empleados();


-- Depuracion general de direccion
create or replace function depurar_direccion_empleados() returns void as $$

declare

id_anterior int;


begin 
	
	id_anterior := (select max(id) from empleados);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		(id_anterior > 0)
		) then


	raise notice '------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "direccion" Tabla "empleados" --';
	raise notice '------------------------------------------------------------';

		

	-- Todas las palabras con su inicial en Mayuscula
	update empleados set direccion = initcap(direccion);

	-- Quitamos los puntos
	update empleados set direccion = replace(direccion, '.', ' ');

	
	
	raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';
	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_direccion_empleados() ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select listado_empleados();


-- Depuracion general de ambos campos
create or replace function depurar_nro_telefonos_empleados() returns void as $$


declare

id_anterior int;


begin 
	
	id_anterior := (select max(id) from empleados);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then
	
	raise notice '-----------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "nro_telefono_principal" y Campo "nro_telefono_secundario" Tabla "empleados" --';
	raise notice '-----------------------------------------------------------------------------------------------------------';

	
		
	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	update empleados set nro_telefono_principal = replace (nro_telefono_principal, '011 ', '11');
	update empleados set nro_telefono_secundario = replace (nro_telefono_secundario, '011 ', '11');
	
	-- Si no est� el +54 lo Agregamos
	update empleados set nro_telefono_principal = replace (nro_telefono_principal, '11 ', '+5411');
	update empleados set nro_telefono_secundario = replace (nro_telefono_secundario, '11 ', '+5411');
	
	-- Reemplazamos los +54911 a +5411 (9 es caracteristica de Celular)
	update empleados set nro_telefono_principal = replace (nro_telefono_principal, '+54911', '+5411');
	update empleados set nro_telefono_secundario = replace (nro_telefono_secundario, '+54911', '+5411');
	
	-- Quitamos los guiones
	update empleados set nro_telefono_principal = replace(nro_telefono_principal, '-', ' ');
	update empleados set nro_telefono_secundario = replace(nro_telefono_secundario, '-', ' ');
	
	-- Quitamos los puntos
	update empleados set nro_telefono_principal = replace(nro_telefono_principal, '.', ' ');
	update empleados set nro_telefono_secundario = replace(nro_telefono_secundario, '.', ' ');
	
	-- Quitamos los espacios en Blanco
	update empleados set nro_telefono_principal = replace(nro_telefono_principal, ' ', '');
	update empleados set nro_telefono_secundario = replace(nro_telefono_secundario, ' ', '');
	
	
		
	
	raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_nros_telefonos_empleados() ------- ';
		
	end if;
	

end;

$$ language plpgsql;


-- ---------------- CAMPO SALARIO_ANUAL --------------------

select listado_empleados();

-- Actualizaci�n del Salario Anual por a�os de antiguedad
create or replace function depurar_salario_anual_empleados() returns void as $$


declare

	id_anterior int;

	-- Aumentamos 3% a los empleados con 1 a�o de antiguedad
	 primer_aumento decimal := 3.0/100;
	
	-- Aumentamos 7% a los empleados con 2 a�os de antiguedad
	 segundo_aumento decimal := 7.0/100;
	
	-- Aumentamos 10% a los empleados con 3 a�os de antiguedad
	 tercer_aumento decimal := 10.0/100;
	
	-- Aumentamos 15% a los empleados con 4 a�os de antiguedad
	 cuarto_aumento decimal := 15.0/100;
 


begin 
	
	id_anterior := (select max(id) from empleados);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	raise notice '-----------------------------------------------------------';
	raise notice '-- Actualizaci�n Campo "salario_anual" Tabla "empleados" --';
	raise notice '-----------------------------------------------------------';

	raise notice '';
	raise notice '--Aumentamos % porciento a los empleados con 1 a�o de antiguedad--' , primer_aumento;
	raise notice '--Aumentamos % porciento a los empleados con 2 a�os de antiguedad--' , segundo_aumento;
	raise notice '--Aumentamos % porciento a los empleados con 3 a�os de antiguedad--' , tercer_aumento;
	raise notice '--Aumentamos % porciento a los empleados con 4 a�os de antiguedad--' , cuarto_aumento;

	
	update empleados set salario_anual = (salario_anual + (salario_anual * primer_aumento)) 
	where antiguedad = 1; 

	update empleados set salario_anual = (salario_anual + (salario_anual * segundo_aumento))
	where antiguedad = 2; 
	
	update empleados set salario_anual = (salario_anual + (salario_anual * tercer_aumento))  
	where antiguedad = 3; 
		
	update empleados set salario_anual = (salario_anual + (salario_anual * cuarto_aumento))  
	where antiguedad = 4; 
	
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';


	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_salario_anual_empleados() ------- ';
		
	end if;
	

end;

$$ language plpgsql;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ==================================
-- ======= TABLA CLIENTES ===========
-- ==================================

select listado_clientes(); 

select descripcion_clientes(); 


-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

-- Depuracionn general de ambos campos
create or replace function depurar_nombres_apellidos_clientes() returns void as $$


declare

	id_anterior int;



begin 
	
	id_anterior := (select max(id) from clientes);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	raise notice '---------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "nombre" y Campo "Apellido" Tabla "clientes" --';
	raise notice '---------------------------------------------------------------------------';
		

	-- Todas las palabras con su inicial en Mayuscula
	update clientes set nombre = initcap(nombre);
	update clientes set apellido = initcap(apellido);
	
	-- Quitamos los espacios
	update clientes set nombre = replace(nombre, ' ', '');
	update clientes set apellido = replace(apellido, ' ', '');
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_nombres_apellidos_clientes() ------- ';
		
	end if;
	

end;

$$ language plpgsql;




-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select listado_clientes(); 



-- Depuracion general de ambos campos
create or replace function depurar_nro_telefonos_clientes() returns void as $$


declare

	id_anterior int;



begin 
	
	id_anterior := (select max(id) from clientes);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	raise notice '----------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "nro_telefono_principal" y Campo "nro_telefono_secundario" Tabla "clientes" --';
	raise notice '----------------------------------------------------------------------------------------------------------';
		

		
	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	update clientes set nro_telefono_principal = replace (nro_telefono_principal, '011 ', '11');
	update clientes set nro_telefono_secundario = replace (nro_telefono_secundario, '011 ', '11');
	
	-- Si no est� el +54 lo Agregamos
	update clientes set nro_telefono_principal = replace (nro_telefono_principal, '11 ', '+5411');
	update clientes set nro_telefono_secundario = replace (nro_telefono_secundario, '11 ', '+5411');
	
	-- Reemplazamos los +54911 a +5411 (9 es caracteristica de Celular)
	update clientes set nro_telefono_principal = replace (nro_telefono_principal, '+54911', '+5411');
	update clientes set nro_telefono_secundario = replace (nro_telefono_secundario, '+54911', '+5411');
	
	-- Quitamos los guiones
	update clientes set nro_telefono_principal = replace(nro_telefono_principal, '-', ' ');
	update clientes set nro_telefono_secundario = replace(nro_telefono_secundario, '-', ' ');
	
	-- Quitamos los puntos
	update clientes set nro_telefono_principal = replace(nro_telefono_principal, '.', ' ');
	update clientes set nro_telefono_secundario = replace(nro_telefono_secundario, '.', ' ');
	
	-- Quitamos los espacios en Blanco
	update clientes set nro_telefono_principal = replace(nro_telefono_principal, ' ', '');
	update clientes set nro_telefono_secundario = replace(nro_telefono_secundario, ' ', '');
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_nro_telefonos_clientes() ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPO DIRECCION ---------------


select listado_clientes(); 

-- Depuracion general de direccion
create or replace function depurar_direccion_clientes() returns void as $$


declare

	id_anterior int;



begin 
	
	id_anterior := (select max(id) from clientes);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	raise notice '-----------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "direccion" Tabla "clientes" --';
	raise notice '-----------------------------------------------------------';
		
		

	-- Todas las palabras con su inicial en Mayuscula
	update clientes set direccion = initcap(direccion);

	-- Quitamos los puntos
	update clientes set direccion = replace(direccion, '.', ' ');

	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_direccion_clientes() ------- ';
		
	end if;
	

end;

$$ language plpgsql;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================================
-- ======= TABLA PROPIETARIOS_INMUEBLES ===========
-- ================================================



-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

select listado_propietarios_inmuebles();

select descripcion_propietarios_inmuebles();


-- Depuracionn general de ambos campos
create or replace function depurar_nombres_apellidos_propietarios_inmuebles() returns void as $$

declare

	id_anterior int;



begin 
	
	id_anterior := (select max(id) from propietarios_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	raise notice '-----------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "nombre" y Campo "apellido" Tabla "propietarios_inmuebles" --';
	raise notice '-----------------------------------------------------------------------------------------';
		
		


	-- Todas las palabras con su inicial en Mayuscula
	update propietarios_inmuebles set nombre = initcap(nombre);
	update propietarios_inmuebles set apellido = initcap(apellido);
	
	-- Quitamos los espacios
	update propietarios_inmuebles set nombre = replace(nombre, ' ', '');
	update propietarios_inmuebles set apellido = replace(apellido, ' ', '');


	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_nombres_apellidos_propietarios_inmuebles() ------- ';
		
	end if;
	

end;


$$ language plpgsql;




-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select listado_propietarios_inmuebles();

select descripcion_propietarios_inmuebles();


-- Depuracion general de ambos campos
create or replace function depurar_nro_telefonos_propietarios_inmuebles() returns void as $$

declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from propietarios_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	
	raise notice '------------------------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "nro_telefono_principal" y Campo "nro_telefono_secundario" Tabla "propietarios_inmuebles" --';
	raise notice '------------------------------------------------------------------------------------------------------------------------';
		
		

		
	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	update propietarios_inmuebles set nro_telefono_principal = replace (nro_telefono_principal, '011 ', '11');
	update propietarios_inmuebles set nro_telefono_secundario = replace (nro_telefono_secundario, '011 ', '11');
	
	-- Si no est� el +54 lo Agregamos
	update propietarios_inmuebles set nro_telefono_principal = replace (nro_telefono_principal, '11 ', '+5411');
	update propietarios_inmuebles set nro_telefono_secundario = replace (nro_telefono_secundario, '11 ', '+5411');
	
	-- Reemplazamos los +54911 a +5411 (9 es caracteristica de Celular)
	update propietarios_inmuebles set nro_telefono_principal = replace (nro_telefono_principal, '+54911', '+5411');
	update propietarios_inmuebles set nro_telefono_secundario = replace (nro_telefono_secundario, '+54911', '+5411');
	
	-- Quitamos los guiones
	update propietarios_inmuebles set nro_telefono_principal = replace(nro_telefono_principal, '-', ' ');
	update propietarios_inmuebles set nro_telefono_secundario = replace(nro_telefono_secundario, '-', ' ');
	
	-- Quitamos los puntos
	update propietarios_inmuebles set nro_telefono_principal = replace(nro_telefono_principal, '.', ' ');
	update propietarios_inmuebles set nro_telefono_secundario = replace(nro_telefono_secundario, '.', ' ');
	
	-- Quitamos los espacios en Blanco
	update propietarios_inmuebles set nro_telefono_principal = replace(nro_telefono_principal, ' ', '');
	update propietarios_inmuebles set nro_telefono_secundario = replace(nro_telefono_secundario, ' ', '');
	
	
	
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_nro_telefonos_propietarios_inmuebles() ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPO DIRECCION ---------------


select listado_propietarios_inmuebles();



-- Depuracion general de direccion
create or replace function depurar_direccion_propietarios_inmuebles() returns void as $$


declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from propietarios_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	raise notice '-------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "direccion" Tabla "propietarios_inmuebles" --';
	raise notice '-------------------------------------------------------------------------';
		

	

	-- Todas las palabras con su inicial en Mayuscula
	update propietarios_inmuebles set direccion = initcap(direccion);

	-- Quitamos los puntos
	update propietarios_inmuebles set direccion = replace(direccion, '.', ' ');

	
		
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	
	
	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_direccion_propietarios_inmuebles() ------- ';
		
	end if;
	

end;


$$ language plpgsql;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================================
-- ======= TABLA INMUEBLES DESCRIPCIONES ==========
-- ================================================



-- --------- CAMPO SUPERFICIE_TOTAL Y CAMPO SUPERFICIE_CUBIERTA---------------

select listado_inmuebles_descripciones();

-- Depuracion general de ambos campos
create or replace function actualizar_superficie_total_cubierta_inmuebles_descripciones
(id_input int , sup_total_input decimal, sup_cubierta_input decimal) returns void as $$

declare 

id_anterior int := (select id from inmuebles_descripciones id where id=id_input);
sup_total_anterior varchar := (select superficie_total from inmuebles_descripciones id where id=id_input);
sup_cubierta_anterior varchar := (select superficie_cubierta from inmuebles_descripciones id where id=id_input);

-- TABLA LOGS_UPDATES

uuid_registro_inm_descr uuid;
nombre_tabla_inm_descr varchar := 'inmuebles_descripciones';
campo_tabla_inm_descr varchar := 'superficie total/superficie cubierta';
accion_inm_descr varchar := 'update';
fecha_inm_descr date ;
hora_inm_descr time ;
usuario_inm_descr varchar;
usuario_sesion_inm_descr varchar;
db_inm_descr varchar;
db_version_inm_descr varchar;


id_last_logs_upd int;



begin 

	if(
	((id_anterior <= 0) or (id_input <= 0) )
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0) and (id_input = id_anterior)
		and (sup_total_input > 0.0) and (sup_cubierta_input > 0.0))
		) then
	
	raise notice '---------------------------------------------------------------------------------------------------------';
	raise notice '-- Modificaci�n Campo "superficie_total" y Campo "superficie_cubierta" Tabla "inmuebles_descripciones" --';
	raise notice '---------------------------------------------------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice ' Sup_Total: %', sup_total_anterior;
	raise notice ' Sup_Cubierta: %', sup_cubierta_anterior;




	update inmuebles_descripciones set superficie_total = sup_total_input, superficie_cubierta = sup_cubierta_input
	where id = id_input;


	
	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice ' Sup_Total: %', sup_total_input;
	raise notice ' Sup_Cubierta: %', sup_cubierta_input;

		raise notice '';
	raise notice 'ok!';
	raise notice ' ';



	
	
		
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_inm_descr, campo_tabla_inm_descr , accion_inm_descr);
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_inm_descr := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inmuebles_descripciones'));
		
		fecha_inm_descr := (select fecha from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inmuebles_descripciones'));
		
		
		hora_inm_descr := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inmuebles_descripciones'));
		
	
		usuario_inm_descr := (select usuario from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inmuebles_descripciones'));
		
	
		usuario_sesion_inm_descr := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inmuebles_descripciones'));
		
	
		db_inm_descr := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inmuebles_descripciones'));
		
	 	
		db_version_inm_descr := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inmuebles_descripciones'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_inm_descr;
		raise notice 'Tabla : %', nombre_tabla_inm_descr;
		raise notice 'Campo : %', campo_tabla_inm_descr;
		raise notice 'Acci�n : %', accion_inm_descr;
		raise notice 'Fecha : %', fecha_inm_descr;
		raise notice 'Hora : %', hora_inm_descr;
     	raise notice 'Usuario : %', usuario_inm_descr;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_inm_descr;
        raise notice 'DB : %', db_inm_descr;
        raise notice 'Versi�n DB : %', db_version_inm_descr;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	

	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- actualizar_superficie_total_cubierta_inmuebles_descripciones
(id_input int , sup_total_input decimal, sup_cubierta_input decimal) ------- ';
		
	end if;
	

end;


$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ================================================
-- ======= TABLA INMUEBLES MEDIDAS ================
-- ================================================



-- --------- CAMPO DORMITORIO ---------------

select listado_inmuebles_medidas();

-- Depuracion general del campo dormitorio
create or replace function depurar_dormitorio_inmuebles_medidas() returns void as $$


declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inmuebles_medidas);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	
	raise notice '---------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "dormitorio" Tabla "inmuebles_medidas" --';
	raise notice '---------------------------------------------------------------------';
		
		


	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio1', 'D1');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio2', 'D2');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio3', 'D3');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio4', 'D4');
	update inmuebles_medidas set dormitorio = replace(dormitorio, '|', ' ');

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_dormitorio_inmuebles_medidas() ------- ';
		
	end if;
	

end;


$$ language plpgsql;



-- --------- CAMPO SANITARIO ---------------

select listado_inmuebles_medidas();

-- Depuracion general de cambo dormitorio
create or replace function depurar_sanitario_inmuebles_medidas() returns void as $$


declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inmuebles_medidas);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	raise notice '---------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "sanitario" Tabla "inmuebles_medidas" --';
	raise notice '---------------------------------------------------------------------';
		
	
	
	update inmuebles_medidas set sanitario = replace(sanitario, 'Ba�o1', 'S1');
	update inmuebles_medidas set sanitario = replace(sanitario, 'Ba�o2', 'S2');
	update inmuebles_medidas set sanitario = replace(sanitario, 'Ba�o3', 'S3');
	update inmuebles_medidas set sanitario = replace(sanitario, '|', ' ');


	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_sanitaro_inmuebles_medidas() ------- ';
		
	end if;
	

end;


$$ language plpgsql;




-- --------- CAMPOS PATIO_JARDIN, COCHERA, BALCON ---------------

select listado_inmuebles_medidas();

-- Depuracion general de los campos
create or replace function depurar_patio_jardin_cochera_balcon_inmuebles_medidas() returns void as $$


declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inmuebles_medidas);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	
	raise notice '---------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "patio_jardin", Campo "cochera" y Campo "balcon" Tabla "inmuebles_medidas" --';
	raise notice '---------------------------------------------------------------------------------------------------------';
		

	update inmuebles_medidas set patio_jardin = replace(patio_jardin, '-', '0.0 x 0.0');
	update inmuebles_medidas set cochera = replace(cochera, '-', '0.0 x 0.0');
	update inmuebles_medidas set balcon = replace(balcon, '-', '0.0 x 0.0');
	
	
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_patio_jardin_cochera_balcon_inmuebles_medidas() ------- ';
		
	end if;
	

end;


$$ language plpgsql;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ===================================
-- ======= TABLA INMUEBLES ===========
-- ===================================



-- --------- CAMPOS DESCRIPCION, TIPO ---------------

select listado_citas_inmuebles();


-- Depuracion general de los campos
create or replace function depurar_descripcion_tipo_inmuebles() returns void as $$


declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
	
		
	raise notice '-----------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "descripcion" y Campo "tipo" Tabla "inmuebles" --';
	raise notice '-----------------------------------------------------------------------------';
		
	

	
	update inmuebles set descripcion = initcap(descripcion);
	update inmuebles set tipo = initcap(tipo);
	
	
	update inmuebles set descripcion = replace(descripcion, 'Ba�o', 'Sanitario');
	update inmuebles set descripcion = replace(descripcion, 'Ba�os', 'Sanitarios');
	update inmuebles set descripcion = replace(descripcion, ',', ' ');
	update inmuebles set tipo = replace(tipo, 'Ph/Casa', 'Ph');



	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
		

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_descripcion_tipo_inmuebles()  ------- ';
		
	end if;
	

end;


$$ language plpgsql;




-- --------- CAMPOS DIRECCION, UBICACION ---------------


select listado_inmuebles();

-- Depuracion general de direccion
create or replace function depurar_direccion_ubicacion_inmuebles() returns void as $$

declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from citas_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
	
		
	raise notice '--------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "direccion" y Campo "ubicacion" Tabla "inmuebles" --';
	raise notice '--------------------------------------------------------------------------------';
		
	
		

	-- Todas las palabras con su inicial en Mayuscula
	update inmuebles set direccion = initcap(direccion);
	update inmuebles set ubicacion = initcap(ubicacion);

	-- Quitamos los puntos
	update inmuebles set direccion = replace(direccion, '.', ' ');

	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	
	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_direccion_ubicacion_inmuebles()  ------- ';
		
	end if;
	

end;



$$ language plpgsql;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ===================================
-- ======= TABLA CITAS_INMUEBLES =====
-- ===================================



-- --------- CAMPOS DESCRIPCION_CITA ---------------


select listado_citas_inmuebles();

-- Depuracion general de descripcion_cita
create or replace function depurar_descripcion_cita_citas_inmuebles() returns void as $$

declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from citas_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
		
	raise notice '-------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "descripcion_cita" Tabla "citas_inmuebles" --';
	raise notice '-------------------------------------------------------------------------';
	

	-- Todas las palabras con su inicial en Mayuscula
	update citas_inmuebles set descripcion_cita = initcap(descripcion_cita);
	
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	

	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_descripcion_cita_citas_inmuebles()  ------- ';
		
	end if;
	

end;


$$ language plpgsql;






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =============================================
-- ======= TABLA INSPECCIONES_INMUEBLES ========
-- =============================================


-- --------- CAMPO DESCRIPCION_INSPECCION ---------------


select listado_inspecciones_inmuebles();



-- Depuracion general de descripcion_inspeccion
create or replace function depurar_descripcion_inspeccion_inspecciones_inmuebles() returns void as $$


declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inspecciones_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
		
	
		
	raise notice '--------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "descripcion_inspeccion" Tabla "inspecciones_inmuebles" --';
	raise notice '--------------------------------------------------------------------------------------';


	-- Todas las palabras con su inicial en Mayuscula
	update inspecciones_inmuebles set descripcion_inspeccion = initcap(descripcion_inspeccion);
	update inspecciones_inmuebles set descripcion_inspeccion = replace(descripcion_inspeccion,'Caba','Cabo');



	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_descripcion_inspeccion_inspecciones_inmuebles()  ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPOS EMPRESA, DIRECCION ---------------

select listado_inspecciones_inmuebles();

-- Depuracion general de los campos
create or replace function depurar_empresa_direccion_inspecciones_inmuebles() returns void as $$


declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inspecciones_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
		

	
	
	raise notice '-------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "empresa" y Campo "direccion" Tabla "inspecciones_inmuebles" --';
	raise notice '-------------------------------------------------------------------------------------------';
	



	-- Todas las palabras con su inicial en Mayuscula
	update inspecciones_inmuebles set empresa = initcap(empresa);
	update inspecciones_inmuebles set direccion = initcap(direccion);
	
	-- Reemplazamos caracteres
	update inspecciones_inmuebles set direccion = replace(direccion,'Caba','Cabo');
	



	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_empresa_direccion_inspecciones_inmuebles()  ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPO NUMERO_TELEFONO ---------------


select listado_inspecciones_inmuebles();

-- Depuracion general de los campos
create or replace function depurar_nro_tel_inspecciones_inmuebles() returns void as $$

declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inspecciones_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	
		
	raise notice '----------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "nro_telefono" Tabla "inspecciones_inmuebles" --';
	raise notice '----------------------------------------------------------------------------';
	

	-- Reemplazamos caracteres
	update inspecciones_inmuebles set nro_telefono = replace(nro_telefono,'-','');
	



	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	
else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_nro_tel_inspecciones_inmuebles()  ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPO COSTO ---------------

select listado_inspecciones_inmuebles();



-- Depuracion general del campo costo
create or replace function depurar_costo_inspecciones_inmuebles() returns void as $$

declare 
	 aumento_depto decimal := 1.6/100;
	 aumento_casa_ph decimal := 2.3/100;

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inspecciones_inmuebles);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then

	

			
	raise notice '---------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "costo" Tabla "inspecciones_inmuebles" --';
	raise notice '---------------------------------------------------------------------';
	

	
	raise notice '';
	raise notice 'Se aumenta el % porciento al tipo de inpecci�n Departamento',aumento_depto;
	raise notice 'Se aumenta el % porciento al tipo de inpecci�n Casa/Ph',aumento_casa_ph;


	update inspecciones_inmuebles set costo = (costo + (costo * aumento_depto)) 
	where tipo_inspeccion = 'DEPARTAMENTO'; 
		
	update inspecciones_inmuebles set costo = (costo + (costo * aumento_casa_ph))  
	where tipo_inspeccion = 'CASA';

	update inspecciones_inmuebles set costo = (costo + (costo * aumento_casa_ph))
	where tipo_inspeccion = 'PH';


	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_costo_inspecciones_inmuebles()  ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPO HORA Y CAMPO FECHA ---------------


select listado_inspecciones_inmuebles();


-- Cambiar Hora y Fecha
create or replace function actualizar_fecha_hora_inspecciones_inmuebles(id_input int, fecha_input date
, hora_input time) returns void as $$

declare 
	 id_anterior int := (select id from inspecciones_inmuebles where id = id_input);
	 fecha_anterior date:= (select fecha from inspecciones_inmuebles where id = id_input);
	 hora_anterior time := (select hora from inspecciones_inmuebles where id = id_input);



-- TABLA LOGS_UPDATES

uuid_registro_insp_inm uuid;
nombre_tabla_insp_inm varchar := 'inspecciones_inmuebles';
campo_tabla_insp_inm varchar := 'fecha/hora';
accion_insp_inm varchar := 'update';
fecha_insp_inm date ;
hora_insp_inm time ;
usuario_insp_inm varchar;
usuario_sesion_insp_inm varchar;
db_insp_inm varchar;
db_version_insp_inm varchar;


id_last_logs_upd int;


begin 
	
	
	if(
	(id_anterior <= 0) or 
	(id_input <= 0)
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(id_anterior > 0) and 
		(id_input > 0) and 
		(id_anterior = id_input) and
		((fecha_input <= current_date) or (fecha_input >= current_date)) and
		((hora_input <= current_time) or (hora_input >= current_time))
		) then
	

			
	raise notice '----------------------------------------------------------------------------------';
	raise notice '-- Modificaci�n del Campo "fecha" y Campo "hora" Tabla "inspecciones_inmuebles" --';
	raise notice '----------------------------------------------------------------------------------';
	
	
	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice ' Fecha : %', fecha_anterior;
	raise notice ' Hora : %', hora_anterior;



	update inspecciones_inmuebles set fecha = fecha_input  where id = id_input; 
	
	update inspecciones_inmuebles set hora = hora_input  where id = id_input; 
		



	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice ' Fecha : %', fecha_input;
	raise notice ' Hora : %', hora_input;

		raise notice '';
	raise notice 'ok!';
	raise notice ' ';




	
	
		
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_insp_inm , campo_tabla_insp_inm  , accion_insp_inm );
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_insp_inm  := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inspecciones_inmuebles'));
		
		fecha_insp_inm  := (select fecha from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inspecciones_inmuebles'));
		
		
		hora_insp_inm  := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inspecciones_inmuebles'));
		
	
		usuario_insp_inm  := (select usuario from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inspecciones_inmuebles'));
		
	
		usuario_sesion_insp_inm  := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inspecciones_inmuebles'));
		
	
		db_insp_inm  := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inspecciones_inmuebles'));
		
	 	
		db_version_insp_inm  := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'inspecciones_inmuebles'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_insp_inm;
		raise notice 'Tabla : %', nombre_tabla_insp_inm;
		raise notice 'Campo : %', campo_tabla_insp_inm;
		raise notice 'Acci�n : %', accion_insp_inm;
		raise notice 'Fecha : %', fecha_insp_inm;
		raise notice 'Hora : %', hora_insp_inm;
     	raise notice 'Usuario : %', usuario_insp_inm;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_insp_inm;
        raise notice 'DB : %', db_insp_inm;
        raise notice 'Versi�n DB : %', db_version_insp_inm;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- cambiar_fecha_hora_inspecciones_inmuebles(id_input int, fecha_input date
, hora_input time)  ------- ';
		
	end if;
	

end;

$$ language plpgsql;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- =============================================
-- ======= TABLA INMUEBLES_MARKETING ===========
-- =============================================



-- --------- CAMPO TIPO_ANUNCIO_PRINCIPAL Y CAMPO TIPO_ANUNCIO_SECUNDARIO ---------------


select listado_inmuebles_marketing();



-- Depuracion general de ambos campos
create or replace function depurar_tipo_anuncio_principal_secundario_inmuebles_marketing() returns void as $$
	

declare 

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inmuebles_marketing);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then


			
	raise notice '---------------------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "tipo_anuncio_principal" y Campo "tipo_anuncio_secundario" Tabla "inmuebles_marketing" --';
	raise notice '---------------------------------------------------------------------------------------------------------------------';
	



	update inmuebles_marketing set tipo_anuncio_principal = replace(tipo_anuncio_principal,'-',''); 
	update inmuebles_marketing set tipo_anuncio_principal = initcap(tipo_anuncio_principal); 
	

	update inmuebles_marketing set tipo_anuncio_secundario = replace(tipo_anuncio_secundario,'-',''); 
	update inmuebles_marketing set tipo_anuncio_secundario = initcap(tipo_anuncio_secundario); 
	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_tipo_anuncio_principal_secundario_inmuebles_marketing() ------- ';
		
	end if;
	

end;

$$ language plpgsql;




-- --------- CAMPO DESCRIPCION_ANUNCIO ---------------


select listado_inmuebles_marketing();



-- Depuracion general del campo descripcion_anuncio
create or replace function depurar_descripcion_anuncio_inmuebles_marketing() returns void as $$
	
declare 

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inmuebles_marketing);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then


			
	raise notice '--------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "descripcion_anuncio" Tabla "inmuebles_marketing" --';
	raise notice '--------------------------------------------------------------------------------';
	



	update inmuebles_marketing set descripcion_anuncio = replace(descripcion_anuncio,'-',''); 
	update inmuebles_marketing set descripcion_anuncio = initcap(descripcion_anuncio); 
	

	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_tipo_anuncio_principal_secundario_inmuebles_marketing() ------- ';
		
	end if;
	

end;


$$ language plpgsql;




-- --------- CAMPO INVERSION_TOTAL ---------------


select listado_inmuebles_marketing();


-- Depuracion general del campo inversion_total
create or replace function depurar_inversion_total_inmuebles_marketing() returns void as $$

declare 
	 aumento_google_ads decimal := 0.9/100;
	 aumento_youtube decimal := 0.2/100;
	 aumento_linkedin decimal := 0.14/100;

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from inmuebles_marketing);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then



			
	raise notice '----------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "inversion_total" Tabla "inmuebles_marketing" --';
	raise notice '----------------------------------------------------------------------------';
	
	
	raise notice '';
	raise notice 'Se aumenta el % porciento al tipo de anuncio Google Ads',aumento_google_ads;
	raise notice 'Se aumenta el % porciento al tipo de anuncio Youtube',aumento_youtube;
	raise notice 'Se aumenta el % porciento al tipo de anuncio Linkedin',aumento_linkedin;
	
	


	update inmuebles_marketing set inversion_total = (inversion_total + (inversion_total * aumento_google_ads))  
	where (tipo_anuncio_principal = 'Google Ads' or tipo_anuncio_secundario = 'Google Ads'); 
	

	update inmuebles_marketing set inversion_total = (inversion_total + (inversion_total * aumento_youtube))  
	where (tipo_anuncio_principal = 'Youtube' or tipo_anuncio_secundario = 'Youtube'); 
	

	update inmuebles_marketing set inversion_total = (inversion_total + (inversion_total * aumento_linkedin))  
	where (tipo_anuncio_principal = 'Linkedin' or tipo_anuncio_secundario = 'Linkedin'); 
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_inversion_total_inmuebles_marketing() ------- ';
		
	end if;
	

end;


$$ language plpgsql;






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =========================================
-- ======= TABLA ADMINISTRADORES ===========
-- =========================================



-- --------- CAMPO TIPO_INMUEBLE ---------------


select listado_administradores();

-- Depuracion general del campo tipo_inmueble
create or replace function depurar_tipo_inmuebles_administradores() returns void as $$
	

declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from administradores);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then



			
	raise notice '----------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "tipo_inmueble" Tabla "administradores" --';
	raise notice '----------------------------------------------------------------------';
	


	update administradores set tipo_inmueble = initcap(tipo_inmueble); 
	update administradores set tipo_inmueble = replace(tipo_inmueble ,'Departamento','Depart');
	update administradores set tipo_inmueble = replace(tipo_inmueble ,'Departamento-Casa','Depart/Casa');
	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_tipo_inmuebles_administradores() ------- ';
		
	end if;
	

end;


$$ language plpgsql;



-- --------- CAMPO CERTIFICACIONES ---------------


select listado_administradores();



-- Depuracion general del campo certificaciones
create or replace function depurar_certificaciones_administradores() returns void as $$
	


declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from administradores);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then



			
	raise notice '------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "certificaciones" Tabla "administradores" --';
	raise notice '------------------------------------------------------------------------';
	


	update administradores set certificaciones = initcap(certificaciones);
 	
	update administradores set certificaciones = replace(certificaciones,',','/');
 	update administradores set certificaciones = replace(certificaciones,'.','');
 	
 	update administradores set certificaciones = replace(certificaciones,'Aministrativas','Admin');
    update administradores set certificaciones = replace(certificaciones,'Aministraci�n','Admin');
 	update administradores set certificaciones = replace(certificaciones,'Administrativas','Admin');
 	update administradores set certificaciones = replace(certificaciones,'Administraci�n','Admin');
 	update administradores set certificaciones = replace(certificaciones,'Administrativo','Admin');
 	
	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_certificaciones_administradores() ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ==================================
-- ======= TABLA GERENTES ===========
-- ==================================


-- --------- CAMPO TITULO ---------------


select listado_gerentes();



-- Depuracion general del campo titulo
create or replace function depurar_titulo_gerentes() returns void as $$
	



declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from gerentes);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then




			
	raise notice '--------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "titulo" Tabla "gerentes" --';
	raise notice '--------------------------------------------------------';
	


	update gerentes set titulo = initcap(titulo); 
	update gerentes set titulo = replace(titulo ,'Licenciado','Lic');
	update gerentes set titulo = replace(titulo ,'Licenciada','Lic');
	update gerentes set titulo = replace(titulo ,'Administraci�n','Adm');

	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_titulo_gerentes() ------- ';
		
	end if;
	

end;

$$ language plpgsql;





-- --------- CAMPO BENEFICIOS ---------------


select listado_gerentes();



-- Depuracion general
create or replace function depurar_beneficios_gerentes() returns void as $$
	




declare

	id_anterior int;


begin 
	
	id_anterior := (select max(id) from gerentes);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then





			
	raise notice '------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "beneficios" Tabla "gerentes" --';
	raise notice '------------------------------------------------------------';
	


	update gerentes set beneficios = initcap(beneficios);
	update gerentes set beneficios = replace(beneficios ,'2 Veces X Sem','');
	update gerentes set beneficios = replace(beneficios ,'35%','');
	update gerentes set beneficios = replace(beneficios ,'40%','');	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_beneficios_gerentes() ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPO RETRIBUCION_SALARIAL_ANUAL ---------------


select listado_gerentes();



-- Depuracion general
create or replace function depurar_retribucion_salarial_anual_gerentes() returns void as $$
	
declare 
	
	primer_aumento decimal := 0.2/100;
	 segundo_aumento decimal := 0.4/100;
	 tercer_aumento decimal := 0.9/100;


	id_anterior int;


begin 
	
	id_anterior := (select max(id) from gerentes);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then





			
	raise notice '----------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "retribucion_salarial_anual" Tabla "gerentes" --';
	raise notice '----------------------------------------------------------------------------';
	
	
	
	raise notice '';
	raise notice 'Se aumenta el % porciento a los Gerentes que tengas entre 2 y 6 a�os de experiencia',primer_aumento; 
	raise notice 'Se aumenta el % porciento a los Gerentes que tengas entre 7 y 9 a�os de experiencia',segundo_aumento; 
	raise notice 'Se aumenta el % porciento a los Gerentes que tengas entre 10 y 15 a�os de experiencia',tercer_aumento; 
	



	update gerentes set retribucion_salarial_anual = 
	(retribucion_salarial_anual + (retribucion_salarial_anual * primer_aumento))  
	where (aneos_experiencia_laboral >= 2 and aneos_experiencia_laboral <= 6); 
	

	update gerentes set retribucion_salarial_anual = 
	(retribucion_salarial_anual + (retribucion_salarial_anual * segundo_aumento))  
	where (aneos_experiencia_laboral > 6 and aneos_experiencia_laboral <= 9); 
		

	
	update gerentes set retribucion_salarial_anual = 
	(retribucion_salarial_anual + (retribucion_salarial_anual * tercer_aumento))  
	where (aneos_experiencia_laboral > 9 and aneos_experiencia_laboral <= 15); 
		
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';


else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_retribucion_salarial_anual_gerentes()
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ====================================
-- ======= TABLA VENDEDORES ===========
-- ====================================


-- --------- CAMPO CANTIDAD_VENTAS ---------------


select listado_vendedores();



-- Modificaci�n campo cantidad_ventas
create or replace function actualizar_cantidad_ventas_vendedores(id_input int, cant_ventas_input int) returns void as $$

declare 
	 id_anterior int := (select id from vendedores where id = id_input );
	 cant_ventas_anterior int  := (select cantidad_ventas from vendedores where id = id_input );



-- TABLA LOGS_UPDATES

uuid_registro_vend uuid;
nombre_tabla_vend varchar := 'vendedores';
campo_tabla_vend varchar := 'cantidad_ventas';
accion_vend varchar := 'update';
fecha_vend date ;
hora_vend time ;
usuario_vend varchar;
usuario_sesion_vend varchar;
db_vend varchar;
db_version_vend varchar;


id_last_logs_upd int;


begin 
	
	
	if(
	(id_anterior <= 0) or 
	(id_input <= 0) or
	(cant_ventas_input < 0)
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(id_anterior > 0) and 
		(id_input > 0) and 
		(id_anterior = id_input) and
		(cant_ventas_input >= 0)
		) then
	
			
	raise notice '--------------------------------------------------------------';
	raise notice '-- Modificaci�n  Campo "cantidad_ventas" Tabla "vendedores" --';
	raise notice '--------------------------------------------------------------';
	



	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice ' Cantidad de Ventas : %', cant_ventas_anterior;


	update vendedores set cantidad_ventas = cant_ventas_input where id = id_input; 



	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice ' Cantidad de Ventas : %', cant_ventas_input;

	
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';






	
	
		
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_vend , campo_tabla_vend  , accion_vend );
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_vend  := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'vendedores'));
		
		fecha_vend := (select fecha from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'vendedores'));
		
		
		hora_vend  := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'vendedores'));
		
	
		usuario_vend  := (select usuario from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'vendedores'));
		
	
		usuario_sesion_vend  := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'vendedores'));
		
	
		db_vend  := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'vendedores'));
		
	 	
		db_version_vend  := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'vendedores'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_vend;
		raise notice 'Tabla : %', nombre_tabla_vend;
		raise notice 'Campo : %', campo_tabla_vend;
		raise notice 'Acci�n : %', accion_vend;
		raise notice 'Fecha : %', fecha_vend;
		raise notice 'Hora : %', hora_vend;
     	raise notice 'Usuario : %', usuario_vend;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_vend;
        raise notice 'DB : %', db_vend;
        raise notice 'Versi�n DB : %', db_version_vend;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	

	

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- actualizar_cantidad_ventas_vendedores(id_input int, cant_ventas_input int)
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- --------- CAMPO BONIFICACION_VENTAS ---------------


select listado_vendedores();


-- Depuracion general
create or replace function depurar_bonificacion_ventas_vendedores() returns void as $$
	
declare 

	 primera_bonif decimal := 1.15/100;
	 segunda_bonif decimal := 2.21/100;
	 tercera_bonif decimal := 3.41/100;


	id_anterior int;


begin 
	
	id_anterior := (select max(id) from vendedores);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then



			
	raise notice '-----------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "bonificacion_ventas" Tabla "vendedores" --';
	raise notice '-----------------------------------------------------------------------';
	
	

	raise notice '';
	raise notice 'Se aumenta el % porciento como bonificacion a los Vendedores que tengan 1 Venta',primera_bonif;
	raise notice 'Se aumenta el % porciento como bonificacion a los Vendedores que tengan 2 o 3 Ventas',segunda_bonif;
	raise notice 'Se aumenta el % porciento como bonificacion a los Vendedores que tengan 4 o 5 Ventas',tercera_bonif;




	update vendedores set bonificacion_ventas = 
	(bonificacion_ventas + (bonificacion_ventas * primera_bonif))  
	where (cantidad_ventas = 1); 


	update vendedores set bonificacion_ventas = 
	(bonificacion_ventas + (bonificacion_ventas * segunda_bonif))  
	where (cantidad_ventas = 2 or cantidad_ventas = 3); 
			
	update vendedores set bonificacion_ventas = 
	(bonificacion_ventas + (bonificacion_ventas * tercera_bonif))  
	where (cantidad_ventas = 4 or cantidad_ventas = 5); 
			

	-- modificamos la bonif y puntuacion
	update vendedores set bonificacion_ventas = 2000 where (cantidad_ventas = 1 and bonificacion_ventas = 0);
	update vendedores set puntuacion_ventas = 'Buena' where (cantidad_ventas < 2 and cantidad_ventas > 0);





	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_bonificacion_ventas_vendedores()
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =====================================
-- ======= TABLA COMPRADORES ===========
-- =====================================



-- --------- CAMPO DESCUENTO_CLIENTE_USD Y CAMPO BENEFICIOS_COMPRAS---------------


select listado_compradores();


-- Depuracion general
create or replace function depurar_descuento_cliente_usd_beneficios_compras_compradores() returns void as $$
	
declare 
	 primer_desc decimal := 7/100;
	 segundo_desc decimal := 10/100;
	
	id_anterior int;


begin 
	
	id_anterior := (select max(id) from compradores);
	
	if(
	(id_anterior <= 0)
	) then
	
		raise exception '===== NO SE PUEDE/N ACTUALIZAR UN/VARIOS REGISTRO/S QUE NO EXISTA/N ===== '
						using hint='------- INGRESAR REGISTROS EN LA TABLA -------';
										
									
	
	elsif (
		((id_anterior > 0))
		) then




			
	raise notice '-------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "descuento_cliente_usd" y campo "beneficios_compras" Tabla "compradores" --';
	raise notice '-------------------------------------------------------------------------------------------------------';
	
	
	raise notice '';			
	raise notice 'Se aplica el descuento del  % porciento a los Compradores que hayan comprado 1 Inmueble',primer_desc;
	raise notice 'Se aplica el descuento del  % porciento a los Compradores que hayan comprado 2 Inmuebles',segundo_desc;



	update compradores set descuento_cliente_usd = 
	(descuento_cliente_usd + 200)  
	where (beneficios_compras like '%7%%'); 

		update compradores set descuento_cliente_usd = 
	(descuento_cliente_usd + 700)  
	where (beneficios_compras like '%10%%'); 

	-- cambiamos los beneficios de compras
	update compradores set beneficios_compras = 'Descuento del 15% en la Pr�xima Compra' where (beneficios_compras like '%7%%');
	update compradores set beneficios_compras = 'Descuento del 20% en la Pr�xima Compra' where (beneficios_compras like '%10%%');  

	update compradores set beneficios_compras = initcap(beneficios_compras);



	raise notice '';
	raise notice 'ok!';
	raise notice ' ';




else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_descuento_cliente_usd_beneficios_compras_compradores()
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;







-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================
-- ======= TABLA VENTAS ===========
-- ================================





-- --------- CAMPO FECHA_VENTA Y CAMPO HORA_VENTA ---------------


select listado_ventas();



-- Modificaci�n campo fecha_venta y campo hora_venta
create or replace function actualizar_fecha_hora_venta_ventas(id_input int, fecha_venta_input date, hora_venta_input time) returns void as $$

declare 
	 id_anterior int := (select id from ventas where id = id_input );
	 fecha_venta_anterior date  := (select fecha_venta from ventas where id = id_input );
	 hora_venta_anterior time  := (select hora_venta from ventas where id = id_input );
	 	



-- TABLA LOGS_UPDATES

uuid_registro_ventas uuid;
nombre_tabla_ventas varchar := 'ventas';
campo_tabla_ventas varchar := 'cantidad_ventas';
accion_ventas varchar := 'update';
fecha_ventas date ;
hora_ventas time ;
usuario_ventas varchar;
usuario_sesion_ventas varchar;
db_ventas varchar;
db_version_ventas varchar;


id_last_logs_upd int;


begin 
	
	
	if(
	(id_anterior <= 0) or 
	(id_input <= 0)
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(id_anterior > 0) and 
		(id_input > 0) and 
		(id_anterior = id_input) and
		((fecha_venta_input <= current_date) or (fecha_venta_input >= current_date)) and
		((hora_venta_input <= current_time) or (hora_venta_input >= current_time))
		) then
	
			

			
	raise notice '---------------------------------------------------------------------------';
	raise notice '-- Modificaci�n  Campo "fecha_venta" y Campo "hora_venta" Tabla "ventas" --';
	raise notice '---------------------------------------------------------------------------';
	



	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice ' Fecha de Venta  : %', fecha_venta_anterior;
	raise notice ' Hora de Venta  : %', hora_venta_anterior;


	update ventas set fecha_venta = fecha_venta_input where id = id_input; 
	update ventas set hora_venta = hora_venta_input where id = id_input; 



	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice ' Fecha de Venta  : %', fecha_venta_input;
	raise notice ' Hora de Venta  : %', hora_venta_input;

		raise notice '';
	raise notice 'ok!';
	raise notice ' ';




	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO logs_updates----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_ventas , campo_tabla_ventas  , accion_ventas );
	
	
		--------------------------------------- FIN INSERCION REGISTRO logs_updates----------------------------------------
	
		
	
		id_last_logs_upd  := (select max(id) from logs_updates);
	
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_ventas  := (select uuid_registro from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'ventas'));
		
		fecha_ventas := (select fecha from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'ventas'));
		
		
		hora_ventas  := (select hora from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'ventas'));
		
	
		usuario_ventas  := (select usuario from logs_updates 
		where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'ventas'));
		
	
		usuario_sesion_ventas  := (select usuario_sesion from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'ventas'));
		
	
		db_ventas  := (select db from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'ventas'));
		
	 	
		db_version_ventas  := (select db_version from logs_updates 
			where (id = id_last_logs_upd) and (id_registro = id_input) and (nombre_tabla = 'ventas'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Actualizaci�n --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
		raise notice 'UUID Registro : %', uuid_registro_ventas;
		raise notice 'Tabla : %', nombre_tabla_ventas;
		raise notice 'Campo : %', campo_tabla_ventas;
		raise notice 'Acci�n : %', accion_ventas;
		raise notice 'Fecha : %', fecha_ventas;
		raise notice 'Hora : %', hora_ventas;
     	raise notice 'Usuario : %', usuario_ventas;
        raise notice 'Sesi�n de Usuario : %', usuario_sesion_ventas;
        raise notice 'DB : %', db_ventas;
        raise notice 'Versi�n DB : %', db_version_ventas;
	

		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	

	



else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- actualizar_fecha_hora_venta_ventas(id_input int, fecha_venta_input date, hora_venta_input time)
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;




-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------

-- ==================================
-- ======= TABLA FACTURAS ===========
-- ==================================


-- --------- CAMPO PRECIO_TOTAL_VENTA_USD ---------------

select listado_facturas();


-- Depuracion general
create or replace function depurar_precio_total_venta_usd_facturas() returns void as $$
	
declare 
	 impuesto_venta  decimal := 0.7/100;
	 impuesto_agregado decimal := 0.6/100;


	id_anterior int := (select max(id) from facturas);

	
	
begin 
	
	
	if(
	(id_anterior <= 0) 
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(id_anterior > 0)
		) then
	
			

			
	raise notice '------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "precio_total_venta_usd" Tabla "facturas" --';
	raise notice '------------------------------------------------------------------------';
	
	raise notice '';
	raise notice 'Se aumenta el % porciento al impuesto de venta',impuesto_venta;
	raise notice 'Se aumenta el % porciento al impuesto agregado',impuesto_agregado;


	update facturas set precio_total_venta_usd = 
	(precio_total_venta_usd + (precio_total_venta_usd * impuesto_venta)); 

	update facturas set precio_total_venta_usd = 
	(precio_total_venta_usd + (precio_total_venta_usd * impuesto_agregado)); 



	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_precio_total_venta_usd_facturas()
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;





-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------

-- ======================================
-- ======= TABLA FACTURAS_DETALLES ======
-- ======================================


-- --------- CAMPO DESCRIPCION_FACTURA Y CAMPO DESCRIPCION_PAGO ---------------

select listado_facturas_detalles();


-- Depuracion general
create or replace function depurar_descripcion_factura_pago_facturas_detalles() returns void as $$
	

declare 

		id_anterior int := (select max(id) from facturas_detalles);


begin 
	
	
	if(
	(id_anterior <= 0) 
	) 
	then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(id_anterior > 0)
		) 
		then
	
			
		
	raise notice '---------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "descripcion_factura" y Campo "descripcion_pago" Tabla "facturas_detalles" --';
	raise notice '---------------------------------------------------------------------------------------------------------';
	


	update facturas_detalles set descripcion_factura = initcap(descripcion_factura);

	update facturas_detalles set descripcion_pago = initcap(descripcion_pago);
	
	update facturas_detalles set descripcion_pago = replace(descripcion_pago ,'1 S�lo','1');
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_descripcion_factura_pago_facturas_detalles()
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;





-- --------- CAMPO VALOR_INMUEBLE_USD---------------


select listado_facturas_detalles();


-- Depuracion general
create or replace function depurar_valor_inmueble_usd_facturas_detalles() returns void as $$
	
declare 
	 aumento_valor decimal := 7.88/100;

		id_anterior int := (select max(id) from facturas_detalles);


begin 
	
	
	if(
	(id_anterior <= 0) 
	) 
	then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(id_anterior > 0)
		) 
		then

			
	raise notice '-----------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "valor_inmueble_usd" Tabla "facturas_detalles" --';
	raise notice '-----------------------------------------------------------------------------';
	
	raise notice '';
	raise notice 'Se aumenta el % porciento al valor del Inmueble',aumento_valor;


	update facturas_detalles set valor_inmueble_usd = 
	(valor_inmueble_usd + (valor_inmueble_usd * aumento_valor)); 

	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_valor_inmueble_usd_facturas_detalles()
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;




-- --------- CAMPO COSTO_ASOCIADO_USD Y CAMPO IMPUESTOS_ASOCIADOS_USD---------------


select listado_facturas_detalles();


-- Depuracion general
create or replace function depurar_costo_impuestos_asociados_usd_facturas_detalles() returns void as $$
	
declare 
	 aumento_costos decimal := 7.88/100;
	 aumento_impuestos decimal := 9.12/100;
	id_anterior int := (select max(id) from facturas_detalles);


begin 
	
	
	if(
	(id_anterior <= 0) 
	) 
	then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO VACIO O INEXISTENTE ===== '
						using hint='------- REVISAR EL RESGISTRO DE MODIFICACI�N -------';
										
									
	
	elsif (
		(id_anterior > 0)
		) 
		then

			
	raise notice '---------------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuraci�n General Campo "costo_asociado_usd" y Campo "impuestos_asociados_usd" Tabla "facturas_detalles" --';
	raise notice '---------------------------------------------------------------------------------------------------------------';
	
	raise notice '';
	raise notice 'Se aumenta el % porciento a los costos asociados',aumento_costos;
	raise notice 'Se aumenta el % porciento a los impuestos asociados',aumento_impuestos;


	update facturas_detalles set costo_asociado_usd = 
	(costo_asociado_usd  + (costo_asociado_usd  * aumento_costos)); 
	
	update facturas_detalles set impuestos_asociados_usd = 
	(impuestos_asociados_usd  + (impuestos_asociados_usd  * aumento_impuestos)); 
	

	raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';

else
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N ====='
						using hint = '------- depurar_costo_impuestos_asociados_usd_facturas_detalles()
 ------- ';
		
	end if;
	

end;

$$ language plpgsql;






