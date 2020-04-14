$winedition = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ProductName
if ($winedition -eq 'Windows 10 Home') {
    
    Write-Output "Adding Settings in Registry"
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'BranchReadinessLevel' -PropertyType 'DWord' -Value 20
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'DeferFeatureUpdatesPeriodInDays' -PropertyType 'DWord' -Value 365
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'DeferQualityUpdatesPeriodInDays' -PropertyType 'DWord' -Value 4
    Write-Output "Done Writing Update Settings in Registry"
}
elseif ($winedition -eq 'Windows 10 Pro N') {
    Write-Output "Windows 10 ProFessionAl"
    Import-module -Name "PolicyFileEditor"
    $MachineDir = "C:\Windows\system32\GroupPolicy\Machine\registry.pol"

    $MachinePols = Import-Clixml -Path 'C:\export.xml'

    foreach ($MachinePol in $MachinePols)
    {
        $MachinePol | Set-PolicyFileEntry -Path $MachineDir
    }
    Write-Output "Done Setting Update Policy"
}
else {
    Write-Output "You are not Running W10 Home or Professional edition"
} 
