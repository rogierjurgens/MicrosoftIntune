# This script is used to disable 128 bit encryption
# Please note that we trust that Microsoft Intune will activate Bitlocker with 256 bit encryption after disk is fully decrypted
# Check if BitLocker is enabled and using 256-bit encryption
$encryptionMethod = "XtsAes256"
$bitLockerProtectionStatus = Get-BitLockerVolume | Select-Object -ExpandProperty ProtectionStatus

if ($bitLockerProtectionStatus -contains "On") {
    $encryptedVolumes = Get-BitLockerVolume | Where-Object { $_.ProtectionStatus -eq "On" }
    $disableBitLocker = $false
    foreach ($volume in $encryptedVolumes) {
        if ($volume.EncryptionMethod -ne $encryptionMethod) {
            Write-Host "BitLocker is enabled but not with 256-bit encryption on volume $($volume.MountPoint). Disabling BitLocker."
            Disable-BitLocker -MountPoint $volume.MountPoint
            $disableBitLocker = $true
        }
    }
    if (!$disableBitLocker) {
        Write-Host "BitLocker is enabled with 256-bit encryption on all volumes."
    }
}
else {
    Write-Host "BitLocker is not enabled on this system."
}
