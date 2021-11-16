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





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';




-- -----------TODOS LOS CAMPOS------------


create or replace function cambiar_campos_oficinas(id_input int, nombre_input varchar, dir_input varchar
, nro_tel_input varchar, email_input varchar) returns void as $$

declare 

 id_anterior varchar:= (select id from oficinas where id=id_input);
 nombre_anterior varchar:= (select nombre from oficinas where id=id_input);
 dir_anterior varchar := (select direccion from oficinas where id=id_input);
 nro_tel_anterior varchar := (select nro_telefono from oficinas where id=id_input);
 email_anterior varchar := (select email from oficinas where id=id_input);



begin
	
	raise notice '-----------------------------------------------------';
	raise notice '-- Modificación de Todos los Campos Tabla Oficinas --';
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

	raise notice '';
	

	
	

end;
	
$$ language plpgsql;


-- ---------------------------------------------------------------------------


-- ----------- CAMPO NRO_TELEFONO --------------

select * from oficinas;


-- Cambiamos el Numero a traves del id
create or replace function cambiar_nro_tel_oficinas(nro_tel_input varchar, id_input int ) returns void as $$

declare 

id_anterior varchar := (select id from oficinas where id=id_input);
nro_tel_anterior varchar := (select nro_telefono from oficinas where id=id_input);

begin 
	
	
	
	raise notice '--------------------------------------------------------';
	raise notice '-- Modificación del Campo nro_telefono Tabla Oficinas --';
	raise notice '--------------------------------------------------------';

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

	raise notice '';
	

end;

$$ language plpgsql;

-- ---------------------------------------------------------------------------

-- ----------- CAMPO NRO_TELEFONO --------------


select * from oficinas;

-- Agregar Digitos
create or replace function agregar_dig_nro_tel_oficinas(caract_input varchar, id_input int ) returns void as $$

declare 

id_anterior varchar := (select id from oficinas where id=id_input);
nro_tel_anterior varchar := (select nro_telefono from oficinas where id=id_input);
nro_tel_actual varchar;

begin 
	
	raise notice '--------------------------------------------------------';
	raise notice '-- Modificación del Campo nro_telefono Tabla Oficinas --';
	raise notice '--------------------------------------------------------';

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

	
	raise notice '';
	

end;

$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- Depuracion General
create or replace function depurar_nro_tel_oficinas() returns void as $$

declare 



begin 
	
	raise notice '--------------------------------------------------------------';
	raise notice '-- Depuración General del Campo nro_telefono Tabla Oficinas --';
	raise notice '--------------------------------------------------------------';

	
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
	
	raise notice 'ok!';
	raise notice ' ';

end;

$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- ----------- CAMPO DIRECCION --------------

create or replace function depurar_dir_oficinas() returns void as $$

begin
	
	raise notice '-----------------------------------------------------------';
	raise notice '-- Depuración General del Campo direccion Tabla Oficinas --';
	raise notice '-----------------------------------------------------------';

		
	
	-- Quitamos Caracteres Especiales
	update oficinas set direccion = replace(direccion, ',', ' ');

	update oficinas set direccion = replace(direccion, 'N°', ' ');

	update oficinas set direccion = replace(direccion, '/', '-');


	raise notice 'ok!';
	raise notice ' ';

	
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
create or replace function cambiar_loc_oficinas_detalles(loc_input varchar, id_input int ) returns void as $$

begin 
	
	update oficinas_detalles set localidad 	= loc_input where id = id_input ;
	
end

$$ language plpgsql;


-- --------- CAMPO TIPO_OFICINA --------------

-- Cmabiamos el tipo de oficina enum

create or replace function cambiar_tipo_of_oficinas_detalles(tipo_input tipo_oficina, id_input int) returns void as $$

begin
	

	update oficinas_detalles set tipo_oficina = tipo_input where id = id_input; 
	
end

$$ language plpgsql;



-- --------- CAMPO SUPERFICIE_TOTAL --------------


create or replace function cambiar_superficie_total_oficinas_detalles(sup_total_input decimal, id_input int) returns void as $$

begin
	

	update oficinas_detalles set superficie_total = sup_total_input where id = id_input; 
	
end

$$ language plpgsql;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

select * from empleados;

-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

-- Depuracionn general de ambos campos
create or replace function depurar_nombres_apellidos_empleados() returns void as $$

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
create or replace function cambiar_cuil_empleados(cuil_input varchar, id_input int) returns void as $$

