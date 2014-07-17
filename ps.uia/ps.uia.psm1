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
. $PSScriptRoot\property_condition.ps1
. $PSScriptRoot\condition.ps1
. $PSScriptRoot\element.ps1
. $PSScriptRoot\pattern.ps1

# export functions
Write-Debug "Exports ps.uia functions"

# conditions
Export-ModuleMember -Function New-UIAPropertyCondition
Export-ModuleMember -Function New-UIAPropertyConditionArray
Export-ModuleMember -Function New-UIAAndCondition
# element
Export-ModuleMember -Function Get-UIARootElement
Export-ModuleMember -Function Find-UIAFirstElement
# pattern
Export-ModuleMember -Function Get-UIAElementPattern

