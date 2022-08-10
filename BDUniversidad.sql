--Base de datos Ejemplo
--Jhon Darwin Valle Ccorimanya
--08/08/2022

use master
go

if DB_ID('BDUniversidad')is not null
	drop database BDUniversidad
go
create database BDUniversidad
go

use BDUniversidad
go
--Crear Tablas
if OBJECT_ID('TEscuela')is not null
	drop table TEscuela
go

create table TEscuela
(
	CodEscuela char(3)primary key,
	Escuela varchar (50),
	Facultad varchar(50)
)
go

if OBJECT_ID('TAlumno')is not null
	drop table TAlumno
go

create table TAlumno
(
	CodAlumno char(5)primary key,
	Apellidos varchar (50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac datetime,
	CodEscuela char(3),
	foreign key(CodEscuela)references TEscuela
)
go
--Inserción de datos
--Inserción de datos TEscuela
insert into TEscuela values('E01','Sistemas','Ingenieria')
insert into TEscuela values('E02','Civil','Ingenieria')
insert into TEscuela values('E03','Industrial','Ingenieria')
insert into TEscuela values('E04','Ambiental','Ingenieria')
insert into TEscuela values('E05','Arquitectura','Ingenieria')
go

select*from TEscuela
go

--Inserción de datos TAlumno
insert into TAlumno values('A01','Pereira Aguilar','Naideli Pricila','Cusco','10/08/2004','E01')  
insert into TAlumno values('A02','Valle Ccorimanya','Jhon Darwin','Cusco','01/01/2002','E02') 
insert into TAlumno values('A03','Lopez Aguilar','Jenifer Isabel','Cusco','02/05/2003','E03') 
insert into TAlumno values('A04','Lima Collavinos','Maria Isabel','Cusco','08/03/2004','E04') 
insert into TAlumno values('A05','Condori Paja','Antonio','Cusco','10/08/2004','E05') 

select*from TAlumno
go
