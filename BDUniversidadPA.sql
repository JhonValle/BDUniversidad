--Procedimientos Almacenados
--Jhon Darwin Valle Ccorimanya
--8 de agosto 2022

--PA para TEscuela

use BDUniversidad
go

--Listar Escuela--

if OBJECT_ID('spListarEscuela')is not null
	drop proc spListarEscuela
go
create proc spListarEscuela
as
begin
	select CodEscuela,Escuela,Facultad from TEscuela
end
go
exec spListarEscuela
go

--Agregar Escuela--

if OBJECT_ID('spAgregarEscuela')is not null
	drop proc spAgregarEscuela
go 
create proc spAgregarEscuela
@CodEscuela char(3),@Escuela varchar(50),@Facultad varchar(50)
as
begin
	--Cod Escuela no puede ser duplicado

	if not exists (select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--Escuela no puede ser duplicado
		if not exists (select Escuela from TEscuela where Escuela=@Escuela)
			begin
				insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
				select CodError=0,Mensaje='Se inserto correctamente escuela'
			end
		else select CodError=1,Mensaje='Error:Escuela duplicada'
	else select CodError=1,Mensaje='Error:CodEscuela duplicado'

end 
go

exec spAgregarEscuela 'E06','Software','Ingenieria'
go

select*from TEscuela
go

-----Actividad Implementar Eliminar ,Actualizar,Buscar--------
----Presentado para el dia miercoles 10 de Agosto-----

-----Eliminar-----------

if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create proc spEliminarEscuela
@CodEscuela char(3)
as begin
	--Comprobamos que no hayan alumnos en la EP
	if not exists (select * from TAlumno where CodEscuela=@CodEscuela)
		begin
			--CodEscuela debe existir
			if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
				begin
					delete from TEscuela where CodEscuela=@CodEscuela
					delete from TEscuela where CodEscuela='E06'
					select CodError = 0, Mensaje = 'Se elimino con �xito Escuela'
				end
			else select CodError = 1, Mensaje = 'El c�digo Escuela no existe'
		end
	else select CodError = 1, Mensaje = 'No se puede eliminar la Escuela Profesional'
end
go

exec spEliminarEscuela @CodEscuela = 'E06';
go

select * from TEscuela


-----Actualizar-----------

if OBJECT_ID('spActualizarEscuela')is not null
	drop proc spActualizarEscuela
go 

create proc spActualizarEscuela
@CodEscuela char(3),@Escuela varchar(50),@Facultad varchar(50)
as
begin
--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			update TEscuela set [Escuela] = @Escuela,
			[Facultad] = @Facultad 
			where [CodEscuela] = @CodEscuela
			select CodError = 0, Mensaje = 'Se actualizo con �xito Escuela'
		end
	else select CodError = 1, Mensaje = 'El c�digo Escuela no existe'
end
go

exec spActualizarEscuela 'E01','Sistemas','Ingenieria'
go

select*from TEscuela
go


-----Buscar-----------
if OBJECT_ID('spBuscarEscuela')is not null
	drop proc spBuscarEscuela
go 

create proc spBuscarEscuela
@CodEscuela char(3)
as 
begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			select * from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se busco con �xito la Escuela'
		end
	else select CodError = 1, Mensaje = 'El c�digo Escuela no existe'
end
go
exec spBuscarEscuela'E02'
go

select*from TEscuela
go

----PA TABLA ALUMNO--------


--Listar Alumno--

if OBJECT_ID('spListarAlumno')is not null
	drop proc spListarAlumno
go
create proc spListarAlumno
as
begin
	select CodAlumno,Apellidos,Nombres,LugarNac,FechaNac from TAlumno
end
go
exec spListarAlumno
go

--Agregar Alumno--

if OBJECT_ID('spAgregarAlumno')is not null
	drop proc spAgregarAlumno
go 
create proc spAgregarAlumno
@CodAlumno char(5),@Apellidos varchar(50),@Nombres varchar(50),@LugarNac varchar(50),@FechaNac date,@CodEscuela char(3) 
as
begin
	--Cod Alumno no puede ser duplicado

	if not exists (select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		--Alumno no puede ser duplicado
		if not exists (select Apellidos from TAlumno where Apellidos=@Apellidos)
			begin
				insert into TAlumno values(@CodAlumno,@Apellidos,@Nombres,@LugarNac,@FechaNac,@CodEscuela)
				select CodError=0,Mensaje='Se inserto correctamente alumno'
			end
		else select CodError=1,Mensaje='Error:Alumno duplicado'
	else select CodError=1,Mensaje='Error:CodAlumno duplicado'
end 
go

exec spAgregarAlumno 'A06','Mamani Quispe','Juan','Cusco','01/01/2002','E02'
go

select*from TAlumno
go

--Eliminar Alumno--

if OBJECT_ID('spEliminarAlumno')is not null
	drop proc spEliminarAlumno
go 

create proc spEliminarAlumno
@CodAlumno char(5)
as 
begin

	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			delete from TAlumno where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se elimino con �xito Alumno'
		end
	else select CodError = 1, Mensaje = 'El c�digo Alumno no existe'
end
go

exec spEliminarAlumno'A06'
go
select*from TAlumno
go



--Actualizar Alumno--

if OBJECT_ID('spActualizarAlumno')is not null
	drop proc spActualizarAlumno
go 

create proc spActualizarAlumno
@CodAlumno char(5),@Apellidos varchar(50),@Nombres varchar(50),@LugarNac varchar(50),@FechaNac date,@CodEscuela char(3)
as
begin
--Cod Alumno  debe existir
	if exists(select @CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			update TAlumno set [Apellidos] = @Apellidos,
			[Nombres] = @Nombres ,
			[LugarNac] = @LugarNac ,
			[FechaNac] = @FechaNac ,
			[CodEscuela] = @CodEscuela 
			where [CodAlumno] = @CodAlumno
			select CodError = 0, Mensaje = 'Se actualizo con �xito Alumno'
		end
	else select CodError = 1, Mensaje = 'El c�digo Alumno no existe'
end
go

exec spActualizarAlumno 'A02','Valle Ccorimanya','Jhon Darwin ','Cusco','01/01/2002','E02'
go

select*from TAlumno
go

--Buscar Alumno--

if OBJECT_ID('spBuscarAlumno')is not null
	drop proc spBuscarAlumno
go 

create proc spBuscarAlumno
@CodAlumno char(5)
as 
begin
	--Cod Alumno  debe existir
	if exists(select @CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			select * from TAlumno where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se busco con �xito la Alumno'
		end
	else select CodError = 1, Mensaje = 'El c�digo Alumno no existe'
end
go
exec spBuscarAlumno'A04'
go

select*from TAlumno
go



