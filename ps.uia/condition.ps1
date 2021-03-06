# condition.ps1

. $PSScriptRoot\property_condition.ps1

Function New-UIAAndCondition
{
    Param(
        [Alias("PropsCond")]
        [array]$PropertyConditionArray = $null,
        [Alias("Props")]
        [hashtable]$Properties = @{}
    )

    Begin
    {
        if ($PropertyConditionArray -eq $null)
        {
            $PropertyConditionArray = New-UIAPropertyConditionArray `
                -Properties $Properties 
        }
        if ($PropertyConditionArray -eq $null)
        {
           Write-Error -Message "Invalid Property Condition Array" `
                       -Category InvalidArgument `
                       -ErrorAction Stop
        }
 
        $ArraySz = $PropertyConditionArray.Length
        Write-Debug "[begin] New UIA And Condition (Size = $ArraySz)"
        if ($ArraySz -le 0)
        {
           Write-Error -Message "Invalid Property Condition Array" `
                       -Category InvalidArgument `
                       -ErrorAction Stop
        }
    }

    Process
    {
        $CondItems = @()
        foreach ($CondItem in $PropertyConditionArray)
        {
            $CondItemTag = $CondItem.Tag
            Write-Debug "Add $CondItemTag to AndCondition"
            $CondItems += $CondItem.Raw.Value
        }
        $AndCond = New-Object Windows.Automation.AndCondition($CondItems)
        Return @{
            "Raw" = [ref]$AndCond;
            "Tag" = "AndCondition"
        }
    }

    End
    {
        Write-Debug "[end] New UIA And Condition"
    }
}

Function New-UIAOrCondition
{
    Param(
        [Alias("PropsCond")]
        [array]$PropertyConditionArray = $null,
        [Alias("Props")]
        [hashtable]$Properties = @{}
    )

    Begin
    {
        if ($PropertyConditionArray -eq $null)
        {
            $PropertyConditionArray = New-UIAPropertyConditionArray `
                -Properties $Properties 
        }
        if ($PropertyConditionArray -eq $null)
        {
           Write-Error -Message "Invalid Property Condition Array" `
                       -Category InvalidArgument `
                       -ErrorAction Stop
        }

        $ArraySz = $PropertyConditionArray.Length
        Write-Debug "[begin] New UIA Or Condition (Size = $ArraySz)"
        if ($ArraySz -le 0)
        {
           Write-Error -Message "Invalid Property Condition Array" `
                       -Category InvalidArgument `
                       -ErrorAction Stop
        }
    }

    Process
    {
        $CondItems = @()
        foreach ($CondItem in $PropertyConditionArray)
        {
            $CondItemTag = $CondItem.Tag
            Write-Debug "Add $CondItemTag to OrCondition"
            $CondItems += $CondItem.Raw.Value
        }
        $OrCond = New-Object Windows.Automation.OrCondition($CondItems)
        Return @{
            "Raw" = [ref]$OrCond;
            "Tag" = "OrCondition"
        }
    }

    End
    {
        Write-Debug "[end] New UIA Or Condition"
    }
}

Function New-UIANotCondition
{
    Param(
		[parameter(Mandatory = $true)]
        [Alias("PropCond")]
        [hashtable]$PropertyCondition = $null
    )

    Begin
    {
        Write-Debug "[begin] New UIA Not Condition"
    }

    Process
    {
        $CondItemTag = $PropertyCondition.Tag
        $CondItem = $PropertyCondition.Raw.Value
        Write-Debug "Add $CondItemTag to NotCondition"
        $NotCond = New-Object Windows.Automation.NotCondition($CondItem)
        Return @{
            "Raw" = [ref]$NotCond;
            "Tag" = "NotCondition"
        }
    }

    End
    {
        Write-Debug "[end] New UIA Not Condition"
    }
}

