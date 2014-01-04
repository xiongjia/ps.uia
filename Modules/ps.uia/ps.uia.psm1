# ps.uia.psm1
# Root module for module 'ps.uia'

# Load MS UIAutomation assemblies
Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName UIAutomationTypes
Add-Type -AssemblyName UIAutomationProvider
Add-Type -AssemblyName UIAutomationClientsideProviders
$script:uia_init = $false

function PSUIA-Init
{
    if ($script:uia_init) 
    {
        return
    }
    $script:uia_init = $true
    # Register client side provider
    [Windows.Automation.AutomationElement]::RootElement
    $client = [System.Reflection.Assembly]::Load("UIAutomationClientsideProviders, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35")
    [System.Windows.Automation.ClientSettings]::RegisterClientSideProviderAssembly($client.GetName())
}
PSUIA-Init

# Search the UIA Root element via the process Id
function Get-UIAProcRootElement([int]$processId)
{
    $rootElement = [Windows.Automation.AutomationElement]::RootElement
    $condAUTProc = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::ProcessIdProperty, $processId)
    $autElement = $rootElement.FindFirst([Windows.Automation.TreeScope]::Children, $condAUTProc)
    if ($autElement -eq $null)
    {
        Write-Error -Message "Cannot find the UIA Element for process ($processId)"
    }
    return $autElement
}

# Search the firt UIA element via the classname & name properties
function Find-UIAFirstElement([object]$element, [string]$className, [string]$name = $null)
{
    # create the condition objects
    $condClassName = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::ClassNameProperty, $className)
    $condName = $null
    if ($name -ne $null)
    {
        $condName = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::NameProperty, $name)
    }
    $condTarget = $condClassName
    if ($condName -ne $null)
    {
        $condTarget = New-Object Windows.Automation.AndCondition($condClassName, $condName)
    }

    # search the element via the condition
    $autElement = $element.FindFirst([Windows.Automation.TreeScope]::Descendants, $condTarget)
    if ($autElement -eq $null)
    {
        Write-Error -Message "Cannot find the Element"
    }
    return $autElement
}
