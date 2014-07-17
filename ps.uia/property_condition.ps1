# property_condition.ps1

Function New-UIAPropertyCondition
{
    Param(
        [parameter(Mandatory = $true)]
        [ValidateSet("ProcessId", "Name")]
        [string]$PropertyName,
        [parameter(Mandatory = $true)]
        [System.Object]$PropertyValue = $null
    )

    Begin
    {
        Write-Debug "[begin] New UIA Property Condition"
        Write-Debug "PropName: $PropertyName; PropVal: $PropertyValue"
    }

    Process
    {
        $WUIAProp = $null
        Switch ($PropertyName)
        {
            "ProcessId"
            {
                $WUIAProp = `
                    [Windows.Automation.AutomationElement]::ProcessIdProperty
            }
            "Name"
            {
                $WUIAProp = `
                    [Windows.Automation.AutomationElement]::NameProperty
            }
            Default
            {
				Write-Error "Invalid Property Name $PropertyName" `
                    -Category InvalidArgument `
                    -ErrorAction Stop
            }
        }
        $WUIAPropCond = New-Object Windows.Automation.PropertyCondition(
            $WUIAProp, $PropertyValue)
        Return @{
            "Raw" = [ref]$WUIAPropCond;
            "Tag" = "PropertyCondition"
        }
    }

    End
    {
        Write-Debug "[begin] New UIA Property Condition"
    }
}

Function New-UIAPropertyConditionArray
{
    Param(
        [parameter(Mandatory = $true)]
        [hashtable]$Properties
    )

    Begin
    {
        Write-Debug "[begin] New UIA property condition array"
        $PropKeys = $Properties.Keys
        Write-Debug "property keys = $PropKeys"
    }

    Process
    {
        $CondArray = @()
        Try
        {
            foreach ($Key in $PropKeys)
            {
                $PropVal = $Properties.$Key
                Write-Debug "Create New Condition $Key = $PropVal"
                $CondItem = New-UIAPropertyCondition -PropertyName $Key `
                    -PropertyValue $PropVal
                $CondArray += $CondItem
            }
        }
        Catch
        {
            Write-Error $_.Exception.Message -ErrorAction Stop
        }
        $CondArraySz = $CondArray.Length
        Write-Debug "Created Condition Array; Size = $CondArraySz"
        Return $CondArray
    }

    End
    {
        Write-Debug "[end] New UIA property condition array"
    }
}

