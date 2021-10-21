/* ----------------------------
 * ------ INMOBILIARIA---------
 * ----------------------------
 * 
 * 
 * ========= QUERIES =============
 */


-- ---------------------------------------------------------------------------

-- ======= CATALOGO DE TABLAS =======
select * from information_schema.tables where table_schema='public';


-- ======= QUERIES TABLA OFICINAS Y OFICINAS_DETALLES ===========

-- Detalle de Todas las Oficinas
select oficinas.* , oficinas_detalles.* from oficinas 
join oficinas_detalles on oficinas_detalles.id_oficina = oficinas.id;

-- Nombres de Oficinas Alquiladas
select oficinas.nombre , oficinas_detalles.estado_oficina from oficinas 
join oficinas_detalles on oficinas_detalles.id_oficina = oficinas.id
where oficinas_detalles.estado_oficina = 'ALQUILADA';

-- Nombres de Oficinas Propias
select oficinas.nombre , oficinas_detalles.estado_oficina from oficinas 
join oficinas_detalles on oficinas_detalles.id_oficina = oficinas.id
where oficinas_detalles.estado_oficina = 'PROPIA';

-- Nombres de Oficinas de 1 Ambiente
select oficinas.nombre , oficinas_detalles.cantidad_ambientes from oficinas 
join oficinas_detalles on oficinas_detalles.id_oficina = oficinas.id
where oficinas_detalles.cantidad_ambientes = 1;

-- Nombres de Oficinas de 2 Ambientes
select oficinas.nombre , oficinas_detalles.cantidad_ambientes from oficinas 
join oficinas_detalles on oficinas_detalles.id_oficina = oficinas.id
where oficinas_detalles.cantidad_ambientes = 2;

-- Nombres de Oficinas que tengan 2 o más Ambientes
select oficinas.nombre , oficinas_detalles.cantidad_ambientes from oficinas 
join oficinas_detalles on oficinas_detalles.id_oficina = oficinas.id
where oficinas_detalles.cantidad_ambientes >= 2;


-- ======= QUERIES TABLA OFICINAS E INMUEBLES ===========

-- Detalle de todos las oficinas con sus inmuebles
select oficinas.* , inmuebles.* from oficinas 
join inmuebles on inmuebles.id_oficina = oficinas.id ;


-- Nombre de las Oficinas y algunos detalles de sus inmuebles( que sea legible por cualquier persona)
select oficinas.nombre as nombre_de_oficina , inmuebles.tipo as tipo_inmueble_venta
, inmuebles.descripcion as descripción_del_inmueble, inmuebles.estado_inmueble 
from oficinas 
join inmuebles on inmuebles.id_oficina = oficinas.id ;














-- ======= QUERIES TABLA PROPIETARIOS_INMUEBLES E INMUEBLES ===========

-- Detalle de Todos los inmuebles y sus propietarios
select inmuebles.* , propietarios_inmuebles.* from inmuebles 
join propietarios_inmuebles on propietarios_inmuebles.id = inmuebles.id_propietario_inmueble ;



