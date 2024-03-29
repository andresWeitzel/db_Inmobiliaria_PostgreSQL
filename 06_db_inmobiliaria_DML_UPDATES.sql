/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML UPDATES =============
 */

-- Eliminamos los Registros Actualizados de la Tabla
delete from logs_updates;


-- Alteramos la secuencia autoincrementable del id
alter sequence id_sec_logs_upd restart with 1;


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ===============================
-- ======= TABLA OFICINAS ========
-- ===============================


select listado_oficinas();


select descripcion_oficinas();



-- ---------- TODOS LOS CAMPOS ---------------
-- Actualizamos todos los campos
select actualizar_registro_oficinas(1, 'Torre San Vicente'
, 'Paraguay 770', '+54911735345','inmobiliariaDuckson@gmail.com');


select listado_oficinas();

select listado_logs_updates();




-- --------- CAMPO NRO_TELEFONO --------------

-- Actualizamos el Numero con sentencia
update oficinas set nro_telefono='+5491152794991' where id = 1;

-- Actualizamos los Nros con funcion
select actualizar_nro_tel_oficinas(1,'0111152794690');

select actualizar_nro_tel_oficinas(3,'+541156541844');


select listado_oficinas();

select listado_logs_updates();


-- Depurar Numeros Telefonicos 
select depurar_nro_tel_oficinas();



-- --------- CAMPO DIRECCION --------------

-- Depurar Direcciones Automatico con funcion
select depurar_dir_oficinas();


select listado_oficinas();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ========================================
-- ======= TABLA OFICINAS_DETALLES ========
-- ========================================

-- --------- CAMPO LOCALIDAD --------------

select listado_oficinas_detalles();


select descripcion_oficinas_detalles();


-- Cambio de Localidad por funcion
select actualizar_loc_oficinas_detalles(1,'Tribunales');


select listado_oficinas_detalles();


select listado_logs_updates();





-- --------- CAMPO TIPO_OFICINA --------------


select listado_oficinas_detalles();


select descripcion_oficinas_detalles();



select actualizar_tipo_of_oficinas_detalles(3, 'PEQUEÑA');



select listado_logs_updates();



-- --------- CAMPO SUPERFICIE_TOTAL --------------


select listado_oficinas_detalles();


select descripcion_oficinas_detalles();


select actualizar_sup_total_oficinas_detalles(1 , 150);


select listado_logs_updates();



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- =============================================
-- ======= TABLA SERVICIOS_OFICINAS ===========
-- =============================================


-- --------- CAMPOS DESCRIPCION_SERVICIOS ---------------


-- Depuracion general de descripcion_servicios
select depurar_descripcion_servicios_oficinas();

select listado_servicios_oficinas();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ===================================
-- ======= TABLA EMPLEADOS ===========
-- ===================================



-- --------- CAMPO NOMBRE Y CAMPO APELLIDO ---------------

select listado_empleados();

select descripcion_empleados();


select depurar_nomb_apell_empleados();


select listado_logs_updates();


-- ---------------------------------------------------------------------------


-- --------  CAMPO CUIL -------------
-- actualización cuil de empleados
select actualizar_cuil_empleados(10,'63-489671-5');

select actualizar_cuil_empleados(3,'373647671564');


select listado_empleados();

select listado_logs_updates();


-- --------- CAMPO DIRECCION ------------

--  Depuración Gral direccion de Empleados
select depurar_direccion_empleados();


select listado_empleados();



-- ---------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ---------------- 
-- Depuración gral de ambos campos
select depurar_nro_telefonos_empleados();


select listado_empleados(); 



-- ----------- CAMPO SALARIO_ANUAL -------------
select depurar_salario_anual_empleados();

select listado_empleados(); 




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ==================================
-- ======= TABLA CLIENTES ===========
-- ==================================

select listado_clientes(); 

select descripcion_clientes();


-- ----------- CAMPO NOMBRE Y CAMPO APELLIDO -------------

select depurar_nombres_apellidos_clientes();

select listado_clientes(); 



-- -------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ------------

select depurar_nro_telefonos_clientes();


