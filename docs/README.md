
PS.UIA = PowerShell + UIAutomation    
* PowerShell    
  Windows PowerShell is an automated task framework from Microsoft, 
  with a command line shell and a scripting language integrated into 
  the .NET framework.
* UIAutomation    
  Microsoft UI Automation is the new accessibility framework for Microsoft Windows, 
  available on all operating systems that support Windows Presentation Foundation (WPF).

PS.UIA is a **pure** Powershell script module help you access the Microsoft UIAutomation in Powershell.

## Source code
* [GitHub](https://github.com/xiongjia/ps.uia) 

## Quick Start
Below GIF Animation is a simple DEMO.

![DEMO](https://github.com/xiongjia/ps.uia/raw/master/sample/calc.gif)    

In this DEMO PowerShell script, 
we open a "calc.exe" process 
and click the '1', '+', '1', '=' buttons via the UIAutomation.     

The following script is the full script. 
You also can check the details in the [Source code Sample Folder](https://github.com/xiongjia/ps.uia/tree/master/sample)
```powershell
#REQUIRES -Version 3.0
# In this sample:
# 1. Launch the AUT ( calc.exe )
# 2. Find the Calculator Window via the ProcessId & Name properties.
# 3. Find buttons via ClassName and Name properties 
# 4. Click the '1', '+', '1', '=' buttons via the InvokePattern
# At last, we will get '2' in the result of calc App.

# Launch the calc.exe & sleep 1 second for wait the process start
Write-Host "Launching the AUT ( calc.exe )"
$CalcProc = Start-Process calc -PassThru
Start-Sleep -s 1

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
```

* More 
  * [Installation](installation.md)
