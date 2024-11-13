@echo off
echo Realizando mantenimiento de red y limpieza de sistema...

REM Mantenimiento de red

REM Vaciar la caché de DNS
ipconfig /flushdns
echo Caché DNS vaciada.

REM Liberar dirección IP actual
ipconfig /release
echo Dirección IP liberada.

REM Renovar dirección IP
ipconfig /renew
echo Dirección IP renovada.

REM Restablecer la caché de resolución de NetBIOS
nbtstat -R
echo Caché de NetBIOS restablecida.

REM Forzar la actualización de nombres NetBIOS y su caché
nbtstat -RR
echo Tabla de nombres NetBIOS y caché actualizadas.

REM Restablecer el stack TCP/IP (requiere reinicio)
netsh int ip reset
echo Stack TCP/IP restablecido. Es posible que se requiera reiniciar el sistema.

REM Restablecer configuración de Winsock
netsh winsock reset
echo Winsock restablecido. Es posible que se requiera reiniciar el sistema.

REM Limpieza de actualizaciones de Windows y carpetas temporales

REM Detener servicios de Windows Update
net stop wuauserv
net stop UsoSvc
net stop bits
net stop dosvc

REM Eliminar y recrear la carpeta SoftwareDistribution
rd /s /q C:\Windows\SoftwareDistribution
md C:\Windows\SoftwareDistribution
echo Carpeta SoftwareDistribution limpiada.

REM Limpieza de carpetas temporales del sistema
rd /s /q %temp%
mkdir %temp%
takeown /f "%temp%" /r /d y
takeown /f "C:\Windows\Temp" /r /d y
rd /s /q C:\Windows\Temp
mkdir C:\Windows\Temp
echo Carpetas temporales de Windows limpiadas.

REM Limpieza de archivos temporales del usuario y sistema
del /s /q "%TMP%\*.*"
del /s /q "%TEMP%\*.*"
del /s /q "%WINDIR%\Temp\*.*"
del /s /q "%USERPROFILE%\Local Settings\Temp\*.*"
del /s /q "%LOCALAPPDATA%\Temp\*.*"
echo Archivos temporales del usuario y sistema eliminados.

echo Mantenimiento de red y limpieza completados.
pause
