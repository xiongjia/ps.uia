# element.ps1

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
            "Tag"="UIARoot";
            "Element"=[ref]$UIARootElement
        }
        Return $RootElement
    }

    End
    {
        Write-Debug "[end] Get UIA Root Element"
    }
}

Function Find-UIAElements
{
    Param(
        [HashTable]$ParentElement = $null,
        [HashTable]$Condition = $null
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
        $Element = $ParentElement.Element.Value.FindFirst(
            [Windows.Automation.TreeScope]::Children,
            $Condition.Condition.Value
        )
        Return $Element
    }

    End
    {
        Write-Debug "[end] Find UIAElements"
    }
}

