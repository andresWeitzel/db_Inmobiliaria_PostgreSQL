/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML UPDATES FUNCTIONS=============
 */

-- https://runebook.dev/es/docs/postgresql/sql-createfunction

drop function if exists depuracionTelefonosOficinas;






-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';


-- -----------CAMPO TELEFONO--------------

-- Función sin devolucion
create function depuracionTelefonosOficinas() returns void as $$


begin 
		
-- Remplazamos todos los Patrones de Caracteristica de Buenos Aires (11)
update oficinas set telefono = replace (telefono, '011', '11');

-- Reemplazamos los +54911 a +5411 (9 es caracteristica de Celular)
update oficinas set telefono = replace (telefono, '+54911', '+5411');

-- Quitamos los guiones
update oficinas set telefono = replace(telefono, '-', ' ');

-- Quitamos los espacios en Blanco
update oficinas set telefono = replace(telefono, ' ', '');


end;

$$ language plpgsql;








