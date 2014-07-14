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
. $PSScriptRoot\element.ps1
. $PSScriptRoot\property_condition.ps1
. $PSScriptRoot\condition.ps1

# export functions
Write-Debug "Exports ps.uia functions"
Export-ModuleMember -Function New-UIAPropertyConditions -Alias New-UIAPropertyConditions
Export-ModuleMember -Function New-UIAAndCondition -Alias New-UIAAndCondition
Export-ModuleMember -Function New-UIAPropertyCondition -Alias New-UIAPropertyCondition

Export-ModuleMember -Function Find-UIAElements -Alias Find-UIAElements
