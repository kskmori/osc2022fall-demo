param (
    [parameter (Mandatory=$true)]
    [string]$VMName
)

# Force error messages to use en-US to display the Vagrant output readable
[System.Threading.Thread]::CurrentThread.CurrentUICulture = 'en-US'

function Add-NewAdapter {
    param([string]$VMName, [string]$SwitchName)
    if ($SwitchName -notin (Get-VMNetworkAdapter -VMName $VMName| Select-Object -ExpandProperty SwitchName)) {
        Add-VMNetworkAdapter -VMName $VMName -SwitchName $SwitchName
    }
}

Add-NewAdapter -VMName $VMName -SwitchName "PM-heartbeat-1"
Add-NewAdapter -VMName $VMName -SwitchName "PM-heartbeat-2"
Add-NewAdapter -VMName $VMName -SwitchName "PM-service"
