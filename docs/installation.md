## Install PowerShell module
PS.UIA is a pure PowerShell script module. Therefore, we have below 2 options: 
* Option 1 - Copy the "ps.uia" folder to your PowerShell module folder.         
```ps1
git clone https://github.com/xiongjia/ps.uia.git 
cd .\ps.uia 
$myPSModulePath = [System.Environment]::GetFolderPath("mydocuments") + "\WindowsPowerShell\Modules" 
Copy-Item .\ps.uia $myPSModulePath\ps.uia -Recurse 
```  
* Option 2 - Add the project root path to your $env:PSModulePath environment.  
```ps1
git clone https://github.com/xiongjia/ps.uia.git 
cd .\ps.uia 
$env:PSModulePath = $env:PSModulePath + ";" + $pwd.Path + ";"
``` 

## PS.UIA module
After install the PS.UIA module, we can use the `Get-Module` cmdlet to check this module.   
For instance, run below command in your PowerShell:  
`Get-Module -List -Name ps.uia | Format-Table -Property Name,ModuleType`

You will get below output:
```
Name              ModuleType
----              ----------
ps.uia                Script
```

## Import PS.UIA
To import the PS.UIA module, use the following cmdlet: `Import-Module ps.uia`.

After imported the PS.UIA module, we can use all the export commands in this module.   
You can check all the export commands via the following command:
`(Get-Module -Name ps.uia).ExportedCommands.Keys`

You will get below output:   
(It listed all the commands. For the details of each command, 
You can check [Element](element.md) and [Pattern](pattern.md) sections.)

```
Find-UIAAllElements
Find-UIAFirstElement
Get-UIAElementAllProperties
Get-UIAElementProperty
Get-UIARootElement
Get-UIASupportedPatterns
New-UIAAndCondition
New-UIANotCondition
New-UIAOrCondition
New-UIAPropertyCondition
New-UIAPropertyConditionArray
```

