# ps.uia.get-root-element.ps1
# 

. $PSScriptRoot\misc.ps1

Function Get-UIARootElement
{
    [CmdletBinding(
    	SupportsShouldProcess=$true,
        ConfirmImpact="Low"
    )]
    Param(
        [Parameter(Mandatory=$true)]
        [Int]$ProcessId
    )

    Begin
    {
        Write-Debug "Begin Get-UIARootElement"
        Write-Debug "ProcessId= $ProcessId"
    }

	Process
    {
        $rootElement = [Windows.Automation.AutomationElement]::RootElement
        $condAUTProc = New-Object Windows.Automation.PropertyCondition(
            [Windows.Automation.AutomationElement]::ProcessIdProperty,
            $ProcessId
        )
        $autElement = $rootElement.FindFirst(
            [Windows.Automation.TreeScope]::Children,
            $condAUTProc
        )

        if ($autElement -eq $null)
        {
            Write-Error -Message "Cannot find the UIA Element for process ($ProcessId)"
        }

        $rootElement = @{
            "ProcessId"=$ProcessId;
            "RootElement"=[ref]$autElement
        }
        Return $rootElement
    }

    End {}
}

