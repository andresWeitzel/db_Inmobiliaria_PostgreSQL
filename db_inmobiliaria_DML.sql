/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= DML =============
 */



select * from inmuebles;

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


-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES_DESCRIPCIONES ===========


select * from inmuebles_descripciones;

select column_name, data_type, is_nullable from
information_schema.columns where table_name = 'inmuebles_descripciones';


-- ---------------------------------------------------------------------------

-- ======= TABLA INMUEBLES_MEDIDAS ===========


select * from inmuebles_medidas;

select column_name, data_type, is_nullable from 
information_schema.columns where table_name = 'inmuebles_medidas';



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
