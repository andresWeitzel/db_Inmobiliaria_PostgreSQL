# Administracion_Gestion_BasesDeDatos_PostgreSQL


* En Este Proyecto se pone en práctica el Modelado, Desarrollo, Gestión y Administración de una Base de Datos con el SGBD PostgreSQL.
* Este Proyecto surgió a partir de una pequeña db a modo de ejemplo de un pdf, el mismo me orientó en la estructura relación-entidad de la db con PostgreSql para una inmobiliaria. Todo el desarrollo fue creado desde cero y guiandome por las informaciones y carácteristicas del mercado inmobiliario en Argentina(valores, precios, medidas, lexico, etc).Se incluye el pdf guía del proyecto dentro de la documentacion.


</br>

#### Diagrama Entidad Relación  `db_inmobiliaria`

![Index app](https://github.com/andresWeitzel/Administracion_Gestion_BasesDeDatos_PostgreSQL/blob/master/documentacion/db_inmobiliaria_DER.png)

</br>

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


