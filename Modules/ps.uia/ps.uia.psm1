# ps.uia.psm1
# Root module for module 'ps.uia'

$script:uia_init = $false

function PSUIA-Init
{
    if ($script:uia_init) 
    {
        return
    }
    $script:uia_init = $true
    # Load MS UIAutomation assemblies
    [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationClient")
    [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationTypes")
    [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationProvider")
    [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationClientsideProviders")
    # Register client side provider
    $client = [System.Reflection.Assembly]::LoadWithPartialName("UIAutomationClientsideProviders")
    [Windows.Automation.ClientSettings]::RegisterClientSideProviderAssembly($client.GetName())
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
