# PS.UIA

PS.UIA = PowerShell + MS UIAutomation   
It's a pure Powershell script module help you access the MS UIAutomation in Powershell.

## How to use
(I am still working on the document and samples. At this time, you can check a simple sample in the sample folder.)


## Installation
Option 1: copy the "ps.uia" folder to your Powershell module folder.         
```ps1
git clone https://github.com/xiongjia/ps.uia.git 
cd .\ps.uia 
$myPSModulePath = [System.Environment]::GetFolderPath("mydocuments") + "\WindowsPowerShell\Modules" 
Copy-Item .\ps.uia $myPSModulePath\ps.uia -Recurse 
```  

Option 2: Add the project root path to your $env:PSModulePath environment.  
```ps1
git clone https://github.com/xiongjia/ps.uia.git 
cd .\ps.uia 
$env:PSModulePath = $env:PSModulePath + ";" + $pwd.Path + ";"
``` 

