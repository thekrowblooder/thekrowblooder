@echo off
echo Inhabilitando Windows Update...

:: Detiene el servicio de Windows Update
net stop wuauserv
echo Servicio Windows Update detenido.

:: Cambia el tipo de inicio del servicio de Windows Update a deshabilitado
sc config wuauserv start= disabled
echo Windows Update configurado como deshabilitado.

pause
