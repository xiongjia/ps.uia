Element is a wrapper of the .NET `System.Windows.Automation.AutomationElement` object.
One Element object is associated to a GUI Control.   

In order to understand it,  we can inspect the UIA Element in the UIA Verify. 
In the PowerShell, we search and check the same UIA Element via PowerShell script.

## UIA Verify
[UIA Verify](https://uiautomationverify.codeplex.com/) is an open source UIAutomation tool.
It can inspect the UIA Elements.   
For instance, in below screenshot:
* The left side is the "calc.exe" window.   
  It the testing application. The "Button 1" is a normal Windows Button Control. 
* The right side is the UIA Verify.   
  In the Elements Tree, we can find the "Button 1" UIA Element.
  It's the UIA Element Object associated to the "Button 1" Control.     
  We can access/control/monitor the Button 1 UI Control via this UIA Element.
  * In the UIA Verify window, the properties grid listed all the Button 1 Element properties. 
    These properties are associated to the Button 1 Control. (e.g. ClassName=Button, Name=1)
  * In the Pattern grid, the Element supported patterns are listed. 
    The Button Control supports "InvokePattern". 
    (To call this InvokePattern equals button click.)

<img src='../fixture/img/uia_verify_01.png' />

## Search Element

