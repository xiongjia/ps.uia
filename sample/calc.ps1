#REQUIRES -Version 3.0

# calc.ps1
# A simple sample for access the MS UIAutomation in PowerShell.
# In this sample:
# 1. Launch the AUT ( calc.exe )
# 2. Find the Calculator Window via the ProcessId & Name properties.
# 3. Find buttons via ClassName and Name properties 
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
$Btn1 = Find-UIAFirstElement -Parent $CalcWnd `
    -AndCond @{ "ClassName"="Button"; "Name"="1" }

$BtnPlus = Find-UIAFirstElement -Parent $CalcWnd `
    -AndCond @{ "ClassName"="Button"; "Name"="+" }

$BtnEqual = Find-UIAFirstElement -Parent $CalcWnd `
    -AndCond @{ "ClassName"="Button"; "Name"="+" }

# Get element patterns
$Btn1Patterns = Get-UIASupportedPatterns -Element $Btn1
$BtnPlusPatterns = Get-UIASupportedPatterns -Element $BtnPlus
$BtnEqualPatterns = Get-UIASupportedPatterns -Element $BtnEqual

# Click the buttons
Write-Host "Clicking the buttons"
$Btn1Patterns.InvokePattern.Invoke()
$BtnPlusPatterns.InvokePattern.Invoke()
$Btn1Patterns.InvokePattern.Invoke()
$BtnEqualPatterns.InvokePattern.Invoke()
Start-Sleep -s 1
Write-Host "Finished. Please check the results on the Calculator Window"

