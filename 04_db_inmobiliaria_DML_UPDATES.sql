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
select cambiar_campos_oficinas(1, 'Torre San Vicente'
, 'Paraguay 770', '+54911735345','inmobiliariaDuckson@gmail.com');
select * from oficinas;


-- --------- CAMPO NRO_TELEFONO --------------

-- Actualizamos el Numero con sentencia
update oficinas set nro_telefono='+5491152794990' where id = 1;

-- Actualizamos los Nros con funcion
select cambiar_nro_tel_oficinas('+541152794690', 1);
select * from oficinas;

select cambiar_nro_tel_oficinas('+541156541849', 3);
select * from oficinas;

-- Agregar Digitos con funcion
select agregar_dig_nro_tel_oficinas('+54', 3);

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



-- ---------CAMPO LOCALIDAD--------------

-- Cambio de Localidad por funcion
select cambiar_loc_oficinas_detalles('Tribunales', 1);
select * from oficinas_detalles;


-- -------- CAMPO TIPO_OFICINA  -------------

-- Cambio de Tipo de Oficina
select cambiar_tipo_of_oficinas_detalles('ESTANDAR',2);
select * from oficinas_detalles;


-- -------- CAMPO SUPERFICIE_TOTAL  -------------

-- Actualizamos la superficie_total
select cambiar_superficie_total_oficinas_detalles(143.88, 1);
select * from oficinas_detalles;

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

select * from empleados;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'empleados';



-- -------- CAMPO NOMBRE Y CAMPO APELLIDO  -------------

-- Depuración general de ambos campos
select depurar_nombres_apellidos_empleados();
select * from empleados;



-- --------  CAMPO CUIL -------------
-- actualización cuil de empleados
select cambiar_cuil_empleados('63-489671-5',1);
select cambiar_cuil_empleados('72-409876546-0',3);
select cambiar_cuil_empleados('74-17896537-2',6);
select cambiar_cuil_empleados('48-33456733-9',7);
select * from empleados;


-- --------- CAMPO DIRECCION ------------
--  Depuración Gral direccion de Empleados
select depurar_direccion_empleados();
select * from empleados;


-- ---------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------- 
-- Depuración gral de ambos campos
select depurar_nro_telefonos_empleados();
select * from empleados; 


-- ----------- CAMPO SALARIO_ANUAL -------------
select depurar_salario_anual_empleados();
select * from empleados;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ======= TABLA CLIENTES ===========


select * from clientes;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'clientes';


-- ----------- CAMPO NOMBRE Y CAMPO APELLIDO -------------
select depurar_nombres_apellidos_clientes();
select * from clientes;



-- -------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ------------
select depurar_nro_telefonos_clientes();
select * from clientes;



-- -------- CAMPO DIRECCION  ------------
select depurar_direccion_clientes();
select * from clientes;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ======= TABLA PROPIETARIOS_INMUEBLES ===========


select * from propietarios_inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'propietarios_inmuebles';


-- -----------  CAMPO NOMBRE Y CAMPO APELLIDO -------------
select depurar_nombres_apellidos_propietarios_inmuebles();
select * from propietarios_inmuebles;



-- -------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ------------
select depurar_nro_telefonos_propietarios_inmuebles();
select * from propietarios_inmuebles;


-- -------- CAMPO DIRECCION ------------
select depurar_direccion_propietarios_inmuebles();
select * from propietarios_inmuebles;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES DESCRIPCIONES ===========



-- ----------- CAMPO SUPERFICIE_TOTAL Y CAMPO SUPERFICIE_CUBIERTA --------------------------


select cambiar_superficie_total_cubierta_inmuebles_descripciones(278.0 , 195.34 , 1 );
select * from inmuebles_descripciones;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INMUEBLES MEDIDAS ===========



-- ----------- CAMPO DORMITORIO --------------------------

select depurar_dormitorio_inmuebles_medidas();
select * from inmuebles_medidas;


-- ----------- CAMPO SANITARIO --------------------------

select depurar_sanitario_inmuebles_medidas();
select * from inmuebles_medidas;



-- --------- CAMPOS PATIO_JARDIN, COCHERA, BALCON ---------------

-- Depuracion general de los campos
select depurar_patio_jardin_cochera_balcon_inmuebles_medidas();
select * from inmuebles_medidas;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA INMUEBLES ===========


-- --------- CAMPOS DESCRIPCION, TIPO ---------------

select depurar_descripcion_tipo_inmuebles();
select * from inmuebles;




-- --------- CAMPOS DIRECCION, UBICACION ---------------

-- Depuracion general de direccion
select depurar_direccion_ubicacion_inmuebles();
select * from inmuebles;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA CITAS_INMUEBLES ===========


-- --------- CAMPOS DESCRIPCION_CITA ---------------


-- Depuracion general de descripcion_cita
select depurar_descripcion_cita_citas_inmuebles();
select * from citas_inmuebles;
		

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======= TABLA SERVICIOS_INMUEBLES ===========


-- --------- CAMPOS DESCRIPCION_CITA ---------------


-- Depuracion general de descripcion_servicios
select depurar_descripcion_servicios_inmuebles();
select * from servicios_inmuebles;




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ======= TABLA INSPECCIONES_INMUEBLES ===========


-- --------- CAMPO DESCRIPCION_INSPECCION ---------------


-- Depuracion general de descripcion_inspeccion
select depurar_descr_inspeccion_inspecciones_inmuebles();
select * from inspecciones_inmuebles;




-- --------- CAMPOS EMPRESA, DIRECCION ---------------


-- Depuracion general de los campos
select depurar_empresa_direccion_inspecciones_inmuebles();
select * from inspecciones_inmuebles;



-- --------- CAMPO NUMERO_TELEFONO ---------------


-- Depuracion general de los campos
select depurar_nro_tel_inspecciones_inmuebles();
select * from inspecciones_inmuebles;



-- --------- CAMPO COSTO ---------------


-- Depuracion general del campo costo
select  depurar_costo_inspecciones_inmuebles();
select * from inspecciones_inmuebles;




