/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML UPDATES FUNCTIONS=============
 */




-- ======= TABLA OFICINAS =========

-- ------- Campo telefono ---------
drop function if exists dep_gral_nro_tel_oficinas;
drop function if exists cambio_nro_tel_oficinas;
drop function if exists agregar_dig_nro_tel_oficinas;

-- ------- Campo direccion --------
drop function if exists dep_gral_dir_oficinas;



-- ======= TABLA OFICINAS_DETALLES ===========

-- -------- Campo Localidad ---------- 
drop function if exists cambio_loc_oficinas_detalles;





-- ---------------------------------------------------------------------------





-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';




-- -----------CAMPO TELEFONO--------------

-- Cambiamos el Numero a traves del id
create function cambio_nro_tel_oficinas(nuevo_nro_tel varchar, id_input int ) returns void as $$

begin 

	update oficinas set nro_telefono = nuevo_nro_tel where id = id_input;

end;

$$ language plpgsql;

-- ---------------------------------------------------------------------------




-- Agregar Digitos
create function agregar_dig_nro_tel_oficinas(caracteres varchar, id_oficina int ) returns void as $$

begin 
		
	-- Agregamos el +54 al id Especifico
	update oficinas set nro_telefono = concat(caracteres, nro_telefono) where id = id_oficina;
	

end;

$$ language plpgsql;


-- ---------------------------------------------------------------------------



-- Depuracion General
create function dep_gral_nro_tel_oficinas() returns void as $$

begin 
		
	-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
	update oficinas set nro_telefono = replace (nro_telefono, '011', '11');
	
	-- Reemplazamos los +54911 a +5411 (9 es caracteristica de Celular)
	update oficinas set nro_telefono = replace (nro_telefono, '+54911', '+5411');
	
	-- Quitamos los guiones
	update oficinas set nro_telefono = replace(nro_telefono, '-', ' ');
	
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



-- ======= TABLA OFICINAS_DETALLES ===========



select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';


-- --------- CAMPO LOCALIDAD --------------

-- Cambiamos la localidad a traves del id
create function cambio_loc_oficinas_detalles(nueva_loc varchar, id_input int ) returns void as $$

begin 
	
	update oficinas_detalles set localidad 	= nueva_loc where id = id_input ;
	
end

$$ language plpgsql;

/*
-- --------- CAMPO TIPO_OFICINA --------------

-- Cmabiamos el tipo de oficina enum

create function cambiotipoOf_OficinasDetalles(tipo) returns void as $$

begin
	
	update oficinas_detalles set tipo_oficina = 
	
end

$$ language plpgsql;


*/