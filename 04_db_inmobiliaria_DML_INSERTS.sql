/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML INSERTS =============
 */



-- Eliminamos todos los registros de las tablas
delete from facturas_detalles cascade;
delete from facturas cascade;
delete from ventas cascade;
delete from compradores cascade;
delete from citas_inmuebles cascade;
delete from inspecciones_inmuebles ;
delete from inmuebles_marketing cascade;
delete from inmuebles cascade;
delete from inmuebles_descripciones cascade;
delete from inmuebles_medidas cascade;
delete from propietarios_inmuebles cascade;
delete from administradores cascade; 
delete from gerentes cascade;
delete from vendedores cascade;
delete from compradores_clientes cascade;
delete from clientes cascade;
delete from empleados cascade;
delete from servicios_oficinas cascade;
delete from oficinas_detalles cascade;
delete from oficinas cascade;
delete from logs_inserts cascade;


-- Alteramos la secuencia auto incrementable id 
alter sequence id_sec_of restart with 1;
alter sequence id_sec_of_det restart with 1;
alter sequence id_sec_serv_of restart with 1;
alter sequence id_sec_inm restart with 1;
alter sequence id_sec_inm_descr restart with 1;
alter sequence id_sec_inm_med restart with 1;
alter sequence id_sec_inm_mark restart with 1;
alter sequence id_sec_insp_inm restart with 1;
alter sequence id_sec_cit_inm restart with 1;
alter sequence id_sec_prop_inm restart with 1;
alter sequence id_sec_empl restart with 1;
alter sequence id_sec_cli restart with 1;
alter sequence id_sec_adm restart with 1;
alter sequence id_sec_ger restart with 1;
alter sequence id_sec_vend restart with 1;
alter sequence id_sec_comp restart with 1;
alter sequence id_sec_vent restart with 1;
alter sequence id_sec_fact restart with 1;
alter sequence id_sec_fact_det restart with 1;

alter sequence id_sec_logs_ins restart with 1;
alter sequence id_sec_logs_upd restart with 1;
alter sequence id_sec_logs_del restart with 1;





-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ==================================
-- ======= TABLA OFICINAS ===========
-- ==================================


select descripcion_oficinas();




-- ------------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------------
-- ------------------------------------------------------

select insertar_registro_oficinas(
'Torre San Vicente' , 'Paraguay 780' , '+54 11 5279-4790' , 'inmobiliariaDuckson@gmail.com'
);

select insertar_registro_oficinas(
'Edificio Torre Alem' , 'Alem Leandro Niceforo N°955 - Piso 13' , '11 61147000' , 'inmobiliariaDuckson@gmail.com'
);


-- -------------------------------------------------
-- ----------- INSERCIÓN DE 2 REGISTROS ------------
-- -------------------------------------------------


select insertar_registros_oficinas(
'Oficina Comercial Principal' , 'Callao 255, Centro / Microcentro' , '11 5653-1799' , 'inmobiliariaDuckson@gmail.com'
,'Oficina de Gestión Le Bluen' , 'Av. Corrientes 445 Microcentro' , '11 3343-7729' , 'inmobiliariaDuckson@gmail.com'
);

select insertar_registros_oficinas(
'Oficina Comercial Puan' , 'Puan 128, Caballito' , '11 8893-0093' , 'inmobiliariaDuckson@gmail.com'
,'Oficina Comercial Recoleta' , 'Agüero 2247, C1425EHW CABA' , '8392-1123' , 'inmobiliariaDuckson@gmail.com'
);


select listado_oficinas();

select listado_logs_inserts();


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ===========================================
-- ======= TABLA OFICINAS_DETALLES ===========
-- ===========================================


-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------


select insertar_registros_oficinas_detalles(
1, 'Retiro', 'EJECUTIVA', 'ALQUILADA', 140.00, 6 , 4 , 15 
, 'www.inmobiliariaDuckson-torre-Nepkiul.com.ar'
);

select insertar_registros_oficinas_detalles(
2 , 'Belgrano' , 'PEQUEÑA' , 'PROPIA' , 35.45 , 1 , 1 , 35 
, 'www.inmobiliariaDuckson-torre-Alem.com.ar'
);

select insertar_registros_oficinas_detalles(
3 , 'Balvanera' , 'ESTANDAR' , 'PROPIA' , 60.20 , 2 , 4 , 22 
, 'www.inmobiliariaDuckson-oficina-principal.com.ar'
);


