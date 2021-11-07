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



-- ---------- Todos los campos ---------------
-- Actualizamos todos los campos
select cambiar_campos_oficinas(1, 'Torre San Vicente', 'Paraguay 770', '+54911735345','inmobiliariaDuckson@gmail.com');
select * from oficinas;


-- --------- Campo nro_telefono --------------

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



-- --------- Campo direccion --------------

-- Depurar Direcciones Automatico con funcion
select depurar_dir_oficinas();
select * from oficinas;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------




-- ======= TABLA OFICINAS_DETALLES ===========

select * from oficinas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas_detalles';



-- --------- Campo localidad--------------
-- Cambio de Localidad por funcion
select cambiar_loc_oficinas_detalles('Tribunales', 1);
select * from oficinas_detalles;


-- -------- Campo tipo_oficina -------------
-- Cambio de Tipo de Oficina
select cambiar_tipo_of_oficinas_detalles('ESTANDAR',2);
select * from oficinas_detalles;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

select * from empleados;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'empleados';



-- -------- Campo nombre, Campo apellido -------------
-- Depuración general de ambos campos
select depurar_nombres_apellidos_empleados();
select * from empleados;



-- -------- Campo cuil -------------
-- actualización cuil de empleados
select cambiar_cuil_empleados('63-489671-5',1);
select cambiar_cuil_empleados('72-409876546-0',3);
select cambiar_cuil_empleados('74-17896537-2',6);
select cambiar_cuil_empleados('48-33456733-9',7);
select * from empleados;


-- --------- Campo direccion ------------
--  Depuración Gral direccion de Empleados
select depurar_direccion_empleados();
select * from empleados;


-- ---------- Campo nro_telefono_principal y Campo nro_telefono_secundario ---------------- 
-- Depuración gral de ambos campos
select depurar_nro_telefonos_empleados();
select * from empleados; 


-- ----------- Campo salario -------------
select depurar_salario_anual_empleados();
select * from empleados;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ======= TABLA CLIENTES ===========


select * from clientes;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'clientes';


-- ----------- Campo nombre y Campo apellido -------------
select depurar_nombres_apellidos_clientes();
select * from clientes;

-- -------- Campo nro_tel_principal y Campo nro_tel_secundario ------------
select depurar_nro_telefonos_clientes();
select * from clientes;

-- -------- Campo direccion ------------
select depurar_direccion_clientes();
select * from clientes;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ======= TABLA PROPIETARIOS_INMUEBLES ===========


select * from propietarios_inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'propietarios_inmuebles';


-- ----------- Campo nombre y Campo apellido -------------
select depurar_nombres_apellidos_propietarios_inmuebles();
select * from propietarios_inmuebles;


-- -------- Campo nro_tel_principal y Campo nro_tel_secundario ------------
select depurar_nro_telefonos_propietarios_inmuebles();
select * from propietarios_inmuebles;


-- -------- Campo direccion ------------
select depurar_direccion_propietarios_inmuebles();
select * from propietarios_inmuebles;