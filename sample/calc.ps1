#REQUIRES -Version 3.0

# calc.ps1
# A simple sample for access the MS UIAutomation in PowerShell.
# In this sample:
# 1. Launch the AUT ( calc.exe )
# 2. Find the Calculator Window via the ProcessId & Name property.
# 3. Find buttons via 'ClassName' and 'Name' property
# 4. Click the '1', '+', '1', '=' buttons via the InvokePattern
# At last, we will get '2' in the result of calc App.

# Launch the calc.exe & sleep 10 seconds for wait the process start
Write-Host "Launching the AUT ( calc.exe )"
$CalcProc = Start-Process calc -PassThru
Start-Sleep -s 5

# Find the Calculator window
$FindCond = New-UIAPropertyConditionArray -Properties `
                @{ "ProcessId"=$CalcProc.Id; "Name"="Calculator" }

$CalcWnd = Find-UIAFirstElement -TreeScope Children -Condition `
            (New-UIAAndCondition -PropertyConditionArray $FindCond)


# Find buttons on the Calculator window
$FindCond = New-UIAPropertyConditionArray -Properties `
                @{ "ClassName"="Button"; "Name"="1" }
$ElementBtn1 = Find-UIAFirstElement -ParentElement $CalcWnd -Condition `
                (New-UIAAndCondition -PropertyConditionArray $FindCond)
$ElementBtn1Patterns = Get-UIAElementSupportedPatterns -Element $ElementBtn1

$FindCond = New-UIAPropertyConditionArray -Properties `
                @{ "ClassName"="Button"; "Name"="+" }
$ElementBtnPlus = Find-UIAFirstElement -ParentElement $CalcWnd -Condition `
                    (New-UIAAndCondition -PropertyConditionArray $FindCond)
$ElementBtnPlusPatterns = Get-UIAElementSupportedPatterns -Element $ElementBtnPlus

$FindCond = New-UIAPropertyConditionArray -Properties `
                @{ "ClassName"="Button"; "Name"="+" }
$ElementBtnEqual = Find-UIAFirstElement -ParentElement $CalcWnd -Condition `
                    (New-UIAAndCondition -PropertyConditionArray $FindCond)
$ElementBtnEqualPatterns = Get-UIAElementSupportedPatterns -Element $ElementBtnEqual

# Click the buttons
Write-Host "Clicking the buttons"
$ElementBtn1Patterns.InvokePattern.Invoke()
$ElementBtnPlusPatterns.InvokePattern.Invoke()
$ElementBtn1Patterns.InvokePattern.Invoke()
$ElementBtnEqualPatterns.InvokePattern.Invoke()
Start-Sleep -s 1
Write-Host "Finished. Please check the results on the Calculator Window"

