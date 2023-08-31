CREATE DATABASE CENTRO_ODONTOLOGICO
GO
USE CENTRO_ODONTOLOGICO
GO

CREATE TABLE PAISES
(id_pais int ,
descripcion varchar (100),
CONSTRAINT PK_paises PRIMARY KEY (id_pais)
)

CREATE TABLE PROVINCIAS 
(id_provincia int ,
descripcion varchar (100),
id_pais int ,
CONSTRAINT PK_provincias PRIMARY KEY (id_provincia),
CONSTRAINT FK_provincias_paises FOREIGN KEY (id_pais)
REFERENCES paises (id_pais) 
)

CREATE TABLE LOCALIDADES 
(id_localidad int  ,
descripcion varchar (100),
id_provincia int,
CONSTRAINT PK_localidades PRIMARY KEY (id_localidad),
CONSTRAINT FK_localidades_provincias FOREIGN KEY (id_provincia)
REFERENCES provincias (id_provincia) 
)

CREATE TABLE BARRIOS 
(id_barrio int,
descripcion varchar (100),
id_localidad int ,
CONSTRAINT PK_barrios PRIMARY KEY (id_barrio),
CONSTRAINT FK_barrios_localidades FOREIGN KEY (id_localidad)
REFERENCES localidades (id_localidad) 
)
CREATE TABLE TIPOS_DOCUMENTOS
(id_tipo_doc int,
descripcion varchar (70),
CONSTRAINT PK_tipos_documentos PRIMARY KEY (id_tipo_doc)
)
CREATE TABLE OBRAS_SOCIALES
(id_obra_social int,
nombre varchar (70),
CONSTRAINT PK_obras_sociales PRIMARY KEY (id_obra_social)
)

CREATE TABLE TIPOS_MOVIMIENTOS
(id_tipo_movimiento int,
descripcion varchar (50),
CONSTRAINT PK_tipos_movimientos PRIMARY KEY (id_tipo_movimiento)
)

CREATE TABLE PROCEDIMIENTOS_ODONTOLOGICOS
(id_proc_odontologico int,
nombre varchar (100),
precio money
CONSTRAINT PK_procedimientos_odontologicos PRIMARY KEY (id_proc_odontologico)
) 



CREATE TABLE FORMAS_DE_PAGOS
(id_forma_pago int,
descripcion varchar  (100),
recargo int,
CONSTRAINT  PK_formas_pagos PRIMARY KEY (id_forma_pago)
)



CREATE TABLE TIPOS_CONTACTOS
(id_tipo_contacto int,
tipo_contacto varchar (100),
CONSTRAINT PK_tipos_contactos PRIMARY KEY (id_tipo_contacto)
)

CREATE TABLE ESPECIALIDADES
(id_especialidad int,
descripcion varchar (100),
CONSTRAINT PK_especialidades PRIMARY KEY (id_especialidad)
)

CREATE TABLE MARCAS
(id_marca int,
marca varchar (100),
CONSTRAINT PK_marcas PRIMARY KEY (id_marca)
)

CREATE TABLE TIPOS_REPARACIONES
(id_tipo_reparacion  int,
descripcion varchar (150),
CONSTRAINT PK_tipos_reparaciones PRIMARY KEY (id_tipo_reparacion)
)




CREATE TABLE PACIENTES
(id_paciente int,
nombre varchar (50),
apellido varchar (50),
nro_telefono int,
fecha_nacimiento date,
nro_documento int,
email varchar (100),  
calle varchar (50),
altura int,
id_tipo_doc int,
id_barrio int,
id_obra_social int,
CONSTRAINT PK_pacientes PRIMARY KEY (id_paciente),
CONSTRAINT FK_pacientes_tipos_documentos FOREIGN KEY (id_tipo_doc)
REFERENCES tipos_documentos (id_tipo_doc),
CONSTRAINT FK_pacientes_barrios  FOREIGN KEY (id_barrio)
REFERENCES barrios (id_barrio),
CONSTRAINT FK_pacientes_obras_sociales FOREIGN KEY (id_obra_social)
REFERENCES obras_sociales (id_obra_social)
)

CREATE TABLE DENTISTAS
(nro_dentista int,
nombre varchar (50),
apellido  varchar (50),
id_tipo_doc int,
nro_documento int,
nro_telefono int,
id_especialidad int,
nro_matricula varchar (30),
email varchar (100),
CONSTRAINT PK_dentistas PRIMARY KEY (nro_dentista),
CONSTRAINT FK_dentistas_tipos_documentos FOREIGN KEY (id_tipo_doc)
REFERENCES  tipos_documentos (id_tipo_doc),
CONSTRAINT FK_dentistas_especialidades FOREIGN KEY(id_especialidad)
REFERENCES especialidades (id_especialidad)
)


CREATE TABLE CLINICAS
(id_clinica int,
nombre varchar (100),
altura int,
calle varchar (100),
hora_apertura  time,
hora_cierre time,
id_barrio int,
CONSTRAINT PK_clinicas PRIMARY KEY (id_clinica),
CONSTRAINT FK_clinicas_barrios FOREIGN KEY (id_barrio)
REFERENCES barrios (id_barrio)
) 


CREATE TABLE FACTURAS
(nro_factura int,
fecha date,
id_clinica int,
id_paciente int,
nro_dentista int,
CONSTRAINT PK_facturas PRIMARY KEY (nro_factura),
CONSTRAINT FK_facturas_clinicas FOREIGN KEY (id_clinica)
REFERENCES clinicas (id_clinica),
CONSTRAINT FK_facturas_pacientes FOREIGN KEY (id_paciente)
REFERENCES pacientes (id_paciente),
CONSTRAINT FK_facturas_dentistas FOREIGN KEY (nro_dentista)
REFERENCES dentistas (nro_dentista)
)

CREATE TABLE DETALLE_FACTURAS
(id_detalle_factura int,
nro_factura int,
id_proc_odontologico int,
precio money,
CONSTRAINT PK_detalles_facturas PRIMARY KEY (id_detalle_factura),
CONSTRAINT FK_detalles_facturas_facturas FOREIGN KEY (nro_factura)
REFERENCES facturas (nro_factura),
CONSTRAINT FK_detalles_facturas_procedimientos_odontologicos FOREIGN KEY (id_proc_odontologico)
REFERENCES procedimientos_odontologicos (id_proc_odontologico)
)

CREATE TABLE FACTURAS_FORMAS_PAGOS
(id_factura_forma_pago int,
nro_factura int,
id_forma_pago int,
monto money,
CONSTRAINT PK_facturas_formas_pagos PRIMARY KEY (id_factura_forma_pago),
CONSTRAINT FK_facturas_formas_pagos_facturas FOREIGN KEY (nro_factura)
REFERENCES facturas (nro_factura),
CONSTRAINT FK_facturas_formas_pagos_formas_de_pagos FOREIGN KEY (id_forma_pago)
REFERENCES formas_de_pagos (id_forma_pago)
)

