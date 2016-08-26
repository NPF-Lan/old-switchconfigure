Get-ClusterNode| ForEach-Object { Get-VM -ComputerName $_.Name}|

ForEach-Object {
    Write-Host $_.Name
    Get-VHD -computername $_.computername -path $_.HardDrives.Path|Out-Host
    Get-VHD -computername $_.computername -path $_.HardDrives.Path|Select-Object Size,FileSize
    Write-Host (Get-VHD -computername $_.computername -path $_.HardDrives.Path|Select-Object Size,FileSize)
}|Measure-Object Size, FileSize -Sum
