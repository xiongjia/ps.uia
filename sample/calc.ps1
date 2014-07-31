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
$CalcWnd = Find-UIAFirstElement -Scope Children `
    -AndCond @{ "ProcessId"=$CalcProc.Id; "Name"="Calculator" }


# Find buttons on the Calculator window
$ElementBtn1 = Find-UIAFirstElement -Parent $CalcWnd `
    -AndCond @{ "ClassName"="Button"; "Name"="1" }

$ElementBtnPlus = Find-UIAFirstElement -Parent $CalcWnd `
    -AndCond @{ "ClassName"="Button"; "Name"="+" }

$ElementBtnEqual = Find-UIAFirstElement -Parent $CalcWnd `
    -AndCond @{ "ClassName"="Button"; "Name"="+" }

# Get element patterns
$ElementBtn1Patterns = Get-UIAElementSupportedPatterns -Element $ElementBtn1
$ElementBtnPlusPatterns = Get-UIAElementSupportedPatterns -Element $ElementBtnPlus
$ElementBtnEqualPatterns = Get-UIAElementSupportedPatterns -Element $ElementBtnEqual

# Click the buttons
Write-Host "Clicking the buttons"
$ElementBtn1Patterns.InvokePattern.Invoke()
$ElementBtnPlusPatterns.InvokePattern.Invoke()
$ElementBtn1Patterns.InvokePattern.Invoke()
$ElementBtnEqualPatterns.InvokePattern.Invoke()
Start-Sleep -s 1
Write-Host "Finished. Please check the results on the Calculator Window"

