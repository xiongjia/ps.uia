#REQUIRES -Version 3.0

# calc.ps1
# A simple sample for access the MS UIAutomation in PowerShell.
# In this sample:
# 1. Launch the AUT ( calc.exe )
# 2. Find the AutomationElement via the Process Id
# 3. Find buttons via 'ClassName' and 'Name' property
# 4. Click the '1', '+', '1', '=' buttons.
# At last, we will get '2' in the result of calc App.

# Launch the calc.exe & sleep 10 seconds for wait the process start
Write-Host "Launching the AUT ( calc.exe )"
$autProc = Start-Process calc -PassThru
Start-Sleep -s 5


$aut = Get-UIAProcRootElement -processId $autProc.Id

$btn1Element = Find-UIAFirstElement -element $aut -className "Button" -name "1"
$btnPlusElement = Find-UIAFirstElement -element $aut -className "Button" -name "+"
$btnEqualElement = Find-UIAFirstElement -element $aut -className "Button" -name "="

# Click the buttons
Write-Host "Clicking the buttons"
$btn1Element.GetCurrentPattern([Windows.Automation.InvokePattern]::Pattern).Invoke()
Start-Sleep -s 1
$btnPlusElement.GetCurrentPattern([Windows.Automation.InvokePattern]::Pattern).Invoke()
Start-Sleep -s 1
$btn1Element.GetCurrentPattern([Windows.Automation.InvokePattern]::Pattern).Invoke()
Start-Sleep -s 1
$btnEqualElement.GetCurrentPattern([Windows.Automation.InvokePattern]::Pattern).Invoke()
Start-Sleep -s 1
 
Write-Host "Finished. Please check the results on the AUT."

