#https://msdn.microsoft.com/en-us/library/ms205154.aspx

#If Import-Module line does not work do this (next line assumes SQLServer 2016 - adjust for you)...
$env:PSModulePath = $env:PSModulePath + ";C:\Program Files (x86)\Microsoft SQL Server\130\Tools\PowerShell\Modules"
Get-Module -ListAvailable

$serverName = "dennis-pc"
Import-Module SQLPS -DisableNameChecking
set-location SQLSERVER:\SQL
set-location SQLSERVER:\SQL\$serverName\default\databases
ls

$now = Get-Date -Format yyyyMMddHHmmss

gci | % {
    $db = $_.Name
    $backupName = "f:\dump\$db.$now.bak"
    write-host $backupName
    Backup-SqlDatabase -ServerInstance $serverName -Database $db -BackupFile $backupName
}

$db = 'WideWorldImporters'
$backupFile = "f:\dump\WideWorldImporters.20161118201409.bak"
Restore-SqlDatabase -ServerInstance $serverName -Database $db -BackupFile $backupFile -ReplaceDatabase

$srv = new-Object Microsoft.SqlServer.Management.Smo.Server("(local)")
$db = New-Object Microsoft.SqlServer.Management.Smo.Database($srv, "Test_SMO_Database")
$db.Create()
Write-Host $db.CreateDate
ls
#$db.Drop()