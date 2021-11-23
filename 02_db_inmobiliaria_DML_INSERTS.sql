/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML INSERTS =============
 */


delete from facturas_detalles cascade;
delete from facturas cascade;
delete from ventas cascade;
delete from citas_inmuebles cascade;
delete from inspecciones_inmuebles ;
delete from inmuebles_marketing cascade;
delete from inmuebles cascade;
delete from inmuebles_descripciones cascade;
delete from inmuebles_medidas cascade;
delete from servicios_inmuebles cascade;
delete from propietarios_inmuebles cascade;
delete from administradores cascade; 
delete from gerentes cascade;
delete from vendedores cascade;
delete from compradores_clientes cascade;
delete from compradores cascade;
delete from clientes cascade;
delete from empleados cascade;
delete from oficinas_detalles cascade;
delete from oficinas cascade;





-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';


insert into oficinas (id, nombre, direccion, nro_telefono, email) values 
(1 , 'Torre San Vicente' , 'Paraguay 780' , '+54 11 5279-4790' , 'inmobiliariaDuckson@gmail.com'),
(2 , 'Edificio Torre Alem' , 'Alem Leandro Niceforo N°955 - Piso 13' , '11 61147000' , 'inmobiliariaDuckson@gmail.com'),
(3 , 'Oficina Comercial Principal' , 'Callao 255, Centro / Microcentro' , '11 5653-1799' , 'inmobiliariaDuckson@gmail.com');



-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS_DETALLES ===========

-- ENUM estado_oficina ('ALQUILADA','PROPIA'); 
-- ENUM  tipo_oficina('PEQUEÑA','ESTANDAR','EJECUTIVA'); 



select * from oficinas_detalles;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'oficinas_detalles';


insert into oficinas_detalles (id, id_oficina, localidad, tipo_oficina, estado_oficina, superficie_total
, cantidad_ambientes, cantidad_sanitarios, antiguedad, sitio_web) values
(1 , 1 , 'Retiro' , 'EJECUTIVA' , 'ALQUILADA' , 140.0 , 6 , 4 , 15 , 'www.inmobiliariaDuckson-torre-Nepkiul.com.ar'),-- sup_total en m^2
(2 , 2 , 'Belgrano' , 'PEQUEÑA' , 'PROPIA' , 35.0 , 1 , 1 , 35 , 'www.inmobiliariaDuckson-torre-Alem.com.ar'),
(3 , 3 , 'Balvanera' , 'ESTANDAR' , 'PROPIA' , 60.0 , 2 , 4 , 22 , 'www.inmobiliariaDuckson-oficina-principal.com.ar');




-- ---------------------------------------------------------------------------

-- ======= TABLA PROPIETARIOS_INMUEBLES ===========

select * from propietarios_inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'propietarios_inmuebles';

insert into propietarios_inmuebles (id, nombre, apellido, edad, fecha_nacimiento, tipo_documento, nro_documento
,direccion, nro_telefono_principal, nro_telefono_secundario , email) values
(1, 'Fabian', 'Gonzalez', 45, '1975/10/09', 'DNI', 45897677, 'San Vicente 879', '+5491156749874', '6578-3786'
, 'viccentin3k@gmail.com'),
(2, 'Guillermo', 'Zulenski', 65, '1955/10/09', 'DNI', 35897677, 'Av. Calloa 879', '+5491156788', '+5491156788'
, 'zulenskiVentas2019@gmail.com');



-- https://inmueble.mercadolibre.com.ar/MLA-1106193666-ph-sin-expensas-_JM#position=2&search_layout=grid&type=item&tracking_id=7d3f63be-4762-490b-a886-4cd1ac9c00a6

-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES_DESCRIPCIONES ===========


select * from inmuebles_descripciones;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'inmuebles_descripciones';

-- EJ. 254.8m^2, 198.9m^2,  4 ambientes, 3 dormis, 2 sanitarios, 1 patio, 1 cochera, 1 balcon, 50 años antiguedad

insert into inmuebles_descripciones (id, superficie_total, superficie_cubierta, cantidad_ambientes
, cantidad_dormitorios, cantidad_sanitarios , cantidad_patios_jardines, cantidad_cocheras, cantidad_balcones
, antiguedad) values 
(1, 265.8, 198.9 , 4, 3, 2, 1, 1, 1, 50 ), 
(2, 185.8, 185.8 , 3, 4, 1, 0, 1, 0, 80 ),
(3, 97.8, 60.3 , 2, 3, 2, 1, 0, 1, 30 );