select insertar_registros_oficinas_detalles(
4 , 'Microcentro' , 'PEQUEÑA' , 'PROPIA' , 43.12 , 1 , 2 , 18 
, 'www.inmobiliariaDuckson-gestion-le-bluen.com.ar'
);


select insertar_registros_oficinas_detalles(
5 , 'Caballito' , 'ESTANDAR' , 'ALQUILADA' , 72.89 , 3 , 2 , 22 
, 'www.inmobiliariaDuckson-oficina-comercial01.com.ar'
);

select insertar_registros_oficinas_detalles(
6 , 'Recoleta' , 'EJECUTIVA' , 'ALQUILADA' , 167.88 , 2 , 2 , 25 
, 'www.inmobiliariaDuckson-oficina-comercial02.com.ar'
);



select listado_oficinas_detalles();

select listado_logs_inserts();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- =============================================
-- ======= TABLA SERVICIOS_OFICINAS ===========
-- =============================================


-- enum division_comercial_enum ('LOCALES','OFICINAS','TERRENOS'
-- ,'LOCALES_OFICINAS_TERRENOS','NO_APLICA');

-- enum division_vivienda_enum ('DEPARTAMENTOS','CASAS','TERRENOS'
-- ,'DEPARTAMENTOS_CASAS_TERRENOS','NO_APLICA');

-- enum tasaciones_enum ('PROFESIONAL','JUDICIAL','PROFESIONAL_JUDICIAL'
-- ,'NO_APLICA');

-- enum administracion_enum ('ALQUILERES','CUENTAS','ALQUILERES_CUENTAS' 
-- ,'NO_APLICA');


select listado_servicios_oficinas();

select descripcion_servicios_oficinas();

select listado_oficinas();


-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------


select insertar_registro_servicios_oficinas(
1 , 'LOCALES_OFICINAS_TERRENOS' , 'NO_APLICA' , 'PROFESIONAL' 
, 'ALQUILERES_CUENTAS' , 'La Oficina San Vicente maneja servicios de tipo comercial, tasaccional y de administración'
);


-- -------------------------------------------------
-- ----------- INSERCIÓN DE 2 REGISTROS ------------
-- -------------------------------------------------


select insertar_registros_servicios_oficinas(
2 , 'LOCALES' , 'DEPARTAMENTOS' , 'PROFESIONAL_JUDICIAL' 
, 'ALQUILERES_CUENTAS' , 'Esta Oficina Aplica para todos los Servicios Disponibles'
, 3 , 'LOCALES_OFICINAS_TERRENOS' , 'NO_APLICA' , 'NO_APLICA' 
, 'NO_APLICA' , 'La Oficina Comercial Principal solo maneja servicios de tipo Comercial'
);

select insertar_registros_servicios_oficinas(
4 , 'OFICINAS' , 'DEPARTAMENTOS' , 'PROFESIONAL' , 'ALQUILERES' 
, 'La responsabilidad tiene implicancia en servicios no comerciales'
, 5 , 'LOCALES_OFICINAS_TERRENOS' , 'DEPARTAMENTOS_CASAS_TERRENOS' , 'PROFESIONAL_JUDICIAL' 
,'ALQUILERES_CUENTAS', 'Aplica para todos los servicios propios y externos'
);

select insertar_registro_servicios_oficinas(
6 , 'LOCALES' , 'TERRENOS' , 'PROFESIONAL' , 'ALQUILERES' 
, 'Se gestionan servicios de tipo tasaccional y de administración'
);



select listado_servicios_oficinas();
select listado_logs_inserts();









-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------





-- ==================================
-- ======= TABLA EMPLEADOS ===========
-- ==================================

-- campos DATE -->Ej 2020/09/09


select descripcion_empleados();


select listado_empleados();

select listado_oficinas();
select listado_empleados();

select listado_logs_inserts();




-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------

select insertar_registro_empleados(1, 'Juan', 'Levbier', 22, '1994-1-2'
, 'DNI', '408736633', '31-408736633-9', 'La Rioja 2221', '1122334321', '-' 
, 'juanLevbier@gmail.com', 'Agente Inmobiliario/ Vendedor', 2 
, '2019/1/1', 50000);




