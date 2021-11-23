
/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DDL =============
 */



-- Tablas
drop table if exists inmuebles cascade;
drop table if exists inmuebles_descripciones cascade;
drop table if exists inmuebles_medidas cascade;
drop table if exists inmuebles_marketing cascade;
drop table if exists servicios_inmuebles cascade;
drop table if exists inspecciones_inmuebles cascade;
drop table if exists citas_inmuebles cascade;
drop table if exists propietarios_inmuebles cascade;
drop table if exists facturas cascade;
drop table if exists facturas_detalles cascade;
drop table if exists ventas cascade;
drop table if exists administradores cascade; -- planeacion, organizacion, etc
drop table if exists gerentes cascade;-- metas y procedimientos, control administracion
drop table if exists vendedores cascade;-- ventas inmuebles, entrevistas, etc
drop table if exists compradores cascade;
drop table if exists clientes cascade;
drop table if exists empleados cascade;
drop table if exists oficinas cascade;
drop table if exists oficinas_detalles cascade;

-- Todos lo id PK auto_increment
drop sequence if exists id_secuencia cascade;


-- Enumerados tabla oficinas_detalles
drop type if exists estado_oficina cascade;
drop type if exists tipo_oficina cascade;

-- Enumerados tabla inspecciones_inmuebles
drop type if exists tipo_inspeccion cascade;
drop type if exists estado_inspeccion cascade;

-- Enumerados tabla inmuebles
drop type if exists estado_inmueble cascade;

-- Enumerados tabla servicios_inmuebles
drop type if exists division_comercial cascade;
drop type if exists division_vivienda cascade;
drop type if exists tasaciones cascade;
drop type if exists administracion cascade;

-- Enumerados tabla citas_inmuebles
drop type if exists estado_cita cascade;


-- Enumerados tabla facturas_detalles
drop type if exists tipo_factura cascade;
drop type if exists tipo_pago cascade;

-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS ===========

create table oficinas(
	
id int primary key,
nombre varchar(30) not null,
direccion varchar(60) not null,
nro_telefono varchar(40) not null,
email varchar(60)

);

-- ======= Restricciones Tabla Oficinas ===========

-- UNIQUE ID
alter table oficinas 
add constraint UNIQUE_oficinas_id
unique(id);

-- UNIQUE DIRECCION
alter table oficinas 
add constraint UNIQUE_oficinas_direccion
unique(direccion);

-- UNIQUE TELEFONO
alter table oficinas 
add constraint UNIQUE_oficinas_nro_telefono
unique(nro_telefono);

-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS_DETALLES ===========

create type estado_oficina as enum('ALQUILADA','PROPIA'); 
create type tipo_oficina as enum('PEQUEÑA','ESTANDAR','EJECUTIVA'); 


create table oficinas_detalles(
	
id int primary key,
id_oficina int ,
localidad varchar(40) not null,
tipo_oficina tipo_oficina not null, 
estado_oficina estado_oficina not null,
superficie_total decimal(8,2) not null,
cantidad_ambientes smallint not null, -- 1,2,3,etc | smallint-->2bytes, int-->4bytes |
cantidad_sanitarios smallint not null, -- Reemplazamos baños por caracter especial
antiguedad smallint, -- 20 años, etc
sitio_web varchar(80)

);

-- ======= Restricciones Tabla oficinas_detalles ===========

-- UNIQUE ID
alter table oficinas_detalles 
add constraint UNIQUE_oficinas_detalles_id
unique(id);

-- UNIQUE ID_OFICINA
alter table oficinas_detalles 
add constraint UNIQUE_oficinas_detalles_id_oficina
unique(id_oficina);

-- FK ID_OFICINA
alter table oficinas_detalles 
add constraint FK_oficinas_detalles_id_oficina
foreign key(id_oficina)
references oficinas(id);

-- CHECK SUPERFICIE_TOTAL
alter table oficinas_detalles
add constraint CHECK_oficinas_detalles_superficie_total
check (superficie_total > 0 );


