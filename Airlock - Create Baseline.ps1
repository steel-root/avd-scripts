#description: WIP - Use at your own risk - This script starts a baseline capture and outputs the baseline file to C:\Temp. Scripted actions run for a max of 2 hours and this may lead to failed captures.
#execution mode: Individual
#tags: Airlock

<#
  .SYNOPSIS
    Creates an Airlock Baseline and stores it in C:\Temp\ of the machine.

  .DESCRIPTION
    This script runs the Airlock Baseline Builder on the AVD session host or golden image.
    The baseline file will be named 

  .NOTES
    Company:  C3 Integrated Solutions
    Website:  c3isit.com
    Created:  2024-05-21
    Modified: 2024-09-03
#>

# Create a TEMP directory if one does not already exist
if (!(Test-Path -Path "C:\Temp" -ErrorAction SilentlyContinue)) {
    #Creates the directory
    New-Item -ItemType Directory -Path "C:\Temp" -Force -Verbose
}

# Change the current working directory to C:\Temp
Set-Location -Path "C:\Temp"

# Define the path to the baseline.exe executable
$baselineExePath = "C:\Program Files (x86)\Airlock Digital\Baseline Builder\baseline.exe"

# Get the current date in the desired format
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Construct the name argument combining client name and current date
$nameArgument = "$($SecureVars.ClientName)-$currentDate"

# Define the path argument
$pathArgument = "C:\"

# Define arguments for Start-Process
$processArgs = @("-path=`"$pathArgument`"","-name=`"$nameArgument`"")

# Start the process and wait for it to complete
Start-Process -FilePath $baselineExePath -ArgumentList $processArgs -NoNewWindow -Wait

# Define the full path of the generated file
$outputFilePath = "C:\Temp\$nameArgument.alf"
