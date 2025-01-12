# Function to print a separator line
function Print-Separator {
       Write-Host "`n------------------------------------------------------------`n"
   }
   
   # Function to print information messages in a consistent style
   function Print-Info {
       param (
           [string]$message
       )
       Write-Host "[INFO] $message" -ForegroundColor Cyan
   }
   
   # Function to print error messages in a consistent style
   function Print-Error {
       param (
           [string]$message
       )
       Write-Host "[ERROR] $message" -ForegroundColor Red
   }
   
   # Function to print suggestion messages in a consistent style
   function Print-Suggestion {
       param (
           [string]$message
       )
       Write-Host "[SUGGESTION] $message" -ForegroundColor Yellow
   }
   
   # Header
   Clear-Host
   Print-Separator
   Write-Host "WSL Compatibility Check Script" -ForegroundColor Green
   Print-Separator
   
   # Check Execution Policy
   $currentPolicy = Get-ExecutionPolicy
   
   # Check if the execution policy allows running scripts
   if ($currentPolicy -eq "Restricted") {
       Print-Error "Error: The current PowerShell execution policy is set to 'Restricted'."
       Print-Suggestion "To run this script, you need to change the execution policy to 'RemoteSigned' or 'Unrestricted'."
   
       Print-Info "Follow these steps to enable script execution:"
       Print-Info "1. Open PowerShell as Administrator."
       Print-Info "2. Run the following command to change the execution policy:"
       Print-Info "   Set-ExecutionPolicy RemoteSigned"
       Print-Info "3. Press 'Y' to confirm when prompted."
       Print-Info "4. Re-run this script after changing the execution policy."
       
       Print-Separator
       Write-Host "Script execution aborted due to restricted policy." -ForegroundColor Red
       Write-Host "Press any key to exit..." -ForegroundColor White
       [System.Console]::ReadKey() | Out-Null
       exit
   }
   
   # Get the current Windows version
   $windowsVersion = [System.Environment]::OSVersion.Version
   $minVersion = [Version]"10.0.18362" # Windows 10, version 1903 (WSL support starts here)
   
   # Display current Windows version
   Print-Info "Current Windows Version: $($windowsVersion.Major).$($windowsVersion.Minor).$($windowsVersion.Build)"
   
   # Check if the version meets the minimum requirement for WSL
   if ($windowsVersion -ge $minVersion) {
       Write-Host "`nChecking system compatibility..." -ForegroundColor Green
       Start-Sleep -Seconds 2
       Print-Info "This version of Windows supports WSL (Windows Subsystem for Linux)."
   
       # Check if WSL is installed
       $wslInstalled = Get-WindowsFeature -Name Microsoft-Windows-Subsystem-Linux
   
       if ($wslInstalled.Installed) {
           Print-Info "WSL is already installed on your system."
   
           # Check if Debian is installed
           $debianInstalled = wsl --list --verbose | Select-String -Pattern "Debian"
   
           if ($debianInstalled) {
               Print-Info "Debian is already installed on your system."
           } else {
               Print-Info "Debian is not installed. Installing Debian..."
   
               # Install Debian via WSL
               wsl --install -d Debian
   
               Write-Host "`nDebian installation is complete." -ForegroundColor Green
               Print-Info "Setting the default username and password..."
   
               # After installation, provide instructions to set up username and password
               Print-Info "Follow these steps to set up your default username and password:"
               Print-Info "1. Launch Debian from the Start menu or run 'wsl' in the command line."
               Print-Info "2. The first time you launch Debian, you will be prompted to create a user."
               Print-Info "3. Set the username to 'dusty' and the password to '123'."
               Print-Info "4. Once the setup is complete, you can start using Debian in WSL."
   
           }
       } else {
           Print-Error "WSL is not installed on your system."
           Print-Suggestion "To install WSL, follow these steps:"
   
           Print-Info "1. Open PowerShell as Administrator."
           Print-Info "2. Run the following command to install WSL:"
           Print-Info "   wsl --install"
           Print-Info "3. Restart your system once the installation is complete."
           Print-Info "4. After restarting, you can use WSL by running 'wsl' from the command line."
       }
   
       Write-Host "`nYou can proceed with configuring or using WSL after installation." -ForegroundColor Green
       
       # Proceed to copy files and execute the bash script
       Print-Separator
       Print-Info "Creating 'llm' directory and copying scripts..."
   
       # Get the script directory path
       $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
   
       # Define the source file paths
       $mainShPath = Join-Path -Path $scriptDir -ChildPath 'main.sh'
       $mainPyPath = Join-Path -Path $scriptDir -ChildPath 'main.py'
       
       # Define the target directory in WSL
       $wslDir = "/home/dusty/llm"
   
       # Check if the main.sh and main.py files exist in the current directory
       if (Test-Path $mainShPath -and Test-Path $mainPyPath) {
           # Copy files to the 'llm' directory in WSL
           Print-Info "Copying main.sh and main.py to the llm directory in WSL..."
   
           # Create the directory in WSL if it does not exist
           wsl mkdir -p $wslDir
   
           # Copy files to WSL
           wsl cp $mainShPath $wslDir/
           wsl cp $mainPyPath $wslDir/
   
           Print-Info "Files copied successfully."
   
           # Run the main.sh script using sudo in WSL
           Print-Info "Running main.sh as sudo..."
   
           # Execute main.sh with sudo in WSL and pass control over to the script
           wsl sudo bash $wslDir/main.sh
       } else {
           Print-Error "Error: main.sh and/or main.py not found in the script directory."
           Write-Host "Please make sure both files exist in the same directory as this script." -ForegroundColor Red
           Write-Host "Press any key to exit..." -ForegroundColor White
           [System.Console]::ReadKey() | Out-Null
           exit
       }
   
   } else {
       Print-Error "Error: This version of Windows does not support WSL."
       Print-Suggestion "Consider upgrading to a version of Windows that supports WSL or install VirtualBox as an alternative for running Linux."
   }
   
   Print-Separator
   Write-Host "Script execution complete. Press any key to exit..." -ForegroundColor White
   [System.Console]::ReadKey() | Out-Null
   