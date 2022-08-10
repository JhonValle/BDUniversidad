echo Instalador de la base de datos de la Universidad
echo Autor:Jhon Darwin Valle Ccorimanya
echo 8 de Agosto de 2022
sqlcmd -SLAPTOP-MOL01LD8 -E -i BDUniversidad.sql
sqlcmd -SLAPTOP-MOL01LD8 -E -i BDUniversidadPA.sql
echo Se ejecuto correctamente la base de datos
pause
