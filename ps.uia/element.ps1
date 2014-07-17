# element.ps1

. $PSScriptRoot\misc.ps1

Function Get-UIARootElement
{
    Begin
    {
        Write-Debug "[begin] Get UIA Root Element"
    }

    Process
    {
        $UIARootElement = [Windows.Automation.AutomationElement]::RootElement
        $RootElement = @{
            "Tag" = "UIARootElement";
            "Raw" = [ref]$UIARootElement
        }
        Return $RootElement
    }

    End
    {
        Write-Debug "[end] Get UIA Root Element"
    }
}

Function Find-UIAFirstElement
{
    Param(
        [hashTable]$ParentElement = $null,
		[parameter(Mandatory = $true)]
        [hashTable]$Condition = $null,
        [ValidateSet("Children", "Parent", "Descendants")]
        [string]$TreeScope = "Children"
    )

    Begin
    {
        Write-Debug "[begin] Find UIAElements"
        if ($ParentElement -eq $null)
        {
            Write-Debug "Parent Element is null and set the root element"
            $ParentElement = Get-UIARootElement
        }
    }

    Process
    {
        $UIATreeScope = Get-UIATreeScope -TreeScope $TreeScope
        $UIAElement = $ParentElement.Raw.Value.FindFirst(
            $UIATreeScope.Raw.Value,
            $Condition.Raw.Value
        )
        Return @{
            "Raw" = [ref]$UIAElement;
            "Tag" = "UIAElement"
        }
    }

    End
    {
        Write-Debug "[end] Find UIAElements"
    }
}