select listado_clientes(); 



-- -------- CAMPO DIRECCION  ------------
select depurar_direccion_clientes();

select listado_clientes();


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ================================================
-- ======= TABLA PROPIETARIOS_INMUEBLES ===========
-- ================================================

select listado_propietarios_inmuebles();

select descripcion_propietarios_inmuebles();

-- -----------  CAMPO NOMBRE Y CAMPO APELLIDO -------------

select depurar_nombres_apellidos_propietarios_inmuebles();

select listado_propietarios_inmuebles();



-- -------- CAMPO NRO_TELEFONO_PRINCIPAL Y CAMPO NRO TELEFONO_SECUNDARIO ------------

select depurar_nro_telefonos_propietarios_inmuebles();

select listado_propietarios_inmuebles();



-- -------- CAMPO DIRECCION ------------
select depurar_direccion_propietarios_inmuebles();
select * from propietarios_inmuebles;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================================
-- ======= TABLA INMUEBLES DESCRIPCIONES ==========
-- ================================================



-- ----------- CAMPO SUPERFICIE_TOTAL Y CAMPO SUPERFICIE_CUBIERTA --------------------------


select actualizar_superficie_total_cubierta_inmuebles_descripciones(1 , 278.0 , 195.34);

select listado_inmuebles_descripciones();

select listado_logs_updates();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ================================================
-- ======= TABLA INMUEBLES MEDIDAS ================
-- ================================================



-- ----------- CAMPO DORMITORIO --------------------------

select depurar_dormitorio_inmuebles_medidas();

select listado_inmuebles_medidas();


-- ----------- CAMPO SANITARIO --------------------------

select depurar_sanitario_inmuebles_medidas();
select listado_inmuebles_medidas();


-- --------- CAMPOS PATIO_JARDIN, COCHERA, BALCON ---------------

-- Depuracion general de los campos
select depurar_patio_jardin_cochera_balcon_inmuebles_medidas();
select listado_inmuebles_medidas();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ===================================
-- ======= TABLA INMUEBLES ===========
-- ===================================


-- --------- CAMPOS DESCRIPCION, TIPO ---------------

select depurar_descripcion_tipo_inmuebles();
select listado_inmuebles();




-- --------- CAMPOS DIRECCION, UBICACION ---------------

-- Depuracion general de direccion
select depurar_direccion_ubicacion_inmuebles();
select listado_inmuebles();





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ===================================
-- ======= TABLA CITAS_INMUEBLES =====
-- ===================================


-- --------- CAMPOS DESCRIPCION_CITA ---------------


-- Depuracion general de descripcion_cita
select depurar_descripcion_cita_citas_inmuebles();
select listado_citas_inmuebles();
		



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- =============================================
-- ======= TABLA INSPECCIONES_INMUEBLES ========
-- =============================================


-- --------- CAMPO DESCRIPCION_INSPECCION ---------------


-- Depuracion general de descripcion_inspeccion
select depurar_descripcion_inspeccion_inspecciones_inmuebles();
select listado_inspecciones_inmuebles();




-- --------- CAMPOS EMPRESA, DIRECCION ---------------


-- Depuracion general de los campos
select depurar_empresa_direccion_inspecciones_inmuebles();
select listado_inspecciones_inmuebles();



-- --------- CAMPO NUMERO_TELEFONO ---------------


-- Depuracion general de los campos
select depurar_nro_tel_inspecciones_inmuebles();
select listado_inspecciones_inmuebles();



-- --------- CAMPO COSTO ---------------


-- Depuracion general del campo costo
select  depurar_costo_inspecciones_inmuebles();
select listado_inspecciones_inmuebles();




-- --------- CAMPO FECHA Y CAMPO HORA ---------------

-- Modificacion del campo fecha y campo hora
select  actualizar_fecha_hora_inspecciones_inmuebles(1,'2021-02-13','08:00:00');
select listado_inspecciones_inmuebles();
select listado_logs_updates();






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =============================================
-- ======= TABLA INMUEBLES_MARKETING ===========
-- =============================================


