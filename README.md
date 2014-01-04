ps.uia
------------

*ps.uia* - A pure Powershell script module help you access the MS UIAutomation in Powershell.

How to use
------------
The following example creates the "calc.exe" process and click the Number "1" button on the window.  

```ps1
# import the ps.uia module
Import-Module ps.uia

# create the calc.exe process and sleep 5 seconds
$autProc = Start-Process calc -PassThru
Start-Sleep -s 5

# find the root element
$aut = Get-UIAProcRootElement -processId $autProc.Id
# find the number "1" button
$btn = Find-UIAFirstElement -element $aut -className "Button" -name "1"

# click it
$btn.GetCurrentPattern([Windows.Automation.InvokePattern]::Pattern).Invoke()
``` 

You also can find another sample script in the "sample" folder. 
Below are the command lines for test this sample script.  
```ps1
Import-Module ps.uia
.\sample\calc.ps1 
```

Installation
------------
Option 1: copy the "Modules\ps.uia" to your Powershell modules folder. 

Option 2: Add the "Mdodules" path to your $env:PSModulePath environment. 

