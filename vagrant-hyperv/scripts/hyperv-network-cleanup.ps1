
$ErrorActionPreference = "SilentlyContinue"
# for debuging
#$ErrorActionPreference = "Continue"
#$ErrorActionPreference = "Stop"


# Remove VMSwitches
Remove-VMSwitch -Name "PM-heartbeat-1" -Force
Remove-VMSwitch -Name "PM-heartbeat-2" -Force
Remove-VMSwitch -Name "PM-service"     -Force

# Remove static IPAddress on "(Default Switch)"
Remove-NetIPAddress -IPAddress "192.168.156.1" -PrefixLength 24 -InterfaceAlias "vEthernet (Default Switch)" -Confirm:$false

# Disable Forwarding between Hyper-V VM and WSL2
Get-NetIPInterface -InterfaceAlias "vEthernet (Default Switch)","vEthernet (WSL (Hyper-V firewall))" -AddressFamily IPv4 | Set-NetIPInterface -Forwarding Disabled

