# condition.ps1

Function New-UIAAndCondition
{
    Param(
		[parameter(Mandatory=$true)]
        [hashtable]$PropertyConditions = $null
    )

    begin
    {
        Write-Debug "[begin] New UIA And Conditions"
        if ($PropertyConditions.Tag -ne "PropertyConditions")
        {
           Write-Error -Message "Invalid Property Conditions"
                       -Category InvalidArgument
        }
        $PropCount = $PropertyConditions.Conditions.Count
        Write-Debug "New UIA And Conditions. Property Count $PropCount"
        if ($PropCount -le 0)
        {
           Write-Error -Message "Invalid Property Conditions"
                       -Category InvalidArgument
        }
    }

    Process
    {
        if ($PropCount -le 1)
        {
            Return $PropertyConditions
        }

        $CondItems = @()
        foreach ($Key in $PropertyConditions.Conditions.Keys)
        {
            $PropItem = $PropertyConditions.Conditions.$Key
            $PropTag = $PropItem.Tag
            Write-Debug "Add $Key ($PropTag) to AndCondition"
            $CondItems += $PropItem.Condition.Value
        }
        $AndCond =  New-Object Windows.Automation.AndCondition($CondItems)
        Return @{
            "Tag"="AndCondition";
            "Condition"=[ref]$AndCond
        }
    }

    End
    {
        Write-Debug "[end] New UIA And Conditions"
    }
}

Function New-UIAPropertyConditions
{
    Param(
        [Int]$ProcessId = 0,
        [String]$Name = ""
    )
    Begin
    {
        Write-Debug "[begin] New UIA Property Conditions"
    }

    Process
    {
        $DefaultCond = $null
        $Cond = @{}
        if ($ProcessId -ne 0)
        {
            #  process id condition
            Write-Debug "Create ProcessId Condition: $ProcessId"
            $UIACond = New-Object Windows.Automation.PropertyCondition(
                [Windows.Automation.AutomationElement]::ProcessIdProperty,
                $ProcessId
            )
            $Cond.Add("ProcessIdProp",
                @{ "Tag" = $ProcessId; "Condition" = [ref]$UIACond })
            $DefaultCond = [ref]$UIACond
        }

        if ($Name)
        {
            # Name Condition
            Write-Debug "Create Name Condition: $Name"
            $UIACond = New-Object Windows.Automation.PropertyCondition(
                [Windows.Automation.AutomationElement]::NameProperty,
                $Name)
            $Cond.Add("NameProp", @{ "Tag" = $Name; "Condition" = [ref]$UIACond })
            $DefaultCond = [ref]$UIACond
        }

        # check condition
        if ($Cond.Count -le 0)
        {
           Write-Error -Message "Cannot create an empty condition"
                       -Category InvalidArgument
        }

        Return @{
            "Tag" = "PropertyConditions";
            "Condition" = $DefaultCond;
            "Conditions" = $Cond
        }
    }

    End
    {
        Write-Debug "[end] New UIA Condition"
    }
}

