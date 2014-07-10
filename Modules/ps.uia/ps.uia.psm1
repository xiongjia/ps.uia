# ps.uia.psm1
# Root module for module 'ps.uia'

Write-Debug "Loading ps.uia"
. $PSScriptRoot\misc.ps1

# Initialize MS UIAutomation
$script:uia_init = $false
if ($script:uia_init -eq $false) 
{
    Initialize-UIAutomation
    $script:uia_init = $true
}

# Load our .ps1 files
Write-Debug "Loads ps.uia script files"
. $PSScriptRoot\ps.uia.get-root-element.ps1

# export functions
Write-Debug "Exports ps.uia functions"
Export-ModuleMember -Function Get-UIARootElement -Alias Get-UIARootElement

