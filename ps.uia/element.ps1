# element.ps1

. $PSScriptRoot\misc.ps1
. $PSScriptRoot\condition.ps1

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
        [Alias("Parent")]
        [hashTable]$ParentElement = $null,
        [Alias("Cond")]
        [hashTable]$Condition = $null,
        [Alias("AndCond")]
        [hashTable]$AndCondition = $null,
        [Alias("OrCond")]
        [hashTable]$OrCondition = $null,
        [ValidateSet("Element", "Children", "Descendants", "Subtree")]
        [Alias("Scope")]
        [string]$TreeScope = "Subtree"
    )

    Begin
    {
        if ($Condition -eq $null) 
        {
            if ($AndCondition)
            {
                $Condition = New-UIAAndCondition -Props $AndCondition
            }
            elseif ($OrCondition)
            {
                $Condition = New-UIAOrCondition -Props $OrCondition
            }
        }
        if ($Condition -eq $null)
        {
           Write-Error -Message "Invalid Condition" `
                       -Category InvalidArgument `
                       -ErrorAction Stop
        }

        Write-Debug "[begin] Find first UIAElement"
        if ($ParentElement -eq $null)
        {
            Write-Debug "Parent Element is null and set the root element"
            $ParentElement = Get-UIARootElement
        }
        $UIATreeScope = Get-UIATreeScope -TreeScope $TreeScope
    }
 
    Process
    {
        $UIAElement = $ParentElement.Raw.Value.FindFirst(
            $UIATreeScope.Raw.Value,
            $Condition.Raw.Value
        )
        if ($UIAElement -eq $null)
        {
            Write-Error "UIAutomation cannot find an element."
            return $null
        }
        Return @{
            "Raw" = [ref]$UIAElement;
            "Tag" = "UIAElement"
        }
    }

    End
    {
        Write-Debug "[end] Find first UIAElement"
    }
}

Function Find-UIAAllElements
{
    Param(
        [Alias("Parent")]
        [hashTable]$ParentElement = $null,
        [Alias("Cond")]
        [hashTable]$Condition = $null,
        [Alias("AndCond")]
        [hashTable]$AndCondition = $null,
        [Alias("OrCond")]
        [hashTable]$OrCondition = $null,
        [ValidateSet("Element", "Children", "Descendants", "Subtree")]
        [Alias("Scope")]
        [string]$TreeScope = "Subtree"
    )

    Begin
    {
        if ($Condition -eq $null) 
        {
            if ($AndCondition)
            {
                $Condition = New-UIAAndCondition -Props $AndCondition
            }
            elseif ($OrCondition)
            {
                $Condition = New-UIAOrCondition -Props $OrCondition
            }
        }
        if ($Condition -eq $null)
        {
           Write-Error -Message "Invalid Condition" `
                       -Category InvalidArgument `
                       -ErrorAction Stop
        }

        Write-Debug "[begin] Find all UIAElements"
        if ($ParentElement -eq $null)
        {
            Write-Debug "Parent Element is null and set the root element"
            $ParentElement = Get-UIARootElement
        }
        $UIATreeScope = Get-UIATreeScope -TreeScope $TreeScope
    }

    Process
    {
        $UIAElements = $ParentElement.Raw.Value.FindAll(
            $UIATreeScope.Raw.Value,
            $Condition.Raw.Value
        )
        if ($UIAElements -eq $null)
        {
            Write-Error "UIAutomation cannot find any element."
            Return $null
        }

        $UIAElementsCnt = $UIAElements.Count
        Write-Debug "Find UIA Elements; Count = $UIAElementsCnt"
        if ($UIAElements.Count -le 0)
        {
            Write-Error "UIAutomation cannot find any element."
            Return $null
        }

        $RetElements = @()
        foreach ($UIAElement in $UIAElements)
        {
            $RetElements += @{
                "Raw" = [ref]$UIAElement;
                "Tag" = "UIAElement"
            }
        }

        $RetElementsSz = $RetElements.Length
        Write-Debug "Return UIA Elements Size = $RetElementsSz"
        Return , $RetElements
    }

    End
    {
        Write-Debug "[end] Find all UIAElements"
    }
}

