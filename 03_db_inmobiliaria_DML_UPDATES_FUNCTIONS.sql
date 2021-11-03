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



-- --------TABLA OFICINAS -----------

-- ------- Todos los Campos ---------
drop function if exists cambiar_campos_oficinas;

-- ------- Campo telefono ---------
drop function if exists depurar_nro_tel_oficinas;
drop function if exists cambiar_nro_tel_oficinas;
drop function if exists agregar_dig_nro_tel_oficinas;

-- ------- Campo direccion --------
drop function if exists depurar_dir_oficinas;



-- --------- TABLA OFICINAS_DETALLES -----------

-- -------- Campo localidad ---------- 
drop function if exists cambiar_loc_oficinas_detalles;
drop function if exists cambiar_tipo_of_oficinas_detalles;


-- --------- TABLA EMPLEADOS -----------

-- ---------Campo nombre y Campo apellido ----
drop function if exists depurar_nombres_apellidos_empleados;

-- -------- Campo cuil ---------- 
drop function if exists cambiar_cuil_empleados;

-- -------- Campo direccion --------
drop function if exists depurar_direccion_empleados;

-- -------- Campo nro_tel_principal y Campo nro_tel_secundario ------------
drop function if exists depurar_nro_telefonos_empleados;

-- --------- Campo salario_anual -----------
drop function if exists depurar_salario_anual_empleados;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';


-- -----------TODOS LOS CAMPOS------------

create function cambiar_campos_oficinas(id_input int, nombre_input varchar, dir_input varchar
, nro_tel_input varchar, email_input varchar) returns void as $$

begin
	
	update oficinas set nombre = nombre_input, direccion = dir_input
	, nro_telefono = nro_tel_input, email = email_input where id = id_input;
end
$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- -----------CAMPO TELEFONO--------------

-- Cambiamos el Numero a traves del id
create function cambiar_nro_tel_oficinas(nro_tel_input varchar, id_input int ) returns void as $$

begin 

	update oficinas set nro_telefono = nro_tel_input where id = id_input;

end;

$$ language plpgsql;

-- ---------------------------------------------------------------------------


-- Agregar Digitos
create function agregar_dig_nro_tel_oficinas(caract_input varchar, id_oficina int ) returns void as $$

begin 
		
	-- Agregamos el +54 al id Especifico
	update oficinas set nro_telefono = concat(caract_input, nro_telefono) where id = id_oficina;
	

end;

$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- Depuracion General
create function depurar_nro_tel_oficinas() returns void as $$

begin 
		
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
	
	


end;

$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- -----------CAMPO DIRECCION--------------

create function depurar_dir_oficinas() returns void as $$

begin
		
	-- Quitamos Caracteres Especiales
	update oficinas set direccion = replace(direccion, ',', ' ');

	update oficinas set direccion = replace(direccion, 'N°', ' ');

	update oficinas set direccion = replace(direccion, '/', '-');
	
end

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA OFICINAS_DETALLES ===========



select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';


-- --------- CAMPO LOCALIDAD --------------

-- Cambiamos la localidad a traves del id
create function cambiar_loc_oficinas_detalles(loc_input varchar, id_input int ) returns void as $$

begin 
	
	update oficinas_detalles set localidad 	= loc_input where id = id_input ;
	
end

$$ language plpgsql;


-- --------- CAMPO TIPO_OFICINA --------------

-- Cmabiamos el tipo de oficina enum

create function cambiar_tipo_of_oficinas_detalles(tipo_input tipo_oficina, id_input int) returns void as $$

begin
	

	update oficinas_detalles set tipo_oficina = tipo_input where id = id_input; 
	
end

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

select * from empleados;

-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

-- Depuracionn general de ambos campos
create function depurar_nombres_apellidos_empleados() returns void as $$

begin
		

	-- Todas las palabras con su inicial en Mayuscula
	update empleados set nombre = initcap(nombre);
	update empleados set apellido = initcap(apellido);
	
	-- Quitamos los espacios
	update empleados set nombre = replace(nombre, ' ', '');
	update empleados set apellido = replace(apellido, ' ', '');

end

$$ language plpgsql;



-- --------- CAMPO CUIL ---------------


select * from empleados;

-- actualizacion de cuil por id
create function cambiar_cuil_empleados(cuil_input varchar, id_input int) returns void as $$

begin
	
	--Relleno de Caracteres por la derecha a longitud especificada
	update empleados set cuil = cuil_input where id = id_input;
	
end
$$ language plpgsql;


-- --------- CAMPO DIRECCION ---------------


select * from empleados;

-- Depuracion general de direccion
create function depurar_direccion_empleados() returns void as $$

begin
		

	-- Todas las palabras con su inicial en Mayuscula
	update empleados set direccion = initcap(direccion);

	-- Quitamos los puntos
	update empleados set direccion = replace(direccion, '.', ' ');


	
end

$$ language plpgsql;



-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select * from empleados;

-- Depuracion general de ambos campos
create function depurar_nro_telefonos_empleados() returns void as $$

begin 
		
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
	

end;

$$ language plpgsql;


-- ---------------- CAMPO SALARIO_ANUAL --------------------

select * from empleados;

-- Actualización del Salario Anual por años de antiguedad
create function depurar_salario_anual_empleados() returns void as $$

/*
-- Declaramos e Inicializamos una variable
declare 

	porcentaje_agregado float = (select * from empleados.salario_anual * 10)/100;
*/	

begin 

	-- Aumentamos 10% a los empleados con 2 o más años de antiguedad
	update empleados set salario_anual = (salario_anual + ((salario_anual*20)/100))  where antiguedad >= 2; 

	
	
end;

$$ language plpgsql;

