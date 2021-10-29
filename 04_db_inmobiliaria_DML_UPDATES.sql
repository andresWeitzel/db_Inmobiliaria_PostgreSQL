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




-- --------- CAMPO NRO_TELEFONO --------------


-- Cambiamos el Numero con sentencia
update oficinas set nro_telefono='+5491152794990' where id = 1;

-- Cambio de Nros con funcion
select cambio_nro_tel_oficinas('+541152794990', 1);
select * from oficinas;

select cambio_nro_tel_oficinas('+541156541849', 3);
select * from oficinas;

-- Agregar Digitos con funcion
--select agregar_dig_nro_tel_oficinas('+54', 3);

-- Depurar Numeros Telefonicos Automatico con Funcion
select dep_gral_nro_tel_oficinas();
select * from oficinas;



-- --------- CAMPO DIRECCION --------------

-- Depurar Direcciones Automatico con funcion
select dep_gral_dir_oficinas();
select * from oficinas;





-- ======= TABLA OFICINAS_DETALLES ===========

select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';




-- --------- CAMPO LOCALIDAD --------------
select cambio_loc_oficinas_Detalles('Tribunales', 1);
select * from oficinas_detalles;
