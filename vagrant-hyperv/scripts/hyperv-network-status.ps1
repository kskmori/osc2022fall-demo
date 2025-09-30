# Commandlet to show the current configured status

# Forwarding status
Write-Host "=== Forwarding"
Get-NetIPInterface -InterfaceAlias "vEthernet (Default Switch)","vEthernet (WSL (Hyper-V firewall))","vEthernet (PM-management)" -AddressFamily IPv4 | Select-Object InterfaceAlias,Forwarding | Format-Table

# VMSwitch and IPAddress
Write-Host "=== VMSwitch and IPAddress"
Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -like "vEthernet*" } | Select-Object InterfaceAlias,IPAddress | Format-Table

# VMs and VMNetworkAdapter
Write-Host "=== VMs and VMNetworkAdapter"

Get-VMNetworkAdapter -VMName hv-node1 -ErrorAction SilentlyContinue
Get-VMNetworkAdapter -VMName hv-node2 -ErrorAction SilentlyContinue
Get-VMNetworkAdapter -VMName hv-storage -ErrorAction SilentlyContinue