-- -------------------------------------------------
-- ----------- INSERCIÓN DE 2 REGISTROS ------------
-- -------------------------------------------------



-- Oficina 1 (Torre San Vicente)
select insertar_registros_empleados(
1, 'Macarena', 'Gutierrez', 32, '1989-04-06', 'DNI', '334565243'
, '12-334565243-7', 'Av. Gaona 352', '1164575222', '1164575222'
, 'maca.gutieerez756@hotmail.com', 'Administradora', 2 
, '2019/03/01', 45000
, 1 , 'marcos', 'Castro', 45, '1971-05-01', 'DNI', '48967156'
,'33489671564', 'Figueroa Alcorta 22', '1178654356', '+5491178654356'
, 'marcosCastro2002_lop@hotmail.com', 'Agente Inmobiliario(Gerente)', 4
, '2017/09/6', 150000
);

-- Oficina 1 (Torre San Vicente)
select insertar_registros_empleados(
 1 , 'José', 'bastituta', 34, '1988-09-07', 'DNI', '409876546'
, '12409876546-0', 'San Acrosio 15781', '1157670000', '+5491157670000'
, 'joseBastituta_88@gmail.com', 'Agente Inmobiliario(Vendedor)', 1
, '2020/07/12', 65000
, 1, 'Juan', 'Contreras', 28, '1992-9-9', 'DNI', '37998637'
, '30-37998637-9', 'Av. Las Heras 7567', '1145367655', '-' 
, 'juanContreras.iptre@gmail.com', 'Agente Inmobiliario/ Gerente', 4 
, '2018/4/2', 78000
);





--Oficina 2 (Edificio Torre Alem)
select insertar_registros_empleados(
2, 'Damian', 'gutierrez', 39, '1978-09-14', 'DNI', '33869556', '20-33869556-3'
, 'Av Alberdi 05', '+5491176844456', '+5491157684445', 'damian_gut.756@gmail.com'
, 'Agente Inmobiliario(Gerente)', 3, '2018/3/4', 139000
, 2, 'Marcelo', 'Perez', 28, '1988-03-17', 'DNI', '39345679', '12-39345679-9'
, 'Carabobo 06', '+5491138765433', '-', 'MarceloPerez@gmail.com'
, 'Administrador', 2, '2019/04/14', 56000
);

--Oficina 2 (Edificio Torre Alem)
select insertar_registros_empleados(
2, 'Jimena', 'D Ambrosio', 37, '1991/11/06', 'DNI', '417896537','2-417896537-2'
, 'Valentin Figueroa 33', '1175680377', '+5491175680338', 'lic_DAmbrosio@gmail.com'
, 'Agente Inmobiliario(Vendedora)', 3, '2018-08-14', 71000 
, 2, 'Carlos', 'Gustamante', 31, '1982-04-03', 'DNI', '290076726', '11-290076726-2'
, 'Av. Figueroa Alcorta 22', '1145639987', '-', 'c.gustamante@gmail.com'
, 'Administrador', 2, '2019/12/02', 57000
);







-- Oficina 3 (Oficina Comercial Principal)
select insertar_registros_empleados(
3,'Sofia', 'Aguilar', 35, '1981-07-01', 'DNI', '33456733', '8-33456733-9'
, 'Av. Corrientes 2564', '1175678844', '+5491130928783', 'lic_sofiaAguilar@gmail.com'
, 'Agente Inmobiliario(Gerenta)', 3, '2018-08-02', 156000
, 3, 'Luis', 'Gonzalez', 26, '1991/09/21', 'DNI', '397865432', '56-397865432-99'
, 'La Pampa 22', '+549113764522', '-', 'luisGonzalez_jsu@gmail.com', 'Administrador', 2
, '2019/07/12', 50000
);

-- Oficina 3 (Oficina Comercial Principal)
select insertar_registros_empleados(
 3, 'Marcelo', 'Castro', 28, '1989/04/06', 'DNI', '39886386', '14-39886386-5'
, 'Los Patos 123', '+549118567453', '+549118567453', 'marcelocastro.746_jj@gmail.com'
, 'Administrador', 2, '2019/02/11', 51000
, 3,  'Juan', 'Notowski', 41, '1988-02-21', 'DNI', '432765411', '22-432765411-93'
, 'Av Rivadavia 9100', '+5491175680827', '+5491175680827', 'notowski_Juan_7238@gmail.com'
, 'Agente Inmobiliario(Vendedor)', 2, '2019-04-22', 74000
);





