/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML =============
 */




select * from inmuebles_marketing;
select * from servicios_inmuebles;
select * from inspecciones_inmuebles;
select * from citas_inmuebles;
select * from administradores;
select * from gerentes;
select * from vendedores;
select * from compradores;
select * from compradores_clientes;
select * from ventas_compras;
select * from facturas;
select * from facturas_detalles;



-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS ===========

select * from oficinas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'oficinas';


insert into oficinas (id, nombre, direccion, telefono, email) values 
(1 , 'Torre Nepkiul' , 'Paraguay 780' , '+54 11 5279-4790' , 'inmobiliariaDuckson@gmail.com'),
(2 , 'Edificio Torre Alem' , 'Alem Leandro Niceforo N°955 - Piso 13' , '+54 11 61147000' , 'inmobiliariaDuckson@gmail.com'),
(3 , 'Oficina Comercial Principal' , 'Callao 255, Centro / Microcentro' , '011 5653-1799' , 'inmobiliariaDuckson@gmail.com');



-- ---------------------------------------------------------------------------

-- ======= TABLA OFICINAS_DETALLES ===========

select * from oficinas_detalles;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'oficinas_detalles';


insert into oficinas_detalles (id, id_oficina, localidad, tipo_oficina, estado_oficina, superficie_total
, cantidad_ambientes, cantidad_baños, antiguedad, sitio_web) values
(1 , 1 , 'Retiro' , 'EJECUTIVA' , 'ALQUILADA' , 140.0 , 6 , 4 , 15 , 'www.inmobiliariaDuckson-torre-Nepkiul.com.ar'),-- sup_total en m^2
(2 , 2 , 'Belgrano' , 'PEQUEÑA' , 'PROPIA' , 35.0 , 1 , 1 , 35 , 'www.inmobiliariaDuckson-torre-Alem.com.ar'),
(3 , 3 , 'Balvanera' , 'ESTANDAR' , 'PROPIA' , 60.0 , 2 , 4 , 22 , 'www.inmobiliariaDuckson-oficina-principal.com.ar');


-- ---------------------------------------------------------------------------

-- ======= TABLA PROPIETARIOS_INMUEBLES ===========

select * from propietarios_inmuebles;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'propietarios_inmuebles';

insert into propietarios_inmuebles (id, nombre, apellido, edad, fecha_nacimiento, tipo_documento, nro_documento
,direccion, telefono_principal, telefono_secundario , email) values
(1, 'Fabian', 'Gonzalez', 45, '1975/10/09', 'DNI', 45897677, 'San Vicente 879', '+5491156749874', '6578-3786', 'viccentin3k@gmail.com'),
(2, 'Guillermo', 'Zulenski', 65, '1955/10/09', 'DNI', 35897677, 'Av. Calloa 879', '+5491156788', '+5491156788', 'zulenskiVentas2019@gmail.com');



-- https://inmueble.mercadolibre.com.ar/MLA-1106193666-ph-sin-expensas-_JM#position=2&search_layout=grid&type=item&tracking_id=7d3f63be-4762-490b-a886-4cd1ac9c00a6

-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES_DESCRIPCIONES ===========


select * from inmuebles_descripciones;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'inmuebles_descripciones';

-- 254.8m^2, 198.9m^2,  4 ambientes, 3 dormis, 2 baños, 1 patio, 1 cochera, 1 balcon, 50 años antiguedad

insert into inmuebles_descripciones (id, superficie_total, superficie_cubierta, cantidad_ambientes, cantidad_dormitorios
, cantidad_baños , cantidad_patios_jardines, cantidad_cocheras, cantidad_balcones, antiguedad) values 
(1, 265.8, 198.9 , 4, 3, 2, 1, 1, 1, 50 ), 
(2, 185.8, 185.8 , 3, 4, 1, 0, 1, 0, 80 ),
(3, 97.8, 60.3 , 2, 3, 2, 1, 0, 1, 30 );

-- ---------------------------------------------------------------------------
/*
-- ======= TABLA INMUEBLES_MEDIDAS ===========


select * from inmuebles_medidas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles_medidas';

-- Dormitorio 1: 23 x 2,9 | Dormitorio 2: 43 x 1,9
-- ALTO X ANCHO

insert into inmuebles_medidas(id, living_comedor, cocina, dormitorio, baño, patio_jardin, cochera, balcon) values 
(1, '17.0 x 5.9' , '6.0 x 4.0' , 'Dormitorio1: 5.0 x 5.0 , Dormitorio2: 7.0 x 4.0 , Dormitorio3: 6.0 x 6.0', ),



-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES ===========


select * from inmuebles;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'inmuebles';


-- ---------------------------------------------------------------------------

-- ======= TABLA EMPLEADOS ===========

select * from empleados;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'empleados';



-- ---------------------------------------------------------------------------

-- ======= TABLA CLIENTES ===========

select * from clientes;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'clientes';
*/