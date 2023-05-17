# Check if BitLocker is enabled and using 256-bit encryption
$encryptionMethod = "Aes256"
$bitLockerProtectionStatus = Get-BitLockerVolume | Select-Object -ExpandProperty ProtectionStatus

if ($bitLockerProtectionStatus -contains "On") {
    $encryptedVolumes = Get-BitLockerVolume | Where-Object { $_.ProtectionStatus -eq "On" }
    foreach ($volume in $encryptedVolumes) {
        if ($volume.EncryptionMethod -eq $encryptionMethod) {
            Write-Host "BitLocker is enabled with 256-bit encryption on volume $($volume.MountPoint)"
            Exit 0
        }
    }
    Write-Host "BitLocker is enabled but not with 256-bit encryption."
    Exit 1
}
else {
    Write-Host "BitLocker is not enabled on this system."
    Exit 2
}