-- Oficina 4 (Oficinas de Gestión Le Bluen)
select insertar_registros_empleados(
4,'Marcos', 'Norwey', 39, '1967/10/06', 'DNI', '27888651', '22-27888651-5'
, 'Entre Ríos 222', '1176874567', '1176874567', 'MarcosNorWorkllo@gmail.com'
, 'Gerente', 6, '2015-3-1', 46000
, 4, 'Micaela', 'Fernandez', 24, '1997-03-02', 'DNI', '299765234', '19-299765234-2'
, 'Av. Acoyte 33', '+5491136547766', '+5491136547766', 'micaela.fernandez.97@gmail.com'
, 'Administradora', 1, '2020/04/09', 44000
);

-- Oficina 4 (Oficinas de Gestión Le Bluen)
select insertar_registros_empleados(
4, 'Antonio', 'Torres', 26, '1995/4/16', 'DNI', '38223344', '19-38223344-1'
, 'Azul 12', '+54911987365', '-', 'antonioJose_cabj@gmail.com', 'Administrador', 3
, '2018-01-09', 55000
, 4,  'Ramon', 'Farias', 44, '1977-09-18', 'DNI', '50456789', '11-50456789-0'
, 'Castro Barros 937', '118765541', '-', 'ramonFarias@gmail.com'
, 'Administrador', 5, '2015/06/12', 80000
);

select listado_oficinas();
select listado_empleados();
select listado_logs_inserts();



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------






-- ================================================
-- ======= TABLA PROPIETARIOS_INMUEBLES ===========
-- ================================================


select listado_propietarios_inmuebles();


select descripcion_propietarios_inmuebles();



select listado_propietarios_inmuebles();
select listado_logs_inserts();


-- campos DATE -->Ej 2020/09/09



-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------

 select insertar_registro_propietarios_inmuebles(
'Fabian', 'Gonzalez', 45, '1975/10/09', 'DNI', '45897677', 'San Vicente 879'
, '+5491156749874', '6578-3786', 'viccentin3k@gmail.com'
);


-- -------------------------------------------------
-- ----------- INSERCIÓN DE 2 REGISTROS ------------
-- -------------------------------------------------

 select insertar_registros_propietarios_inmuebles(
'Marcela', 'Sanchez', 49, '1971/12/08', 'DNI', '4298762543', 'San AZUL 222'
, '+5491173654378', '-', 'marcelaSanchez222@gmail.com',
'Guillermo', 'Zulenski', 65, '1955/10/09', 'DNI', '35897677', 'Av. Calloa 879'
, '+5491156788', '+5491156788', 'zulenskiVentas2019@gmail.com'
);

select listado_propietarios_inmuebles();
select listado_logs_inserts();

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ================================================
-- ======= TABLA INMUEBLES_DESCRIPCIONES ===========
-- ================================================


select listado_inmuebles_descripciones();


select descripcion_inmuebles_descripciones();



-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------

-- EJ. 254.8m^2, 198.9m^2,  4 ambientes, 3 dormis, 2 sanitarios, 1 patio, 1 cochera, 1 balcon, 50 años antiguedad

select insertar_registro_inmuebles_descripciones(
265.8, 198.9 , 4, 3, 2, 1, 1, 1, 50 
);



-- -------------------------------------------------
-- ----------- INSERCIÓN DE 2 REGISTROS ------------
-- -------------------------------------------------

select insertar_registros_inmuebles_descripciones(
185.8, 185.8 , 3, 4, 1, 0, 1, 0, 80 
,97.8, 60.3 , 2, 3, 2, 1, 0, 1, 30 
);


select listado_inmuebles_descripciones();

select listado_logs_inserts();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

 


-- ================================================
-- ======= TABLA INMUEBLES_MEDIDAS ===========
-- ================================================


select listado_inmuebles_medidas();


select descripcion_inmuebles_medidas();





-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------

-- EJ dormitorio: Dormitorio01: 23 x 2,9 | Dormitorio 2: 43 x 1,9
-- Medidas ALTO X ANCHO

