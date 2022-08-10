--Procedimientos Almacenados
--Jhon Darwin Valle Ccorimanya
--8 de agosto 2022

--PA para TEscuela

use BDUniversidad
go
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
@CodAlumno char(5),@Apellidos varchar(50),@Nombres varchar(50),@LugarNac varchar(50),@FechaNac datetime,@CodEscuela char(3) 
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
			select CodError = 0, Mensaje = 'Se elimino con éxito Alumno'
		end
	else select CodError = 1, Mensaje = 'El código Alumno no existe'
end
go

exec spEliminarAlumno'A07'
go
select*from TAlumno
go


--Actualizar Alumno--

if OBJECT_ID('spActualizarAlumno')is not null
	drop proc spActualizarAlumno
go 

create proc spActualizarAlumno
@CodAlumno char(5),@Apellidos varchar(50),@Nombres varchar(50),@LugarNac varchar(50),@FechaNac datetime,@CodEscuela char(3)
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
			select CodError = 0, Mensaje = 'Se actualizo con éxito Alumno'
		end
	else select CodError = 1, Mensaje = 'El código Alumno no existe'
end
go

exec spActualizarAlumno 'A02','Valle Ccorimanya','Jhon ','Cusco','01/01/2002','E02'
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
			select CodAlumno from TAlumno where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se busco con éxito la Alumno'
		end
	else select CodError = 1, Mensaje = 'El código Alumno no existe'
end
go
exec spBuscarAlumno'A04'
go

select*from TAlumno
go