-- CHECK CANTIDAD AMBIENTES
alter table oficinas_detalles
add constraint CHECK_oficinas_detalles_cantidad_ambientes
check (cantidad_ambientes > 0 );


-- CHECK CANTIDAD SANITARIOS
alter table oficinas_detalles
add constraint CHECK_oficinas_detalles_cantidad_sanitarios
check (cantidad_sanitarios > 0 );


-- CHECK ANTIGUEDAD
alter table oficinas_detalles
add constraint CHECK_oficinas_detalles_antiguedad
check (antiguedad >= 0 or antiguedad = null ); -- Puede ser nulleable


-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------


-- ======= TABLA EMPLEADOS ===========

create table empleados(
	
id int primary key,
id_oficina int not null,
nombre varchar(30) not null,
apellido varchar(30) not null,
edad int not null,
fecha_nacimiento date not null,
tipo_documento varchar(50) not null, -- Pasaporte, LE(libreta enrolamiento),LC(libreta civica)
nro_documento varchar(20) not null,
cuil varchar(30) not null, -- Si no tiene DNI, cuil provisorio
direccion varchar(40) not null, 
nro_telefono_principal varchar(40) not null,
nro_telefono_secundario varchar(40),
email varchar(40),
cargo varchar(40) not null,
antiguedad int,
fecha_ingreso date not null,
salario_anual decimal(10,2) not null


);

-- ======= Restricciones Tabla Empleados ===========

-- UNIQUE ID
alter table empleados 
add constraint UNIQUE_empleados_id
unique(id);

-- FK ID_OFICINA
alter table empleados 
add constraint FK_empleados_id_oficina
foreign key(id_oficina)
references oficinas(id);


-- UNIQUE NOMBRE/APELLIDO
alter table empleados 
add constraint UNIQUE_empleados_nombre_apellido
unique(nombre,apellido);


-- CHECK EDAD
alter table empleados 
add constraint CHECK_empleados_edad
check (edad >= 18);

-- CHECK ANTIGUEDAD
alter table empleados 
add constraint CHECK_empleados_antiguedad
check (antiguedad >= 0 or antiguedad=null);

--- UNIQUE NRO_DOCUMENTO
alter table empleados 
add constraint UNIQUE_empleados_nro_documento
unique(nro_documento);


-- UNIQUE TELEFONO
alter table empleados
add constraint UNIQUE_empleados_nro_telefono_principal
unique(nro_telefono_principal);


-- CHECK FECHA_NACIMIENTO Y FECHA_INGRESO
alter table empleados 
add constraint CHECK_empleados_fecha_nacimiento_ingreso
check (current_date > fecha_nacimiento and current_date >= fecha_ingreso );

-- CHECK SALARIO_ANUAL
alter table empleados 
add constraint CHECK_empleados_salario_anual
check (salario_anual > 300);



-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA CLIENTES ===========

create table clientes(
	
id int primary key,
nombre varchar(30) not null,
apellido varchar(30) not null,
edad int not null,
fecha_nacimiento date not null,
tipo_documento varchar(20) not null,
nro_documento varchar(20) not null,
direccion varchar(40) not null, 
nro_telefono_principal varchar(40) not null,
nro_telefono_secundario varchar(40),
email varchar(40),
fecha_alta date not null


);

-- ======= Restricciones Tabla clientes ===========

-- UNIQUE ID
alter table clientes 
add constraint UNIQUE_clientes_id
unique(id);


-- UNIQUE NOMBRE/APELLIDO
alter table clientes 
add constraint UNIQUE_clientes_nombre_apellido
unique(nombre,apellido);


-- CHECK EDAD
alter table clientes 
add constraint CHECK_clientes_edad
check (edad >= 18);


-- UNIQUE TELEFONO
alter table clientes
add constraint UNIQUE_clientes_nro_telefono_principal
unique(nro_telefono_principal);



--- UNIQUE NRO_DOCUMENTO
alter table clientes 
add constraint UNIQUE_clientes_nro_documento
unique(nro_documento);