select insertar_registro_inmuebles_medidas(
'17.0 x 5.9' , '6.0 x 4.0' , 'Dormitorio1: 5.0 x 5.0 | Dormitorio2: 7.0 x 4.0 | Dormitorio3: 6.0 x 6.0'
, 'Baño1: 2.0 x 1.4 | Baño2: 1.67 x 1.89' , '6.0 x 7.56' , '3.0 x 3.66' , '1.0 x 1.23'
);


-- -------------------------------------------------
-- ----------- INSERCIÓN DE 2 REGISTROS ------------
-- -------------------------------------------------

select insertar_registros_inmuebles_medidas(
'6.0 x 3.5' , '4.0 x 2.0' , 'Dormitorio1: 2.0 x 1.66 | Dormitorio2: 3.0 x 2.0 | Dormitorio3: 2.0 x 1.4 | 
Dormitorio4: 1.3 x 1.2', '1.88 x 2.20' , '-' , '2.77 x 1.02' , '-'
,'2.34 x 1.89' , '2.02 x 2.66' , 'Dormitorio1: 2.45 x 2.09 | Dormitorio2: 2.03 x 1.88 | Dormitorio3: 1.89 x 1.20'
, 'Baño1: 1.50 x 1.04 | Baño2: 1.90 x 1.3' , '1.34 x 1.88' , '-' , '1.33 x 1.22'
);


select listado_inmuebles_medidas();


select listado_logs_inserts();



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ===================================
-- ======= TABLA INMUEBLES ===========
-- ===================================


-- ENUM estado_inmueble ('VENDIDO','DISPONIBLE','NO_DISPONIBLE','FALTA_INSPECCION');


select listado_inmuebles();

select descripcion_inmuebles();




-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------

select listado_propietarios_inmuebles();
select listado_inmuebles_medidas();
select listado_inmuebles_descripciones();
select listado_oficinas();

select insertar_registros_inmuebles(
1, 1, 1, 1, 'PH de 4 Ambientes, 3 dormis, 2 baños, Amplio Espacio,jardin y balcon, Sin Expensas, Lujoso'
, 'PH/Casa','DISPONIBLE', 177.000, 'San Cristobla 456', 'Palermo'
, 'www.avisosAlInstante.com.ar'
);

select insertar_registros_inmuebles(
2, 2, 2, 2,  'Casa 3 Ambientes, 4 Dormitorios, 1 baño y Cochera', 'Casa','VENDIDO'
, 168.000, 'Aristobulo del Valle 608 ', 'Belgrano', 'www.avisosAlInstante.com.ar'
, 3, 3, 3, 3 , 'Departamento de 2 Ambientes', 'Departamento','VENDIDO'
, 110.000, 'Av. Corrientes', 'Caballito', 'www.avisosAlInstante.com.ar'
);



select listado_inmuebles();

select listado_logs_inserts();



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ===================================
-- ======= TABLA CLIENTES ===========
-- ===================================

select listado_clientes();

select descripcion_clientes();

-- campos DATE -->Ej 2020/09/09


-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------
select insertar_registro_clientes(
'Rodrigo', 'Bustamante', 29, '1991/11/02', 'DNI', '36879254'
, 'Aristobulo del Valle 887', '+5491176534456', '3765-9978'
, 'rodrigo_bustamante@gmail.com', '2021/06/12'
);

select insertar_registros_clientes(
'Marcela', 'Pérez', 31, '1989/12/12', 'DNI', '33895854', 'Av. Callao 213'
, '+5491143534456', '+5491143534456', 'marcela_perez@gmail.com', '2020/03/06'
,'Jaime', 'Rodriguez', 48, '1977-02-16', 'DNI', '29937852', 'Av. La Pampa 218'
, '+5491183675544', '+5491183675544', 'jaime.CL_la@gmail.com', '2020/11/23'
);

select listado_clientes();



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------



-- ===================================
-- ======= TABLA CITAS_INMUEBLES ===========
-- ===================================


-- ENUM estadoCita('PENDIENTE','COMPLETADA','INCOMPLETA');
-- fecha_cita date '2001/10/07'
-- hora_cita time '09:00:07'



select listado_citas_inmuebles();


select descripcion_citas_inmuebles();


select listado_inmuebles();
select listado_empleados();
select listado_clientes();

-- -------------------------------------------------
-- ----------- INSERCIÓN DE 1 REGISTRO ------------
-- -------------------------------------------------


