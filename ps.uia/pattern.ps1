# pattern.ps1

Function Get-UIAElementPattern
{
    Param(
        [parameter(Mandatory = $true)]
        [hashtable]$Element,
        [ValidateSet("InvokePattern")]
        [string]$Pattern
    )

    Begin
    {
        Write-Debug "[begin] Get UIA Pattern; Pattern = $Pattern"
    }

    Process
    {
        $UIAPattern = [Windows.Automation.InvokePattern]::Pattern
        $data = $Element.Raw.Value.GetCurrentPattern($UIAPattern)
        Return [ref]$data
    }

    End
    {
        Write-Debug "[end] Get UIA Pattern"
    }
}

