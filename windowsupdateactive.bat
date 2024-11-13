@echo off
echo Habilitando Windows Update...

:: Configura el servicio de Windows Update para que se inicie automáticamente
sc config wuauserv start= auto
echo Windows Update configurado para iniciarse automáticamente.

:: Inicia el servicio de Windows Update
net start wuauserv
echo Servicio Windows Update iniciado.

:: Abre la ventana de Windows Update para buscar actualizaciones
start ms-settings:windowsupdate
echo Abriendo la interfaz de Windows Update...

pause
