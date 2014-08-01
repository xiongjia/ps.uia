# pattern.ps1

Function Get-UIASupportedPatterns
{
    Param(
        [parameter(Mandatory = $true)]
        [hashtable]$Element
    )

    Begin
    {
        Write-Debug "[begin] Get UIA Element Supported Patterns"
        $ElementRef = $Element.Raw.Value
    }

    Process
    {
        $AllPatterns = @{}
        $SupportedPatterns = $ElementRef.GetSupportedPatterns()
        foreach ($SupportedPattern in $SupportedPatterns)
        {
            # Update ProgrammaticName
            $ProgrammaticName = $SupportedPattern.ProgrammaticName
            $ProgrammaticName = $ProgrammaticName.Split(".")[0]
            $ProgrammaticName = $ProgrammaticName -replace "Identifiers$", ""

            Write-Debug "Adding $ProgrammaticName Pattern"
            $ElementPattern = $ElementRef.GetCurrentPattern($SupportedPattern)
            $AllPatterns.Add($ProgrammaticName, $ElementPattern)
        }
        Return $AllPatterns
    }

    End
    {
        Write-Debug "[end] Get UIA Element Supported Patterns"
    }
}

