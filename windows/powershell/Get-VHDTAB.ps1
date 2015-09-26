[CmdletBinding()]
Param(
	[Parameter(Mandatory=$True,Position=1)]
	[string]$ComputerName
)

GET-VM -ComputerName $ComputerName|Get-VMHardDiskDrive|Select-Object -Property VMName, VMId, ComputerName, ControllerType, ControllerNumber, ControllerLocation, Path|Sort-Object -Property VMName| Out-GridView -Title "Virtual Disks"