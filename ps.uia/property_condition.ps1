# property_condition.ps1

. $PSScriptRoot\misc.ps1

Function New-UIAPropertyCondition
{
    Param(
        [parameter(Mandatory = $true)]
        [string]$PropertyName,
        [parameter(Mandatory = $true)]
        [System.Object]$PropertyValue = $null
    )

    Begin
    {
        Write-Debug "[begin] New UIA Property Condition"
        Write-Debug "PropName: $PropertyName; PropVal: $PropertyValue"
        $UIAProp = Get-UIAProperty -Property $PropertyName
    }

    Process
    {
        $UIAPropCond = New-Object Windows.Automation.PropertyCondition(
            $UIAProp.Raw.Value, $PropertyValue)
        Return @{
            "Raw" = [ref]$UIAPropCond;
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
        Return , $CondArray
    }

    End
    {
        Write-Debug "[end] New UIA property condition array"
    }
}

