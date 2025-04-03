CREATE DATABASE sakilacampus ;

USE sakilacampus;

CREATE TABLE IF NOT EXISTS categoria(
​	id_categoria INT PRIMARY KEY ,
​	nombre VARCHAR(25),
​	ultima_actualizacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS actor (
​	id_actor INT PRIMARY KEY,
​	nombre VARCHAR(45),
​	apellidos VARCHAR(45),
​	ultima_actualizacion TIMESTAMP 
);

CREATE TABLE IF NOT EXISTS pais(
​	id_pais INT PRIMARY KEY ,
​	nombre VARCHAR(50),
​	ultima_actualizacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ciudad (
​	id_ciudad INT PRIMARY KEY ,
​	nombre VARCHAR(50),
​	ultima_actualizacion TIMESTAMP,
   id_pais INT,
   CONSTRAINT id_fk_pais FOREIGN KEY id_pais REFERENCES pais(id_pais)
);

CREATE TABLE IF NOT EXISTS  direccion (
​	id_direccion SMALLINT PRIMARY KEY ,
​	direccion  VARCHAR(50),
​	direccion2 VARCHAR(50),
​	distrito VARCHAR(20),
​	codigo_postal VARCHAR(10),
​	telefono VARCHAR(20),
​   ultima_actualizacion TIMESTAMP,
   id_ciudad SMALLINT, 
​	CONSTRAINT id_ciudad_FK FOREIGN KEY id_ciudad REFERENCES ciudad(id_ciudad)
);

CREATE TABLE IF NOT EXISTS idioma(
​	id_idioma INT PRIMARY KEY ,
​	nombre VARCHAR(20),
​	ultima_actualizacion TIMESTAMP
);
CREATE TABLE IF NOT EXISTS  pelicula(
​	id_pelicula SMALLINT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    anyo_lanzamiento YEAR,
    id_idioma TINYINT,
    id_idioma_original TINYINT,
    duracion_alquiler TINYINT,
    rental_rate DECIMAL(5,2),
    duracion SMALLINT,
    replacement_cost DECIMAL(5,2),
    clasificacion ENUM('G','PG','PG-13','R','NC-17'),
    caracteristicas_especiales SET('Trailers','Commentaries','Delete Scenes','Behind the Scenes'),
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT id_idioma_FK FOREIGN KEY id_idioma  REFERENCES idioma(id_idioma)
);

CREATE TABLE IF NOT EXISTS pelicula_actor(
    id_actor SMALLINT PRIMARY KEY,
    id_pelicula SMALLINT,
    ultima_actualizacion TIMESTAMP
    CONSTRAINT id_pelicula_FK FOREIGN KEY id_pelicula REFERENCES pelicula(id_pelicula)
);
CREATE TABLE IF NOT EXISTS pelicula_categoria (
    id_pelicula SMALLINT PRIMARY KEY,
    id_categoria SMALLINT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT id_pelicula_FK FOREIGN KEY id_pelicula REFERENCES pelicula(id_pelicula)
);
CREATE TABLE IF NOT EXISTS empleado(
    id_empleado TINYINT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR (45),
    id_direccion SMALLINT,
    imagen BLOB,
    email VARCHAR(50),
    id_almacen TINYINT,
    activo TINYINT(1),
    username VARCHAR(16),
    password VARCHAR(40),
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT id_direccion_FK FOREIGN KEY id_direccion REFERENCES direccion(id_direccion)
);
CREATE TABLE IF NOT EXISTS almacen(
    id_almacen TINYINT PRIMARY KEY,
    id_empleado_jefe TINYINT,
    id_direccion SMALLINT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT id_empleado_jefe_FK FOREIGN KEY id_empleado_jefe REFERENCES empleado(id_empleado),
    CONSTRAINT id_direccion_Foreing FOREIGN KEY id_direccion REFERENCES direccion(id_direccion)
);
CREATE TABLE IF NOT EXISTS cliente(
    id_cliente SMALLINT PRIMARY KEY,
    id_almacen TINYINT,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    email VARCHAR(50),
    id_direccion SMALLINT,
    activo TINYINT(1),
    fecha_creacion DATETIME,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT id_almacen_FK FOREIGN KEY id_almacen REFERENCES almacen(id_almacen),
    CONSTRAINT FK_id_direccion FOREIGN KEY id_direccion REFERENCES direccion(id_direccion)
);
CREATE TABLE IF NOT EXISTS inventario(
    id_inventario MEDIUMINT PRIMARY KEY,
    id_pelicula SMALLINT,
    id_almacen TINYINT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT id_peliculas_FK FOREIGN KEY id_peliculas REFERENCES pelicula(id_pelicula),
    CONSTRAINT Fk_id_almacen FOREIGN KEY id_almacen REFERENCES almacen(id_almacen)
);
CREATE TABLE IF NOT EXISTS alquiler(
    id_alquiler INT PRIMARY KEY,
    fecha_alquiler DATETIME,
    id_inventario MEDIUMINT,
    id_cliente SMALLINT,
    fecha_devolucion DATETIME,
    id_empleado TINYINT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT id_inventario_FK FOREIGN KEY id_inventario REFERENCES inventario(id_inventario),
    CONSTRAINT id_cliente_FK FOREIGN KEY id_cliente REFERENCES cliente(id_cliente),
    CONSTRAINT id_empleados_FK FOREIGN KEY id_cliente REFERENCES cliente(id_cliente)
);
CREATE TABLE IF NOT EXISTS pago(
    id_pago SMALLINT PRIMARY key,
    id_cliente SMALLINT,
    id_empleado TINYINT,
    id_alquiler INT,
    total DECIMAL(5,2),
    fecha_pago DATETIME,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT id_clientes_FK FOREIGN KEY id_cliente REFERENCES cliente(id_cliente),
    CONSTRAINT FK_id_empleado FOREIGN KEY id_empleado REFERENCES empleado(id_empleado),
    CONSTRAINT id_alquiler_FK FOREIGN KEY id_alquiler REFERENCES alquiler(id_alquiler)
);
CREATE TABLE IF NOT EXISTS film_text(
    film_id SMALLINT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT
);

