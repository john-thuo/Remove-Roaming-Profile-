# Run as Administrator

# Define local profile path
$UserName = $env:USERNAME
$LocalProfilePath = "C:\Users\$UserName"

# Define redirected folders (modify as needed)
$RedirectedFolders = @(
    "Desktop",
    "Documents",
    "Downloads",
    "Favorites",
    "Links",
    "Music",
    "Pictures",
    "Videos"
)

# Copy files from redirected folders back to the local profile
foreach ($Folder in $RedirectedFolders) {
    $Source = "$env:USERPROFILE\$Folder"
    $Destination = "$LocalProfilePath\$Folder"

    if (Test-Path $Source) {
        Write-Host "Copying $Source to $Destination..."
        robocopy $Source $Destination /E /COPYALL /MOVE
    }
}

# Remove Folder Redirection from Registry
$RegistryPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
)

foreach ($RegPath in $RegistryPaths) {
    foreach ($Folder in $RedirectedFolders) {
        $RegKey = Get-ItemProperty -Path $RegPath -Name $Folder -ErrorAction SilentlyContinue
        if ($RegKey) {
            Set-ItemProperty -Path $RegPath -Name $Folder -Value "%USERPROFILE%\$Folder"
            Write-Host "Reset redirection for $Folder"
        }
    }
}

# Disable Roaming Profile
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" -Name "CentralProfile" -Value ""

# Force user logoff after changes
Write-Host "Folder redirection removed. Logging off in 10 seconds..."
Start-Sleep -Seconds 10
shutdown -l