-- CHECK FECHA_NACIMIENTO Y FECHA_ALTA
alter table clientes 
add constraint CHECK_clientes_fecha_nacimiento_alta
check (current_date > fecha_nacimiento and current_date >= fecha_alta );



-- ---------------------------------------------------------------------------




-- ---------------------------------------------------------------------------

-- ======= TABLA PROPIETARIOS_INMUEBLES ===========


create table propietarios_inmuebles(

id int primary key,
nombre varchar(40) not null,
apellido varchar(40) not null,
edad int not null,
fecha_nacimiento date not null,
tipo_documento varchar(20) not null,
nro_documento varchar(20) not null,
direccion varchar(40) not null, 
nro_telefono_principal varchar(40) not null,
nro_telefono_secundario varchar(40),
email varchar(40)

);

-- ======= Restricciones Tabla propietarios_inmuebles ===========

-- UNIQUE ID
alter table propietarios_inmuebles 
add constraint UNIQUE_propietarios_inmuebles_id
unique(id);



-- UNIQUE NOMBRE/APELLIDO
alter table propietarios_inmuebles 
add constraint UNIQUE_propietarios_inmuebles_nombre_apellido
unique(nombre,apellido);


-- CHECK EDAD
alter table propietarios_inmuebles 
add constraint CHECK_propietarios_inmuebles_edad
check (edad >= 18);


-- UNIQUE TELEFONO
alter table propietarios_inmuebles
add constraint UNIQUE_propietarios_inmuebles_nro_telefono_principal
unique(nro_telefono_principal);



-- CHECK FECHA_NACIMIENTO
alter table propietarios_inmuebles 
add constraint CHECK_propietarios_inmuebles_fecha_nacimiento
check (current_date > fecha_nacimiento);


--- UNIQUE NRO_DOCUMENTO
alter table propietarios_inmuebles 
add constraint UNIQUE_propietarios_inmuebles_nro_documento
unique(nro_documento);



-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA INMUEBLES DESCRIPCIONES ===========


create table inmuebles_descripciones(
	
id int primary key,
superficie_total decimal(8,2) not null,-- ej: 92 m^2 Total.
superficie_cubierta decimal(8,2) not null,-- ej: 72 m^2 Total.
cantidad_ambientes smallint not null, -- 1,2,3,etc | smallint-->2bytes, int-->4bytes |
cantidad_dormitorios smallint not null,-- 1,2,3
cantidad_sanitarios smallint not null,-- 1,2,3 reemplazamos baños, por el caracter especial
cantidad_patios_jardines smallint , -- patio casa, jardin piso/semipiso
cantidad_cocheras smallint ,-- si no tiene  0 o null
cantidad_balcones smallint ,-- si no tiene  0 o null
antiguedad smallint -- 20 años, etc

);


-- ======= Restricciones Tabla Inmuebles Descripción ===========

-- UNIQUE ID
alter table inmuebles_descripciones
add constraint UNIQUE_inmuebles_descripciones_id
unique(id);


-- CHECK SUPERFICIE_TOTAL
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_superficie_total
check (superficie_total > 0 );

-- CHECK SUPERFICIE_CUBIERTA
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_superficie_cubierta
check (superficie_total >= superficie_cubierta );


-- CHECK CANTIDAD AMBIENTES
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_ambientes
check (cantidad_ambientes > 0 );

-- CHECK CANTIDAD DORMITORIOS
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_dormitorios
check (cantidad_dormitorios > 0 );

-- CHECK CANTIDAD SANITARIOS
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_sanitarios
check (cantidad_sanitarios > 0 );

-- CHECK CANTIDAD PATIOS/JARDINES
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_patios_jardines
check (cantidad_patios_jardines >= 0 or cantidad_patios_jardines = null );

-- CHECK CANTIDAD COCHERAS
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_cocheras
check (cantidad_cocheras >= 0 or cantidad_cocheras = null ); -- Puede ser nulleable

-- CHECK CANTIDAD BALCONES
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_cantidad_balcones
check (cantidad_balcones >= 0 or cantidad_balcones = null ); -- Puede ser nulleable

