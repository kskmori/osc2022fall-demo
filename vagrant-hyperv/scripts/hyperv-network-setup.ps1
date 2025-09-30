# Priviledge escalation required for New-NetIPAddress
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
       Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
       exit;
}		  

# Create a new VMSwitch only when it's not created yet
function Create-New-VMSwitch {
    param([string]$Name)
    if ($Name -notin (Get-VMSwitch | Select-Object -ExpandProperty Name)) {
       New-VMSwitch -Name $Name -SwitchType Internal
    }
}

# Use "(Default Switch)" instead of dedicated PM-management switch
#Create-New-VMSwitch -Name "PM-management"
Create-New-VMSwitch -Name "PM-heartbeat-1"
Create-New-VMSwitch -Name "PM-heartbeat-2"
Create-New-VMSwitch -Name "PM-service"

New-NetIPAddress -IPAddress "192.168.156.1" -PrefixLength 24 -InterfaceAlias "vEthernet (Default Switch)"
New-NetIPAddress -IPAddress "192.168.157.1" -PrefixLength 24 -InterfaceAlias "vEthernet (PM-heartbeat-1)"
New-NetIPAddress -IPAddress "192.168.158.1" -PrefixLength 24 -InterfaceAlias "vEthernet (PM-heartbeat-2)"
New-NetIPAddress -IPAddress "192.168.159.1" -PrefixLength 24 -InterfaceAlias "vEthernet (PM-service)"

# Enable Forwarding between Hyper-V VM and WSL2
Get-NetIPInterface -InterfaceAlias "vEthernet (Default Switch)","vEthernet (WSL (Hyper-V firewall))" -AddressFamily IPv4 | Set-NetIPInterface -Forwarding Enabled

