# Proyecto db_inmobiliaria con PostgreSQL.

* En Este Proyecto se pone en práctica el Diseño, Modelado, Creación, Desarrollo, Programación, Gestión y Administración de una Base de Datos acerca de nua Inmobiliaria con el SGBD PostgreSQL.
* El Desarrollo surgió a partir de una pequeña db a modo de ejemplo de un pdf, el mismo me orientó en la estructura relación-entidad de la db con PostgreSql para una inmobiliaria. Todo el desarrollo fue creado desde cero y guiándome por las informaciones y características del mercado Inmobiliario en Argentina (valores, precios, medidas, léxico, etc).
*  Las páginas de inmobiliaria más conocidas en las que me guíe son zonaprop, re/max y baigún.
*  Para la gran mayoría de las medidas tomadas en inmuebles me guié en anuncios en MercadoLibre, ya que allí se detallan en mayor cantidad.
*  Se incluye el pdf guía del proyecto dentro de la documentacion.

</br>

## Descripción Técnica

* Para este proyecto se aplica un Diseño Normalizado, se separan las tablas que contengan varios campos y se aplica la convención de nombres, tanto para tablas como para campos.
* Para el Modelado se aplican relaciones de Uno a Uno y relaciones de Uno a Varios. Posteriormente a esta descripción se anexa el DER de la db junto con la descripción de Relaciones.
* Dentro de la Creación y Desarrollo de la sección DDL se aplican todas las Restricciones correspondientes para cada uno de los campos desarrollados, las mismas incluyen los tipos UNIQUE y se aplican los FOREIGN KEY  para la relación de tablas, además de los tipos CHECKS para comprobación de valores de campos.
* Dentro de la sección del DML se comienza con la Programación de la Base de Datos, generando funciones que nos permitan insertar registros de la forma requerida y deseada.
* Se aplica un Nivel de Seguridad de Respaldo con la creación de tablas y funciones para almacenar todos los cambios que se generen en la Base de Datos. Es evidente que se podría generar tablas temporales o trabajar con el propio sistema de log de PostgreSql, pero se aplica una administración a Nivel más Bajo de esta db y se crean estas tablas por gusto y manejo. Cabe aclarar que las funciones que se desarrollaron se aplican siempre que se borre, actualice o agregue un registro y se almacena dicha información en tablas individuales
* El Proyecto está separado por varios archivos .sql enumerados para facilitar la comprensión del desarrollo y la ejecución de los mismos.


</br>

#### Diagrama Entidad Relación  `db_inmobiliaria`