CREATE TABLE CONSULTORIOS
(id_consultorio int,
descripcion varchar (100),
id_clinica int,
CONSTRAINT PK_consultorios PRIMARY KEY (id_consultorio),
CONSTRAINT FK_consultorios_clinicas FOREIGN KEY (id_clinica)
REFERENCES clinicas (id_clinica)
)

CREATE TABLE CONTACTOS	
(id_contacto int,
contacto varchar (150),
id_tipo_contacto int,
id_clinica int,
CONSTRAINT PK_contactos PRIMARY KEY (id_contacto),
CONSTRAINT FK_contactos_tipos_contactos FOREIGN KEY (id_tipo_contacto)
REFERENCES tipos_contactos (id_tipo_contacto),
CONSTRAINT FK_contactos_clinicas FOREIGN KEY (id_clinica)
REFERENCES clinicas (id_clinica)
)



CREATE TABLE OBRAS_SOCIALES_PROCEDIMIENTOS
(id_obra_social_procedimiento int,
id_proc_odontologico int,
id_obra_social int,
porc_cobertura int,
CONSTRAINT PK_obras_sociales_procedimientos PRIMARY KEY (id_obra_social_procedimiento),
CONSTRAINT FK_obras_sociales_procedimientos_procedimientos_odontologicos FOREIGN KEY (id_proc_odontologico)
REFERENCES procedimientos_odontologicos (id_proc_odontologico),
CONSTRAINT FK_obras_sociales_procedimientos_obras_sociales FOREIGN KEY (id_obra_social)
REFERENCES obras_sociales (id_obra_social)
)



CREATE TABLE PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS
(id_paciente_proc_odontologico int,		
id_paciente int,
id_proc_odontologico int,
fecha date,
costo money,
CONSTRAINT PK_pacientes_procedimientos_odontologicos PRIMARY KEY (id_paciente_proc_odontologico),
CONSTRAINT FK_pacientes_procedimientos_odontologicos_pacientes FOREIGN KEY (id_paciente)
REFERENCES pacientes (id_paciente),
CONSTRAINT FK_pacientes_procedimientos_odontologicos_procedimientos_odontologicos FOREIGN KEY (id_proc_odontologico)
REFERENCES procedimientos_odontologicos (id_proc_odontologico)
)



CREATE TABLE INSTRUMENTOS
(id_instrumento int,
nombre varchar (100),
id_marca int,
id_pais int,
nro_serie varchar (150),
fecha_adquisicion date,
fecha_ult_revision date,
fecha_proxima_revision date,
CONSTRAINT PK_instrumentos PRIMARY KEY (id_instrumento),
CONSTRAINT FK_instrumentos_marcas FOREIGN KEY (id_marca) 
REFERENCES marcas (id_marca),
CONSTRAINT FK_instrumentos_paises FOREIGN KEY (id_pais) 
REFERENCES paises (id_pais)
)




CREATE TABLE INSTRUMENTOS_CONSULTORIOS
(id_instrumento_consultorio int,
id_instrumento int,
nro_dentista int,
id_consultorio int,
CONSTRAINT PK_instrumentos_consultorios PRIMARY KEY (id_instrumento_consultorio),
CONSTRAINT FK_instrumentos_consultorios_instrumentos   FOREIGN KEY (id_instrumento)
REFERENCES instrumentos (id_instrumento),
CONSTRAINT FK_instrumentos_consultorios_dentistas FOREIGN KEY (nro_dentista)
REFERENCES dentistas (nro_dentista),
CONSTRAINT FK_instrumentos_consultorios_consultorios FOREIGN KEY (id_consultorio)
REFERENCES consultorios (id_consultorio)
)



CREATE TABLE MATERIALES
(id_material int,
nombre varchar (100),
id_marca int,
id_pais int,
fecha_vencimiento date,
cantidad int,
CONSTRAINT PK_materiales PRIMARY KEY (id_material),
CONSTRAINT FK_materiales_marcas FOREIGN KEY (id_marca)
REFERENCES marcas (id_marca),
CONSTRAINT FK_materiales_paises FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
)
CREATE TABLE INVENTARIOS
(id_inventario int,
id_instrumento int,
id_material int,
id_tipo_movimiento int,
fecha date,
cantidad int,
CONSTRAINT PK_inventarios PRIMARY KEY (id_inventario),
CONSTRAINT Fk_inventarios_instrumentos FOREIGN KEY (id_instrumento)
REFERENCES instrumentos (id_instrumento),
CONSTRAINT Fk_inventarios_materiales FOREIGN KEY (id_material)
REFERENCES materiales (id_material),
CONSTRAINT FK_inventarios_tipos_movimientos FOREIGN KEY (id_tipo_movimiento)
REFERENCES tipos_movimientos (id_tipo_movimiento)
)	








CREATE TABLE PROCEDIMIENTOS_X_INSTRUMENTOS
(id_proc_instrumento int,
id_proc_odontologico int,
id_material int,
id_instrumento int,
cantidad int,
CONSTRAINT PK_procedimientos_x_instrumentos PRIMARY KEY (id_proc_instrumento),
CONSTRAINT FK_procedimientos_x_instrumentos_procedimientos_odontologicos FOREIGN KEY (id_proc_odontologico)
REFERENCES procedimientos_odontologicos (id_proc_odontologico),
CONSTRAINT FK_procedimientos_x_instrumentos_materiales  FOREIGN KEY (id_material)
REFERENCES materiales (id_material),
CONSTRAINT FK_procedimientos_x_instrumentos_instrumentos FOREIGN KEY (id_instrumento)
REFERENCES  instrumentos (id_instrumento)
)




CREATE TABLE REPARACIONES
(id_reparacion int,
id_instrumento int,
id_tipo_reparacion int,
costo money,
CONSTRAINT PK_reparaciones PRIMARY KEY (id_reparacion),
CONSTRAINT FK_reparaciones_instrumentos FOREIGN KEY (id_instrumento)
REFERENCES instrumentos (id_instrumento),
CONSTRAINT FK_reparaciones_tipos_reparaciones FOREIGN KEY (id_tipo_reparacion)
REFERENCES tipos_reparaciones (id_tipo_reparacion)
)