-- --------- CAMPO TIPO_ANUNCIO_PRINCIPAL Y CAMPO TIPO_ANUNCIO_SECUNDARIO ---------------

-- Modificacion del campo tipo_anuncio_principal y campo tipo_anuncio_secundario
select  depurar_tipo_anuncio_principal_secundario_inmuebles_marketing();

select listado_inmuebles_marketing();





-- --------- CAMPO DESCRIPCION_ANUNCIO ---------------

-- Modificacion del campo descripcion_anuncio
select  depurar_descripcion_anuncio_inmuebles_marketing();
select listado_inmuebles_marketing();



-- --------- CAMPO INVERSION_TOTAL ---------------

-- Modificacion del campo inversion_total
select  depurar_inversion_total_inmuebles_marketing();
select listado_inmuebles_marketing();


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =========================================
-- ======= TABLA ADMINISTRADORES ===========
-- =========================================



-- --------- CAMPO TIPO_INMUEBLES ---------------

-- Modificacion del campo tipo_inmuebles
select  depurar_tipo_inmuebles_administradores();

select listado_administradores();



-- --------- CAMPO CERTIFICACIONES ---------------

-- Modificacion del campo certificaciones
select  depurar_certificaciones_administradores();

select listado_administradores();






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ==================================
-- ======= TABLA GERENTES ===========
-- ==================================



-- --------- CAMPO TITULO ---------------

-- Depuracion general del campo titulo
select depurar_titulo_gerentes();
select listado_gerentes();



-- --------- CAMPO BENEFICIOS ---------------

-- Depuracion general
select depurar_beneficios_gerentes();
select listado_gerentes();





-- --------- CAMPO RETRIBUCION_SALARIAL_ANUAL ---------------

-- Depuracion general
select depurar_retribucion_salarial_anual_gerentes();
select listado_gerentes();


	

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ====================================
-- ======= TABLA VENDEDORES ===========
-- ====================================




-- --------- CAMPO CANTIDAD_VENTAS ---------------


-- Modificacion cantidad_ventas
select actualizar_cantidad_ventas_vendedores(1, 1);
select listado_vendedores();
select listado_logs_updates();



-- --------- CAMPO BONIFICACION_VENTAS ---------------

-- Depuracion general
select depurar_bonificacion_ventas_vendedores();
select listado_vendedores();


	




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- =====================================
-- ======= TABLA COMPRADORES ===========
-- =====================================


-- --------- CAMPO DESCUENTO_CLIENTE_USD Y CAMPO BENEFICIOS_COMPRAS---------------

-- Depuracion general
select depurar_descuento_cliente_usd_beneficios_compras_compradores();

select listado_compradores();





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ================================
-- ======= TABLA VENTAS ===========
-- ================================



-- --------- CAMPO FECHA_VENTA Y CAMPO HORA_VENTA ---------------

-- Modificación campo fecha_venta y campo hora_venta
select actualizar_fecha_hora_venta_ventas(1, '2020-12-22', '09:00:00');
select listado_ventas();
select listado_logs_updates();



-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ================================
-- ======= TABLA FACTURAS =========
-- ================================




-- --------- CAMPO PRECIO_TOTAL_VENTA_USD ---------------


-- Depuracion general
select depurar_precio_total_venta_usd_facturas();
select listado_facturas();






-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------

-- ===========================================
-- ======= TABLA FACTURAS_DETALLES ===========
-- ===========================================



-- --------- CAMPO DESCRIPCION_FACTURA Y CAMPO DESCRIPCION_PAGO ---------------

-- Depuracion general
select depurar_descripcion_factura_pago_facturas_detalles();

select listado_facturas_detalles();




-- --------- CAMPO VALOR_INMUEBLE_USD---------------

-- Depuracion general
select depurar_valor_inmueble_usd_facturas_detalles();

select listado_facturas_detalles();




-- --------- CAMPO COSTO_ASOCIADO_USD Y CAMPO IMPUESTOS_ASOCIADOS_USD---------------

-- Depuracion general
select depurar_costo_impuestos_asociados_usd_facturas_detalles();

select listado_facturas_detalles();