-- CHECK ANTIGUEDAD
alter table inmuebles_descripciones
add constraint CHECK_inmuebles_descripciones_antiguedad
check (antiguedad >= 0 or antiguedad = null ); -- Puede ser nulleable

-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES MEDIDAS ===========
-- Pueden no estar estipuladas

create table inmuebles_medidas(-- ALTO X ANCHO

id int primary key,
living_comedor varchar(100),-- ej: 8,05 x 3,4
cocina varchar(100), -- Cocina 1: 3,25 x 1,55
dormitorio varchar(100), -- Dormitorio 1: 23 x 2,9 | Dormitorio 2: 43 x 1,9
sanitario varchar(100),
patio_jardin varchar(100),
cochera varchar(50),
balcon varchar(50)

);


-- ======= Restricciones Tabla inmuebles_medidas ===========

-- UNIQUE ID
alter table inmuebles_medidas
add constraint UNIQUE_inmuebles_medidas_id
unique(id);



-- ---------------------------------------------------------------------------




-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES ===========


create type estado_inmueble as enum('VENDIDO','DISPONIBLE','NO DISPONIBLE','FALTA INSPECCION');


create table inmuebles(
	
id int primary key,
id_propietario_inmueble int not null,
id_inmueble_medidas int not null,
id_inmueble_descripcion int not null,
id_oficina int not null,
descripcion varchar(200) not null,-- ej: semipiso de 3 Amb en Palermo
tipo varchar(20) not null, -- depto, casa, etc
estado_inmueble estado_inmueble not null,
precio_inmueble_usd decimal(10,2) not null,
direccion varchar(40) not null,-- San sarasa 123
ubicacion varchar(40) not null, -- zona:palermo, recoleta, etc
sitioWeb varchar(40)-- link de la pag de la descripcion

);

-- ======= Restricciones Tabla inmuebles ===========

-- UNIQUE ID
alter table inmuebles 
add constraint UNIQUE_inmuebles_id
unique(id);

-- UNIQUE ID_INMUEBLE_MEDIDAS
alter table inmuebles
add constraint UNIQUE_inmuebles_id_inmueble_medidas
unique(id_inmueble_medidas);


-- UNIQUE ID_INMUEBLE_DESCRIPCION
alter table inmuebles
add constraint UNIQUE_inmuebles_id_inmueble_descripcion
unique(id_inmueble_descripcion);


-- FK ID_INMUEBLES_MEDIDAS
alter table inmuebles
add constraint FK_inmuebles_id_inmueble_medidas
foreign key(id_inmueble_medidas)
references inmuebles_medidas(id);

-- FK ID_INMUEBLE_DESCRIPCIONES
alter table inmuebles
add constraint FK_inmuebles_id_inmueble_descripciones
foreign key(id_inmueble_descripcion)
references inmuebles_descripciones(id);

--FK ID_PROPIETARIO_INMUEBLE
alter table inmuebles 
add constraint FK_inmuebles_id_propietario_inmueble
foreign key(id_propietario_inmueble)
references propietarios_inmuebles(id);


--FK ID_OFICINA
alter table inmuebles 
add constraint FK_inmuebles_id_oficina
foreign key(id_oficina)
references oficinas(id);

-- CHECK PRECIO_INMUEBLE_USD
alter table inmuebles
add constraint CHECK_inmuebles_precio_inmueble_usd
check (precio_inmueble_usd > 0);




-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------

-- ======= TABLA CITAS_INMUEBLES ===========

create type estado_cita as enum('PENDIENTE','COMPLETADA','INCOMPLETA');


create table citas_inmuebles(
	
id int primary key,
id_inmueble int not null,
id_empleado int NOT NULL,-- Puede ser un gerente o vendedor
id_cliente int NOT null,-- Si hay cita automaticamente pasa a ser un cliente
estado_cita estado_cita not null,
descripcion_cita varchar(200) not null,
fecha_cita date NOT null,-- ej '2001-10-07'
hora_cita time NOT NULL  -- ej '09:00:07'

);

-- ======= Restricciones Tabla citas_inmuebles ===========

