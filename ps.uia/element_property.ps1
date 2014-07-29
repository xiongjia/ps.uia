# element_property.ps1

. $PSScriptRoot\misc.ps1

Function Get-UIAElementProperty
{
    Param(
        [parameter(Mandatory = $true)]
        [Alias("PropName")]
        [string]$PropertyName = $null,
        [parameter(Mandatory = $true)]
        [hashtable]$Element
    )

    Begin
    {
        Write-Debug "[begin] Get UIA Element property ($PropertyName)"
    }

    Process
    {
        $UIAProp = $script:UIA_PROPERTY[$PropertyName]
        if ($UIAProp -eq $null)
        {
            Write-Error "Invalid UIA Property $Property" `
                -Category InvalidArgument `
                -ErrorAction Stop
        }
        Return $Element.Raw.Value.GetCurrentPropertyValue($UIAProp)
    }

    End
    {
        Write-Debug "[end] Get UIA Element property"
    }
}

Function Get-UIAElementAllProperties
{
    Param(
        [parameter(Mandatory = $true)]
        [hashtable]$Element
    )

    Begin
    {
        Write-Debug "[begin] Get UIA Element all properties"
    }

    Process
    {
        $AllProp = @{}
        foreach ($PropName in $script:UIA_PROPERTY.Keys)
        {
            $PropVal = Get-UIAElementProperty `
                -Element $Element -PropertyName $PropName
            $AllProp.Add($PropName, $PropVal)
        }
        Return $AllProp
    }

    End
    {
        Write-Debug "[end] Get UIA Element all properties"
    }
}

