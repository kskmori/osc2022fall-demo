
function CreateNewNetwork {
    param([string]$Name, [string]$IPAddress, [int]$Prefix)
    if ($Name -notin (Get-VMSwitch | Select-Object -ExpandProperty Name)) {
	# Priviledge escalation required for New-NetIPAddress
        #  Re-run the whole script from the beginning if escalated
	#  If all VMSwitches are already created, it should exit without prompting the escalation dialog
        if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
            Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
            exit;
        }

        New-VMSwitch -Name $Name -SwitchType Internal
        New-NetIPAddress -IPAddress $IPAddress -PrefixLength $Prefix -InterfaceAlias "vEthernet ($Name)"
    }
}


CreateNewNetwork -Name "PM-management"  -IPAddress "192.168.156.1" -Prefix 24
CreateNewNetwork -Name "PM-heartbeat-1" -IPAddress "192.168.157.1" -Prefix 24
CreateNewNetwork -Name "PM-heartbeat-2" -IPAddress "192.168.158.1" -Prefix 24
CreateNewNetwork -Name "PM-service"     -IPAddress "192.168.159.1" -Prefix 24
