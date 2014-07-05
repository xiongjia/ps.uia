# ps.uia.psm1
# Root module for module 'ps.uia'

Write-Debug "Loading ps.uia"

# Load MS UIAutomation assemblies
Write-Debug "Loading MS UIA assemblies"
Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName UIAutomationTypes
Add-Type -AssemblyName UIAutomationProvider
Add-Type -AssemblyName UIAutomationClientsideProviders
$script:uia_init = $false

# Initialize UIAutomation
function Init-UIAutomation
{
    if ($script:uia_init) 
    {
        return
    }
    $script:uia_init = $true

    $providersAsm = "UIAutomationClientsideProviders"
    $providersAsm += ", Version=4.0.0.0, Culture=neutral"
    $providersAsm += ", PublicKeyToken=31bf3856ad364e35"
    Write-Debug "Initialize UIA; Provider = $providersAsm"

    # Register client side provider
    [Windows.Automation.AutomationElement]::RootElement
    # $client = [System.Reflection.Assembly]::Load("UIAutomationClientsideProviders, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35")
    $client = [System.Reflection.Assembly]::Load($providersAsm)
    [System.Windows.Automation.ClientSettings]::RegisterClientSideProviderAssembly($client.GetName())
}
Write-Debug "Initialize UIA"
Init-UIAutomation

# Load our .ps1 files
Write-Debug "Loads ps.uia scripts"
. $PSScriptRoot\ps.uia.get-root-element.ps1

# export functions
Write-Debug "Exports ps.uia functions"
Export-ModuleMember -Function Get-UIARootElement -Alias Get-UIARootElement