select insertar_registro_citas_inmuebles(
1, 1, 1, 'COMPLETADA' , 'Cita Finalizada y Venta Efectuada de Forma Exitosa'
, '2020/03/01', '11:00:00'    
);



-- -------------------------------------------------
-- ----------- INSERCIÓN DE 2 REGISTROS ------------
-- -------------------------------------------------

select insertar_registros_citas_inmuebles(
2, 2 , 2 , 'PENDIENTE' , 'Se reserva cita para la fecha estipulada' 
, '2022/01/12', '09:00:00'
, 3 , 3 , 3 , 'COMPLETADA' , 'Venta Efectuada de forma exitosa'
, '2020/06/11', '12:00:00'
);



select listado_citas_inmuebles();
select listado_logs_inserts();






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =============================================
-- ======= TABLA INMUEBLES_MARKETING ===========
-- =============================================


select listado_inmuebles_marketing();

select descripcion_inmuebles_marketing();


select insertar_registro_inmuebles_marketing(
1, 'GOOGLE' , 'TWITTER' , 'Posicionamiento SEO de nuestra página en google y uso de Redes Sociales, se cotiza por visitas'
, 2000
);

select insertar_registros_inmuebles_marketing(
2 , 'Google Ads', 'Linkedin', 'Sección Ventas en Inmuebles', 5000
, 3 , 'Google Ads', '-', 'Sección Ventas en Inmuebles', 3000
);


select listado_inmuebles_marketing();






-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =============================================
-- ======= TABLA INSPECCIONES_INMUEBLES ========
-- =============================================

-- ENUM estado_inspeccion ('ACEPTADA','NO_ACEPTADA','PENDIENTE_REVISION');
-- ENUM tipo_inspeccion('DEPARTAMENTO','CASA','PH');
-- fecha date  '2001/10/07'
-- hora time   '09:00:07'



select listado_inspecciones_inmuebles();

select descripcion_inspecciones_inmuebles();



select insertar_registro_inspecciones_inmuebles(
1, 'ACEPTADA', 'PH', 'Se llevo a caba la inspeccion de forma exitosa y sin Novedad'
, 'Les Venegas', 'Las Pampas 334', '7568-0499', '8600', '2021/02/13', '07:00:00'
);

select insertar_registros_inspecciones_inmuebles(
2, 'ACEPTADA', 'CASA', 'Se llevo a caba la inspeccion de forma exitosa y sin Novedad'
, 'Les Venegas', 'Las Pampas 334', '7568-0499', '7400', '2021/03/18', '10:00:00'
, 3, 'ACEPTADA', 'DEPARTAMENTO', 'Se llevo a caba la inspeccion de forma exitosa y sin Novedad'
, 'Les Venegas', 'Las Pampas 334', '7568-0499', '5100', '2020/01/09', '08:30:00'
);

select listado_inspecciones_inmuebles();
select listado_logs_inserts();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ===============================
-- ======= TABLA GERENTES ========
-- ===============================



select listado_gerentes();

select descripcion_gerentes();



select listado_empleados();


select insertar_registro_gerentes(
2 , 'Contador Público Universitario', 12, 'Planeamiento Eficiente, Ejecución Eficaz, Rendimiento'
,'Home Office 2 veces x sem, 35% Descuento Pack Viajes, Planes de Ahorro Viviendas', 32000
);


select insertar_registros_gerentes(
4 , 'Licenciado en Administración', 5.6, 'Organización, Gestión, Desempeño'
,'Horarios Flexibles, 35% Descuento Pack Viajes', 42000
, 8 , 'Licenciada en Marketing', 7.0, 'Ventas, Publicidad, Coordinación'
,'Horarios Flexibles y Días Extras de Descanso, 40% Descuento Pack Viajes', 35000
);


select listado_gerentes();
select listado_logs_inserts();

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ======================================
-- ======= TABLA ADMINISTRADORES ========
-- ======================================

select listado_administradores();

select descripcion_administradores();


select listado_empleados();

select insertar_registro_administradores(
1 , 'Departamento', 'Cert. Habilidades Aministrativas, Cert. Nivel 2 en Aministración de Cuentas'
, 'Alto', 'Liderazgo y Negociación'
);

