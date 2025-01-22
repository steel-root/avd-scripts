#description: This script will expand the OS disk (C:) to the maximum size. This can be run on image VMs or AVD hosts. 
#execution mode: Individual

# Variable specifying the drive you want to extend. Use the system drive but remove the trailing colon to get just the drive letter.
$drive_letter = ($env:SYSTEMDRIVE).TrimEnd(':')

# Script to get the partition sizes and then resize the volume  
$size = Get-PartitionSupportedSize -DriveLetter $drive_letter
Resize-Partition -DriveLetter $drive_letter -Size $size.SizeMax