begin
	
	--Relleno de Caracteres por la derecha a longitud especificada
	update empleados set cuil = cuil_input where id = id_input;
	
end
$$ language plpgsql;




-- --------- CAMPO DIRECCION ---------------

select * from empleados;

-- Depuracion general de direccion
create or replace function depurar_direccion_empleados() returns void as $$

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
create or replace function depurar_nro_telefonos_empleados() returns void as $$

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
	

	
	update empleados set salario_anual = (salario_anual + (salario_anual * primer_aumento))  where antiguedad = 1; 

	
	update empleados set salario_anual = (salario_anual + (salario_anual * segundo_aumento))  where antiguedad = 2; 

	
	update empleados set salario_anual = (salario_anual + (salario_anual * tercer_aumento))  where antiguedad = 3; 
	
	
	update empleados set salario_anual = (salario_anual + (salario_anual * cuarto_aumento))  where antiguedad = 4; 
	

	
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
		

	-- Todas las palabras con su inicial en Mayuscula
	update clientes set nombre = initcap(nombre);
	update clientes set apellido = initcap(apellido);
	
	-- Quitamos los espacios
	update clientes set nombre = replace(nombre, ' ', '');
	update clientes set apellido = replace(apellido, ' ', '');

end

$$ language plpgsql;




-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select * from clientes;

-- Depuracion general de ambos campos
create or replace function depurar_nro_telefonos_clientes() returns void as $$

begin 
		
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
	

end;

$$ language plpgsql;




-- --------- CAMPO DIRECCION ---------------


select * from clientes;

-- Depuracion general de direccion
create or replace function depurar_direccion_clientes() returns void as $$

begin
		

	-- Todas las palabras con su inicial en Mayuscula
	update clientes set direccion = initcap(direccion);

	-- Quitamos los puntos
	update clientes set direccion = replace(direccion, '.', ' ');


	
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
		

	-- Todas las palabras con su inicial en Mayuscula
	update propietarios_inmuebles set nombre = initcap(nombre);
	update propietarios_inmuebles set apellido = initcap(apellido);
	
	-- Quitamos los espacios
	update propietarios_inmuebles set nombre = replace(nombre, ' ', '');
	update propietarios_inmuebles set apellido = replace(apellido, ' ', '');

end

$$ language plpgsql;




-- --------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------

select * from propietarios_inmuebles;


-- Depuracion general de ambos campos
create or replace function depurar_nro_telefonos_propietarios_inmuebles() returns void as $$

declare 
	
	num_tel_princ varchar;
	num_tel_sec varchar;

begin 
		
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
	

	
	
end;

$$ language plpgsql;



-- --------- CAMPO DIRECCION ---------------


select * from propietarios_inmuebles;

-- Depuracion general de direccion
create or replace function depurar_direccion_propietarios_inmuebles() returns void as $$

begin
		

	-- Todas las palabras con su inicial en Mayuscula
	update propietarios_inmuebles set direccion = initcap(direccion);

	-- Quitamos los puntos
	update propietarios_inmuebles set direccion = replace(direccion, '.', ' ');


	
end

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES DESCRIPCIONES ===========



-- --------- CAMPO SUPERFICIE_TOTAL Y CAMPO SUPERFICIE_CUBIERTA---------------

select * from inmuebles_descripciones;

-- Depuracion general de cambos campos
create or replace function cambiar_superficie_total_cubierta_inmuebles_descripciones
(sup_total_input decimal, sup_cubierta_input decimal, id_input int ) returns void as $$

begin

	update inmuebles_descripciones set superficie_total = sup_total_input, superficie_cubierta = sup_cubierta_input
	where id = id_input;

	
end

$$ language plpgsql;

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES MEDIDAS ===========



-- --------- CAMPO DORMITORIO ---------------

select * from inmuebles_medidas;

-- Depuracion general de cambo dormitorio
create or replace function depurar_dormitorio_inmuebles_medidas() returns void as $$

begin

	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio1', 'D1');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio2', 'D2');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio3', 'D3');
	update inmuebles_medidas set dormitorio = replace(dormitorio, 'Dormitorio4', 'D4');
	update inmuebles_medidas set dormitorio = replace(dormitorio, '|', ' ');

	
end

$$ language plpgsql;




-- --------- CAMPO SANITARIO ---------------

select * from inmuebles_medidas;

-- Depuracion general de cambo dormitorio
create or replace function depurar_sanitario_inmuebles_medidas() returns void as $$

