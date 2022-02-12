/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML UPDATES FUNCTIONS=============
 */

-- https://www.postgresqltutorial.com/postgresql-string-functions/
-- http://es.tldp.org/Postgresql-es/web/navegable/user/x2341.html
-- https://www.postgresql.org/docs/9.1/functions-string.html
-- https://microbuffer.wordpress.com/2011/04/12/funciones-con-strings-en-postgresql/





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



-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';




-- -----------TODOS LOS CAMPOS------------


create or replace function actualizar_registro_oficinas(id_input int, nombre_input varchar, dir_input varchar
, nro_tel_input varchar, email_input varchar) returns void as $$

declare 


-- Registro Anterior
 id_anterior varchar:= (select id from oficinas where id=id_input);
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




begin
	
	
	
	if(
	(nombre_input = '') or (dir_input = '') or 
	(nro_tel_input = '') or (email_input = '')
	) then
	
		raise exception '===== NO SE PUEDE INGRESAR UN REGISTRO CON CAMPOS VACIOS ===== '
						using hint='------- REVISAR LOS CAMPOS DE LA OFICINA -------';
										
									
	
	elsif (
		(nombre_input <> '') and (dir_input <> '') and 
		(nro_tel_input <> '') and (email_input <> '')
		) then
	
	
	raise notice '-----------------------------------------------------';
	raise notice '-- Modificación de Todos los Campos Tabla "oficinas" --';
	raise notice '-----------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice 'Nombre : %', nombre_anterior;
	raise notice 'Dirección : %', dir_anterior;
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
	raise notice 'Dirección : %', dir_input;
	raise notice 'Nro Telefono : %', nro_tel_input;
	raise notice 'Email : %', email_input;

	raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';	



	
	
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_of, campo_tabla_of , accion_of);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts 
		where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		fecha_of := (select fecha from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		
		hora_of := (select hora from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		usuario_of := (select usuario from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		usuario_sesion_of := (select usuario_sesion from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		db_of := (select db from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	 	
		db_version_of := (select db_version from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
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
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN actualizar_registro_oficinas() ====='
						using hint = '-------actualizar_registro_oficinas------- ';
		
	end if;
	

end;
	
$$ language plpgsql;



-- ---------------------------------------------------------------------------


-- ----------- CAMPO NRO_TELEFONO --------------

select listado_oficinas();


-- Cambiamos el Numero a traves del id
create or replace function actualizar_nro_tel_oficinas(nro_tel_input varchar, id_input int ) returns void as $$

declare 

id_anterior varchar := (select id from oficinas where id=id_input);
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



begin 
	
	
	if(
	(nro_tel_input = '') or (id_input < 0)
	) then
	
		raise exception '===== NO SE PUEDE ACTUALIZAR UN REGISTRO CON CAMPOS VACIOS O QUE NO EXISTAN ===== '
						using hint='------- REVISAR LOS CAMPOS DE LA OFICINA -------';
										
									
	
	elsif (
		(nro_tel_input <> '') and (id_input > 0)
		) then
	
	
	
	raise notice '------------------------------------------------------------';
	raise notice '-- Modificación  Campo "nro_telefono" Tabla "oficinas" --';
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
		raise notice '-- Inserción de Registro Tabla "logs_updates" --';
		raise notice '----------------------------------------------';
	
	
		--------------------------------------- INSERCION REGISTRO ----------------------------------------
	
	
		insert into logs_updates(id_registro, nombre_tabla , campo_tabla,  accion) values
		
		(id_input , nombre_tabla_of, campo_tabla_of , accion_of);
	
	
		--------------------------------------- FIN INSERCION REGISTRO ----------------------------------------
	
		-- Traemos los valores del Registro Insertado
		uuid_registro_of := (select uuid_registro from logs_inserts 
		where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		fecha_of := (select fecha from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		
		hora_of := (select hora from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		usuario_of := (select usuario from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		usuario_sesion_of := (select usuario_sesion from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	
		db_of := (select db from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
	 	
		db_version_of := (select db_version from logs_inserts 
			where (id_registro = id_input) and (nombre_tabla = 'oficinas'));
		
		
	 
	 	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';

		raise notice 'ID Registro: %' , id_input ;
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
	
	raise exception '===== SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN actualizar_nro_tel_oficinas() ====='
						using hint = '-------actualizar_nro_tel_oficinas------- ';
		
	end if;
	

end;



$$ language plpgsql;


-- ---------------------------------------------------------------------------

/*

-- ----------- CAMPO NRO_TELEFONO --------------


select * from oficinas;

-- Agregar Digitos
create or replace function agregar_dig_nro_tel_oficinas(caract_input varchar, id_input int ) returns void as $$

declare 

id_anterior varchar := (select id from oficinas where id=id_input);
nro_tel_anterior varchar := (select nro_telefono from oficinas where id=id_input);
nro_tel_actual varchar;

begin 
	
	raise notice '------------------------------------------------------------';
	raise notice '-- Modificación  Campo "nro_telefono" Tabla "oficinas" --';
	raise notice '------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice 'Nro Telefono : %', nro_tel_anterior;


		

	-- Agregamos el +54 al id Especifico
	update oficinas set nro_telefono = concat(caract_input, nro_telefono) where id = id_input;

	nro_tel_actual := (select nro_telefono from oficinas where id = id_input);
	
	
	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice 'Nro Telefono : %', nro_tel_actual;

	
		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';
	

end;

$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- Depuracion General
create or replace function depurar_nro_tel_oficinas() returns void as $$

declare 



begin 
	
	raise notice '------------------------------------------------------------------';
	raise notice '-- Depuración General  Campo "nro_telefono" Tabla "oficinas" --';
	raise notice '------------------------------------------------------------------';

	
	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	update oficinas set nro_telefono = replace (nro_telefono, '011 ', '11');
	
	-- Si no está el +54 lo Agregamos
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


end;

$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- ----------- CAMPO DIRECCION --------------

create or replace function depurar_dir_oficinas() returns void as $$

begin
	
	raise notice '---------------------------------------------------------------';
	raise notice '-- Depuración General  Campo "direccion" Tabla "oficinas" --';
	raise notice '---------------------------------------------------------------';

		
	
	-- Quitamos Caracteres Especiales
	update oficinas set direccion = replace(direccion, ',', ' ');

	update oficinas set direccion = replace(direccion, 'N°', ' ');

	update oficinas set direccion = replace(direccion, '/', '-');


		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';
	
end

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA OFICINAS_DETALLES ===========


-- --------- CAMPO LOCALIDAD --------------

select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';


-- Cambiamos la localidad a traves del id
create or replace function cambiar_loc_oficinas_detalles(loc_input varchar, id_input int ) returns void as $$

declare 

id_anterior varchar := (select id from oficinas_detalles where id=id_input);
loc_anterior varchar := (select localidad from oficinas_detalles where id=id_input);


begin 
	
	raise notice '------------------------------------------------------------------';
	raise notice '-- Modificación Campo "localidad" Tabla "oficinas_detalles" --';
	raise notice '------------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice 'Localidad : %', loc_anterior;



	update oficinas_detalles set localidad = loc_input where id = id_input ;


	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice 'Localidad : %', loc_input;

	
		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';
	
end

$$ language plpgsql;




-- --------- CAMPO TIPO_OFICINA --------------


select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';



-- Cambiamos el tipo de oficina enum
create or replace function cambiar_tipo_of_oficinas_detalles(tipo_input tipo_oficina, id_input int) returns void as $$

declare 

id_anterior varchar := (select id from oficinas_detalles where id=id_input);
tipo_anterior varchar := (select "tipo_oficina" from oficinas_detalles where id=id_input);


begin 
	
	raise notice '---------------------------------------------------------------------';
	raise notice '-- Modificación Campo "tipo_oficina" Tabla "oficinas_detalles" --';
	raise notice '---------------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice ' Tipo Oficina : %', tipo_anterior;

	update oficinas_detalles set tipo_oficina = tipo_input where id = id_input; 
	
	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice ' Tipo Oficina : %', tipo_input;
	


		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';


end

$$ language plpgsql;



-- --------- CAMPO SUPERFICIE_TOTAL --------------


create or replace function cambiar_superficie_total_oficinas_detalles(sup_total_input decimal, id_input int) returns void as $$

declare 

id_anterior varchar := (select id from oficinas_detalles where id=id_input);
sup_total_anterior varchar := (select superficie_total from oficinas_detalles where id=id_input);


begin 
	
	raise notice '-------------------------------------------------------------------------';
	raise notice '-- Modificación  Campo "superficie_total" Tabla "oficinas_detalles" --';
	raise notice '-------------------------------------------------------------------------';

	raise notice '';
	raise notice '-- Registro Anterior --';
	raise notice '';

	raise notice ' Id : %',  id_anterior;
	raise notice ' Superficie Total : %', sup_total_anterior;


	update oficinas_detalles set superficie_total = sup_total_input where id = id_input; 

	
	raise notice '';
	raise notice '';
	raise notice '-- Registro Actual --';
	raise notice '';

	raise notice ' Id : %',  id_input;
	raise notice ' Superficie Total : %', sup_total_input;

		raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';	

	
end

$$ language plpgsql;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========



-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

select * from empleados;

-- Depuracionn general de ambos campos
create or replace function depurar_nombres_apellidos_empleados() returns void as $$

begin
	
	raise notice '----------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "nombre" y Campo "apellido" Tabla "empleados" --';
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

end

$$ language plpgsql;




-- --------- CAMPO CUIL ---------------

select * from empleados;

-- actualizacion de cuil por id
create or replace function cambiar_cuil_empleados(cuil_input varchar, id_input int) returns void as $$

declare 

id_anterior varchar := (select id from empleados where id=id_input);
cuil_anterior varchar := (select cuil from empleados where id=id_input);


begin 
	
	raise notice '--------------------------------------------------';
	raise notice '-- Modificación  Campo "cuil" Tabla "empleados" --';
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
	
end
$$ language plpgsql;




-- --------- CAMPO DIRECCION ---------------

select * from empleados;

-- Depuracion general de direccion
create or replace function depurar_direccion_empleados() returns void as $$

begin
	
	raise notice '------------------------------------------------------------';
	raise notice '-- Depuración General Campo "direccion" Tabla "empleados" --';
	raise notice '------------------------------------------------------------';

		

	-- Todas las palabras con su inicial en Mayuscula
	update empleados set direccion = initcap(direccion);

	-- Quitamos los puntos
	update empleados set direccion = replace(direccion, '.', ' ');

	
	
	raise notice ' ';
	raise notice 'ok!';
	raise notice ' ';
	
end

$$ language plpgsql;



-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select * from empleados;

-- Depuracion general de ambos campos
create or replace function depurar_nro_telefonos_empleados() returns void as $$

begin
	
	raise notice '-----------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "nro_telefono_principal" y Campo "nro_telefono_secundario" Tabla "empleados" --';
	raise notice '-----------------------------------------------------------------------------------------------------------';

	
		
	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	update empleados set nro_telefono_principal = replace (nro_telefono_principal, '011 ', '11');
	update empleados set nro_telefono_secundario = replace (nro_telefono_secundario, '011 ', '11');
	
	-- Si no está el +54 lo Agregamos
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

end;

$$ language plpgsql;


-- ---------------- CAMPO SALARIO_ANUAL --------------------

select * from empleados;

-- Actualización del Salario Anual por años de antiguedad
create or replace function depurar_salario_anual_empleados() returns void as $$

declare
	-- Aumentamos 3% a los empleados con 1 año de antiguedad
	 primer_aumento decimal := 3.0/100;
	
	-- Aumentamos 7% a los empleados con 2 años de antiguedad
	 segundo_aumento decimal := 7.0/100;
	
	-- Aumentamos 10% a los empleados con 3 años de antiguedad
	 tercer_aumento decimal := 10.0/100;
	
	-- Aumentamos 15% a los empleados con 4 años de antiguedad
	 cuarto_aumento decimal := 15.0/100;
 


begin 
	
	raise notice '-----------------------------------------------------------';
	raise notice '-- Actualización Campo "salario_anual" Tabla "empleados" --';
	raise notice '-----------------------------------------------------------';

	raise notice '';
	raise notice '--Aumentamos % porciento a los empleados con 1 año de antiguedad--' , primer_aumento;
	raise notice '--Aumentamos % porciento a los empleados con 2 años de antiguedad--' , segundo_aumento;
	raise notice '--Aumentamos % porciento a los empleados con 3 años de antiguedad--' , tercer_aumento;
	raise notice '--Aumentamos % porciento a los empleados con 4 años de antiguedad--' , cuarto_aumento;

	
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


	
end;

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA CLIENTES ===========

select * from clientes;


-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

-- Depuracionn general de ambos campos
create or replace function depurar_nombres_apellidos_clientes() returns void as $$

begin
	
	raise notice '---------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "nombre" y Campo "Apellido" Tabla "clientes" --';
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


end

$$ language plpgsql;




-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select * from clientes;

-- Depuracion general de ambos campos
create or replace function depurar_nro_telefonos_clientes() returns void as $$

begin 
	
	raise notice '----------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "nro_telefono_principal" y Campo "nro_telefono_secundario" Tabla "clientes" --';
	raise notice '----------------------------------------------------------------------------------------------------------';
		

		
	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	update clientes set nro_telefono_principal = replace (nro_telefono_principal, '011 ', '11');
	update clientes set nro_telefono_secundario = replace (nro_telefono_secundario, '011 ', '11');
	
	-- Si no está el +54 lo Agregamos
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


end;

$$ language plpgsql;




-- --------- CAMPO DIRECCION ---------------


select * from clientes;

-- Depuracion general de direccion
create or replace function depurar_direccion_clientes() returns void as $$

begin
	
	raise notice '-----------------------------------------------------------';
	raise notice '-- Depuración General Campo "direccion" Tabla "clientes" --';
	raise notice '-----------------------------------------------------------';
		
		

	-- Todas las palabras con su inicial en Mayuscula
	update clientes set direccion = initcap(direccion);

	-- Quitamos los puntos
	update clientes set direccion = replace(direccion, '.', ' ');

	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

	
end

$$ language plpgsql;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA PROPIETARIOS_INMUEBLES ===========



-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

select * from clientes;


-- Depuracionn general de ambos campos
create or replace function depurar_nombres_apellidos_propietarios_inmuebles() returns void as $$

begin
	
	raise notice '-----------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "nombre" y Campo "apellido" Tabla "propietarios_inmuebles" --';
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

		
end

$$ language plpgsql;




-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select * from propietarios_inmuebles;


-- Depuracion general de ambos campos
create or replace function depurar_nro_telefonos_propietarios_inmuebles() returns void as $$

begin 
	
	
	raise notice '------------------------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "nro_telefono_principal" y Campo "nro_telefono_secundario" Tabla "propietarios_inmuebles" --';
	raise notice '------------------------------------------------------------------------------------------------------------------------';
		
		

		
	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	update propietarios_inmuebles set nro_telefono_principal = replace (nro_telefono_principal, '011 ', '11');
	update propietarios_inmuebles set nro_telefono_secundario = replace (nro_telefono_secundario, '011 ', '11');
	
	-- Si no está el +54 lo Agregamos
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
	
	
end;

$$ language plpgsql;



-- --------- CAMPO DIRECCION ---------------


select * from propietarios_inmuebles;

-- Depuracion general de direccion
create or replace function depurar_direccion_propietarios_inmuebles() returns void as $$

begin
	
	raise notice '-------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "direccion" Tabla "propietarios_inmuebles" --';
	raise notice '-------------------------------------------------------------------------';
		

	

	-- Todas las palabras con su inicial en Mayuscula
	update propietarios_inmuebles set direccion = initcap(direccion);

	-- Quitamos los puntos
	update propietarios_inmuebles set direccion = replace(direccion, '.', ' ');

	
		
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	
	
	
end

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES DESCRIPCIONES ===========



-- --------- CAMPO SUPERFICIE_TOTAL Y CAMPO SUPERFICIE_CUBIERTA---------------

select * from inmuebles_descripciones;

-- Depuracion general de ambos campos
create or replace function cambiar_superficie_total_cubierta_inmuebles_descripciones
(sup_total_input decimal, sup_cubierta_input decimal, id_input int ) returns void as $$

declare 

id_anterior varchar := (select id from inmuebles_descripciones id where id=id_input);
sup_total_anterior varchar := (select superficie_total from inmuebles_descripciones id where id=id_input);
sup_cubierta_anterior varchar := (select superficie_cubierta from inmuebles_descripciones id where id=id_input);


begin 
	
	raise notice '---------------------------------------------------------------------------------------------------------';
	raise notice '-- Modificación Campo "superficie_total" y Campo "superficie_cubierta" Tabla "inmuebles_descripciones" --';
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

	
end

$$ language plpgsql;

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES MEDIDAS ===========



-- --------- CAMPO DORMITORIO ---------------

select * from inmuebles_medidas;

-- Depuracion general del campo dormitorio
create or replace function depurar_dormitorio_inmuebles_medidas() returns void as $$

begin
	
	
	
	raise notice '---------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "dormitorio" Tabla "inmuebles_medidas" --';
	raise notice '---------------------------------------------------------------------';
		
		


	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio1', 'D1');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio2', 'D2');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio3', 'D3');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio4', 'D4');
	update inmuebles_medidas set dormitorio = replace(dormitorio, '|', ' ');

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	

end

$$ language plpgsql;




-- --------- CAMPO SANITARIO ---------------

select * from inmuebles_medidas;

-- Depuracion general de cambo dormitorio
create or replace function depurar_sanitario_inmuebles_medidas() returns void as $$

begin
	
	raise notice '---------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "sanitario" Tabla "inmuebles_medidas" --';
	raise notice '---------------------------------------------------------------------';
		
	
	
	update inmuebles_medidas set sanitario = replace(sanitario, 'Baño1', 'S1');
	update inmuebles_medidas set sanitario = replace(sanitario, 'Baño2', 'S2');
	update inmuebles_medidas set sanitario = replace(sanitario, 'Baño3', 'S3');
	update inmuebles_medidas set sanitario = replace(sanitario, '|', ' ');


	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;




-- --------- CAMPOS PATIO_JARDIN, COCHERA, BALCON ---------------

select * from inmuebles_medidas;

-- Depuracion general de los campos
create or replace function depurar_patio_jardin_cochera_balcon_inmuebles_medidas() returns void as $$

begin
	
	raise notice '---------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "patio_jardin", Campo "cochera" y Campo "balcon" Tabla "inmuebles_medidas" --';
	raise notice '---------------------------------------------------------------------------------------------------------';
		

	update inmuebles_medidas set patio_jardin = replace(patio_jardin, '-', '0.0 x 0.0');
	update inmuebles_medidas set cochera = replace(cochera, '-', '0.0 x 0.0');
	update inmuebles_medidas set balcon = replace(balcon, '-', '0.0 x 0.0');
	
	
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

	
end

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES ===========



-- --------- CAMPOS DESCRIPCION, TIPO ---------------

select * from inmuebles;



-- Depuracion general de los campos
create or replace function depurar_descripcion_tipo_inmuebles() returns void as $$

begin
	
		
	raise notice '-----------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "descripcion" y Campo "tipo" Tabla "inmuebles" --';
	raise notice '-----------------------------------------------------------------------------';
		
	

	
	update inmuebles set descripcion = initcap(descripcion);
	update inmuebles set tipo = initcap(tipo);
	
	
	update inmuebles set descripcion = replace(descripcion, 'Baño', 'Sanitario');
	update inmuebles set descripcion = replace(descripcion, 'Baños', 'Sanitarios');
	update inmuebles set descripcion = replace(descripcion, ',', ' ');
	update inmuebles set tipo = replace(tipo, 'Ph/Casa', 'Ph');



	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
		

end

$$ language plpgsql;




-- --------- CAMPOS DIRECCION, UBICACION ---------------


select * from inmuebles;

-- Depuracion general de direccion
create or replace function depurar_direccion_ubicacion_inmuebles() returns void as $$

begin
	
		
	raise notice '--------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "direccion" y Campo "ubicacion" Tabla "inmuebles" --';
	raise notice '--------------------------------------------------------------------------------';
		
	
		

	-- Todas las palabras con su inicial en Mayuscula
	update inmuebles set direccion = initcap(direccion);
	update inmuebles set ubicacion = initcap(ubicacion);

	-- Quitamos los puntos
	update inmuebles set direccion = replace(direccion, '.', ' ');

	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	
	
end

$$ language plpgsql;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA CITAS_INMUEBLES ===========


-- --------- CAMPOS DESCRIPCION_CITA ---------------


select * from citas_inmuebles;

-- Depuracion general de descripcion_cita
create or replace function depurar_descripcion_cita_citas_inmuebles() returns void as $$

begin
		
	raise notice '-------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "descripcion_cita" Tabla "citas_inmuebles" --';
	raise notice '-------------------------------------------------------------------------';
	

	-- Todas las palabras con su inicial en Mayuscula
	update citas_inmuebles set descripcion_cita = initcap(descripcion_cita);
	
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	

	
end

$$ language plpgsql;






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA SERVICIOS_INMUEBLES ===========


-- --------- CAMPOS DESCRIPCION_SERVICIOS---------------


select * from servicios_inmuebles;

-- Depuracion general de descripcion_cita
create or replace function depurar_descripcion_servicios_inmuebles() returns void as $$

begin
	
		
	raise notice '----------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "descripcion_servicios" Tabla "servicios_inmuebles" --';
	raise notice '----------------------------------------------------------------------------------';
	

		

	-- Todas las palabras con su inicial en Mayuscula
	update servicios_inmuebles set descripcion_servicios = initcap(descripcion_servicios);
	
	update servicios_inmuebles set descripcion_servicios = replace(descripcion_servicios,'-','');
	
	
		
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	


	
end

$$ language plpgsql;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INSPECCIONES_INMUEBLES ===========


-- --------- CAMPO DESCRIPCION_INSPECCION ---------------


select * from inspecciones_inmuebles;

-- Depuracion general de descripcion_inspeccion
create or replace function depurar_descripcion_inspeccion_inspecciones_inmuebles() returns void as $$

begin
	
		
	raise notice '--------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "descripcion_inspeccion" Tabla "inspecciones_inmuebles" --';
	raise notice '--------------------------------------------------------------------------------------';


	-- Todas las palabras con su inicial en Mayuscula
	update inspecciones_inmuebles set descripcion_inspeccion = initcap(descripcion_inspeccion);
	update inspecciones_inmuebles set descripcion_inspeccion = replace(descripcion_inspeccion,'Caba','Cabo');



	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	


end

$$ language plpgsql;



-- --------- CAMPOS EMPRESA, DIRECCION ---------------


select * from inspecciones_inmuebles;

-- Depuracion general de los campos
create or replace function depurar_empresa_direccion_inspecciones_inmuebles() returns void as $$

begin

	
	
	raise notice '-------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "empresa" y Campo "direccion" Tabla "inspecciones_inmuebles" --';
	raise notice '-------------------------------------------------------------------------------------------';
	



	-- Todas las palabras con su inicial en Mayuscula
	update inspecciones_inmuebles set empresa = initcap(empresa);
	update inspecciones_inmuebles set direccion = initcap(direccion);
	
	-- Reemplazamos caracteres
	update inspecciones_inmuebles set direccion = replace(direccion,'Caba','Cabo');
	



	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	

end

$$ language plpgsql;



-- --------- CAMPO NUMERO_TELEFONO ---------------


select * from inspecciones_inmuebles;

-- Depuracion general de los campos
create or replace function depurar_nro_tel_inspecciones_inmuebles() returns void as $$

begin
		
	raise notice '----------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "nro_telefono" Tabla "inspecciones_inmuebles" --';
	raise notice '----------------------------------------------------------------------------';
	

	-- Reemplazamos caracteres
	update inspecciones_inmuebles set nro_telefono = replace(nro_telefono,'-','');
	



	raise notice '';
	raise notice 'ok!';
	raise notice ' ';
	
end

$$ language plpgsql;



-- --------- CAMPO COSTO ---------------


select * from inspecciones_inmuebles;


-- Depuracion general del campo costo
create or replace function depurar_costo_inspecciones_inmuebles() returns void as $$

declare 
	 aumento_depto decimal := 1.6/100;
	 aumento_casa_ph decimal := 2.3/100;
	

begin

			
	raise notice '---------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "costo" Tabla "inspecciones_inmuebles" --';
	raise notice '---------------------------------------------------------------------';
	

	
	raise notice '';
	raise notice 'Se aumenta el % porciento al tipo de inpección Departamento',aumento_depto;
	raise notice 'Se aumenta el % porciento al tipo de inpección Casa/Ph',aumento_casa_ph;


	update inspecciones_inmuebles set costo = (costo + (costo * aumento_depto)) 
	where tipo_inspeccion = 'DEPARTAMENTO'; 
		
	update inspecciones_inmuebles set costo = (costo + (costo * aumento_casa_ph))  
	where tipo_inspeccion = 'CASA';

	update inspecciones_inmuebles set costo = (costo + (costo * aumento_casa_ph))
	where tipo_inspeccion = 'PH';


	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;



-- --------- CAMPO HORA Y CAMPO FECHA ---------------


select * from inspecciones_inmuebles;


-- Cambiar Hora y Fecha
create or replace function cambiar_fecha_hora_inspecciones_inmuebles(id_input int, fecha_input date
, hora_input time) returns void as $$

declare 
	 id_anterior int := (select id from inspecciones_inmuebles where id = id_input);
	 fecha_anterior date:= (select fecha from inspecciones_inmuebles where id = id_input);
	 hora_anterior time := (select hora from inspecciones_inmuebles where id = id_input);

begin

			
	raise notice '----------------------------------------------------------------------------------';
	raise notice '-- Modificación del Campo "fecha" y Campo "hora" Tabla "inspecciones_inmuebles" --';
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


end

$$ language plpgsql;






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES_MARKETING ===========



-- --------- CAMPO TIPO_ANUNCIO_PRINCIPAL Y CAMPO TIPO_ANUNCIO_SECUNDARIO ---------------


select * from inmuebles_marketing;



-- Depuracion general de ambos campos
create or replace function depurar_tipo_anuncio_principal_secundario_inmuebles_marketing() returns void as $$
	

begin

			
	raise notice '---------------------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "tipo_anuncio_principal" y Campo "tipo_anuncio_secundario" Tabla "inmuebles_marketing" --';
	raise notice '---------------------------------------------------------------------------------------------------------------------';
	



	update inmuebles_marketing set tipo_anuncio_principal = replace(tipo_anuncio_principal,'-',''); 
	update inmuebles_marketing set tipo_anuncio_principal = initcap(tipo_anuncio_principal); 
	

	update inmuebles_marketing set tipo_anuncio_secundario = replace(tipo_anuncio_secundario,'-',''); 
	update inmuebles_marketing set tipo_anuncio_secundario = initcap(tipo_anuncio_secundario); 
	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;




-- --------- CAMPO DESCRIPCION_ANUNCIO ---------------


select * from inmuebles_marketing;



-- Depuracion general del campo descripcion_anuncio
create or replace function depurar_descripcion_anuncio_inmuebles_marketing() returns void as $$
	

begin

			
	raise notice '--------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "descripcion_anuncio" Tabla "inmuebles_marketing" --';
	raise notice '--------------------------------------------------------------------------------';
	



	update inmuebles_marketing set descripcion_anuncio = replace(descripcion_anuncio,'-',''); 
	update inmuebles_marketing set descripcion_anuncio = initcap(descripcion_anuncio); 
	

	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;




-- --------- CAMPO INVERSION_TOTAL ---------------


select * from inmuebles_marketing;


-- Depuracion general del campo inversion_total
create or replace function depurar_inversion_total_inmuebles_marketing() returns void as $$

declare 
	 aumento_google_ads decimal := 0.9/100;
	 aumento_youtube decimal := 0.2/100;
	 aumento_linkedin decimal := 0.14/100;
	

begin

			
	raise notice '----------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "inversion_total" Tabla "inmuebles_marketing" --';
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

end

$$ language plpgsql;






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA ADMINISTRADORES ===========



-- --------- CAMPO TIPO_INMUEBLE ---------------


select * from administradores;


-- Depuracion general del campo tipo_inmueble
create or replace function depurar_tipo_inmuebles_administradores() returns void as $$
	

begin

			
	raise notice '----------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "tipo_inmueble" Tabla "administradores" --';
	raise notice '----------------------------------------------------------------------';
	


	update administradores set tipo_inmueble = initcap(tipo_inmueble); 
	update administradores set tipo_inmueble = replace(tipo_inmueble ,'Departamento','Depart');
	update administradores set tipo_inmueble = replace(tipo_inmueble ,'Departamento-Casa','Depart/Casa');
	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;



-- --------- CAMPO CERTIFICACIONES ---------------


select * from administradores;



-- Depuracion general del campo certificaciones
create or replace function depurar_certificaciones_administradores() returns void as $$
	

begin

			
	raise notice '------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "certificaciones" Tabla "administradores" --';
	raise notice '------------------------------------------------------------------------';
	


	update administradores set certificaciones = initcap(certificaciones);
 	
	update administradores set certificaciones = replace(certificaciones,',','/');
 	update administradores set certificaciones = replace(certificaciones,'.','');
 	
 	update administradores set certificaciones = replace(certificaciones,'Aministrativas','Admin');
    update administradores set certificaciones = replace(certificaciones,'Aministración','Admin');
 	update administradores set certificaciones = replace(certificaciones,'Administrativas','Admin');
 	update administradores set certificaciones = replace(certificaciones,'Administración','Admin');
 	update administradores set certificaciones = replace(certificaciones,'Administrativo','Admin');
 	
	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA GERENTES ===========



-- --------- CAMPO TITULO ---------------


select * from gerentes;


-- Depuracion general del campo titulo
create or replace function depurar_titulo_gerentes() returns void as $$
	

begin

			
	raise notice '--------------------------------------------------------';
	raise notice '-- Depuración General Campo "titulo" Tabla "gerentes" --';
	raise notice '--------------------------------------------------------';
	


	update gerentes set titulo = initcap(titulo); 
	update gerentes set titulo = replace(titulo ,'Licenciado','Lic');
	update gerentes set titulo = replace(titulo ,'Licenciada','Lic');
	update gerentes set titulo = replace(titulo ,'Administración','Adm');

	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;



-- --------- CAMPO TITULO ---------------


select * from gerentes;


-- Depuracion general del campo titulo
create or replace function depurar_titulo_gerentes() returns void as $$
	

begin

			
	raise notice '--------------------------------------------------------';
	raise notice '-- Depuración General Campo "titulo" Tabla "gerentes" --';
	raise notice '--------------------------------------------------------';
	


	update gerentes set titulo = initcap(titulo); 
	update gerentes set titulo = replace(titulo ,'Licenciado','Lic');
	update gerentes set titulo = replace(titulo ,'Licenciada','Lic');
	update gerentes set titulo = replace(titulo ,'Administración','Adm');

	
	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;



-- --------- CAMPO BENEFICIOS ---------------


select * from gerentes;


-- Depuracion general
create or replace function depurar_beneficios_gerentes() returns void as $$
	

begin

			
	raise notice '------------------------------------------------------------';
	raise notice '-- Depuración General Campo "beneficios" Tabla "gerentes" --';
	raise notice '------------------------------------------------------------';
	


	update gerentes set beneficios = initcap(beneficios);
	update gerentes set beneficios = replace(beneficios ,'2 Veces X Sem','');
	update gerentes set beneficios = replace(beneficios ,'35%','');
	update gerentes set beneficios = replace(beneficios ,'40%','');	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;



-- --------- CAMPO RETRIBUCION_SALARIAL_ANUAL ---------------


select * from gerentes;


-- Depuracion general
create or replace function depurar_retribucion_salarial_anual_gerentes() returns void as $$
	
declare 
	
	primer_aumento decimal := 0.2/100;
	 segundo_aumento decimal := 0.4/100;
	 tercer_aumento decimal := 0.9/100;
	

begin

			
	raise notice '----------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "retribucion_salarial_anual" Tabla "gerentes" --';
	raise notice '----------------------------------------------------------------------------';
	
	
	
	raise notice '';
	raise notice 'Se aumenta el % porciento a los Gerentes que tengas entre 2 y 6 años de experiencia',primer_aumento; 
	raise notice 'Se aumenta el % porciento a los Gerentes que tengas entre 7 y 9 años de experiencia',segundo_aumento; 
	raise notice 'Se aumenta el % porciento a los Gerentes que tengas entre 10 y 15 años de experiencia',tercer_aumento; 
	



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

end

$$ language plpgsql;




-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA VENDEDORES ===========



-- --------- CAMPO CANTIDAD_VENTAS ---------------


select * from vendedores;



-- Modificación campo cantidad_ventas
create or replace function cambiar_cantidad_ventas_vendedores(id_input int, cant_ventas_input int) returns void as $$

declare 
	 id_anterior int := (select id from vendedores where id = id_input );
	 cant_ventas_anterior int  := (select cantidad_ventas from vendedores where id = id_input );
	 	

begin

			
	raise notice '--------------------------------------------------------------';
	raise notice '-- Modificación  Campo "cantidad_ventas" Tabla "vendedores" --';
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

end

$$ language plpgsql;



-- --------- CAMPO BONIFICACION_VENTAS ---------------


select * from vendedores;


-- Depuracion general
create or replace function depurar_bonificacion_ventas_vendedores() returns void as $$
	
declare 

	 primera_bonif decimal := 1.15/100;
	 segunda_bonif decimal := 2.21/100;
	 tercera_bonif decimal := 3.41/100;

begin

			
	raise notice '-----------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "bonificacion_ventas" Tabla "vendedores" --';
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

end

$$ language plpgsql;





-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA COMPRADORES ===========



-- --------- CAMPO DESCUENTO_CLIENTE_USD Y CAMPO BENEFICIOS_COMPRAS---------------


select * from compradores;


-- Depuracion general
create or replace function depurar_descuento_cliente_usd_beneficios_compras_compradores() returns void as $$
	
declare 
	 primer_desc decimal := 7/100;
	 segundo_desc decimal := 10/100;
begin

			
	raise notice '-------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "descuento_cliente_usd" y campo "beneficios_compras" Tabla "compradores" --';
	raise notice '-------------------------------------------------------------------------------------------------------';
	
	
	raise notice '';			
	raise notice 'Se aplica el descuento del  % porciento a los Compradores que hayan comprado 1 Inmueble',primer_desc;
	raise notice 'Se aplica el descuento del  % porciento a los Compradores que hayan comprado 2 Inmuebles',segundo_desc;



	update compradores set descuento_cliente_usd = 
	(descuento_cliente_usd + (descuento_cliente_usd * primer_desc))  
	where (cantidad_inmuebles_comprados = 1); 

	update compradores set descuento_cliente_usd = 
	(descuento_cliente_usd + (descuento_cliente_usd * segundo_desc))  
	where (cantidad_inmuebles_comprados = 2); 

	-- cambiamos los beneficios de compras
	update compradores set beneficios_compras = 'Descuento del 15% en la Próxima Compra' where cantidad_inmuebles_comprados = 1;
	update compradores set beneficios_compras = 'Descuento del 20% en la Próxima Compra' where cantidad_inmuebles_comprados = 2;

	update compradores set beneficios_compras = initcap(beneficios_compras);


	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;







-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA VENTAS ===========




-- --------- CAMPO FECHA_VENTA Y CAMPO HORA_VENTA ---------------


select * from ventas;



-- Modificación campo fecha_venta y campo hora_venta
create or replace function cambiar_fecha_hora_venta_ventas(id_input int, fecha_venta_input date, hora_venta_input time) returns void as $$

declare 
	 id_anterior int := (select id from ventas where id = id_input );
	 fecha_venta_anterior date  := (select fecha_venta from ventas where id = id_input );
	 hora_venta_anterior time  := (select hora_venta from ventas where id = id_input );
	 	

begin

			
	raise notice '---------------------------------------------------------------------------';
	raise notice '-- Modificación  Campo "fecha_venta" y Campo "hora_venta" Tabla "ventas" --';
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

end

$$ language plpgsql;




-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA FACTURAS ===========



-- --------- CAMPO PRECIO_TOTAL_VENTA_USD ---------------

select * from facturas;


-- Depuracion general
create or replace function depurar_precio_total_venta_usd_facturas() returns void as $$
	
declare 
	 impuesto_venta  decimal := 0.7/100;
	 impuesto_agregado decimal := 0.6/100;

begin

			
	raise notice '------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "precio_total_venta_usd" Tabla "facturas" --';
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

end

$$ language plpgsql;





-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA FACTURAS_DETALLES ===========



-- --------- CAMPO DESCRIPCION_FACTURA Y CAMPO DESCRIPCION_PAGO ---------------

select * from facturas_detalles;


-- Depuracion general
create or replace function depurar_descripcion_factura_pago_facturas_detalles() returns void as $$
	

begin

			
	raise notice '---------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "descripcion_factura" y Campo "descripcion_pago" Tabla "facturas_detalles" --';
	raise notice '---------------------------------------------------------------------------------------------------------';
	


	update facturas_detalles set descripcion_factura = initcap(descripcion_factura);

	update facturas_detalles set descripcion_pago = initcap(descripcion_pago);
	
	update facturas_detalles set descripcion_pago = replace(descripcion_pago ,'1 Sólo','1');
	
	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;





-- --------- CAMPO VALOR_INMUEBLE_USD---------------


select * from facturas_detalles;


-- Depuracion general
create or replace function depurar_valor_inmueble_usd_facturas_detalles() returns void as $$
	
declare 
	 aumento_valor decimal := 7.88/100;

begin

			
	raise notice '-----------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "valor_inmueble_usd" Tabla "facturas_detalles" --';
	raise notice '-----------------------------------------------------------------------------';
	
	raise notice '';
	raise notice 'Se aumenta el % porciento al valor del Inmueble',aumento_valor;


	update facturas_detalles set valor_inmueble_usd = 
	(valor_inmueble_usd + (valor_inmueble_usd * aumento_valor)); 

	

	raise notice '';
	raise notice 'ok!';
	raise notice ' ';

end

$$ language plpgsql;




-- --------- CAMPO COSTO_ASOCIADO_USD Y CAMPO IMPUESTOS_ASOCIADOS_USD---------------


select * from facturas_detalles;


-- Depuracion general
create or replace function depurar_costo_impuestos_asociados_usd_facturas_detalles() returns void as $$
	
declare 
	 aumento_costos decimal := 7.88/100;
	 aumento_impuestos decimal := 9.12/100;

begin

			
	raise notice '---------------------------------------------------------------------------------------------------------------';
	raise notice '-- Depuración General Campo "costo_asociado_usd" y Campo "impuestos_asociados_usd" Tabla "facturas_detalles" --';
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

end

$$ language plpgsql;
*/