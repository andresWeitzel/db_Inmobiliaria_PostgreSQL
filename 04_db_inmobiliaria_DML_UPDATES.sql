/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML UPDATES =============
 */


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS ===========


select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';



-- ---------- TODOS LOS CAMPOS ---------------
-- Actualizamos todos los campos
select cambio_campos_oficinas(1, 'Torre San Vicente', 'Paraguay 770', '+54911735345','inmobiliariaDuckson@gmail.com');
select * from oficinas;


-- --------- CAMPO NRO_TELEFONO --------------

-- Actualizamos el Numero con sentencia
update oficinas set nro_telefono='+5491152794990' where id = 1;

-- Actualizamos los Nros con funcion
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



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------




-- ======= TABLA OFICINAS_DETALLES ===========

select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';



-- --------- CAMPO LOCALIDAD --------------
-- Cambio de Localidad por funcion
select cambio_loc_oficinas_detalles('Tribunales', 1);
select * from oficinas_detalles;


-- -------- CAMPO TIPO_OFICINA -------------
-- Cambio de Tipo de Oficina
select cambio_tipo_of_oficinas_detalles('ESTANDAR',2);
select * from oficinas_detalles;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

select * from empleados;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'empleados';