INSERT INTO PAISES (id_pais,descripcion) VALUES(1,'Argentina');
INSERT INTO PAISES (id_pais,descripcion) VALUES(2,'Uruguay');
INSERT INTO PAISES (id_pais,descripcion) VALUES(3,'Brasil');
INSERT INTO PAISES (id_pais,descripcion) VALUES(4,'Chile');
INSERT INTO PAISES (id_pais,descripcion) VALUES(5,'Bolivia');
INSERT INTO PAISES (id_pais,descripcion) VALUES(6,'Colombia');
INSERT INTO PAISES (id_pais,descripcion) VALUES(7,'Paraguay');
INSERT INTO PAISES (id_pais,descripcion) VALUES(8,'Peru');
INSERT INTO PAISES (id_pais,descripcion) VALUES(9,'Ecuador');
INSERT INTO PAISES (id_pais,descripcion) VALUES(10,'Venezuela');
INSERT INTO PAISES (id_pais,descripcion) VALUES(11,'Mexico');
INSERT INTO PAISES (id_pais,descripcion) VALUES(12,'España');
INSERT INTO PAISES (id_pais,descripcion) VALUES(13,'Estados Unidos');
INSERT INTO PAISES (id_pais,descripcion) VALUES(14,'Italia');
INSERT INTO PAISES (id_pais,descripcion) VALUES(15,'Alemania');
INSERT INTO PAISES (id_pais,descripcion) VALUES(16,'Panama');
INSERT INTO PAISES (id_pais,descripcion) VALUES(17,'Guatemala');
INSERT INTO PAISES (id_pais,descripcion) VALUES(18,'Nicaragua');
INSERT INTO PAISES (id_pais,descripcion) VALUES(19,'Costa Rica');
INSERT INTO PAISES (id_pais,descripcion) VALUES(20,'Cuba');
INSERT INTO PAISES (id_pais,descripcion) VALUES(21,'China');


INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(1,'Cordoba',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(2,'Buenos Aires',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(3,'Catamarca',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(4,'Chaco',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(5,'Chubut',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(6,'Jujuy',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(7,'Corrientes',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(8,'Entre Rios',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(9,'Formosa',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(10,'La Pampa',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(11,'La Rioja',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(12,'Mendoza',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(13,'Misiones',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(14,'Neuquen',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(15,'Rio Negro',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(16,'Salta',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(17,'San Juan',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(18,'San Luis',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(19,'Santa Cruz',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(20,'Santa Fe',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(21,'Santigo Del Estero',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(22,'Tierra Del Fuego',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(23,'Tucuman',1);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(24,'Montevideo',2);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(25,'Santiago',4);
INSERT INTO PROVINCIAS (id_provincia,descripcion,id_pais) VALUES(26,'Bogota',6);



INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(1,'Cordoba',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(2,'Carloz Paz',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(3,'Adelia Maria ',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(4,'Alta Gracia',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(5,'Agua De Oro',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(6,'Agua De Tala',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(7,'Agua Pintada',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(8,'Alejandro Roca',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(9,'Arias',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(10,'Arroyo Cabral',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(11,'Arroyo La Higuera',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(12,'Ascochinga',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(13,'Bajo De Fernandez',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(14,'Bajo Del Carmen',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(15,'Bajo Grande',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(16,'Bajo Hondo',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(17,'Bajo Lindo',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(18,'Barrio Dean Funes',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(19,'Barrio La Feria',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(20,'Bo Flores Guarnicion Aerea',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(21,'Cajon Del Rio',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(22,'Calasuya',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(23,'Campo Bandillo',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(24,'Campo Los Zorroz',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(25,'Candelaria Sur',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(26,'Capilla De Siton',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(27,'Capilla La Esperanza',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(28,'Casas Vejas',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(29,'Caser Este',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(30,'Cañada De Cuevas',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(31,'Cañada Del Tala',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(32,'Cañada verde',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(33,'Cerro Pelado',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(34,'Characato',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(35,'Chañariaco',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(36,'Buenos Aires',2);  
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(37,'Mendoza',12); 
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(38,'Jesus Maria',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(39,'San Juan',17);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(40,'Villa Maria',1);
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(41,'Santiago',25);  
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(42,'Montevideo',24);  
INSERT INTO LOCALIDADES (id_localidad,descripcion,id_provincia) VALUES(43,'Bogota',26); 


INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (1,'Centro',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (2,'Alto Alberdi',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (3,'Engativa',43); 
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (4,'Jardin',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (5,'General Paz',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (6,'Franklin',41);   
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (7,'La Blanqueada',42); 
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (8,'Almagro',36); 
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (9,'San Vicente',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (10,'Alta Cordoba',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (11,'Santa Lucia',39);  
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (12,'Dorrego',37);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (13,'Yofre Norte',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (14,'Ampliacion Residencial America',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (15,'Arguello',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (16,'Ayacucho',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (17,'Las Rosas',2); 
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (18,'Ferreyra',1);
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (19,'Malvin',42);   
INSERT INTO BARRIOS(id_barrio,descripcion,id_localidad) VALUES (20,'Patricios',1);





INSERT INTO TIPOS_DOCUMENTOS (id_tipo_doc, descripcion) VALUES(1,'DNI');
INSERT INTO TIPOS_DOCUMENTOS (id_tipo_doc, descripcion) VALUES(2,'Pasaporte');
INSERT INTO TIPOS_DOCUMENTOS (id_tipo_doc, descripcion) VALUES(3,'Libreta Civica');
INSERT INTO TIPOS_DOCUMENTOS (id_tipo_doc, descripcion) VALUES(4,'Libreta Enrolamiento');
INSERT INTO TIPOS_DOCUMENTOS (id_tipo_doc, descripcion) VALUES(5,'Carnet de Conducir');
INSERT INTO TIPOS_DOCUMENTOS (id_tipo_doc, descripcion) VALUES(6,'Cuil');
INSERT INTO TIPOS_DOCUMENTOS (id_tipo_doc, descripcion) VALUES(7,'Cuit');


INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(1,'Nobis');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(2,'Sipssa');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(3,'Gea');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(4,'Prosalud');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(5,'Osde');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(6,'Ospe');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(7,'Osmedica');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(8,'Oschoca');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(9,'Medife');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(10,'Omint');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(11,'Swiss Medical');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(12,'Sancor Salud');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(13,'Osplad');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(14,'Prevencion Salud');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(15,'Cemic');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(16,'Avalian');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(17,'Premedic');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(18,'Ensalud');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(19,'Accord Salud');
INSERT INTO OBRAS_SOCIALES(id_obra_social,nombre) VALUES(20,'Pami');


INSERT INTO TIPOS_MOVIMIENTOS(id_tipo_movimiento, descripcion)VALUES(1,'Entrada');
INSERT INTO TIPOS_MOVIMIENTOS(id_tipo_movimiento, descripcion)VALUES(2,'Salida');
INSERT INTO TIPOS_MOVIMIENTOS(id_tipo_movimiento, descripcion)VALUES(3,'Reparacion');


INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(1,'Frenos Dentales',200000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(2,'Puentes e Implantes',95000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(3,'Coronas',32000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(4,'Extracciones',19000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(5,'Carrillas Dentales',120000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(6,'Protesis Dental',86000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(7,'Empastes y Reparaciones',150000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(8,'Cirugia de las Encias',70000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(9,'Selladores',40000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(10,'Blanqueamiento Dental',20000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(11,'Obturacion',18000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(12,'Dentaduras Removibles',55000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(13,'Fisioterapia Oral',60000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(14,'Cirugia bucal Ambulatoria',90000);
INSERT INTO PROCEDIMIENTOS_ODONTOLOGICOS (id_proc_odontologico,nombre,precio)VALUES(15,'Reconstruccion e Injerto de Hueso Bucal ',100000);


INSERT INTO FORMAS_DE_PAGOS (id_forma_pago, descripcion,recargo) VALUES(1,'Efectivo',0);
INSERT INTO FORMAS_DE_PAGOS (id_forma_pago, descripcion,recargo) VALUES(2,'Transferencia',0);
INSERT INTO FORMAS_DE_PAGOS (id_forma_pago, descripcion,recargo) VALUES(3,'Tarjeta Credito',15);
INSERT INTO FORMAS_DE_PAGOS (id_forma_pago, descripcion,recargo) VALUES(4,'Tarjeta Debito',5);
INSERT INTO FORMAS_DE_PAGOS (id_forma_pago, descripcion,recargo) VALUES(5,'Marcado Pago',10);


INSERT INTO  TIPOS_CONTACTOS (id_tipo_contacto,tipo_contacto)VALUES(1,'Teléfono');
INSERT INTO  TIPOS_CONTACTOS (id_tipo_contacto,tipo_contacto)VALUES(2,'Correo Electronico');
INSERT INTO  TIPOS_CONTACTOS (id_tipo_contacto,tipo_contacto)VALUES(3,'Instagram');
INSERT INTO  TIPOS_CONTACTOS (id_tipo_contacto,tipo_contacto)VALUES(4,'WhatsApp');
INSERT INTO  TIPOS_CONTACTOS (id_tipo_contacto,tipo_contacto)VALUES(5,'Twitter');
INSERT INTO  TIPOS_CONTACTOS (id_tipo_contacto,tipo_contacto)VALUES(6,'Facebook');
INSERT INTO  TIPOS_CONTACTOS (id_tipo_contacto,tipo_contacto)VALUES(7,'Mensaje Comun');
INSERT INTO  TIPOS_CONTACTOS (id_tipo_contacto,tipo_contacto)VALUES(8,'Telegram');


INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(1,'Dentista General');
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(2,'Odontopediatria');
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(3,'Ortodoncia');  
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(4,'Periodoncista');
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(5,'Endoncista');
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(6,'Patologia Dental');
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(7,'Protodoncista');
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(8,'Cirujano Maxilofacial');
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(9,'Rehabilitacion Oral');
INSERT INTO ESPECIALIDADES (id_especialidad,descripcion)VALUES(10,'Implantologia');



INSERT INTO MARCAS (id_marca ,marca)VALUES(1,'Dental X');
INSERT INTO MARCAS (id_marca ,marca)VALUES(2,'Oxy Instruments');
INSERT INTO MARCAS (id_marca ,marca)VALUES(3,'Tecno Dental');
INSERT INTO MARCAS (id_marca ,marca)VALUES(4,'Komed');
INSERT INTO MARCAS (id_marca ,marca)VALUES(5,'Novaplus');
INSERT INTO MARCAS (id_marca ,marca)VALUES(6,'Ordisi');
INSERT INTO MARCAS (id_marca ,marca)VALUES(7,'Hu-Friedy');
INSERT INTO MARCAS (id_marca ,marca)VALUES(8,'Kerr');
INSERT INTO MARCAS (id_marca ,marca)VALUES(9,'Dentsply Sirona');
INSERT INTO MARCAS (id_marca ,marca)VALUES(10,'Coltene');
INSERT INTO MARCAS (id_marca ,marca)VALUES(11,'Carl Martin');
INSERT INTO MARCAS (id_marca ,marca)VALUES(12,'Paradise Dental Technologies');
INSERT INTO MARCAS (id_marca ,marca)VALUES(13,'Premier Dental');
INSERT INTO MARCAS (id_marca ,marca)VALUES(14,'Septodont');
INSERT INTO MARCAS (id_marca ,marca)VALUES(15,'NSK');
INSERT INTO MARCAS (id_marca ,marca)VALUES(16,'W&H');
INSERT INTO MARCAS (id_marca ,marca)VALUES(17,'Satelec');
INSERT INTO MARCAS (id_marca ,marca)VALUES(18,'LM-Dental');
INSERT INTO MARCAS (id_marca ,marca)VALUES(19,'Ultradent');
INSERT INTO MARCAS (id_marca ,marca)VALUES(20,'GC Corporation');
INSERT INTO MARCAS (id_marca ,marca)VALUES(21,'3M ESPE');
INSERT INTO MARCAS (id_marca ,marca)VALUES(22,'KaVo');
INSERT INTO MARCAS (id_marca ,marca)VALUES(23,'Ivoclar Vivadent');
INSERT INTO MARCAS (id_marca ,marca)VALUES(24,'Medesy');
INSERT INTO MARCAS (id_marca ,marca)VALUES(25,'Zhermack');
INSERT INTO MARCAS (id_marca ,marca)VALUES(26,'Woodpecker');


INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(1,'Reemplazo de una pieza');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(2,'Afilado de una pieza');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(3,'Reparación de un cable');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(4,'Reparación de grieta o fractura');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(5,'Reajuste y lubricación de mecanismos');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(6,'Cambio de bateria');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(7,'Calibración y ajuste');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(8,'Mantenimiento y limpieza general');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(9,'Cambio de jeringa');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(10,'Reemplazo de puntas desgastadas');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(11,'Cambio de espejo');
INSERT INTO TIPOS_REPARACIONES(id_tipo_reparacion,descripcion)VALUES(12,'Cambio de motor');





INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(1,'Valentina','Rosa',351511975 ,'18/05/2000',42648536,'valentinarosa@gmail.com','25 de Mayo', 458,1,1,2);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(2,'Juan Fernando','Perez',351186591,'12/06/1985',31217340  ,'juanfernandoperez@gmail.com','Colon', 1689,1,1,4);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(3,'Martin', 'Acosta',351685987,'23/02/1980',29008452,'martinacosta@gmail.com' ,'Velez' ,987 ,1 ,2,9);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(4,'Oscar','Martinez',351563254 ,'07/10/1975' ,23855204 ,'oscarmartinez@gmail.com','Isabella Catolica',347 ,1 ,10 ,11);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(5,'Maria' ,'Del Carmen',351252643,'08/08/1986' ,33599332 ,'mariadelcarmen86@gmail.com','Oncativo',729 ,1 ,5 ,8 );
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(6,'Antonio','Garcia',351321578,'15/07/1969' ,18174804 ,'antoniogarcia@gmail.com','Entre Rios',325,1,9,7);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(7,'Mirtha Batriz','Dunaevsky',351529691,'06/01/1951',6789246,'mirtabeatrizdunaevsky@gmail.com','Joaquin Montaña',849,1,14,20 );
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(8,'Pedro','Molina',351529771, '17/12/1990',34715384,'pedromolina@gmail.com','Arturo Cabdevila',1697,1,16,2);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(9,'Jose','Sanchez',351516189,'19/04/2002',43450682,'josesanchez02@gmail.com','La Salle',1298,1,15,11 );
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(10,'Marcelo','Tejeda',351465132,'12/09/1984',30470032,'mtejeda@gmail.com','Don Bosco',889,1,8,15 );
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(11,'Federico','Arias',351782694,'20/09/1992',37635206,'federicoarias@gmail.com','Los Pinos',96,1,17,11);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(12,'Alejandro','Miro',264458525,'11/02/1963',14693198,'alejandromiro@gmail.com','San Francisco',1238,1,11,14);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(13,'Malena','Acevedo',261846353,'14/05/2001',43429150,'malenaacevedo@gmail.com','French',987,1,12,19);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(14,'Juan Carlos','Del Rio',351612145,'28/03/1960',14501769,'juancarlosdelrio@gmail.com','Wilson',1964,1,13,20);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(15,'Emilio','Rodriguez',301235896 ,'27/08/1981',4748562,'emiliorodriguez@gmail.com','Carrera 86',82,2,3,15);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(16,'Alberto','Placeres',351803657,'04/10/1978',26498528,'albertoplaceres@gmail.com','Juan de Alagon',532,1,18,13);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(17, 'Diego','Di Ciariaco',262883276,'09/07/1974',15168142,'diegodiciriaco@gmail.com','Verdi',416,2,19,10);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(18,'Rocio','Gomez',220451995,'01/05/2003',12127046,'rociogomez@gmail.com','Mariano Moreno',758,2,7,12);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(19,'Laura','Diaz',620994863,'18/06/1993',2325698,'lauradiaz@gmail.com','Arauco',548,2,6,18);
INSERT INTO PACIENTES (id_paciente,nombre,apellido,nro_telefono,fecha_nacimiento,nro_documento,email,calle,altura,id_tipo_doc,id_barrio,id_obra_social)VALUES(20,'Cristian','Saez',351206497,'07/10/2005',45524328,'cristiansaez49@gmail.com','Juan de Dios',421,1,18,11 );


INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(1,'Carlos','Raul',1,16254836,351511975,1,'MO96947','carlosruiz@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(2,'Javier','Hernandez',1,24120296,351514183,2,'MO96948','javierhernandez@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(3,'Jorge','Blazquez',1,20359647,35129775,3,'MO96949','jorgeblazquez@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(4,'Adrian','Pardo',1,18947852,351135684,9,'MO96950','adrianpardo@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(5,'Ruben','Moya',1,25168495,351299376,4,'MO96951','rubenmoya@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(6,'Juan Manuel','Arenas',1,17426863,351915652,10,'MO96952','juanmanuelarenas@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(7,'Andrea','Castillo',1,28576954,351363387,7,'MO96953','andreacastillo@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(8,'Juana','Alfaro',1,32689231,351298364,3,'MO96954','juanaalfaro@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(9,'Marta','Picazo',1,30665298,351376248,3,'MO96955','martapicazo@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(10,'Raquel','Alvarez',1,14387692,351238754,4,'MO96956','raquelalvarez@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(11,'Ana Maria','Muñoz',1,16587695,351699524,3,'MO96957', 'anamariamuñoz@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(12,'Agustin','Cortes',1,23289654,351496258,1,'MO96958','agustincortes@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(13,'Gustavo ','Alvizo',1,26543922,351757684,6,'MO96959','gustavoalvizo@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(14,'Javier','Milei',1,21834641,351696524,5,'MO96960','javiermilei@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(15,'Jorge Luis ','Navarro',1,18256489,351458939,10,'MO96961','joseluisnavarro@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(16,'Gonzalo ','Tolosa',1,14369951,351463215,2,'MO96962','gonzalotoloza@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(17,'Maria  Dolores','Gonzalez',1,22579865,351625423,6,'MO96963','mariadoloresgonzalez@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(18,'Nicolas','Quiroga',1,28659325,351358656,8,'MO96964','nicolasquiroga@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(19,'Vanesa','Del Valle',1,29554632,351029658,5,'MO96965','vanesadelvalle@gmail.com');
INSERT INTO DENTISTAS(nro_dentista,nombre,apellido,id_tipo_doc,nro_documento,nro_telefono,id_especialidad,nro_matricula,email )VALUES(20,'Walter','Enriquez',1,23789143,351626359,8,'MO96966','walterenriquez@gmail.com');


 
 INSERT INTO CLINICAS(id_clinica,nombre,altura,calle,hora_apertura,hora_cierre,id_barrio)VALUES (1,'Clinica Delntal LL',1566,'Mariano Fragueiro','8:00','20:30',10);



 

 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(1,'02/10/2016',1,1,1);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(2,'18/11/2016',1,2,2);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(3,'24/06/2017',1,3,3);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(4,'06/09/2018',1,4,4);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(5,'16/10/2018',1,5,5);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(6,'12/12/2017',1,6,6);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(7,'28/02/2017',1,7,7);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(8,'30/10/2019',1,8,8);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(9,'15/07/2020',1,9,9);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(10,'21/09/2021',1,10,10);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(11,'15/03/2020',1,11,11);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(12,'11/07/2021',1,12,12);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(13,'19/08/2017',1,13,13);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(14,'24/06/2018',1,14,14);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(15,'22/02/2018',1,15,15);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(16,'27/12/2016',1,16,16);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(17,'26/08/2019',1,17,17);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(18,'21/05/2019',1,18,1);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(19,'23/09/2019',1,19,4);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(20,'17/03/2021',1,20,2);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(21,'25/04/2023',1,15,9);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(22,'21/03/2023',1,17,10);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(23,'14/02/2023',1,14,14);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(24,'05/10/2022',1,11,15);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(25,'10/11/2022',1,8,17);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(26,'09/09/2022',1,6,3);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(27,'01/08/2022',1,9,6);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(28,'02/06/2023',1,7,5);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(29,'24/04/2023',1,3,7);
 INSERT INTO FACTURAS(nro_factura,fecha,id_clinica,id_paciente,nro_dentista)VALUES(30,'07/07/2022',1,1,8);

 
 



 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(1,1,1,55000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(2,2,1,55000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(3,3,10,9500);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(4,4,4,6000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(5,5,3,21000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(6,6,2,60550);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(7,7,7,115000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(8,8,6,75400);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(9,9,11,37900);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(10,10,14,77800);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(11,11,10,13500);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(12,12,1,180000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(13,13,10,9500);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(14,14,10,11600);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(15,15,1,150000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(16,16,8,21000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(17,17,10,12200);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(18,18,12,33000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(19,19,9,18700);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(20,20,15,75000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(21,21,14,90000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(22,22,13,60000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(23,23,4,15000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(24,24,4,13000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(25,25,6,79500);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(26,26,8,65000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(27,27,3,27800);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(28,28,5,120000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(29,29,4,15000);
 INSERT INTO DETALLE_FACTURAS(id_detalle_factura,nro_factura,id_proc_odontologico,precio)VALUES(30,30,10,18250);
 

 

 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(1,1,1,30000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(2,2,1,30000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(3,3,1,9500);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(4,4,2,6000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(5,5,2,21000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(6,6,1,30275);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(7,7,2,70000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(8,8,5,40000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(9,9,1,37900);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(10,10,2,47000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(11,11,2,13500);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(12,12,2,120000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(13,13,1,50000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(14,14,1,11600);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(15,15,2,100000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(16,16,2,21000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(17,17,1,12200);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(18,18,2,33000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(19,19,1,18700);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(20,20,2,40000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(21,21,2,50000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(22,22,1,30000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(23,23,2,15000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(24,24,1,13000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(25,25,2,50000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(26,26,2,40000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(27,27,1,27800);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(28,28,2,100000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(29,29,1,15000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(30,30,2,18250);     
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(31,1,4,25000);    
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(32,2,4,25000);   
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(33,6,4,30275);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(34,7,3,45000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(35,8,4,35400);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(36,10,4,30800);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(37,12,3,60000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(38,13,4,45000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(39,15,3,50000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(40,20,4,35000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(41,21,4,40000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(42,22,3,30000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(43,25,4,29500);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(44,26,4,25000);
 INSERT INTO FACTURAS_FORMAS_PAGOS(id_factura_forma_pago,nro_factura,id_forma_pago,monto)VALUES(45,28,3,20000);



 INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(1,'Consultorio N_1',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(2,'Consultorio N_2',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(3,'Consultorio N_3',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(4,'Consultorio N_4',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(5,'Consultorio N_5',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(6,'Consultorio N_6',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(7,'Consultorio N_7',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(8,'Consultorio N_8',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(9,'Consultorio N_9',1);
INSERT INTO CONSULTORIOS (id_consultorio,descripcion,id_clinica)VALUES(10,'Consultorio N_10',1);



 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(1,'Odontodentisll',6,1);
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(2,'Dentaldentisll',3,1); 
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(3,'3515895724',4,1);
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(4,'03514780852',1,1);
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(5,'3514591364',1,1);
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(6,'03514320394',1,1);
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(7,'dentisllturnos@gmail.com',2,1);
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(8,'dentisllinformes@gmail.com',2,1);
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(9,'GrupoTGDentis',8,1);
 INSERT INTO CONTACTOS (id_contacto,contacto,id_tipo_contacto,id_clinica)VALUES(10,'Dentaldentisll',5,1);



 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(1,1,11,60);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(2,7,2,20);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(3,3,7,15);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(4,8,15,25);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(5,5,9,45);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(6,9,13,10);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(7,15,17,25);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(8,10,8,5);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(9,12,20,40);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(10,2,2,20);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(11,13,18,15);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(12,15,14,10);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(13,6,20,35);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(14,7,17,35);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(15,14,4,5);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(16,11,1,15);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(17,3,16,25);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(18,2,19,25);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(19,1,11,30);
 INSERT INTO OBRAS_SOCIALES_PROCEDIMIENTOS(id_obra_social_procedimiento,id_proc_odontologico,id_obra_social,porc_cobertura)VALUES(20,4,6,5);



 
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(1,1,1,'02/10/2016',55000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(2,2,1,'18/11/2016',55000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(3,3,10,'24/06/2017',9500);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(4,4,4,'06/09/2018',6000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(5,5,3,'16/10/2018',21000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(6,6,2,'12/12/2017',60550);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(7,7,7,'28/02/2017',115000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(8,8,6,'30/10/2019',75400);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(9,9,11,'15/07/2020',37900);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(10,10,14,'21/09/2021',77800);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(11,11,10,'15/03/2020',13500);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(12,12,1,'11/07/2021',180000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(13,13,10,'19/08/2017',9500);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(14,14,10,'24/06/2018',11600);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(15,15,1,'22/02/2018',150000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(16,16,8,'27/12/2016',21000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(17,17,10,'26/08/2019',12200);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(18,18,12,'21/05/2019',33000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(19,19,9,'23/09/2019',18700);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(20,20,15,'17/03/2021',75000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(21,15,14,'25/04/2023',90000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(22,17,13,'21/03/2023',60000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(23,14,4,'14/02/2023',15000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(24,11,4,'05/10/2022',13000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(25,8,6,'10/11/2022',79500);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(26,6,8,'09/09/2022',65000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(27,9,3,'01/08/2022',27800);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(28,7,5,'02/06/2023',120000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(29,3,4,'24/04/2023',15000);
INSERT INTO PACIENTES_PROCEDIMIENTOS_ODONTOLOGICOS(id_paciente_proc_odontologico,id_paciente,id_proc_odontologico,fecha,costo)VALUES(30,1,10,'07/07/2022',18250);

 
 
 


INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(1,'Espejo dental',1,21,40001,'20/3/2016','3/4/2023','3/7/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(2,'Torno',1,21,50017,'20/3/2019','7/5/2023','7/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision)VALUES(3,'Torno',1,21,40001,'7/1/2016','7/5/2019');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(4,'Mango de bisturí',9,21,50017,'15/2/2016','3/4/2023','3/7/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(5,'Explorador dental',11,21,77999,'10/10/2022','1/5/2023','1/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision)VALUES(6,'Explorador dental',14,21,67595,'12/1/2020','8/10/2022');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(7,'Explorador dental',17,21,77998,'10/10/2022','1/5/2023','1/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(8,'Pinzas de algodón',25,21,50017,'7/7/2016','17/1/2023','17/7/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(9,'Lima para hueso',26,21,55000,'7/7/2022','17/5/2023','17/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision)VALUES(10,'Lima para hueso',26,21,43023,'7/7/2017','5/7/2022');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(11,'Pulidor dental',2,21,75849,'22/4/2022','9/5/2023','9/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision)VALUES(12,'Pulidor dental',5,21,50119,'7/7/2016','21/4/2022');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(13,'Bandeja de impresión',7,21,51111,'22/4/2016','9/5/2023','9/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(14,'Bandeja de impresión',19,21,51112,'22/4/2017','9/5/2023','9/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(15,'Jeringa anestesia',19,21,50233,'22/4/2016','10/5/2023','10/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(16,'Jeringa anestesia',18,21,85545,'5/9/2022','10/5/2023','10/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(17,'Aspiradora dental',8,21,66667,'22/4/2016','9/5/2023','9/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(18,'Aspiradora dental',8,21,30017,'22/4/2017','9/5/2023','9/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(19,'Aspiradora dental',12,21,50100,'2/6/2019','9/5/2023','9/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(20,'Torno',12,21,99556,'7/3/2022','7/5/2023','7/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(21,'Pinzas',4,21,10023,'7/3/2016','7/5/2023','7/8/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(22,'Pinzas',4,21,56899,'3/5/2021','10/4/2023','10/7/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(23,'Fresas dentales',3,21,50017,'3/5/2016','10/4/2023','10/7/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(24,'Fresas dentales',13,21,89994,'3/5/2022','10/4/2023','10/7/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(25,'Forcep dental',16,21,00600,'3/3/2016','7/3/2023','7/6/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(26,'Forcep dental',15,21,50000,'8/5/2021','7/3/2023','7/6/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(27,'Cucharilla de dentina',15,21,23337,'8/5/2016','7/5/2023','7/9/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(28,'Cucharilla de dentina',7,21,78669,'8/5/2022','7/5/2023','7/9/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(29,'Espejo dental',7,21,78009,'7/3/2019','3/4/2023','3/7/2023');
INSERT INTO INSTRUMENTOS(id_instrumento,nombre,id_marca,id_pais,nro_serie,fecha_adquisicion,fecha_ult_revision,fecha_proxima_revision)VALUES(30,'Espejo dental',1,21,99998,'20/5/2022','3/4/2023','3/7/2023');


 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(1,2,1,1);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(2,3,2,2);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(3,3,3,3);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(4,11,4,4);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(5,18,5,5);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(6,2,6,6);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(7,9,7,7);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(8,3,1,1);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(9,2,2,2);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(10,11,3,3);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(11,2,4,4);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(12,30,5,5);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(13,18,6,6);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(14,2,7,7);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(15,11,1,1);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(16,21,2,2);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(17,21,3,3);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(18,3,4,4);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(19,14,5,5);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(20,23,6,6);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(21,17,7,7);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(22,21,1,1);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(23,11,2,2);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(24,2,3,3);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(25,21,4,4);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(26,25,5,5);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(27,27,6,6);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(28,24,7,7);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(29,15,1,1);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(30,15,2,2);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(31,15,3,3);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(32,17,4,4);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(33,24,5,5);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(34,2,6,6);
 INSERT INTO INSTRUMENTOS_CONSULTORIOS(id_instrumento_consultorio,id_instrumento,nro_dentista,id_consultorio)VALUES(35,30,7,7);



INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(1,'Anestesia',1,13,'1/12/2024',690);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(2,'Anestesia',14,13,'10/12/2020',800);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(3,'Jeringa blanqueadora',10,13,'29/12/2020',200);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(4,'Jeringa blanqueadora',9,21,'10/12/2026',500);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(5,'Guantes descartables',9,1,750);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(6,'Guantes descartables',26,1,800);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(7,'Gasas',24,1,550);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(8,'Gasas',23,1,850);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(9,'Algodón',23,1,640);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(10,'Algodón',2,1,740);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(11,'Brackets',3,13,230);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(12,'Brackets',4,13,540);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(13,'Barbijo',5,1,1200);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(14,'Barbijo',7,1,1200);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(15,'Hoja de bisturí',7,21,900);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,cantidad)VALUES(16,'Hoja de bisturí',7,1,675);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(17,'Anestesia',10,21,'5/12/2026',3000);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(18,'Anestesia',1,13,'10/12/2020',1500);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(19,'Jeringa blanqueadora',1,13,'29/12/2020',2000);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(20,'Jeringa blanqueadora',1,1,'10/12/2024',3500);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(21,'Hidróxido de calcio',5,1,'7/12/2021',890);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(22,'Hidróxido de calcio',5,1,'15/12/2024',1000);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(23,'Cemento dental',14,13,'15/12/2026',895);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(24,'Cemento dental',9,1,'15/12/2023',380);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(25,'Pasta',8,1,'1/12/2020',1360);
INSERT INTO MATERIALES(id_material,nombre,id_marca,id_pais,fecha_vencimiento,cantidad)VALUES(26,'Pasta',17,13,'7/12/2024',2300);






INSERT INTO INVENTARIOS(id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(1,3,2,'7/5/2019',1);
INSERT INTO INVENTARIOS(id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(2,6,2,'8/10/2022',1);
INSERT INTO INVENTARIOS(id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(3,10,2,'5/7/2022',1);
INSERT INTO INVENTARIOS	(id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(4,12,2,'21/4/2022',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(5,1,1,'20/3/2016',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(6,2,1,'20/3/2017',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(7,4,1,'15/2/2016',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(8,7,1,'10/10/2022',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(9,8,1,'7/7/2016',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(10,14,1,'22/4/2017',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(11,16,1,'5/9/2022',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(12,9,3,'17/5/2023',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(13,30,3,'10/4/2023',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(14,27,3,'7/5/2023',1);
INSERT INTO INVENTARIOS (id_inventario,id_instrumento,id_tipo_movimiento,fecha,cantidad)VALUES(15,24,3,'3/4/2023',1);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(16,11,2,'11/7/2019',32);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(17,13,2,'17/9/2022',1);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(18,5,2,'3/6/2022',2);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(19,1,2,'5/10/2018',2);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(20,2,1,'2/3/2017',800);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(21,3,1,'5/3/2019',200);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(22,20,2,'20/7/2022',6);
INSERT INTO INVENTARIOS(id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(23,12,1,'15/5/2023',540);
INSERT INTO INVENTARIOS(id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(24,15,1,'16/7/2021',900);
INSERT INTO INVENTARIOS(id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(25,9,2,'1/1/2019',1);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(26,16,2,'3/4/2018',2);
INSERT INTO INVENTARIOS (id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(27,26,1,'4/4/2017',2300);
INSERT INTO INVENTARIOS(id_inventario,id_material,id_tipo_movimiento,fecha,cantidad)VALUES(28,25,2,'7/7/2017',2);


 

INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(1,1,11,32);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(2,1,13,1);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(3,1,5,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(4,1,18);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(5,4,1,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(6,4,5,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(7,4,13,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(8,4,1);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(9,4,15);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(10,4,17);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(11,4,21);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(12,10,20,6);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(13,10,11);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(14,8,1,3);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(15,8,5,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(16,8,9,1);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(17,8,16,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(18,8,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(19,8,1);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(20,8,4);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(21,7,1,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_material,cantidad)VALUES(22,7,25,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(23,7,2);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(24,7,7);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(25,7,9);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(26,7,15);
INSERT INTO PROCEDIMIENTOS_X_INSTRUMENTOS(id_proc_instrumento,id_proc_odontologico,id_instrumento)VALUES(27,7,18);


 
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(1,1,11,1000);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(2,2,3,500);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(3,3,3,500);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(4,5,10,1625);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(5,6,10,1625);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(6,11,7,4500);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(7,15,9,2500);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(8,16,9,2500);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(9,11,3,2250);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(10,17,12,12850);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(11,18,1,9200);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(12,19,3,2000);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(13,27,10,3100);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(14,28,10,3100);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(15,9,8,2000);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(16,30,11,4500);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(17,20,6,4780);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(18,21,8,2500);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(19,22,8,2500);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(20,23,1,3100);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(21,24,4,3240);
INSERT INTO REPARACIONES(id_reparacion,id_instrumento,id_tipo_reparacion,costo)VALUES(22,14,8,1300);

/*
Se quiere saber de la clínica dental: Las facturas con los campos (nro_factura, fecha), el nombre de la clínica,
el nombre completo del dentista en una sola columna y lo mismo con el paciente.
Del paciente también se requieren las formas de contacto y qué procedimiento odontológico se hizo,
el precio en el detalle factura y la forma en que pagó el procedimiento.
Agregar un alias a los campos que sean necesarios.
La fecha de la factura no tienen que ser de los años 
(2020, 2021 y 2022), el precio en el detalle_factura tiene que ser inferior a 100000
y la inicial del nombre de los pacientes tienen que estar entre la 'A' y la 'M'.
El orden tiene que ser por las fechas más recientes y por apellido del paciente.
*/

SELECT F.nro_factura,F.fecha,C.nombre,D.apellido+', '+D.nombre 'dentista',
P.apellido+', '+P.nombre 'paciente',P.nro_telefono,P.email,PO.nombre 'procedimiento',DF.precio,
FP.descripcion 'forma de pago'
FROM FACTURAS F,CLINICAS C, PACIENTES P, DENTISTAS D,DETALLE_FACTURAS DF,
PROCEDIMIENTOS_ODONTOLOGICOS PO, FACTURAS_FORMAS_PAGOS FFP, FORMAS_DE_PAGOS FP
WHERE F.id_clinica = C.id_clinica
AND F.id_paciente = P.id_paciente
AND F.nro_dentista = D.nro_dentista
AND DF.nro_factura = F.nro_factura
AND DF.id_proc_odontologico = PO.id_proc_odontologico
AND FFP.nro_factura = F.nro_factura
AND FFP.id_forma_pago = FP.id_forma_pago
AND YEAR(F.fecha) NOT IN (2020,2021,2022)
AND DF.precio < 100000
AND P.nombre LIKE '[A-M]%'
ORDER BY F.fecha DESC, P.apellido;


/*
Se necesitan los instrumentos de la clínica dental con toda su información, excepto el identificador. 
La marca debe estar en mayúsculas y se deben rotular los campos necesarios. 
Todos los instrumentos deben tener fecha de próxima revisión y haber sido adquiridos en los meses (3, 8, 9 y 10) de cualquier año. 
Ordenar por fecha de adquisición de más antigua a más reciente y por nombre de instrumento de la 'Z' a la 'A'. 
Seleccionar solo los primeros 5 instrumentos que cumplan con estas condiciones.
*/
--Join implicito
SELECT TOP 5 I.nombre 'instrumento', I.nro_serie,UPPER(M.marca)'marca',P.descripcion 'país',
I.fecha_adquisicion,I.fecha_ult_revision,I.fecha_proxima_revision
FROM INSTRUMENTOS I, MARCAS M, PAISES P
WHERE I.id_marca = M.id_marca
AND I.id_pais = P.id_pais
AND (fecha_proxima_revision IS NOT NULL AND MONTH(fecha_adquisicion) IN (3,8,9,10))
ORDER BY I.fecha_adquisicion, I.nombre DESC;

--Join explicito
SELECT TOP 5 I.nombre 'instrumento', I.nro_serie, UPPER(M.marca)'marca', P.descripcion'país',
I.fecha_adquisicion, I.fecha_ult_revision, I.fecha_proxima_revision
FROM INSTRUMENTOS I
JOIN MARCAS M ON I.id_marca = M.id_marca
JOIN PAISES P ON I.id_pais = P.id_pais
WHERE I.fecha_proxima_revision IS NOT NULL
AND MONTH(I.fecha_adquisicion) IN (3, 8, 9, 10)
ORDER BY I.fecha_adquisicion, I.nombre DESC;


/*
Recupera los datos de los pacientes, sus documentos, números de teléfono, correos electrónicos, información de factura, 
fechas, dentistas, precios de procedimientos y nombres de procedimientos para las facturas emitidas entre el 1 de enero de 2017 
y el 31 de diciembre de 2023, con un precio de detalle de factura igual o superior a 60000. 
Muestra los resultados en orden ascendente según el apellido del paciente. 
Limita la salida a los primeros 10 resultados.
*/

SELECT TOP 10 P.apellido + SPACE(1)  + P.nombre 'Paciente',P.nro_documento'Documento', P.nro_telefono'Telefono', P.email'Correo Electronico',
B.descripcion'Barrio',F.nro_factura'Factura',F.fecha'Fecha',
D.apellido + SPACE(1)  + D.nombre 'Dentista', DF.precio 'Precio',PO.nombre'Procedimiento'
FROM  FACTURAS F 
JOIN PACIENTES P ON F.id_paciente = P.id_paciente
JOIN DENTISTAS D ON F.nro_dentista = D.nro_dentista
JOIN DETALLE_FACTURAS DF ON F.nro_factura = DF.nro_factura
JOIN PROCEDIMIENTOS_ODONTOLOGICOS PO ON DF.id_proc_odontologico = PO.id_proc_odontologico
JOIN BARRIOS B ON P.id_paciente=B.id_barrio
WHERE F.fecha BETWEEN '1/1/2017' and '31/12/2023' and DF.precio >=60000
ORDER BY P.apellido Asc


/*
Recupera los datos de los instrumentos en los consultorios, incluyendo el identificador del instrumento en consultorio, 
el nombre del instrumento, el número de serie, la marca, el origen, el nombre del consultorio, 
el nombre del dentista, la especialidad del dentista, la fecha de adquisición del instrumento, la fecha de la última revisión, 
la fecha de la próxima revisión. Selecciona solo los instrumentos adquiridos en el año 2016, 
con una fecha de próxima revisión no nula y cuyas especialidades de los dentistas comiencen con una letra entre 'M' y 'Z'. 
Ordena los resultados en orden descendente según el nombre del instrumento.
*/
SELECT  IC.id_instrumento_consultorio'Identificador IC',I.nombre'Nombre',I.nro_serie'NRO_SERIE',
M.marca'Marca',p.descripcion'Origen',C.descripcion'Nombre Consultorio',D.apellido+SPACE(1) +D.nombre'Dentista',
E.descripcion'Especialidad',I.fecha_adquisicion'Adquisicion',I.fecha_ult_revision'Ultima Revision',I.fecha_proxima_revision'Proxima Revision'
FROM INSTRUMENTOS_CONSULTORIOS IC, INSTRUMENTOS I,MARCAS M, PAISES P, DENTISTAS D, CONSULTORIOS C, ESPECIALIDADES E, CLINICAS CL
WHERE IC.id_instrumento=I.id_instrumento 
AND IC.nro_dentista=D.nro_dentista 
AND IC.id_consultorio = C.id_consultorio 
AND I.id_marca=M.id_marca 
AND I.id_pais=P.id_pais
AND D.id_especialidad=E.id_especialidad 
AND C.id_clinica= CL.id_clinica
AND YEAR(I.fecha_adquisicion) IN (2016) AND I.fecha_proxima_revision IS NOT NULL
AND E.descripcion LIKE '[M-Z]%'
ORDER BY I.nombre Desc