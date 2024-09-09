#description: Deletes existing page file & points to C:\ instead
#execution mode: IndividualWithRestart
#tags: Testing

<#
  .SYNOPSIS
    Deletes existing page file & points to C:\ instead
 
  .NOTES
    Company:  C3 Integrated Solutions, LLC.
    Website:  c3isit.com
    Created:  2021-12-06
    Modified: 2024-09-03
#>


$computer = Get-WmiObject Win32_computersystem -EnableAllPrivileges
$computer.AutomaticManagedPagefile = $false
$computer.Put()
$CurrentPageFile = Get-WmiObject -Query "select * from Win32_PageFileSetting where name='c:\\pagefile.sys'"
$CurrentPageFile.delete()
Set-WMIInstance -Class Win32_PageFileSetting -Arguments @{name="C:\pagefile.sys";InitialSize = 0; MaximumSize = 0}
