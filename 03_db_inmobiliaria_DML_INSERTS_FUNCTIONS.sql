/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML INSERTS FUNCTIONS=============
 */




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';





-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA OFICINAS -------

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

-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA LOGS_INSERTS -------
drop function listado_logs_inserts() returns setof logs_inserts;

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



/*
-- ----------- SELECT DE ALGUNOS REGISTROS DE LA TABLA OFICINAS -------

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








-- ----------- INSERCION DE 1 REGISTRO ------------
--drop function insertar_registro_oficinas( varchar, varchar, varchar, varchar);

create or replace function insertar_registro_oficinas(

nombre_input varchar, dir_input varchar, nro_tel_input varchar, email_input varchar

) returns void as $$

declare

-- Nos aseguramos que no exista un registro repetido ademas del check de la db
 nombre_of_check boolean := exists(select nombre from oficinas where nombre = nombre_input);
 direccion_of_check boolean := exists(select direccion from oficinas where direccion = dir_input);

-- == Variables para el log_insert ==

-- Ultimo id ingresado
id_of_last int := (select currval(pg_get_serial_sequence('logs_inserts','id')));

-- Identificar unico del registro
-- uuid_of_last int := ();

begin
	
	if(
	(nombre_of_check = true) or (direccion_of_check = true)
	
	) then
	
		raise exception 'NO SE PUEDE INGRESAR UN REGISTRO REPETIDO '
						using hint = ' | DETALLE | -->REVISAR NOMBRE Y DIRECCION DE LA OFICINA';
						
		
	
	elsif (
		
		(nombre_of_check = false) and (direccion_of_check = false)
		and nombre_input <> '' 
		and dir_input <> '' 
		and nro_tel_input <> '' 
		and email_input <> ''
		
		) then
	
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "oficinas" --';
		raise notice '----------------------------------------------';
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserci�n --';
		raise notice '';
	
		raise notice 'ID : %' , id_of_last;
		raise notice 'Nombre : %', nombre_input;
		raise notice 'Direcci�n : %', dir_input;
		raise notice 'Nro Telefono : %', nro_tel_input;
		raise notice 'Email : %', email_input;
	
	
	
		
		insert into oficinas(nombre, direccion, nro_telefono, email) values 
		(nombre_input , dir_input , nro_tel_input , email_input);
	
	
		-- Actualizamos la tabla de logs_inserts
		-- insert into logs_inserts (id_registro
		-- nombre_tabla, accion, fecha, hora, rol_nivel, motor_db ) VALUES
		
		insert into logs_inserts(id_registro, nombre_tabla, accion, fecha, hora, usuario, rol_nivel, motor_db) values
		( id_of_last, "oficinas", "update", current_date, current_time, current_user
		, information_schema.enabled_roles , information_schema."attributes");

		
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	else
	
	raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N insertar_registro_oficinas()'
						using hint = ' | DETALLE | --> insertar_registros_oficinas(nombre varchar, direccion varchar, nro_telefono varchar, email varchar); ';
		
	end if;
	

end;
	
$$ language plpgsql;


-- ---------------------------------------------------------------------------


/*


-- ----------- INSERCION DE 2 REGISTROS ------------


create or replace function insertar_registros_oficinas(

nombre_input_01 varchar, dir_input_01 varchar, nro_tel_input_01 varchar, email_input_01 varchar
,nombre_input_02 varchar, dir_input_02 varchar, nro_tel_input_02 varchar, email_input_02 varchar

) returns void as $$

declare

-- Nos aseguramos que no se inserten registros repetidos en la db ademas del check de la db
 nombre_of_check_01 boolean := exists(select nombre from oficinas where nombre = nombre_input_01);
 nombre_of_check_02 boolean := exists(select nombre from oficinas where nombre = nombre_input_02);

 direccion_of_check_01 boolean := exists(select direccion from oficinas where direccion = dir_input_01);
 direccion_of_check_02 boolean := exists(select direccion from oficinas where direccion = dir_input_02);

begin
	
	if(
	--Nombre y direccion repetida
	((nombre_of_check_01 = true) and (direccion_of_check_01 = true))
	or ((nombre_of_check_02 = true) and (direccion_of_check_02 = true))
	or (dir_input_01 = dir_input_02)
	
	) then
	
		raise exception 'NO SE PUEDE INGRESAR UN REGISTRO REPETIDO '
						using hint = ' | DETALLE | --> REVISAR NOMBRES Y DIRECCIONES DE LA OFICINA';
						
		
	
	elsif ( 
		((direccion_of_check_01 = false) and (direccion_of_check_02 = false))
		and nombre_input_01 <> '' and dir_input_01 <> '' and nro_tel_input_01 <> '' and email_input_01 <> ''
		and nombre_input_02 <> '' and dir_input_02 <> '' and nro_tel_input_02 <> '' and email_input_02 <> ''
		
		) then
	
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de 2 Registros Tabla "oficinas" --';
		raise notice '----------------------------------------------';
	
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserci�n N�mero 1--';
		raise notice '';
	
		
		raise notice 'Nombre : %', nombre_input_01;
		raise notice 'Direcci�n : %', dir_input_01;
		raise notice 'Nro Telefono : %', nro_tel_input_01;
		raise notice 'Email : %', email_input_01;
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserci�n N�mero 2-';
		raise notice '';
	
		
		raise notice 'Nombre : %', nombre_input_02;
		raise notice 'Direcci�n : %', dir_input_02;
		raise notice 'Nro Telefono : %', nro_tel_input_02;
		raise notice 'Email : %', email_input_02;
	
	
	
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input_01 , dir_input_01 , nro_tel_input_01 , email_input_01),
		(nombre_input_02 , dir_input_02 , nro_tel_input_02 , email_input_02);
	
		
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';
	
	
		else
			
			raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DE LOS REGISTRO PARA LA FUNCI�N insertar_registros_oficinas()'
						using hint = ' | DETALLE | --> insertar_registros_oficinas(
									nombre_01 varchar, direccion_01 varchar, nro_telefono_01 varchar, email_01 varchar
									,nombre_02 varchar, direccion_02 varchar, nro_telefono_02 varchar, email_02 varchar); ';
		
		end if;

	


end;
	
$$ language plpgsql;


-- ---------------------------------------------------------------------------




-- ----------- INSERCION DE 3 REGISTROS ------------

-- APLICAMOS SOBRECARGA DE METODOS
create or replace function insertar_registros_oficinas(

nombre_input_01 varchar, dir_input_01 varchar, nro_tel_input_01 varchar, email_input_01 varchar
,nombre_input_02 varchar, dir_input_02 varchar, nro_tel_input_02 varchar, email_input_02 varchar
,nombre_input_03 varchar, dir_input_03 varchar, nro_tel_input_03 varchar, email_input_03 varchar

) returns void as $$


declare

-- Nos aseguramos que no se inserten registros repetidos en la db ademas del check de la db
 nombre_of_check_01 boolean := exists(select nombre from oficinas where nombre = nombre_input_01);
 nombre_of_check_02 boolean := exists(select nombre from oficinas where nombre = nombre_input_02);
 nombre_of_check_03 boolean := exists(select nombre from oficinas where nombre = nombre_input_03);

 direccion_of_check_01 boolean := exists(select direccion from oficinas where direccion = dir_input_01);
 direccion_of_check_02 boolean := exists(select direccion from oficinas where direccion = dir_input_02);
 direccion_of_check_03 boolean := exists(select direccion from oficinas where direccion = dir_input_03);

begin
	
	if(
	--Nombre y direccion repetida
	((nombre_of_check_01 = true) and (direccion_of_check_01 = true))
	or ((nombre_of_check_02 = true) and (direccion_of_check_02 = true))
	or ((nombre_of_check_03 = true) and (direccion_of_check_03 = true))
	or ((dir_input_01 = dir_input_02) or (dir_input_01 = dir_input_03) or (dir_input_02 = dir_input_03))
	
	) then
	
		raise exception 'NO SE PUEDE INGRESAR UN REGISTRO REPETIDO '
						using hint = ' | DETALLE | --> REVISAR NOMBRES Y DIRECCIONES DE LA OFICINA';
						
		
	
	elsif ( 
		((direccion_of_check_01 = false) and (direccion_of_check_02 = false) and (direccion_of_check_03 = false))
		and nombre_input_01 <> '' and dir_input_01 <> '' and nro_tel_input_01 <> '' and email_input_01 <> ''
		and nombre_input_02 <> '' and dir_input_02 <> '' and nro_tel_input_02 <> '' and email_input_02 <> ''
		and nombre_input_03 <> '' and dir_input_03 <> '' and nro_tel_input_03 <> '' and email_input_03 <> ''
		
		) then
			
			raise notice '';
			raise notice '----------------------------------------------';
			raise notice '-- Inserci�n de 3 Registros Tabla "oficinas" --';
			raise notice '----------------------------------------------';
		
		
		
			raise notice '';
			raise notice '';
			raise notice '-- Registro de Inserci�n N�mero 1--';
			raise notice '';
		
			
			raise notice 'Nombre : %', nombre_input_01;
			raise notice 'Direcci�n : %', dir_input_01;
			raise notice 'Nro Telefono : %', nro_tel_input_01;
			raise notice 'Email : %', email_input_01;
		
		
			raise notice '';
			raise notice '';
			raise notice '-- Registro de Inserci�n N�mero 2-';
			raise notice '';
		
			
			raise notice 'Nombre : %', nombre_input_02;
			raise notice 'Direcci�n : %', dir_input_02;
			raise notice 'Nro Telefono : %', nro_tel_input_02;
			raise notice 'Email : %', email_input_02;
		
			raise notice '';
			raise notice '';
			raise notice '-- Registro de Inserci�n N�mero 3-';
			raise notice '';
		
			
			raise notice 'Nombre : %', nombre_input_03;
			raise notice 'Direcci�n : %', dir_input_03;
			raise notice 'Nro Telefono : %', nro_tel_input_03;
			raise notice 'Email : %', email_input_03;
		
		
			
			insert into oficinas (nombre, direccion, nro_telefono, email) values 
			(nombre_input_01 , dir_input_01 , nro_tel_input_01 , email_input_01),
			(nombre_input_02 , dir_input_02 , nro_tel_input_02 , email_input_02),
			(nombre_input_03 , dir_input_03 , nro_tel_input_03 , email_input_03);
		
			
		
			raise notice ' ';
			raise notice 'ok!';
			raise notice ' ';
	
	
		else
			
			raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DE LOS REGISTROS PARA LA FUNCI�N insertar_registros_oficinas()'
							using hint = ' | DETALLE | --> insertar_registros_oficinas(
										nombre_01 varchar, direccion_01 varchar, nro_telefono_01 varchar, email_01 varchar
										,nombre_02 varchar, direccion_02 varchar, nro_telefono_02 varchar, email_02 varchar
										,nombre_03 varchar, direccion_03 varchar, nro_telefono_03 varchar, email_03 varchar); ';
			
		end if;
	

end;
	
$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- ----------- INSERCION DE 4 REGISTROS ------------

-- APLICAMOS SOBRECARGA DE METODOS
create or replace function insertar_registros_oficinas(

nombre_input_01 varchar, dir_input_01 varchar, nro_tel_input_01 varchar, email_input_01 varchar
, nombre_input_02 varchar, dir_input_02 varchar, nro_tel_input_02 varchar, email_input_02 varchar
, nombre_input_03 varchar, dir_input_03 varchar, nro_tel_input_03 varchar, email_input_03 varchar
, nombre_input_04 varchar, dir_input_04 varchar, nro_tel_input_04 varchar, email_input_04 varchar

) returns void as $$


declare

-- Nos aseguramos que no se inserten registros repetidos en la db ademas del check de la db
 nombre_of_check_01 boolean := exists(select nombre from oficinas where nombre = nombre_input_01);
 nombre_of_check_02 boolean := exists(select nombre from oficinas where nombre = nombre_input_02);
 nombre_of_check_03 boolean := exists(select nombre from oficinas where nombre = nombre_input_03);
 nombre_of_check_04 boolean := exists(select nombre from oficinas where nombre = nombre_input_04);

 direccion_of_check_01 boolean := exists(select direccion from oficinas where direccion = dir_input_01);
 direccion_of_check_02 boolean := exists(select direccion from oficinas where direccion = dir_input_02);
 direccion_of_check_03 boolean := exists(select direccion from oficinas where direccion = dir_input_03);
 direccion_of_check_04 boolean := exists(select direccion from oficinas where direccion = dir_input_04);

begin
	
	if(
	--Nombre y direccion repetida
	((nombre_of_check_01 = true) and (direccion_of_check_01 = true))
	or ((nombre_of_check_02 = true) and (direccion_of_check_02 = true))
	or ((nombre_of_check_03 = true) and (direccion_of_check_03 = true))
	or ((dir_input_01 = dir_input_02) or (dir_input_01 = dir_input_03) or (dir_input_01 = dir_input_04)) 
	or ((dir_input_02 = dir_input_03) or (dir_input_02 = dir_input_04) or (dir_input_03 = dir_input_04))
	
	) then
	
		raise exception 'NO SE PUEDE INGRESAR UN REGISTRO REPETIDO '
						using hint = ' | DETALLE | --> REVISAR NOMBRES Y DIRECCIONES DE LA OFICINA';
						
		
	
	elsif ( 
		((direccion_of_check_01 = false) and (direccion_of_check_02 = false)) 
		and ((direccion_of_check_03 = false) and (direccion_of_check_04 = false))
		and nombre_input_01 <> '' and dir_input_01 <> '' and nro_tel_input_01 <> '' and email_input_01 <> ''
		and nombre_input_02 <> '' and dir_input_02 <> '' and nro_tel_input_02 <> '' and email_input_02 <> ''
		and nombre_input_03 <> '' and dir_input_03 <> '' and nro_tel_input_03 <> '' and email_input_03 <> ''
		) then
			
			raise notice '';
			raise notice '----------------------------------------------';
			raise notice '-- Inserci�n de 4 Registros Tabla "oficinas" --';
			raise notice '----------------------------------------------';
		
		
		
			raise notice '';
			raise notice '';
			raise notice '-- Registro de Inserci�n N�mero 1--';
			raise notice '';
		
			
			raise notice 'Nombre : %', nombre_input_01;
			raise notice 'Direcci�n : %', dir_input_01;
			raise notice 'Nro Telefono : %', nro_tel_input_01;
			raise notice 'Email : %', email_input_01;
		
		
			raise notice '';
			raise notice '';
			raise notice '-- Registro de Inserci�n N�mero 2-';
			raise notice '';
		
			
			raise notice 'Nombre : %', nombre_input_02;
			raise notice 'Direcci�n : %', dir_input_02;
			raise notice 'Nro Telefono : %', nro_tel_input_02;
			raise notice 'Email : %', email_input_02;
		
			raise notice '';
			raise notice '';
			raise notice '-- Registro de Inserci�n N�mero 3-';
			raise notice '';
		
			
			raise notice 'Nombre : %', nombre_input_03;
			raise notice 'Direcci�n : %', dir_input_03;
			raise notice 'Nro Telefono : %', nro_tel_input_03;
			raise notice 'Email : %', email_input_03;
		
		
			
			raise notice '';
			raise notice '';
			raise notice '-- Registro de Inserci�n N�mero 4-';
			raise notice '';
		
			
			raise notice 'Nombre : %', nombre_input_04;
			raise notice 'Direcci�n : %', dir_input_04;
			raise notice 'Nro Telefono : %', nro_tel_input_04;
			raise notice 'Email : %', email_input_04;
		
		
			
			insert into oficinas (nombre, direccion, nro_telefono, email) values 
			(nombre_input_01 , dir_input_01 , nro_tel_input_01 , email_input_01),
			(nombre_input_02 , dir_input_02 , nro_tel_input_02 , email_input_02),
			(nombre_input_03 , dir_input_03 , nro_tel_input_03 , email_input_03),
			(nombre_input_04 , dir_input_04 , nro_tel_input_04 , email_input_04);
		
			
		
			raise notice ' ';
			raise notice 'ok!';
			raise notice ' ';
	
	
		else
			
			raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DE LOS REGISTROS PARA LA FUNCI�N insertar_registros_oficinas()'
							using hint = ' | DETALLE | --> insertar_registros_oficinas(
										nombre_01 varchar, direccion_01 varchar, nro_telefono_01 varchar, email_01 varchar
										,nombre_02 varchar, direccion_02 varchar, nro_telefono_02 varchar, email_02 varchar
										,nombre_03 varchar, direccion_03 varchar, nro_telefono_03 varchar, email_03 varchar
										,nombre_04 varchar , direccion_04 varchar, nro_telefono_04 varchar, email_04 varchar); ';
			
		end if;
	

end;
	
$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA OFICINAS_DETALLES===========


select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';







-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA OFICINAS_DETALLES -------

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









-- ENUMERADOS DECLARADOS
--  estado_oficina_enum ('ALQUILADA','PROPIA'); 
--   tipo_oficina_enum ('PEQUE�A','ESTANDAR','EJECUTIVA'); 


select * from oficinas_detalles;

-- ----------- INSERCION DE 1 REGISTRO ------------ 


create or replace function insertar_registro_oficinas_detalles(

id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum, estado_of_input estado_oficina_enum
, sup_total_input decimal , cant_amb_input smallint , cant_sanit_input smallint, antiguedad_input smallint
, sitio_web_input varchar

) returns void as $$

declare 


 id_of_comprobar boolean:= exists(select id from oficinas where id=id_of_input);

begin
	
	if( id_of_comprobar = false ) then
	
		raise exception 'LA OFICINA CON EL ID INGRESADO NO EXISTE'
						using hint = ' | DETALLE | --> insertar_registro_oficinas_detalles(
							id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum, estado_of_input estado_oficina_enum
							, sup_total_input decimal, cant_amb_input int, cant_sanit_input int, antiguedad_input int, sitio_web_input varchar
							);';
						
		
	
	elsif ( 
		id_of_input <> null 
		and loc_input <> ''
		and (tipo_of_input = 'PEQUE�A' or tipo_of_input = 'ESTANDAR' or tipo_of_input = 'EJECUTIVA')
		and (estado_of_input = 'ALQUILADA' or estado_of_input ='PROPIA') 
		and sup_total_input <> null 
		and cant_amb_input <> null 
		and cant_sanit_input <> null 
		and sitio_web_input <> ''
		) then
	
		
		raise notice '';
		raise notice '-----------------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "oficinas_detalles" --';
		raise notice '-----------------------------------------------------';
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserci�n --';
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
	
	
		
		insert into oficinas_detalles (id_oficina, localidad, tipo_oficina, estado_oficina
		, superficie_total, cantidad_ambientes, cantidad_sanitarios, antiguedad, sitio_web) values
		
		-- Casteamos algunas variables, para que postgresql las interprete correctamente
		(id_of_input::int, loc_input , tipo_of_input::tipo_oficina_enum, estado_of_input::estado_oficina_enum
		, sup_total_input::varchar, cant_amb_input::smallint, cant_sanit_input::smallint, antiguedad_input::smallint
		, sitio_web_input::varchar );
	
	
		
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	else
	
		--raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N insertar_registro_oficinas_detalles()'
			--			using hint = ' | DETALLE | --> insertar_registro_oficinas_detalles(
				--			id_of_input int, loc_input varchar, tipo_of_input tipo_oficina_enum, estado_of_input estado_oficina_enum
					--		, sup_total_input decimal, cant_amb_input int, cant_sanit_input int, antiguedad_input int, sitio_web_input varchar
						--	);';
						
	end if;
	

end;
	
$$ language plpgsql;







-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA EMPLEADOS ===========


select * from empleados;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'empleados';







-- ----------- SELECT DE TODOS LOS REGISTROS DE LA TABLA EMPLEADOS -------

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



-- ----------- INSERCION DE 1 REGISTRO ------------


create or replace function insertar_registro_empleados(

id_of_input varchar, nombre_input varchar, apell_input varchar, edad_input int, fecha_nac_input date
, tipo_doc_input varchar, nro_doc_input varchar, cuil_input varchar, direc_input varchar,
, nro_tel_princ_input varchar, nro_tel_sec_input varchar, email_input varchar, cargo_input varchar
, antig_input int, fecha_ingreso_input date, sal_anual_input decimal

) returns void as $$

declare

--Nos aseguramos que el id exista
id_empl_check boolean := exists(select id from oficinas where id = id_of_input);


-- Nos aseguramos que no exista un registro repetido ademas del check de la db
 nombre_empl_check boolean := exists(select nombre from empleados where nombre = nombre_input);
 apellido_empl_check boolean := exists(select apellido from empleados where apellido = apellido_input);
 nro_doc_empl_check boolean := exists(select nro_documento from empleados where nro_documento = nro_doc_input);
 cuil_empl_check boolean := exists(select cuil from empleados where cuil = cuil_input);

begin
	
	if (id_empl_check = false)then
		
		raise exception 'NO SE PUEDE INGRESAR UN EMPLEADO SIN UNA OFICINA EXISTENTE '
						using hint = ' | DETALLE | --> REVISAR EL ID DE LA OFICINA ASIGNADA';
						
	
	
	elsif( 
		((nombre_empl_check = true) and (apelido_empl_check = true))
		or ((nro_doc_empl_check = true) and (cuil_empl_check = true))
	
	) then
	
		raise exception 'NO SE PUEDE INGRESAR UN REGISTRO REPETIDO '
						using hint = ' | DETALLE | --> REVISAR LOS VALORES DE LOS REGISTROS A INGRESAR';
						
		
	
	elsif (
		(id_empl_check = true)
		or ((nombre_empl_check = false) and (apelido_empl_check = false))
		or ((nro_doc_empl_check = false) and (cuil_empl_check = false))
		or ((nombre_input <> '') and (apelido_input <> ''))
		or ((fecha_nac_input <> '') and (direc_input <> ''))
		or ((tipo_doc_input <> '') and (nro_doc_input <> ''))
		or ((nro_tel_princ_input <> '') and (nro_tel_sec_input <> ''))
		or ((email_input <> '') and (cargo_input <> ''))
		or ((edad_input < 80) and (edad_input > 0))
		or ((antiguedad_input < 60) and (antigueda_input > 0))
		or (salario_anual_input > 0)
		
		) then
	
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserci�n de Registro Tabla "empleados" --';
		raise notice '----------------------------------------------';
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserci�n --';
		raise notice '';
	
		
		raise notice 'Nombre : %', nombre_input;
		raise notice 'Apellido : %', apellido_input;
		raise notice 'Direcci�n : %', dir_input;
		raise notice 'Nro Telefono : %', nro_tel_input;
		raise notice 'Email : %', email_input;
	
	
	
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input , dir_input , nro_tel_input , email_input);
	
	
		
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	
	else
	
	raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCI�N insertar_registro_oficinas()'
						using hint = ' | DETALLE | --> insertar_registros_oficinas(nombre varchar, direccion varchar, nro_telefono varchar, email varchar); ';
		
	end if;
	

end;
	
$$ language plpgsql;


-- ---------------------------------------------------------------------------


*/