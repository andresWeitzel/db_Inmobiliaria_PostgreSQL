/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML UPDATES =============
 */





-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';

-- Cambiamos el Numero
update oficinas set telefono='+5491152794990' where id = 1;

-- Agregamos el +54 al id Especifico
update oficinas set telefono=concat('+54',telefono) where id = 3;



select depuracionTelefonosOficinas();
select * from oficinas;


