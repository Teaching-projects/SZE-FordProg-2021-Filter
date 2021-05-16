clear-host

#region Import, Fehlerbehandlung
$ScriptDir = Split-Path -parent $MyInvocation.MyCommand.Path
$ScriptName = $MyInvocation.MyCommand.Name
if(test-path ($ScriptDir+'\'+$ScriptName+'_MODULERROR') -pathtype leaf){
    remove-item -path ($ScriptDir+'\'+$ScriptName+'_MODULERROR')
}
try{ 
    import-module  $ScriptDir\test2.psm1 -force -ErrorAction Stop #-----------------------------TEST .psm1----------------------
}
catch{
    new-item ($ScriptDir+'\'+$ScriptName+'_MODULERROR')
    exit  
}

$string = 'Write-Host "command"'

Invoke-Expression $string

write-host 'end'