begin

	update inmuebles_medidas set sanitario = replace(sanitario, 'Baño1', 'S1');
	update inmuebles_medidas set sanitario = replace(sanitario, 'Baño2', 'S2');
	update inmuebles_medidas set sanitario = replace(sanitario, 'Baño3', 'S3');
	update inmuebles_medidas set sanitario = replace(sanitario, '|', ' ');

	
end

$$ language plpgsql;




-- --------- CAMPOS PATIO_JARDIN, COCHERA, BALCON ---------------

select * from inmuebles_medidas;

-- Depuracion general de los campos
create or replace function depurar_patio_jardin_cochera_balcon_inmuebles_medidas() returns void as $$

begin

	update inmuebles_medidas set patio_jardin = replace(patio_jardin, '-', '0.0 x 0.0');
	update inmuebles_medidas set cochera = replace(cochera, '-', '0.0 x 0.0');
	update inmuebles_medidas set balcon = replace(balcon, '-', '0.0 x 0.0');

	
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
		

	
	update inmuebles set descripcion = initcap(descripcion);
	update inmuebles set tipo = initcap(tipo);
	
	
	update inmuebles set descripcion = replace(descripcion, 'Baño', 'Sanitario');
	update inmuebles set descripcion = replace(descripcion, 'Baños', 'Sanitarios');
	update inmuebles set descripcion = replace(descripcion, ',', ' ');
	update inmuebles set tipo = replace(tipo, 'Ph/Casa', 'Ph');

end

$$ language plpgsql;




-- --------- CAMPOS DIRECCION, UBICACION ---------------


select * from inmuebles;

-- Depuracion general de direccion
create or replace function depurar_direccion_ubicacion_inmuebles() returns void as $$

begin
		

	-- Todas las palabras con su inicial en Mayuscula
	update inmuebles set direccion = initcap(direccion);
	update inmuebles set ubicacion = initcap(ubicacion);

	-- Quitamos los puntos
	update inmuebles set direccion = replace(direccion, '.', ' ');


	
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
		

	-- Todas las palabras con su inicial en Mayuscula
	update citas_inmuebles set descripcion_cita = initcap(descripcion_cita);
	


	
end

$$ language plpgsql;






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA SERVICIOS_INMUEBLES ===========


-- --------- CAMPOS DESCRIPCION_CITA ---------------


select * from servicios_inmuebles;

-- Depuracion general de descripcion_cita
create or replace function depurar_descripcion_servicios_inmuebles() returns void as $$

begin
		

	-- Todas las palabras con su inicial en Mayuscula
	update servicios_inmuebles set descripcion_servicios = initcap(descripcion_servicios);
	
	update servicios_inmuebles set descripcion_servicios = replace(descripcion_servicios,'-','');
	


	
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
		

	-- Todas las palabras con su inicial en Mayuscula
	update inspecciones_inmuebles set descripcion_inspeccion = initcap(descripcion_inspeccion);
	update inspecciones_inmuebles set descripcion_inspeccion = replace(descripcion_inspeccion,'Caba','Cabo');
	

end

$$ language plpgsql;



-- --------- CAMPOS EMPRESA, DIRECCION ---------------


select * from inspecciones_inmuebles;

-- Depuracion general de los campos
create or replace function depurar_empresa_direccion_inspecciones_inmuebles() returns void as $$

begin
		

	-- Todas las palabras con su inicial en Mayuscula
	update inspecciones_inmuebles set empresa = initcap(empresa);
	update inspecciones_inmuebles set direccion = initcap(direccion);
	
	-- Reemplazamos caracteres
	update inspecciones_inmuebles set direccion = replace(direccion,'Caba','Cabo');
	

end

$$ language plpgsql;



-- --------- CAMPO NUMERO_TELEFONO ---------------


select * from inspecciones_inmuebles;

-- Depuracion general de los campos
create or replace function depurar_nro_tel_inspecciones_inmuebles() returns void as $$

begin
		

	-- Reemplazamos caracteres
	update inspecciones_inmuebles set nro_telefono = replace(nro_telefono,'-','');
	

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
		

	update inspecciones_inmuebles set costo = (costo + (costo * aumento_depto))  where tipo_inspeccion = 'DEPARTAMENTO'; 
	
	
	update inspecciones_inmuebles set costo = (costo + (costo * aumento_casa_ph))  where tipo_inspeccion = 'CASA';


	update inspecciones_inmuebles set costo = (costo + (costo * aumento_casa_ph))  where tipo_inspeccion = 'PH';


end

$$ language plpgsql;