![Index app](https://github.com/andresWeitzel/Administracion_Gestion_BasesDeDatos_PostgreSQL/blob/master/documentacion/db_inmobiliaria_DER_01.png)

![Index app](https://github.com/andresWeitzel/Administracion_Gestion_BasesDeDatos_PostgreSQL/blob/master/documentacion/db_inmobiliaria_DER_02.png)


* DBeaver implementa la Notación IDEF1X para el Diagrama Entidad Relación. En la documentación que anexa DBeaver(https://dbeaver.com/docs/wiki/ER-Diagrams/) no está del todo claro la relación que implementa. Investigando sobre las mismas, se puede concluir que la Relación Diamante y Círculo entre línea Punteada se declara como relaciónes Opcionales. Por ende debajo de la siguiente Imagen está detallado las Relaciones entre Entidades.

![Index app](https://github.com/andresWeitzel/Administracion_Gestion_BasesDeDatos_PostgreSQL/blob/master/documentacion/relacionDeTablas.png)

</br>


#### Tabla Descriptiva Entidad-Relación Uno a Varios (1:N).

| **Entidad-Relacion** | **Entidad-Relacion** |               
| ------------- | ------------- |
| oficinas(1) | inmuebles(N)  |
| oficinas(1) | empleados(N)  |
| inmuebles(1) | ventas(N)  |
| inmuebles(1) | inmuebles_marketing(N)  |
| inmuebles(1) |  citas_inmuebles(N)  |
| inmuebles(1) |  inspecciones_inmuebles(N)  |
| propietarios_inmuebles(1) | inmuebles(N)   |
| empleados(1) |  citas_inmuebles(N) |
| empleados(1) | ventas(N)  |
| clientes(1) |  citas_inmuebles(N) |
| clientes(1) | ventas(N)  |


* No declarando las FK como Unique en las relaciones de Tablas nos aseguramos que exista duplicidad de registros.


</br>

#### Tabla Descriptiva Entidad-Relación Uno a Uno (1:1).

| **Entidad-Relacion** | **Entidad-Relacion** |               
| ------------- | ------------- |
| oficinas(1) | oficinas_detalles(1) |
| oficinas(1) | servicios_oficinas(1) |
| inmuebles(1) | inmuebles_descripciones(1) |
| inmuebles(1) | inmuebles_medidas(1) |
| empleados(1) | vendedores(1) |
| empleados(1) | administradores(1) |
| empleados(1) | gerentes(1)  |
| clientes(1) | compradores(1)  |
| facturas(1) |  ventas(1) |
| facturas(1) | facturas_detalles(1) |


* Declarando las FK como Unique en las relaciones de Tablas nos aseguramos qué NO exista duplicidad.


#### Restricciones de tipo CHECK UNIQUE para relación (1:1)

| **Tabla** | **Campo** |               
| ------------- | ------------- |
| oficinas_detalles | FK id_oficina UNIQUE |
| servicios_oficinas | FK id_oficina UNIQUE  |
| inmuebles | FK id_inmueble_medidas UNIQUE | 
| inmuebles | FK id_inmueble_descripcion UNIQUE | 
| administradores | FK id_empleado UNIQUE |
| gerentes | FK id_empleado UNIQUE |
| compradores | FK id_cliente UNIQUE |
| vendedores | FK id_empleado UNIQUE |
| facturas  | FK id_venta UNIQUE
| facturas_detalles | FK id_factura UNIQUE | 


</br>

<hr>

## Más Información

</br>


| **Tecnologías Empleadas** | **Versión** | **Finalidad** |               
| ------------- | ------------- | ------------- |
| PostgreSQL | 13.4  | SGDB  |
| DBeaver | 21.1  | Gestor de Base de Datos | 
| Git Bash | 2.29.1  | Control de Versiones |
| CMD | 10 | Manipular los Servicios de Postgres mediante linea de comandos | 

</br>


## Descarga y Documentacion de las Tecnologías Empleadas:

</br>

| **Tecnologías** | **Descarga** | **Documentación** |               
| ------------- | ------------- | ------------- |
| Git Bash |  https://git-scm.com/downloads |   https://git-scm.com/docs |
| PostgreSQL |  https://www.postgresql.org/download/  | https://www.postgresql.org/docs/current/tutorial.html  |
| DBeaver | https://dbeaver.io/download/  | https://github.com/dbeaver/dbeaver/wiki | 

</br>

<hr>

## `Documentación y Guía Del Proyecto`
#### (Esta Documentación y Guía que Desarrollé es para la Creación, Configuración, Manejo, etc de la Base de Datos db_inmuebles con PostgreSQL en DBeaver. Como así también para el Desarrollo de este Proyecto, Aplicaciones del Código, Manejo de los Posibles Errores que pudiesen surgir, manejo de Git, Consideraciones y Declaraciones del Proyecto, etc. Recomiendo Leerla y Realizar todo paso a paso como se indica en la misma, cualquier aporte o sugerencia, informar al respecto).

## Indice

  #### Sección 1) Configuración de la Base de Datos

  - [ Paso 1) Configuración y Puesta en Marcha de la Base de Datos.](#paso-1-configuración-y-puesta-en-marcha-de-la-base-de-datos-db-inmuebles)

  - [ Paso 2) Ejecución de los Archivos .SQL .](#paso-2-ejecución-dee-los-archivos-sql)

  
   #### Sección Apéndice
   
   -[ Funciones Implementadas Predefinidas para los Logs del Usuario](#funciones-predefinidas-para-los-logs-del-usuario)



</br>

## Sección 1) Configuración de la Base de Datos

</br>

### Paso 1) Configuración y Puesta en Marcha de la Base de Datos `db_inmuebles`
#### (Primeramente deberás descargar el SGDB PostgreSQL , luego algún GDB como por ej. DBeaver y crear la db ).

#### 1.1) Descarga de DBeaver
* https://dbeaver.io/
* Descargar, Ejecutar e Instalar (Siguiente, Siguiente).


#### 1.2) Descarga de PostgreSQL
*  https://www.postgresql.org/download/
*  Descargar, Ejecutar e Instalar (Siguiente, Siguiente).


#### 1.3) Configuración de PostgreSQL en DBeaver (Conexión a PostgreSQL).
* Click sobre la Pestaña Archivo.
    * --> Nuevo
    * --> Database Connection, Siguiente.
    * --> Seleccionar el SGDB PostgreSQL, Siguiente.
    * --> En Database dejamos como aparece `postgres`
    * --> Seguidamente vamos a agregar una contraseña, en password escribimos `postgres`
    * --> El resto lo dejamos todo por defecto ( Host, Port, etc ).
    * --> Finalizar, asegurarse que se haya creado la db con su configuración
    * --> Ya está la conexión configurada.



#### 1.4) Creación de la Base de Datos `db_inmobiliaria` en la Conexión de PostgreSQL
#### ( En DBeaver tuve problemas al incluir código sql para la creación de la db, así que vamos a crear la db manualmente)
* Una vez realizado el paso anterior, se debería haber desplegado la Conexión PostgreSQL, sino desplagar para visualizar 
*  Click Der sobre la conexión creada `postgres`
    * --> Crear, Base de Datos
    * --> En Database Name colocamos `db_inmobiliaria`.
    * --> En owner Seleccionamos postgres o dejarlo seleccionado por defecto.
    * --> Template database vacío.
    * --> En Encoding Seleccionamos UTF8 o dejarlo seleccionado por defecto.
    * --> Tablespace pg_default o dejarlo seleccionado por defecto.
    * --> Aceptar, ya está la db creada.


#### 1.5) Creación de una Conexión Independiente de la Base de Datos `db_inmobiliaria`
* Ya tenemos creada la conexión con Postgres y nuestra base de datos, ahora podemos crear una conexión independiente para su uso, cuestión de comodidad
* Click sobre la Pestaña Archivo.
    * --> Nuevo
    * --> Database Connection, Siguiente.
    * --> Seleccionar el SGDB PostgreSQL, Siguiente.
    * --> En Database escribimos nuestra db creada `db_inmobiliaria`
    * --> Seguidamente vamos a agregar una contraseña, en password escribimos `postgres`
    * --> El resto lo dejamos todo por defecto ( Host, Port, etc ).
    * --> Finalizar, asegurarse que se haya creado la db con su configuración
    * --> Ya está la conexión configurada.
    * --> IMPORTANTE : Lo único configurable es `Database: db_inmobiliaria` y `Contraseña:postgres`


</br>

### Paso 2) Ejecución de los Archivos `.SQL`
#### (Vamos a trabajar con los Archivos sql dentro de DBeaver, los mismos están enumerados para su orden de ejecución).

#### 2.1) Importamos los Archivos SQL a DBeaver
* Click sobre Archivo (Barra Superior)
    * --> Buscar Archivo Denominado..
    * --> Seleccionas los .sql y Open.
    * --> Listo
 

#### 2.2) Orden de Ejecución de los Scripts
* Cada uno de los Archivos están enumerados para que se realice el orden de ejecución correspondiente.
* 







</br>

## Sección Apéndice

</br>



### Funciones Predefinidas para los LOGS del Usuario. 
* Referencia : https://www.postgresql.org/docs/current/functions-info.html


| **Tipo de Función** | **Finalidad** |               
| ------------- | ------------- |

</br>







</br>
</br>
</br>
</br>
</br>


## Subir el proyecto al repositorio desde bash 

#### 1)Creamos un nuevo repositorio en GitHub.

#### 2)Inicializamos nuestro repositorio local .git desde git bash.
* git init

#### 3)Agregamos lo desarrollado a nuestro repo local desde la terminal.
* git add *

#### 4)Agregamos lo que tenemos en nuestro repo local al área de Trabajo desde la terminal.
* git commit -m "agrega un comentario entre comillas"

#### 5)Le indicamos a git donde se va a almacenar nuestro proyecto(fijate en tu repositorio de github cual es el enlace de tu proyecto(esta en code)).
* git remote add origin https://github.com/andresWeitzel/Administracion_Gestion_BasesDeDatos_PostgreSQL

#### 6)Subimos nuestro proyecto.
* git push -u origin master


</br>


## Actualización de el proyecto al repositorio con git bash.

#### 1)Visualizamos las modificaciones realizadas en local
* git status

#### 2)Agregamos lo modificado al area de trabajo
* git add *

#### 3)Confirmamos las modificaciones realizadas
* git commit -m "tu commit entre comillas"

#### 4)Sincronizamos y traemos todos los cambios del repositorio remoto a la rama en la que estemos trabajando actualmente.
##### (SOLO SI SE REALIZARON CAMBIOS DESDE OTRA LADO, ej: en github u/o/y un equipo de trabajo)
* git pull https://github.com/andresWeitzel/Administracion_Gestion_BasesDeDatos_PostgreSQL

#### 5)Enviamos todos los cambios locales al repo en github
* git push https://github.com/andresWeitzel/Administracion_Gestion_BasesDeDatos_PostgreSQL

#### 6) En casos extremos pisamos todo el repositorio
* git push -f --set-upstream origin master


</br>


