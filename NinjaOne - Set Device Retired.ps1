#description: Marks the device as retired in NinjaOne via CLI using the 'Retired' custom field. This is typically set to run during host removal.
#execution mode: Individual
#tags: NinjaOne

Write-Host "INFO: Setting NinjaOne 'retired' custom field to TRUE..."

try {
    Ninja-Property-Set retired true
    Write-Host "INFO: Command executed successfully."

    # Verify the value was set correctly
    $currentValue = Ninja-Property-Get retired

    if ($currentValue -eq "1" -or $currentValue -eq "true") {
        Write-Host "SUCCESS: 'retired' field confirmed as TRUE. Device is flagged for deletion."
    } else {
        Write-Host "WARNING: 'retired' field value after set is '$currentValue'. Expected TRUE. Please verify."
    }

    Write-Host "INFO: Pausing for 60 seconds to report status back to NinjaOne"
    Start-Sleep -Seconds 60
    Write-Host "SUCCESS: Script execution complete"
} catch {
    Write-Host "ERROR: Failed to execute Ninja-Property-Set. $_"
}