Import-Module SQLPS -DisableNameChecking
set-location SQLSERVER:\SQL\denmot\default\databases
ls

$now = Get-Date -Format yyyyMMddHHmmss

gci | % {
    $db = $_.Name
    $backupName = "f:\dump\$db.$now.bak"
    write-host $backupName
    Backup-SqlDatabase -ServerInstance denmot -Database $db -BackupFile $backupName
}

$db = 'WideWorldImporters'
$backupFile = "f:\dump\WideWorldImporters.20161118201409.bak"
Restore-SqlDatabase -ServerInstance denmot -Database $db -BackupFile $backupFile -ReplaceDatabase

