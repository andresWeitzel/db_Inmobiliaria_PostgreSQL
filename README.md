# Administracion_Gestion_BasesDeDatos_PostgreSQL


* En Este Proyecto se pone en práctica el Modelado, Desarrollo, Gestión y Administración de una Base de Datos con el SGBD PostgreSQL.
* El Desarrollo surgió a partir de una pequeña db a modo de ejemplo de un pdf, el mismo me orientó en la estructura relación-entidad de la db con PostgreSql para una inmobiliaria. Todo el desarrollo fue creado desde cero y guiandome por las informaciones y carácteristicas del mercado inmobiliario en Argentina(valores, precios, medidas, lexico, etc). Se incluye el pdf guía del proyecto dentro de la documentacion.


</br>

#### Diagrama Entidad Relación  `db_inmobiliaria`

![Index app](https://github.com/andresWeitzel/Administracion_Gestion_BasesDeDatos_PostgreSQL/blob/master/documentacion/db_inmobiliaria_DER.png)

</br>


#### Tabla Descriptiva Entidad-Relación

| **Entidades** | **Relaciones** |               
| ------------- | ------------- |
| Ventas(1)-Facturas(N) | 1:N (Uno a Muchos)   |
| Compradores(1)-Ventas(N) | 1:N (Uno a Muchos)   |
| Compradores(1)-Compradores_Clientes(N) | 1:N (Uno a Muchos)   |
| Clientes(1)-Compradores_Clientes(N) | 1:N (Uno a Muchos)   |
| Vendedores(1)-Ventas(N) | 1:N (Uno a Muchos)   |
| Inmuebles(1)-Ventas(N) | 1:N (Uno a Muchos)   |
| Propietarios_Inmuebles(1)-Inmuebles(N) | 1:N (Uno a Muchos)   |
| Oficinas(1)-Inmuebles(N) | 1:N (Uno a Muchos)   |
| Oficinas(1)-Empleados(N) | 1:N (Uno a Muchos)   |
| Empleados(1)-Vendedores(N) | 1:N (Uno a Muchos)   |
| Empleados(1)-Administradores(N) | 1:N (Uno a Muchos)   |
| Empleados(1)-Gerentes(N) | 1:N (Uno a Muchos)   |
| Inmuebles_Descripciones(1)-Inmuebles(N) | 1:N (Uno a Muchos)   |
| Inmuebles_Medidas(1)-Inmuebles(N) | 1:N (Uno a Muchos)   |




<hr>

## Más Información

</br>


| **Tecnologías Empleadas** | **Versión** | **Finalidad** |               
| ------------- | ------------- | ------------- |
| Git Bash | 2.29.1.windows.1  | Control de Versiones |
| PostgreSQL | 13.4  | SGDB  |
| DBeaver | 21.1  | Gestor de Base de Datos | 

</br>


## Descarga y documentacion de las Tecnologías empleadas:
#### Git:                              https://git-scm.com/docs
#### PostgreSQL:                            https://www.postgresql.org/download/
#### DBeaver:                         https://dbeaver.io/

</br>

<hr>

## `Documentación Del Proyecto`
#### (Esta Documentación que Desarrollé es para la Creación, Configuración, Posibles Errores, Manejo de la Base de Datos db_inmuebles con PostgreSQL en DBeaver. Recomiendo Leerla y Realizar todo paso a paso como se indica en la misma, cualquier aporte o sugerencia, informar al respecto).

## Indice
- [Creación y Configuraciones de un Proyecto Spring Boot con Maven en Spring Tool Suite 4.](#creación-de-un-proyecto-spring-boot-con-maven-en-spring-tool-suite-4-y-configuraciones-iniciales)

- [Configuración del Servidor de Despliegue (Wildfly).](#configuración-del-servidor-de-despliegue-wildfly)
- [Herramienta Cygwin para el uso de Git.](#uso-de-cygwin)


</br>

## Configuración y Puesta en Marcha de la Base de Datos db_inmuebles.
#### (Primeramente deberás descargate PostgreSQL como SGDB, luego DBeaver como GDB y crear la db ).

#### 1) Descarga de DBeaver
* --> https://dbeaver.io/
* --> Descargar, Ejecutar e Instalar (Siguiente, Siguiente).


#### 2) Descarga de PostgreSQL
* -->  https://www.postgresql.org/download/
* --> Descargar, Ejecutar e Instalar (Siguiente, Siguiente).


#### 3) Configuración de PostgreSQL en DBeaver (Conexión a PostgreSQL).
* --> Click sobre la Pestaña Archivo.
* --> Nuevo
* --> Database Connection, Siguiente.
* --> Seleccionar el SGDB PostgreSQL, Siguiente.
* --> En Propiedades de Conexión dejamos todo por defecto ( Host, Port, Database, etc ).
* --> Finalizar, ya está la conexión configurada.


#### 4) Creación de nuestra DB db_inmuebles.
* --> Se debería haber desplegado la Conexión PostgreSQL, sino desplagar para visualizar 
* --> Click Der sobre postgres
* --> Crear, Base de Datos
* --> En Database Name colocamos db_inmobiliaria.
* --> En owner Seleccionamos postgres o dejarlo seleccionado por defecto.
* --> Template database vacío.
* --> En Encoding Seleccionamos UTF8 o dejarlo seleccionado por defecto.
* --> Tablespace pg_default o dejarlo seleccionado por defecto.
* --> Aceptar, ya está la db creada.

</br>

## Uso y Ejecución de los Scripts .sql
#### (Vamos a trabajar con los Archivos sql dentro de DBeaver).

#### 1) Primeramente asegurate de haber descargado este Repositorio

#### 2) Importamos los Archivos SQL a DBeaver
* --> Click sobre Archivo (Barra Superior)
* --> Importar
* --> Directorio General
* --> Sistema de Archivos
* --> Click en Examinar
* --> Se abre el Gestor de Archivos y buscar la ubicación del Repositorio Descargado.
* --> Seleccionas los .sql y Open.
* --> Listo

#### 3) Orden de Ejecución de los Scripts
* --> 1) db_inmobiliaria_DDL.sql







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

</br>


