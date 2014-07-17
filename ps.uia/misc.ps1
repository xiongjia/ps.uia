# misc.ps1

Function Initialize-UIAutomation
{
    Begin
    {
        Write-Debug "[begin] Initialize UIAutomation"
    }

    Process
    {
        Write-Debug "Loading MS UIA assemblies"
        Add-Type -AssemblyName UIAutomationClient
        Add-Type -AssemblyName UIAutomationTypes
        Add-Type -AssemblyName UIAutomationProvider
        Add-Type -AssemblyName UIAutomationClientsideProviders

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

Function Get-UIATreeScope
{
    Param(
        [ValidateSet("Children", "Parent", "Descendants")]
        [string]$TreeScope = "Children"
    )

    Begin
    {
        Write-Debug "[begin] get uia TreeScope ($TreeScope)"
    }

    Process
    {
        $UIATreeScope = $null
        Switch ($TreeScope)
        {
            "Children"
            {
                $UIATreeScope = [Windows.Automation.TreeScope]::Children
            }
            "Descendants"
            {
                $UIATreeScope = [Windows.Automation.TreeScope]::Descendants
            }
            Default
            {
                Write-Error "Invalid TreeScope $TreeScope" `
                    -Category InvalidArgument `
                    -ErrorAction Stop
            }
        }
        Return @{
            "Raw" = [ref]$UIATreeScope;
            "Tag" = "TreeScope"
        }
    }

    End
    {
        Write-Debug "[end] get uia TreeScope"
    }
}