select insertar_registros_administradores(
5, 'Casa', 'Cert. Administración Viviendas, Cert. Tecnologías Digital, Cert. Servicios de Aministración'
,'Medio', 'Recursos Tecnológicos, Comunicación y Planificación'
, 9, 'Departamento-Casa', 'Cert. Gestión Avanzada en Inmuebles, Cert. Especialista Apoyo Administrativo, 
Cert. Aministración de Oficinas', 'Alto', 'Alta Flexibilidad, Marketing Digital y Planificación'
);


select listado_administradores();
select listado_logs_inserts();



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =================================
-- ======= TABLA VENDEDORES ========
-- =================================

select listado_vendedores();

select descripcion_vendedores();


select listado_empleados();



select insertar_registro_vendedores(
1, 3, 20000 , 'Excelente', 'Departamento', 'Confianza, Dominio de Venta, Desarrollo Linguístico'
);


select insertar_registros_vendedores(
4, 0, 0 , 'Sin Ventas' , 'Casa' , 'Ambición, Comercialización, Determinación'
, 8, 2, 10000 , 'Buena', 'Departamento-Casa', 'Comunicación Eficaz, Creatividad, Convicción'
);




select listado_vendedores();
select listado_logs_inserts();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ==============================
-- ======= TABLA VENTAS ========
-- =============================

-- campos DATE -->Ej 2020/09/09
-- hora_venta time '09:00:07'


select listado_ventas();

select descripcion_ventas();



select listado_empleados();
select listado_clientes();
select listado_inmuebles();



select insertar_registro_ventas(
1, 1, 1, '2020/12/22', '08:30:00', 'Se Realiza la Venta de Manera Eficiente'
);

select insertar_registros_ventas(
4 , 2 , 2 , '2020/01/12', '11:15:00', 'La Venta fue exitosa'
, 8 , 3 , 3 , '2021/03/22', '18:45:00', 'La Venta fue exitosa'
);



select listado_ventas();
select listado_logs_inserts();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =================================
-- ======= TABLA COMPRADORES ========
-- =================================

-- importe_maximo_por_compra_usd se considera en base a todas las compras 	
-- importe_total_compras_usd se considera la suma de todas las compras


select listado_compradores();

select descripcion_compradores();


select listado_clientes();
select listado_inmuebles();



select insertar_registro_compradores(
1, 1 ,'Descuento del 7% en la Próxima Compra', 200
);


select insertar_registros_compradores(
 2, 2, 'Descuento del 10% en la Próxima Compra',200
 , 3, 3, 'Descuento del 10% en la Próxima Compra',200
);


 
select listado_compradores();
select listado_logs_inserts();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- =================================
-- ======= TABLA FACTURAS ========
-- =================================

-- fecha_venta date '2001/10/07'
-- hora_venta time '09:00:07'


select listado_facturas();

select descripcion_facturas();

select listado_ventas();
select listado_inmuebles();

select insertar_registro_facturas(
 1, '00001-00000001', '2020/12/22', '08:30:00', 180000
);


select insertar_registros_facturas(
 2, '00001-00000002', '2020/01/12', '11:15:00', 170000
, 3, '00001-00000003', '2020/03/22', '18:45:00', 115000
);





select listado_facturas();
select listado_logs_inserts();




-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------


-- ========================================
-- ======= TABLA FACTURAS_DETALLES ========
-- ========================================

-- ENUM tipo_factura_enum ('A','B','C','D');
-- ENUM tipo_pago_enum ('EFECTIVO','CHEQUE','TARJETA');



select listado_facturas_detalles();

select descripcion_facturas_detalles();

select listado_ventas();
select listado_inmuebles();
select listado_facturas();


select insertar_registro_facturas_detalles(
 1, 'A', 'Venta de Inmueble Tipo Departamento de 2 Ambientes Zona Caballito'
 , 177000, 800, 200, 'EFECTIVO', 'Se efectuó la compra en 1 sólo Pago'
);

select insertar_registros_facturas_detalles(
 2, 'A', 'Venta de Inmueble Tipo Casa de 3 Ambientes Zona Belgrano'
 , 170000, 1600, 400, 'CHEQUE', 'Se efectuó la compra a Pagar en 3 Pagos'
 , 3, 'A', 'Venta del Departamento de 2 Ambientes en Caballito'
 , 170000, 1600, 400, 'EFECTIVO', 'Se efectuó la compra a Pagar en 2 Pagos'
 );





select listado_facturas_detalles();
select listado_logs_inserts();










