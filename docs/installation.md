PS.UIA is a pure PowerShell script module. Therefore, we have below 2 options: 
* Option 1: Copy the "ps.uia" folder to your PowerShell module folder.         
```ps1
git clone https://github.com/xiongjia/ps.uia.git 
cd .\ps.uia 
$myPSModulePath = [System.Environment]::GetFolderPath("mydocuments") + "\WindowsPowerShell\Modules" 
Copy-Item .\ps.uia $myPSModulePath\ps.uia -Recurse 
```  
* Option 2: Add the project root path to your $env:PSModulePath environment.  
```ps1
git clone https://github.com/xiongjia/ps.uia.git 
cd .\ps.uia 
$env:PSModulePath = $env:PSModulePath + ";" + $pwd.Path + ";"
``` 

