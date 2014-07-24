# misc.ps1

Function Initialize-UIAAssemblies
{
    Begin
    {
        Write-Debug "[begin] Initialize UIAAssemblies"
    }

    Process
    {
        Write-Debug "Loading MS UIA assemblies"
        Add-Type -AssemblyName UIAutomationClient
        Add-Type -AssemblyName UIAutomationTypes
        Add-Type -AssemblyName UIAutomationProvider
        Add-Type -AssemblyName UIAutomationClientsideProviders
    }

    End
    {
        Write-Debug "[begin] Initialize UIAAssemblies"
    }
}

$script:UIA_ASSEMBLIES = $false
if ($script:UIA_ASSEMBLIES -eq $false) 
{
    Initialize-UIAAssemblies
    $script:UIA_ASSEMBLIES= $true
}

Function Initialize-UIAutomation
{
    Begin
    {
        Write-Debug "[begin] Initialize UIAutomation"
    }

    Process
    {
        $providersAsm = "UIAutomationClientsideProviders"
        $providersAsm += ", Version=4.0.0.0, Culture=neutral"
        $providersAsm += ", PublicKeyToken=31bf3856ad364e35"
        Write-Debug "Initialize UIA; Provider = $providersAsm"
        # Register client side provider
        [Windows.Automation.AutomationElement]::RootElement
        $client = [System.Reflection.Assembly]::Load($providersAsm)
        [System.Windows.Automation.ClientSettings]::RegisterClientSideProviderAssembly(
            $client.GetName()
        )
        Write-Debug "UIA Provider is registed"
    }

    End
    {
        Write-Debug "[end] Initialize UIAutomation"
    }
}

# UIA TreeScope hashtable
$script:UIA_TREE_SCOPE = @{
    "Element"     = [Windows.Automation.TreeScope]::Element;
    "Children"    = [Windows.Automation.TreeScope]::Children;
    "Descendants" = [Windows.Automation.TreeScope]::Descendants;
    "Subtree"     = [Windows.Automation.TreeScope]::Subtree;
}

Function Get-UIATreeScope
{
    Param(
        [parameter(Mandatory = $true)]
        [ValidateSet("Element", "Children", "Descendants", "Subtree")]
        [string]$TreeScope = "Subtree"
    )

    Begin
    {
        Write-Debug "[begin] get uia TreeScope ($TreeScope)"
    }

    Process
    {
        $Raw = $script:UIA_TREE_SCOPE[$TreeScope]
        if ($Raw -eq $null) 
        {
            Write-Error "Invalid TreeScope $TreeScope" `
                -Category InvalidArgument `
                -ErrorAction Stop
        }
        Return @{
            "Raw" = [ref]$Raw;
            "Tag" = "TreeScope"
        }
    }

    End
    {
        Write-Debug "[end] get uia TreeScope"
    }
}

# UIA Property hashtable
$script:UIA_PROPERTY = @{
    # > Identification properties:
    #   AutomationId, ClassName, ControlType,
    #   FrameworkId, hWnd, IsContentElement, IsControlElement,
    #   IsPassword, LocalizedControlType, Name, ProcessId
    "AutomationId" = `
        [Windows.Automation.AutomationElement]::AutomationIdProperty;
    "ClassName" = [Windows.Automation.AutomationElement]::ClassNameProperty;
    "ControlType" = `
        [Windows.Automation.AutomationElement]::ControlTypeProperty;
    "FrameworkId" = `
        [Windows.Automation.AutomationElement]::FrameworkIdProperty;
    "HWND" = `
        [Windows.Automation.AutomationElement]::NativeWindowHandleProperty;
    "IsContentElement" = `
        [Windows.Automation.AutomationElement]::IsContentElementProperty;
    "IsControlElement" = `
        [Windows.Automation.AutomationElement]::IsControlElementProperty;
    "IsPassword" = [Windows.Automation.AutomationElement]::IsPasswordProperty;
    "LocalizedControlType" = `
        [Windows.Automation.AutomationElement]::LocalizedControlTypeProperty;
    "Name" = [Windows.Automation.AutomationElement]::NameProperty;
    "ProcessId" = [Windows.Automation.AutomationElement]::ProcessIdProperty;
    # > State properties
    #   HasKeyboardFocus, IsEnabled
    "HasKeyboardFocus" = `
        [Windows.Automation.AutomationElement]::HasKeyboardFocusProperty;
    "IsEnabled" = [Windows.Automation.AutomationElement]::IsEnabledProperty;
    # > Visibility properties
    #   BoundingRectangle, IsOffscreen
    "BoundingRectangle" = `
        [Windows.Automation.AutomationElement]::BoundingRectangleProperty;
    "IsOffscreen" = `
        [Windows.Automation.AutomationElement]::IsOffscreenProperty;
    # > General Accessibility
    #   AcceleratorKey, AccessKey, HelpText,
    #   IsKeyboardFocusable, LabeledBy
    "AcceleratorKey" = `
        [Windows.Automation.AutomationElement]::AcceleratorKeyProperty;
    "AccessKey" = [Windows.Automation.AutomationElement]::AccessKeyProperty;
    "HelpText" = [Windows.Automation.AutomationElement]::HelpTextProperty;
    "IsKeyboardFocusable" = `
        [Windows.Automation.AutomationElement]::IsKeyboardFocusableProperty;
    "LabeledBy" = `
        [Windows.Automation.AutomationElement]::LabeledByProperty;
}

Function Get-UIAProperty
{
    Param(
        [parameter(Mandatory = $true)]
        [string]$Property
    )

    Begin
    {
        Write-Debug "[begin] get uia property; [$Property]"
    }

    Process
    {
        $Raw = $script:UIA_PROPERTY[$Property]
        if ($Raw -eq $null)
        {
            # > Unknown property
            Write-Error "Invalid UIA Property $Property" `
                -Category InvalidArgument `
                -ErrorAction Stop
        }
        Return @{
            "Raw" = [ref]$Raw;
            "Tag" = "Property"
        }
    }

    End
    {
        Write-Debug "[end] get uia property"
    }
}