-- UNIQUE ID
alter table citas_inmuebles 
add constraint UNIQUE_citas_inmuebles_id
unique(id);


-- FK ID_INMUEBLE
alter table citas_inmuebles
add constraint FK_citas_inmuebles_id_inmueble
foreign key(id_inmueble)
REFERENCES inmuebles(id);


-- FK ID_EMPLEADO
alter table citas_inmuebles
add constraint FK_citas_inmuebles_id_empleado
foreign key(id_empleado)
REFERENCES empleados(id);


-- FK ID_CLIENTE
alter table citas_inmuebles
add constraint FK_citas_inmuebles_id_cliente
foreign key(id_cliente)
REFERENCES clientes(id);

-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------

-- ======= TABLA SERVICIOS_INMUEBLES ===========
-- https://www.mosquerabrokers.com.ar/es/informacion/servicios

create type division_comercial as enum('LOCALES','OFICINAS','TERRENOS'
,'LOCALES-OFICINAS-TERRENOS','NO APLICA');

create type division_vivienda as enum('DEPARTAMENTOS','CASAS','TERRENOS'
,'DEPARTAMENTOS-CASAS-TERRENOS','NO APLICA');

create type tasaciones as enum('PROFESIONAL','JUDICIAL','PROFESIONAL-JUDICIAL'
,'NO APLICA');

create type administracion as enum('ALQUILERES','CUENTAS','ALQUILERES-CUENTAS' 
,'NO APLICA');


create table servicios_inmuebles(
	
id int primary key,
id_oficina int not null,
tipo_comercial division_comercial not null,
tipo_vivienda division_vivienda not null,
tipo_tasaciones tasaciones not null,
tipo_administracion administracion not null,
descripcion_servicios varchar(200)

);

-- ======= Restricciones Tabla servicios_inmuebles ===========

-- UNIQUE ID
alter table servicios_inmuebles 
add constraint UNIQUE_servicios_inmuebles_id
unique(id);


-- FK ID_OFICINA
alter table servicios_inmuebles
add constraint FK_servicios_inmuebles_id_oficina
foreign key(id_oficina)
references oficinas(id);


-- ---------------------------------------------------------------------------




-- ---------------------------------------------------------------------------

-- ======= TABLA INSPECCIONES_INMUEBLES ===========
-- http://checkhouse.com.ar/inspecciones-para-inquilinos/#amenities-content

create type estado_inspeccion as enum('ACEPTADA','NO ACEPTADA','PENDIENTE REVISION');
create type tipo_inspeccion as enum('DEPARTAMENTO','CASA','PH');

create table inspecciones_inmuebles(
	
id int primary key,
id_inmueble int not null,
estado_inspeccion estado_inspeccion not null,
tipo_inspeccion tipo_inspeccion not null,
descripcion_inspeccion varchar(200) not null,
empresa varchar(30) not null,
direccion varchar(30) not null,
nro_telefono varchar(30) not null,
costo decimal(10,2) not null,
fecha date not null,-- ej '2001-10-07'
hora time not null  -- ej '09:00:07'

);

-- ======= Restricciones Tabla inspecciones_inmuebles ===========

-- UNIQUE ID
alter table inspecciones_inmuebles 
add constraint UNIQUE_inspecciones_inmuebles_id
unique(id);


-- FK ID_INMUEBLE
alter table inspecciones_inmuebles
add constraint FK_inspecciones_inmuebles_id_inmueble
foreign key(id_inmueble)
references inmuebles(id);

-- CHECK COSTO
alter table inspecciones_inmuebles
add constraint CHECK_inspecciones_inmuebles_costo
check(costo > 0);


-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------


-- ======= TABLA INMUEBLES_MARKETING===========


create table inmuebles_marketing(
	
id int primary key,
id_inmueble int not null,
tipo_anuncio_principal varchar(50) not null,
tipo_anuncio_secundario varchar(50),
descripcion_anuncio varchar(100) not null,
inversion_total decimal(8,2) not null
);

-- ======= Restricciones Tabla inmuebles_marketing ===========

