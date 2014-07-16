# condition.ps1

Function New-UIAAndCondition
{
    Param(
		[parameter(Mandatory = $true)]
        [array]$PropertyConditionArray = @()
    )

    begin
    {
        $ArraySz = $PropertyConditionArray.Length
        Write-Debug "[begin] New UIA And Condition (Size = $ArraySz)"
        if ($ArraySz -le 0)
        {
           Write-Error -Message "Invalid Property Condition Array"
                       -Category InvalidArgument
                       -ErrorAction Stop
        }
    }

    Process
    {
        $CondItems = @()
        foreach ($CondItem in $PropertyConditionArray)
        {
            $CondItemTag = $CondItem.Tag
            Write-Debug "Add to $CondItemTag to AndCondition"
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

