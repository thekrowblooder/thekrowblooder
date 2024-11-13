Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Diccionario de rutas base para claves de registro
$RegPaths = @{
    "PowerSettings" = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00"
    "TcpIpParameters" = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
    "MemoryManagement" = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
    "PriorityControl" = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"
    "MouseSettings" = "HKCU:\Control Panel\Mouse"
    "GameConfigStore" = "HKCU:\System\GameConfigStore"
}

# Función para obtener valores del registro
function Get-RegistryValue {
    param (
        [string]$Section,
        [string]$Name
    )
    $Path = $RegPaths[$Section]
    if ($Path) {
        try {
            $value = (Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop).$Name
            return $value
        } catch {
            return "No configurado"
        }
    } else {
        return "Error: sección no definida"
    }
}

# Función para establecer valores en el registro
function Set-RegistryValue {
    param (
        [string]$Section,
        [string]$Name,
        [string]$Value
    )
    $Path = $RegPaths[$Section]
    if ($Path) {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value
    }
}

# Función para aplicar todas las optimizaciones
function Apply-Optimizations {
    Set-RegistryValue -Section "PowerSettings" -Name "Attributes" -Value 0
    Set-RegistryValue -Section "TcpIpParameters" -Name "TcpAckFrequency" -Value 1
    Set-RegistryValue -Section "MemoryManagement" -Name "DisablePagingExecutive" -Value 1
    Set-RegistryValue -Section "PriorityControl" -Name "Win32PrioritySeparation" -Value 26
    Set-RegistryValue -Section "MouseSettings" -Name "MouseSpeed" -Value 1
    Set-RegistryValue -Section "GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2

    [System.Windows.Forms.MessageBox]::Show("Las configuraciones se han optimizado con éxito para un mejor rendimiento.", "Optimización Aplicada", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    UpdateStatus
}

# Función para revertir las optimizaciones a los valores por defecto
function Revert-Optimizations {
    # Restablecer valores predeterminados
    Set-RegistryValue -Section "PowerSettings" -Name "Attributes" -Value 1
    Set-RegistryValue -Section "TcpIpParameters" -Name "TcpAckFrequency" -Value 0
    Set-RegistryValue -Section "MemoryManagement" -Name "DisablePagingExecutive" -Value 0
    Set-RegistryValue -Section "PriorityControl" -Name "Win32PrioritySeparation" -Value 18
    Set-RegistryValue -Section "MouseSettings" -Name "MouseSpeed" -Value 0
    Set-RegistryValue -Section "GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 0

    [System.Windows.Forms.MessageBox]::Show("Las optimizaciones han sido revertidas a sus valores predeterminados.", "Reversión Completada", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    UpdateStatus
}

# Función para actualizar los valores en la interfaz
function UpdateStatus {
    $textboxPowerSettings.Text = "Ajustes de energia: " + (Get-RegistryValue -Section "PowerSettings" -Name "Attributes")
    $textboxTcpIpParameters.Text = "Optimización de red (TCP): " + (Get-RegistryValue -Section "TcpIpParameters" -Name "TcpAckFrequency")
    $textboxMemoryManagement.Text = "Gestion de memoria: " + (Get-RegistryValue -Section "MemoryManagement" -Name "DisablePagingExecutive")
    $textboxPriorityControl.Text = "Prioridad del sistema: " + (Get-RegistryValue -Section "PriorityControl" -Name "Win32PrioritySeparation")
    $textboxMouseSettings.Text = "Velocidad del ratón: " + (Get-RegistryValue -Section "MouseSettings" -Name "MouseSpeed")
    $textboxGameConfigStore.Text = "Ajustes de juego (DVR): " + (Get-RegistryValue -Section "GameConfigStore" -Name "GameDVR_FSEBehaviorMode")
}

# Crear la interfaz gráfica
$form = New-Object System.Windows.Forms.Form
$form.Text = "Optimización del Sistema"
$form.Size = New-Object System.Drawing.Size(600, 400)
$form.StartPosition = "CenterScreen"
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# TextBoxes para mostrar los valores de configuración
$textboxPowerSettings = New-Object System.Windows.Forms.TextBox
$textboxPowerSettings.Location = New-Object System.Drawing.Point(20, 20)
$textboxPowerSettings.Size = New-Object System.Drawing.Size(540, 20)
$textboxPowerSettings.ReadOnly = $true

$textboxTcpIpParameters = New-Object System.Windows.Forms.TextBox
$textboxTcpIpParameters.Location = New-Object System.Drawing.Point(20, 50)
$textboxTcpIpParameters.Size = New-Object System.Drawing.Size(540, 20)
$textboxTcpIpParameters.ReadOnly = $true

$textboxMemoryManagement = New-Object System.Windows.Forms.TextBox
$textboxMemoryManagement.Location = New-Object System.Drawing.Point(20, 80)
$textboxMemoryManagement.Size = New-Object System.Drawing.Size(540, 20)
$textboxMemoryManagement.ReadOnly = $true

$textboxPriorityControl = New-Object System.Windows.Forms.TextBox
$textboxPriorityControl.Location = New-Object System.Drawing.Point(20, 110)
$textboxPriorityControl.Size = New-Object System.Drawing.Size(540, 20)
$textboxPriorityControl.ReadOnly = $true

$textboxMouseSettings = New-Object System.Windows.Forms.TextBox
$textboxMouseSettings.Location = New-Object System.Drawing.Point(20, 140)
$textboxMouseSettings.Size = New-Object System.Drawing.Size(540, 20)
$textboxMouseSettings.ReadOnly = $true

$textboxGameConfigStore = New-Object System.Windows.Forms.TextBox
$textboxGameConfigStore.Location = New-Object System.Drawing.Point(20, 170)
$textboxGameConfigStore.Size = New-Object System.Drawing.Size(540, 20)
$textboxGameConfigStore.ReadOnly = $true

# Botón para aplicar optimizaciones
$applyButton = New-Object System.Windows.Forms.Button
$applyButton.Location = New-Object System.Drawing.Point(20, 210)
$applyButton.Size = New-Object System.Drawing.Size(250, 40)
$applyButton.Text = "Aplicar Optimizaciones"
$applyButton.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$applyButton.Add_Click({
    Apply-Optimizations
})

# Botón para revertir optimizaciones
$revertButton = New-Object System.Windows.Forms.Button
$revertButton.Location = New-Object System.Drawing.Point(310, 210)
$revertButton.Size = New-Object System.Drawing.Size(250, 40)
$revertButton.Text = "Revertir Optimizaciones"
$revertButton.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$revertButton.Add_Click({
    Revert-Optimizations
})

# Botón para salir de la aplicación
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = New-Object System.Drawing.Point(150, 270)
$exitButton.Size = New-Object System.Drawing.Size(300, 30)
$exitButton.Text = "Salir"
$exitButton.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$exitButton.Add_Click({
    $form.Close()
})

# Añadir los controles al formulario
$form.Controls.AddRange(@(
    $textboxPowerSettings, $textboxTcpIpParameters, $textboxMemoryManagement,
    $textboxPriorityControl, $textboxMouseSettings, $textboxGameConfigStore,
    $applyButton, $revertButton, $exitButton
))

# Actualizar la interfaz con el estado actual
UpdateStatus

# Mostrar el formulario
$form.ShowDialog()