-- UNIQUE ID
alter table inmuebles_marketing
add constraint UNIQUE_inmuebles_marketing_id
unique(id);


-- FK ID_INMUEBLES
alter table inmuebles_marketing
add constraint FK_inmuebles_marketing_id_inmueble
foreign key(id_inmueble)
references inmuebles(id);

-- CHECK INVERSION_TOTAL
alter table inmuebles_marketing
add constraint CHECK_inmuebles_marketing_inversion_total
check(inversion_total > 0);


-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------


-- ======= TABLA ADMINISTRADORES ===========

create table administradores(
	
id int primary key,
id_empleado int not null,
tipo_inmueble varchar(20),-- casa, depto, etc
certificaciones varchar(200),-- administracion zonas residenciales, rurales, etc
nivel_experiencia varchar(30),-- bueno,alto,excelente
cualidades varchar(100)-- flexibilidad, confianza,etc

);

-- ======= Restricciones Tabla Administradores ===========

-- UNIQUE ID
alter table administradores 
add constraint UNIQUE_administradores_id
unique(id);

-- UNIQUE ID_EMPLEADO
alter table administradores 
add constraint UNIQUE_administradores_id_empleado
unique(id_empleado);

-- FK ID_EMPLEADO
alter table administradores
add constraint FK_administradores_id_empleado
foreign key(id_empleado)
references empleados(id);

-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------


-- ======= TABLA GERENTES ===========

-- Cargo de Directores, etc

create table gerentes(
	
id int primary key,
id_empleado int not null,
titulo varchar(30) not null,
aneos_experiencia_laboral decimal(4,2) not null, -- ej 1.2 años, etc
competencias varchar(100),-- planeamiento Estrategico, comunicacion efectiva, liderazgo, trabajo en equipo, orientacion a resultados,etc  
beneficios varchar(100),--Viajes, Horario flexible, home office,etc 
retribucion_salarial_anual decimal(8,2) not null 

);

-- ======= Restricciones Tabla Gerentes ===========

-- UNIQUE ID
alter table gerentes 
add constraint UNIQUE_gerentes_id
unique(id);

-- UNIQUE ID_EMPLEADO
alter table gerentes 
add constraint UNIQUE_gerentes_id_empleado
unique(id_empleado);

-- FK ID_EMPLEADO
alter table gerentes
add constraint FK_gerentes_id_empleado
foreign key(id_empleado)
references empleados(id);


-- CHECK EXPERIENCIA_LABORAL
alter table gerentes 
add constraint CHECK_gerentes_aneos_expericia_laboral
check ( aneos_experiencia_laboral >= 2);-- 2 años


-- CHECK MONTO_ADICIONAL
alter table gerentes
add constraint CHECK_gerentes_retribucion_salarial_anual
check ( retribucion_salarial_anual > 0);


-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA VENDEDORES ===========

create table vendedores(
	
id int primary key,
id_empleado int not null,
cantidad_ventas int not null,
bonificacion_ventas decimal(8,2),
puntuacion_ventas varchar(20),-- buena, normal, excelente
orientacion_tipo_inmueble varchar(30),-- casa, depto, etc
cualidades varchar(100)-- flexibilidad, confianza,etc

);

-- ======= Restricciones Tabla vendedores ===========

-- UNIQUE ID
alter table vendedores 
add constraint UNIQUE_vendedores_id
unique(id);

-- UNIQUE ID_EMPLEADO
alter table vendedores 
add constraint UNIQUE_vendedores_id_empleado
unique(id_empleado);

-- FK ID_EMPLEADO
alter table vendedores 
add constraint FK_vendedores_id_empleado
foreign key(id_empleado)
references empleados(id);


-- CHECK CANTIDAD_VENTAS
alter table vendedores 
add constraint CHECK_vendedores_cantidad_ventas
check ( cantidad_ventas >= 0);

-- CHECK BONIFICACION_VENTAS
alter table vendedores 
add constraint CHECK_vendedores_bonificacion_ventas
check ( bonificacion_ventas >= 0);


-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------