-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES_MEDIDAS ===========


select * from inmuebles_medidas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles_medidas';

-- EJ dormitorio: Dormitorio01: 23 x 2,9 | Dormitorio 2: 43 x 1,9
-- Medidas ALTO X ANCHO

insert into inmuebles_medidas(id, living_comedor, cocina, dormitorio, sanitario, patio_jardin, cochera, balcon) values 
(1, '17.0 x 5.9' , '6.0 x 4.0' , 'Dormitorio1: 5.0 x 5.0 | Dormitorio2: 7.0 x 4.0 | Dormitorio3: 6.0 x 6.0'
, 'Baño1: 2.0 x 1.4 | Baño2: 1.67 x 1.89' , '6.0 x 7.56' , '3.0 x 3.66' , '1.0 x 1.23'),
(2, '6.0 x 3.5' , '4.0 x 2.0' , 'Dormitorio1: 2.0 x 1.66 | Dormitorio2: 3.0 x 2.0 | Dormitorio3: 2.0 x 1.4 | 
Dormitorio4: 1.3 x 1.2', '1.88 x 2.20' , '-' , '2.77 x 1.02' , '-'),
(3, '2.34 x 1.89' , '2.02 x 2.66' , 'Dormitorio1: 2.45 x 2.09 | Dormitorio2: 2.03 x 1.88 | Dormitorio3: 1.89 x 1.20'
, 'Baño1: 1.50 x 1.04 | Baño2: 1.90 x 1.3' , '1.34 x 1.88' , '-' , '1.33 x 1.22');




-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES ===========

-- ENUM estado_inmueble ('VENDIDO','DISPONIBLE','NO DISPONIBLE','FALTA INSPECCION');


select * from inmuebles;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'inmuebles';

insert into inmuebles (id, id_propietario_inmueble, id_inmueble_medidas, id_inmueble_descripcion, id_oficina,
descripcion, tipo, estado_inmueble, precio_inmueble_usd, direccion, ubicacion, sitioWeb) values 
(1, 1, 1, 1, 1, 'PH de 4 Ambientes, 3 dormis, 2 baños, Amplio Espacio,jardin y balcon, Sin Expensas, Lujoso'
, 'PH/Casa','DISPONIBLE', 177000, 'San Cristobla 456', 'Palermo', 'www.avisosAlInstante.com.ar' ),
(2, 1, 2, 2, 2, 'Casa 3 Ambientes, 4 Dormitorios, 1 baño y Cochera', 'Casa','VENDIDO'
, 168000, 'Aristobulo del Valle 608 ', 'Belgrano', 'www.avisosAlInstante.com.ar' ),
(3, 2, 3, 3, 3, 'Departamento de 2 Ambientes', 'Departamento','VENDIDO', 110000, 'Av. Corrientes'
, 'Caballito', 'www.avisosAlInstante.com.ar');



-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES_MARKETING ===========


select * from inmuebles_marketing;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'inmuebles_marketing';


insert into inmuebles_marketing(id, id_inmueble, tipo_anuncio_principal, tipo_anuncio_secundario
, descripcion_anuncio, inversion_total) values
(1, 1, 'Google Ads', 'Youtube', 'Marketing en Páginas de Búsqueda de Inmuebles', 4000),
(2, 2, 'Google Ads', 'Linkedin', 'Sección Ventas en Inmuebles', 5000),
(3, 3, 'Google Ads', '-', 'Sección Ventas en Inmuebles', 3000);




-- ---------------------------------------------------------------------------

-- ======= TABLA INSPECCIONES_INMUEBLES ===========

-- ENUM estado_inspeccion ('ACEPTADA','NO ACEPTADA','PENDIENTE REVISION');
-- ENUM tipo_inspeccion('DEPARTAMENTO','CASA','PH');
-- fecha date  '2001-10-07'
-- hora time   '09:00:07'


select * from inspecciones_inmuebles;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'inspecciones_inmuebles';

insert into inspecciones_inmuebles (id, id_inmueble, estado_inspeccion, tipo_inspeccion
, descripcion_inspeccion, empresa, direccion, nro_telefono, costo, fecha, hora) values
(1, 1, 'ACEPTADA', 'PH', 'Se llevo a caba la inspeccion de forma exitosa y sin Novedad'
, 'Les Venegas', 'Las Pampas 334', '7568-0499', '8600', '2021-02-13', '07:00:00' ),
(2, 2, 'ACEPTADA', 'CASA', 'Se llevo a caba la inspeccion de forma exitosa y sin Novedad'
, 'Les Venegas', 'Las Pampas 334', '7568-0499', '7400', '2021-03-18', '10:00:00' ),
(3, 3, 'ACEPTADA', 'DEPARTAMENTO', 'Se llevo a caba la inspeccion de forma exitosa y sin Novedad'
, 'Les Venegas', 'Las Pampas 334', '7568-0499', '5100', '2020-01-09', '08:30:00' );





-- ---------------------------------------------------------------------------

-- ======= TABLA SERVICIOS_INMUEBLES ===========

-- ENUM division_comercial ('LOCALES','OFICINAS','TERRENOS','LOCALES-OFICINAS-TERRENOS','NO APLICA');
-- ENUM division_vivienda ('DEPARTAMENTOS','CASAS','TERRENOS','DEPARTAMENTOS-CASAS-TERRENOS','NO APLICA');
-- ENUM tasaciones ('PROFESIONAL','JUDICIAL', 'PROFESIONAL-JUDICIAL','NO APLICA');
-- ENUM administracion ('ALQUILERES','CUENTAS','ALQUILERES-CUENTAS','NO APLICA');


select * from servicios_inmuebles;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'servicios_inmuebles';


insert into servicios_inmuebles (id, id_oficina, tipo_comercial, tipo_vivienda, tipo_tasaciones
, tipo_administracion, descripcion_servicios) values 
(1, 1, 'LOCALES-OFICINAS-TERRENOS','DEPARTAMENTOS-CASAS-TERRENOS','PROFESIONAL','ALQUILERES-CUENTAS','-'),
(2, 2, 'OFICINAS','DEPARTAMENTOS','PROFESIONAL','ALQUILERES-CUENTAS','-'),
(3, 3, 'LOCALES-OFICINAS-TERRENOS','DEPARTAMENTOS-CASAS-TERRENOS','PROFESIONAL-JUDICIAL','ALQUILERES-CUENTAS','-');




-- ---------------------------------------------------------------------------

-- ======= TABLA EMPLEADOS ===========

select * from empleados;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'empleados';

-- Oficina 1 (Torre San Vicente)
insert into empleados (id, id_oficina, nombre, apellido, edad, fecha_nacimiento
, tipo_documento, nro_documento, cuil, direccion, nro_telefono_principal, nro_telefono_secundario
, email, cargo, antiguedad, fecha_ingreso, salario_anual ) values
(1, 1, 'marcos', 'Castro', 45, '1971/05/01', 'DNI', '48967156','33489671564', 'Figueroa Alcorta 22'
, '1178654356', '+5491178654356', 'marcosCastro2002_lop@hotmail.com', 'Agente Inmobiliario(Gerente)'
, 4, '2017/09/6', 150000 ),
(2, 1, 'Luciana', 'martinez', 23, '1999/07/12', 'DNI', '37997256', '32-37997256-9', 'Av. Corrientes 234'
, '11 74568399', '-', 'lu_martinez_trabajo@gmail.com', 'Administradora'
, 1, '2020/10/09', 55000 ),
(3, 1, 'José', 'bastituta', 34, '1988/09/07', 'DNI', '409876546', '12409876546-0', 'San Acrosio 15781'
, '1157670000', '+5491157670000', 'joseBastituta_88@gmail.com', 'Agente Inmobiliario(Vendedor)'
, 1, '2020/07/12', 65000 );

-- Oficina 2 (Edificio Torre Alem)
insert into empleados (id, id_oficina, nombre, apellido, edad, fecha_nacimiento
, tipo_documento, nro_documento, cuil, direccion, nro_telefono_principal, nro_telefono_secundario
, email, cargo, antiguedad, fecha_ingreso, salario_anual ) values
(4, 2, 'Damian', 'gutierrez', 39, '1978/09/14', 'DNI', '33869556', '20-33869556-3', 'Av Alberdi 05'
, '+5491176844456', '+5491157684445', 'damian_gut.756@gmail.com', 'Agente Inmobiliario(Gerente)'
, 3, '2018/3/4', 139000 ),
(5, 2, 'Marcelo', 'Perez', 28, '1988/03/17', 'DNI', '39345679', '12-39345679-9', 'Carabobo 06'
, '+5491138765433', '-', 'MarceloPerez@gmail.com', 'Administrador'
, 2, '2019/04/14', 56000 ),
(6, 2, 'Jimena', 'D Ambrosio', 37, '1991/11/06', 'DNI', '417896537', '2-417896537-2', 'Valentin Figueroa 33'
, '1175680377', '+5491175680338', 'lic_DAmbrosio@gmail.com', 'Agente Inmobiliario(Vendedora)'
, 3, '2018/08/14', 71000 );

-- Oficina 3 (Oficina Comercial Principal)
insert into empleados (id, id_oficina, nombre, apellido, edad, fecha_nacimiento
, tipo_documento, nro_documento, cuil, direccion, nro_telefono_principal, nro_telefono_secundario
, email, cargo, antiguedad, fecha_ingreso, salario_anual ) values
(7, 3, 'Sofia', 'Aguilar', 35, '1981/07/01', 'DNI', '33456733', '8-33456733-9', 'Av. Corrientes 2564'
, '1175678844', '+5491130928783', 'lic_sofiaAguilar@gmail.com', 'Agente Inmobiliario(Gerenta)'
, 3, '2018/08/02', 156000 ),
(8, 3, 'Luis', 'Gonzalez', 26, '1991/09/21', 'DNI', '397865432', '56-397865432-99', 'La Pampa 22'
, '+549113764522', '-', 'luisGonzalez_jsu@gmail.com', 'Administrador'
, 2, '2019/07/12', 50000 ),
(9, 3, 'Juan', 'Notowski', 41, '1988/02/21', 'DNI', '432765411', '22-432765411-93', 'Av Rivadavia 9100'
, '+5491175680827', '+5491175680827', 'notowski_Juan_7238@gmail.com', 'Agente Inmobiliario(Vendedor)'
, 2, '2019/04/22', 74000 );


-- ---------------------------------------------------------------------------

-- ======= TABLA GERENTES ===========

select * from gerentes;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'gerentes';

insert into gerentes (id, id_empleado, titulo, aneos_experiencia_laboral, competencias, beneficios
, retribucion_salarial_anual) values
(1, 1, 'Contador Público Universitario', 12.8, 'Planeamiento Eficiente, Ejecución Eficaz, Rendimiento'
,'Home Office 2 veces x sem, 35% Descuento Pack Viajes, Planes de Ahorro Viviendas', 32000),
(2, 4, 'Licenciado en Administración', 5.6, 'Organización, Gestión, Desempeño'
,'Horarios Flexibles, 35% Descuento Pack Viajes', 42000),
(3, 7, 'Licenciada en Marketing', 7.0, 'Ventas, Publicidad, Coordinación'
,'Horarios Flexibles y Días Extras de Descanso, 40% Descuento Pack Viajes', 35000);



-- ---------------------------------------------------------------------------

-- ======= TABLA ADMINISTRADORES ===========

select * from administradores;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'administradores';

-- tipo_inmueble --> casa, depto, etc

insert into administradores(id, id_empleado, tipo_inmueble, certificaciones, nivel_experiencia, cualidades)values
(1, 2, 'Departamento', 'Cert. Habilidades Aministrativas, Cert. Nivel 2 en Aministración de Cuentas'
,'Alto', 'Liderazgo y Negocición'),
(2, 5, 'Casa', 'Cert. Administración Viviendas, Cert. Tecnologías Digital, Cert. Servicios de Aministración'
,'Medio', 'Recursos Tecnológicos, Comunicación y Planificación'),
(3, 8, 'Departamento-Casa', 'Cert. Gestión Avanzada en Inmuebles, Cert. Especialista Apoyo Administrativo
, Cert. Aministración de Oficinas', 'Alto', 'Alta Flexibilidad, Marketing Digital y Planificación');


-- ---------------------------------------------------------------------------

-- ======= TABLA VENDEDORES ===========

select * from vendedores;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'vendedores';

--puntuacion_ventas --> Buena, Normal, Excelente

insert into vendedores(id, id_empleado, cantidad_ventas, bonificacion_ventas, puntuacion_ventas, 
orientacion_tipo_inmueble, cualidades) values
(1, 3, 0, 0, 'Sin Ventas', 'Departamento', 'Confianza, Dominio de Venta, Desarrollo Linguístico'),
(2, 6, 1, 2000, 'Buena', 'Casa', 'Ambición, Comercialización, Determinación'),
(3, 9, 2, 5000, 'Muy Buena', 'Departamento-Casa', 'Comunicación Eficaz, Creatividad, Convicción');






-- ---------------------------------------------------------------------------

-- ======= TABLA CLIENTES ===========

-- fecha_nacimiento date ejemplo '2001-10-07'
-- fecha_alta date ejemplo '2002-10-07'

select * from clientes;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'clientes';

insert into clientes(id, nombre, apellido, edad, fecha_nacimiento, tipo_documento, nro_documento
, direccion, nro_telefono_principal, nro_telefono_secundario, email, fecha_alta)values
(1, 'Rodrigo', 'Bustamante', 29, '1991-03-02', 'DNI', '36879254', 'Aristobulo del Valle 887'
, '+5491176534456', '3765-9978', 'rodrigo_bustamante@gmail.com', '2021-06-12'),
(2, 'Marcela', 'Pérez', 31, '1989-12-12', 'DNI', '33895854', 'Av. Callao 213'
, '+5491143534456', '+5491143534456', 'marcela_perez@gmail.com', '2020-03-06'),
(3, 'Jaime', 'Rodriguez', 48, '1977-02-16', 'DNI', '29937852', 'Av. La Pampa 218'
, '+5491183675544', '+5491183675544', 'jaime.CL_la@gmail.com', '2020-11-23');




-- ---------------------------------------------------------------------------

-- ======= TABLA CITAS_INMUEBLES ===========

-- ENUM estadoCita('PENDIENTE','COMPLETADA','INCOMPLETA');
-- fecha_cita date '2001-10-07'
-- hora_cita time '09:00:07'


select * from citas_inmuebles;


select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'citas_inmuebles';

insert into citas_inmuebles (id, id_inmueble, id_empleado, id_cliente, estado_cita
, descripcion_cita,  fecha_cita, hora_cita)values
(1, 3, 3, 1, 'INCOMPLETA', 'Cita Pendiente', '2020-03-01', '11:00:00' ),
(2, 2, 6, 2, 'COMPLETADA', 'Cita Finalizada y Venta Efectuada de Forma Exitosa', '2020-09-02', '09:15:00' ),
(3, 3, 3, 1, 'COMPLETADA', 'Venta Efectuada de Forma Exitosa', '2020-12-22', '08:30:00' );



-- ---------------------------------------------------------------------------


-- ======= TABLA COMPRADORES ===========

-- importe_maximo_por_compra_usd se considera en base a todas las compras 	
-- importe_total_compras_usd se considera la suma de todas las compras

select * from compradores;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'compradores';


insert into compradores(id, id_cliente, cantidad_inmuebles_comprados, importe_maximo_por_compra_usd
, importe_total_compras_usd, beneficios_compras, descuento_cliente_usd) values 
(1, 1, 1, 168000, 168000, 'Descuento del 7% en la Próxima Compra', 200),
(2, 2, 1, 110000, 110000, 'Descuento del 10% en la Próxima Compra',200);


-- ---------------------------------------------------------------------------

-- ======= TABLA VENTAS ===========
	
-- fecha_venta date '2001-10-07'
-- hora_venta time '09:00:07'


select * from ventas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'ventas';


insert into ventas(id, id_empleado, id_cliente, id_inmueble, fecha_venta, hora_venta, detalle_ventas) values
(1, 3, 1, 3, '2020-12-22', '08:30:00', 'Se Realiza la Venta luego de la Primera Cita Inconclusa'),
(2, 6, 2, 2, '2020-09-02', '09:15:00', 'La Venta del Inmueble fue de manera Exitosa');



-- ---------------------------------------------------------------------------

-- ======= TABLA FACTURAS ===========
	
-- fecha_venta date '2001-10-07'
-- hora_venta time '09:00:07'


select * from facturas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'facturas';

insert into facturas(id, id_venta, nro_factura, fecha_emision, hora_emision, precio_total_venta_usd)values
(1, 1, '00001-00000001', '2020-12-22', '08:30:00', 110000),
(2, 2, '00001-00000002', '2020-09-02', '09:15:00', 168000);



-- ---------------------------------------------------------------------------

-- ======= TABLA FACTURAS_DETALLES ===========

-- ENUM tipoFactura ('A','B','C','D');
-- ENUM tipoPago ('EFECTIVO','CHEQUE','TARJETA');



select * from facturas_detalles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'facturas_detalles';


insert into facturas_detalles (id, id_factura, tipo, descripcion_factura, valor_inmueble_usd
, costo_asociado_usd, impuestos_asociados_usd, medio_de_pago, descripcion_pago) values
(1, 1, 'A', 'Venta de Inmueble Tipo Departamento de 2 Ambientes Zona Caballito', 109000, 800, 200
, 'EFECTIVO', 'Se efectuó la compra en 1 sólo Pago'),
(2, 2, 'A', 'Venta de Inmueble Tipo Casa de 3 Ambientes Zona Belgrano', 167000, 600, 400
, 'CHEQUE', 'Se efectuó la compra a Pagar en 3 Pagos');






