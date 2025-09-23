function CreateNewNetwork {
    param([string]$Name, [string]$IPAddress, [int]$Prefix)
    if ($Name -notin (Get-VMSwitch | Select-Object -ExpandProperty Name)) {
        New-VMSwitch -Name $Name -SwitchType Internal

        New-NetIPAddress -IPAddress $IPAddress -PrefixLength $Prefix -InterfaceAlias "vEthernet ($Name)"
    }
}


CreateNewNetwork -Name "PM-management"  -IPAddress "192.168.156.1" -Prefix 24
CreateNewNetwork -Name "PM-heartbeat-1" -IPAddress "192.168.157.1" -Prefix 24
CreateNewNetwork -Name "PM-heartbeat-2" -IPAddress "192.168.158.1" -Prefix 24
CreateNewNetwork -Name "PM-service"     -IPAddress "192.168.159.1" -Prefix 24