-- ======= TABLA COMPRADORES ===========

-- importe_maximo_por_compra_usd se considera en base a todas las compras 	
-- importe_total_compras_usd se considera la suma de todas las compras

create table compradores(
	
id int primary key,
id_cliente int not null,
cantidad_inmuebles_comprados int not null,
importe_maximo_por_compra_usd decimal(8,2) not null,
importe_total_compras_usd decimal(8,2) not null,
beneficios_compras varchar(100) not null,
descuento_cliente_usd decimal(8,2) not null
);

-- ======= Restricciones Tabla compradores ===========


-- UNIQUE ID
alter table compradores
add constraint UNIQUE_compradores_id
unique(id);


-- UNIQUE ID_CLIENTE
alter table compradores
add constraint UNIQUE_compradores_id_cliente
unique(id_cliente);


-- FK ID_CLIENTE
alter table compradores
add constraint FK_compradores_id_cliente
foreign key(id_cliente)
references clientes(id);


-- CHECK CANTIDAD_INMUEBLES_COMPRADOS
alter table compradores 
add constraint CHECK_compradores_cantidad_inmuebles_comprados
check ( cantidad_inmuebles_comprados > 0);

-- CHECK IMPORTE_MAXIMO_POR_COMPRA
alter table compradores
add constraint CHECK_compradores_importe_maximo_por_compra_usd
check ( importe_maximo_por_compra_usd > 0);


-- CHECK IMPORTE_TOTAL_COMPRAS
alter table compradores
add constraint CHECK_compradores_importe_total_compras_usd
check ( importe_total_compras_usd > 0);


-- CHECK DESCUENTO_CLIENTE
alter table compradores
add constraint CHECK_compradores_descuento_cliente_usd
check ( descuento_cliente_usd >= 0);



-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------


-- ======= TABLA VENTAS ===========

create table ventas(
	
id int primary key,
id_empleado int not null,
id_cliente int not null,
id_inmueble int not null,
fecha_venta date not null,-- ej '2001-10-07'
hora_venta time not null, -- ej  '09:00:07'
detalle_ventas varchar(100) not null

);

-- ======= Restricciones Tabla ventas ===========

-- UNIQUE ID
alter table ventas
add constraint UNIQUE_ventas_id
unique(id);

-- FK ID_EMPLEADO
alter table ventas 
add constraint FK_ventas_id_empleado
foreign key(id_empleado)
references empleados(id);

-- FK ID_CLIENTE
alter table ventas
add constraint FK_ventas_id_cliente
foreign key(id_cliente)
references clientes(id);

-- FK ID_INMUEBLE
alter table ventas 
add constraint FK_ventas_id_inmuebles
foreign key(id_inmueble)
references inmuebles(id);


-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------


-- ======= TABLA FACTURAS ===========

create table facturas(
	
id int primary key,
id_venta int not null,
nro_factura varchar(30) not null,
fecha_emision date not null,-- ej '2001-10-07'
hora_emision time not null,  -- ej '09:00:07'
precio_total_venta_usd decimal(10,2) not null -- + impuestos + costos + etc

);

-- ======= Restricciones Tabla facturas ===========

-- UNIQUE ID
alter table facturas 
add constraint UNIQUE_facturas_id
unique(id);

-- FK ID_VENTA
alter table facturas 
add constraint FK_facturas_id_venta
foreign key(id_venta)
references ventas(id);

-- UNIQUE ID_VENTA
alter table facturas 
add constraint UNIQUE_facturas_id_venta
unique(id_venta);

-- CHECK PRECIO_TOTAL_VENTA_USD
alter table facturas
add constraint CHECK_facturas_precio_total_venta_usd
check ( precio_total_venta_usd > 0);


-- ---------------------------------------------------------------------------



-- ---------------------------------------------------------------------------

-- ======= TABLA FACTURAS_DETALLES ===========

-- Los enumerados deben estar declarados fuera de la creacion de tabla 

create type tipo_factura as enum('A','B','C','D');
create type tipo_pago as enum('EFECTIVO','CHEQUE','TARJETA');



