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

if OBJECT_ID('spEliminarEscuela')is not null
	drop proc spEliminarEscuela
go 

create proc spEliminarEscuela
@CodEscuela char(3)
as 
begin

	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			delete from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se elimino con éxito Escuela'
		end
	else select CodError = 1, Mensaje = 'El código Escuela no existe'
end
go

exec spEliminarEscuela'E01'
go

select*from TEscuela
go

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
			select CodError = 0, Mensaje = 'Se actualizo con éxito Escuela'
		end
	else select CodError = 1, Mensaje = 'El código Escuela no existe'
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
			select CodEscuela from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se busco con éxito la Escuela'
		end
	else select CodError = 1, Mensaje = 'El código Escuela no existe'
end
go
exec spBuscarEscuela'E02'
go

select*from TEscuela
go