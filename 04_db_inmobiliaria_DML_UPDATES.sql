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
select cambiar_campos_oficinas(1, 'Torre San Vicente', 'Paraguay 770', '+54911735345','inmobiliariaDuckson@gmail.com');
select * from oficinas;


-- --------- CAMPO NRO_TELEFONO --------------

-- Actualizamos el Numero con sentencia
update oficinas set nro_telefono='+5491152794990' where id = 1;

-- Actualizamos los Nros con funcion
select cambiar_nro_tel_oficinas('+541152794990', 1);
select * from oficinas;

select cambiar_nro_tel_oficinas('+541156541849', 3);
select * from oficinas;

-- Agregar Digitos con funcion
--select agregar_dig_nro_tel_oficinas('+54', 3);

-- Depurar Numeros Telefonicos Automatico con Funcion
select depurar_nro_tel_oficinas();
select * from oficinas;



-- --------- CAMPO DIRECCION --------------

-- Depurar Direcciones Automatico con funcion
select depurar_dir_oficinas();
select * from oficinas;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------




-- ======= TABLA OFICINAS_DETALLES ===========

select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';



-- --------- CAMPO LOCALIDAD --------------
-- Cambio de Localidad por funcion
select cambiar_loc_oficinas_detalles('Tribunales', 1);
select * from oficinas_detalles;


-- -------- CAMPO TIPO_OFICINA -------------
-- Cambio de Tipo de Oficina
select cambiar_tipo_of_oficinas_detalles('ESTANDAR',2);
select * from oficinas_detalles;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

select * from empleados;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'empleados';



-- -------- CAMPO NOMBRE, CAMPO APELLIDO -------------
-- Depuración general de ambos campos
select depurar_nombres_apellidos_empleados();
select * from empleados;



-- -------- CAMPO CUIL -------------
-- Depuración general de cuil de empleados
select cambiar_cuil_empleados('33-489671-5',1);
select cambiar_cuil_empleados('12-409876546-0',3);
select * from empleados;

