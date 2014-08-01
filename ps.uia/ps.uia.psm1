# ps.uia.psm1
# Root module for module 'ps.uia'

Write-Debug "Loading ps.uia"
. $PSScriptRoot\misc.ps1

# Initialize MS UIAutomation
$script:UIA_INIT = $false
if ($script:UIA_INIT -eq $false) 
{
    Initialize-UIAutomation
    $script:UIA_INIT = $true
}

# Load our .ps1 files
Write-Debug "Loads ps.uia script files"
. $PSScriptRoot\property_condition.ps1
. $PSScriptRoot\condition.ps1
. $PSScriptRoot\element.ps1
. $PSScriptRoot\element_property.ps1
. $PSScriptRoot\pattern.ps1

# export functions
Write-Debug "Exports ps.uia functions"

# condition
Export-ModuleMember -Function New-UIAPropertyCondition
Export-ModuleMember -Function New-UIAPropertyConditionArray

Export-ModuleMember -Function New-UIAAndCondition
Export-ModuleMember -Function New-UIAOrCondition
Export-ModuleMember -Function New-UIANotCondition

# element
Export-ModuleMember -Function Get-UIARootElement
Export-ModuleMember -Function Find-UIAFirstElement
Export-ModuleMember -Function Find-UIAAllElements

Export-ModuleMember -Function Get-UIAElementProperty
Export-ModuleMember -Function Get-UIAElementAllProperties

# pattern
Export-ModuleMember -Function Get-UIASupportedPatterns

