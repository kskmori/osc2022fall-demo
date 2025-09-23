Remove-VMSwitch -Name "PM-management"  -Force -ErrorAction SilentlyContinue
Remove-VMSwitch -Name "PM-heartbeat-1" -Force -ErrorAction SilentlyContinue
Remove-VMSwitch -Name "PM-heartbeat-2" -Force -ErrorAction SilentlyContinue
Remove-VMSwitch -Name "PM-service"     -Force -ErrorAction SilentlyContinue

#Remove-VMSwitch -Name "PM-management"  -Confirm:$false -ErrorAction SilentlyContinue
#Remove-VMSwitch -Name "PM-heartbeat-1" -Confirm:$false -ErrorAction SilentlyContinue
#Remove-VMSwitch -Name "PM-heartbeat-2" -Confirm:$false -ErrorAction SilentlyContinue
#Remove-VMSwitch -Name "PM-service"     -Confirm:$false -ErrorAction SilentlyContinue
