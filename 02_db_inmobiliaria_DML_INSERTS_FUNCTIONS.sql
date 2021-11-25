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




-- ----------- INSERCION DE 1 REGISTRO ------------


create or replace function insertar_registro_oficinas(nombre_input varchar, dir_input varchar
, nro_tel_input varchar, email_input varchar) returns void as $$

declare 

begin
	
	if (nombre_input <> '' and dir_input <> '' and nro_tel_input <> '' and email_input <> '') then
	
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de Registro Tabla "oficinas" --';
		raise notice '----------------------------------------------';
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción --';
		raise notice '';
	
		
		raise notice 'Nombre : %', nombre_input;
		raise notice 'Dirección : %', dir_input;
		raise notice 'Nro Telefono : %', nro_tel_input;
		raise notice 'Email : %', email_input;
	
	
	
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input , dir_input , nro_tel_input , email_input);
	
	
		
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';	
	
	else
	
	raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DEL REGISTRO PARA LA FUNCIÓN insertar_registro_oficinas()'
						using hint = ' | DETALLE | --> insertar_registros_oficinas(nombre varchar, direccion varchar, nro_telefono varchar, email varchar); ';
		
		end if;
	

end;
	
$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- ----------- INSERCION DE 2 REGISTROS ------------


create or replace function insertar_registros_oficinas(nombre_input_01 varchar, dir_input_01 varchar, nro_tel_input_01 varchar, email_input_01 varchar
, nombre_input_02 varchar, dir_input_02 varchar, nro_tel_input_02 varchar, email_input_02 varchar) returns void as $$

declare 


begin
	

	if (nombre_input_01 <> '' and dir_input_01 <> '' and nro_tel_input_01 <> '' and email_input_01 <> '') then
	
		if(nombre_input_02 <> '' and dir_input_02 <> '' and nro_tel_input_02 <> '' and email_input_02 <> '') then 
			
		
		raise notice '';
		raise notice '----------------------------------------------';
		raise notice '-- Inserción de 2 Registros Tabla "oficinas" --';
		raise notice '----------------------------------------------';
	
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción Número 1--';
		raise notice '';
	
		
		raise notice 'Nombre : %', nombre_input_01;
		raise notice 'Dirección : %', dir_input_01;
		raise notice 'Nro Telefono : %', nro_tel_input_01;
		raise notice 'Email : %', email_input_01;
	
	
		raise notice '';
		raise notice '';
		raise notice '-- Registro de Inserción Número 2-';
		raise notice '';
	
		
		raise notice 'Nombre : %', nombre_input_02;
		raise notice 'Dirección : %', dir_input_02;
		raise notice 'Nro Telefono : %', nro_tel_input_02;
		raise notice 'Email : %', email_input_02;
	
	
	
		
		insert into oficinas (nombre, direccion, nro_telefono, email) values 
		(nombre_input_01 , dir_input_01 , nro_tel_input_01 , email_input_01),
		(nombre_input_02 , dir_input_02 , nro_tel_input_02 , email_input_02);
	
		
	
		raise notice ' ';
		raise notice 'ok!';
		raise notice ' ';
	
	
		else
			
		raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DEL SEGUNDO REGISTRO PARA LA FUNCIÓN insertar_registros_oficinas()'
						using hint = ' | DETALLE | --> insertar_registros_oficinas(
									nombre01 varchar, direccion01 varchar, nro_telefono_01 varchar, email_01 varchar
									,nombre02 varchar, direccion02 varchar, nro_telefono_02 varchar, email_02 varchar); ';
		
		end if;

	
	else
	
		raise exception ' SE DEBEN AGREGAR TODOS LOS VALORES DEL PRIMER REGISTRO PARA LA FUNCIÓN insertar_registros_oficinas()'
									using hint = ' | DETALLE | --> insertar_registros_oficinas(
									nombre01 varchar, direccion01 varchar, nro_telefono_01 varchar, email_01 varchar
									,nombre02 varchar, direccion02 varchar, nro_telefono_02 varchar, email_02 varchar); ';
		
									
end if;


end;
	
$$ language plpgsql;


-- ---------------------------------------------------------------------------



