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

-- Tabla Oficinas
select * from oficinas;

-- Tabla Oficinas_Detalles
select * from oficinas_detalles;

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

-- Tabla Oficinas
select * from oficinas;

-- Tabla Inmuebles
select * from inmuebles;

-- Detalle de todos las oficinas con sus inmuebles
select oficinas.* , inmuebles.* from oficinas 
join inmuebles on inmuebles.id_oficina = oficinas.id ;


-- Nombre de las Oficinas y algunos detalles de sus inmuebles( que sea legible por cualquier persona)
select oficinas.nombre as nombre_de_oficina , inmuebles.tipo as tipo_inmueble_venta
, inmuebles.descripcion as descripción_del_inmueble, inmuebles.estado_inmueble 
from oficinas 
join inmuebles on inmuebles.id_oficina = oficinas.id ;


-- Cantidad de Inmuebles por Oficina
select oficinas.nombre as nombre_de_oficina, count(inmuebles.id) as cantidad_de_inmuebles
from oficinas
join inmuebles on inmuebles.id_oficina = oficinas.id
group by oficinas.nombre ;


-- Cantidad de Inmuebles Disponibles por Oficina
select oficinas.nombre as nombre_de_oficina, count(inmuebles.id) as cantidad_de_inmuebles_disponibles
from oficinas
join inmuebles on inmuebles.id_oficina = oficinas.id
where inmuebles.estado_inmueble = 'DISPONIBLE'
group by oficinas.nombre ;


-- Cantidad de Inmuebles Vendidos por Oficina
select oficinas.nombre as nombre_de_oficina, count(inmuebles.id) as cantidad_de_inmuebles_vendidos
from oficinas
join inmuebles on inmuebles.id_oficina = oficinas.id
where inmuebles.estado_inmueble = 'VENDIDO'
group by oficinas.nombre ;



-- Inmueble con descripcion y  con el Mayor Precio por oficina
select oficinas.nombre as nombre_de_oficina, max(inmuebles.precio_inmueble_usd) as inmueble_con_mayor_importe 
, inmuebles.descripcion as descripcion_del_inmueble
from oficinas
join inmuebles on inmuebles.id_oficina = oficinas.id
group by oficinas.nombre, inmuebles.descripcion ;


-- Inmueble con descripcion, ubicación/zona y con el Menor Precio por oficina
select oficinas.nombre as nombre_de_oficina, min(inmuebles.precio_inmueble_usd) as inmueble_con_menor_importe 
, inmuebles.descripcion as descripcion_del_inmueble, inmuebles.ubicacion as ubicacion
from oficinas
join inmuebles on inmuebles.id_oficina = oficinas.id
group by oficinas.nombre, inmuebles.descripcion, inmuebles.ubicacion ;


-- Oficina que tenga Disponible una Casa para Vender con su precio
select oficinas.nombre as nombre_de_oficina , inmuebles.tipo , inmuebles.descripcion as descripcion_del_inmueble
, inmuebles.precio_inmueble_usd 
from oficinas
join inmuebles on inmuebles.id_oficina = oficinas.id
where inmuebles.estado_inmueble = 'DISPONIBLE' 
and (inmuebles.tipo like '%Casa%' or inmuebles.tipo like '%CASA%');






-- ======= QUERIES TABLA PROPIETARIOS_INMUEBLES E INMUEBLES ===========

-- Detalle de Todos los inmuebles y sus propietarios
select inmuebles.* , propietarios_inmuebles.* from inmuebles 
join propietarios_inmuebles on propietarios_inmuebles.id = inmuebles.id_propietario_inmueble ;



