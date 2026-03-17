#description: Marks the device as active in NinjaOne via CLI using the 'Retired' custom field.
#execution mode: Individual
#tags: NinjaOne

Write-Host "INFO: Setting NinjaOne 'retired' custom field to FALSE..."

try {
    Ninja-Property-Set retired false
    Write-Host "INFO: Command executed successfully."

    # Verify the value was set correctly
    $currentValue = Ninja-Property-Get retired

    if ($currentValue -eq "0" -or $currentValue -eq "false") {
        Write-Host "SUCCESS: 'retired' field confirmed as FALSE. Device is active."
    } else {
        Write-Host "WARNING: 'retired' field value after set is '$currentValue'. Expected FALSE. Please verify."
    }

    Write-Host "INFO: Pausing for 60 seconds to report status back to NinjaOne"
    Start-Sleep -Seconds 60
    Write-Host "SUCCESS: Script execution complete"
} catch {
    Write-Host "ERROR: Failed to execute Ninja-Property-Set. $_"
}