/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML UPDATES FUNCTIONS=============
 */





-- --------TABLA OFICINAS -----------

-- ------- Todos los Campos ---------
drop function if exists cambio_campos_oficinas;

-- ------- Campo telefono ---------
drop function if exists dep_gral_nro_tel_oficinas;
drop function if exists cambio_nro_tel_oficinas;
drop function if exists agregar_dig_nro_tel_oficinas;

-- ------- Campo direccion --------
drop function if exists dep_gral_dir_oficinas;



-- --------- TABLA OFICINAS_DETALLES -----------

-- -------- Campo Localidad ---------- 
drop function if exists cambio_loc_oficinas_detalles;
drop function if exists cambio_tipo_of_oficinas_detalles;


-- --------- TABLA EMPLEADOS -----------

-- -------- Campo Cuil ---------- 
drop function if exists dep_gral_cuil_empleados;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';


-- -----------TODOS LOS CAMPOS------------

create function cambio_campos_oficinas(id_input int, nombre_input varchar, dir_input varchar
, nro_tel_input varchar, email_input varchar) returns void as $$

begin
	
	update oficinas set nombre = nombre_input, direccion = dir_input
	, nro_telefono = nro_tel_input, email = email_input where id = id_input;
end
$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- -----------CAMPO TELEFONO--------------

-- Cambiamos el Numero a traves del id
create function cambio_nro_tel_oficinas(nro_tel_input varchar, id_input int ) returns void as $$

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
create function dep_gral_nro_tel_oficinas() returns void as $$

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

create function dep_gral_dir_oficinas() returns void as $$

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
create function cambio_loc_oficinas_detalles(loc_input varchar, id_input int ) returns void as $$

begin 
	
	update oficinas_detalles set localidad 	= loc_input where id = id_input ;
	
end

$$ language plpgsql;


-- --------- CAMPO TIPO_OFICINA --------------

-- Cmabiamos el tipo de oficina enum

create function cambio_tipo_of_oficinas_detalles(tipo_input tipo_oficina, id_input int) returns void as $$

begin
	

	update oficinas_detalles set tipo_oficina = tipo_input where id = id_input; 
	
end

$$ language plpgsql;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

-- --------- CAMPO CUIL ---------------

/*
create function dep_gral_cuil_empleados() returns void as $$

begin
	
	update empleados set cuil = replace(cuil,'-','');
	
end
$$ language plpgsql;
*/