create table facturas_detalles(
	
id int primary key,
id_factura int not null,
tipo tipo_factura not null, -- A,C ETC
descripcion_factura varchar(100) not null,-- venta departamento inscripto en la partida N° 14567..
valor_inmueble_usd decimal(10,2) not null,-- Valor Real del Inmueble sin impuestos, etc
costo_asociado_usd decimal(8,2) not null, -- Escritura del vendedor, sellos, comisiones, etc 
impuestos_asociados_usd decimal(8,2) not null, -- IVA 10%, imp a las ganancias, imp tranf. de inmuebles, etc
medio_de_pago tipo_pago not null,
descripcion_pago varchar(100) not null

);

-- ======= Restricciones Tabla facturas_detalles ===========

-- UNIQUE ID
alter table facturas_detalles
add constraint UNIQUE_facturas_detalles_id
unique(id);

-- UNIQUE ID_FACTURA
alter table facturas_detalles
add constraint UNIQUE_facturas_detalles_id_factura
unique(id_factura);

-- FK ID_FACTURA
alter table facturas_detalles 
add constraint FK_facturas_detalles_id_factura
foreign key(id_factura)
references facturas(id);


-- CHECK VALOR_INMUEBLE_USD
alter table facturas_detalles
add constraint CHECK_facturas_detalles_valor_inmueble_usd
check ( valor_inmueble_usd > 0);


-- CHECK COSTO_ASOCIADO_USD
alter table facturas_detalles
add constraint CHECK_facturas_detalles_costo_asociado_usd
check( costo_asociado_usd > 0);

-- CHECK IMPUESTOS_ASOCIADOS_USD
alter table facturas_detalles
add constraint CHECK_facturas_detalles_impuestos_asociados_usd
check( impuestos_asociados_usd > 0);


-- ---------------------------------------------------------------------------

-- -------------------------------------------------------------------






-- ======== TODOS LOS ID´S PK DE LAS TABLAS COMO AUTO_INCREMENT =======

CREATE SEQUENCE id_secuencia;

alter table oficinas alter id set default nextval('id_secuencia');
alter table oficinas_detalles alter id set default nextval('id_secuencia');
alter table inmuebles alter id set default nextval('id_secuencia');
alter table inmuebles_descripciones alter id set default nextval('id_secuencia');
alter table inmuebles_medidas alter id set default nextval('id_secuencia');
alter table inmuebles_marketing alter id set default nextval('id_secuencia');
alter table servicios_inmuebles alter id set default nextval('id_secuencia');
alter table inspecciones_inmuebles alter id set default nextval('id_secuencia');
alter table citas_inmuebles alter id set default nextval('id_secuencia');
alter table propietarios_inmuebles alter id set default nextval('id_secuencia');
alter table empleados alter id set default nextval('id_secuencia');
alter table clientes alter id set default nextval('id_secuencia');
alter table administradores alter id set default nextval('id_secuencia');
alter table gerentes alter id set default nextval('id_secuencia');
alter table vendedores alter id set default nextval('id_secuencia');
alter table compradores alter id set default nextval('id_secuencia');
alter table ventas alter id set default nextval('id_secuencia');
alter table facturas alter id set default nextval('id_secuencia');
alter table facturas_detalles alter id set default nextval('id_secuencia');



-- -------------------------------------------------------------------


-- ---------------------------------------------------------------------------

/*

select * from pg_catalog.pg_tables 
where  schemaname != 'information_schema' 
and schemaname != 'pg_catalog';
 
 
select * from oficinas;
select * from oficinas_detalles;
select * from inmuebles;
select * from inmuebles_descripciones;
select * from inmuebles_medidas;
select * from inmuebles_marketing;
select * from servicios_inmuebles;
select * from inspecciones_inmuebles;
select * from citas_inmuebles;
select * from propietarios_inmuebles;
select * from empleados;
select * from clientes;
select * from administradores;
select * from gerentes;
select * from vendedores;
select * from compradores;
select * from ventas;
select * from facturas;
select * from facturas_detalles;

*/






