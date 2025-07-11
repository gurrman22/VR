﻿$PackageName = "Wallpaper"
$Version = 1

# Set image file names for desktop background and lock screen
# leave blank if you wish not to set either of one
$WallpaperIMG = "Desktop.png"
$LockscreenIMG = "lockscreen.png"

Start-Transcript -Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\$PackageName-install.log" -Force
$ErrorActionPreference = "Stop"

# Set variables for registry key path and names of registry values to be modified
$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"
$LockScreenPath = "LockScreenImagePath"
$LockScreenStatus = "LockScreenImageStatus"
$LockScreenUrl = "LockScreenImageUrl"
$StatusValue = "1"


$url1 = "https://raw.githubusercontent.com/gurrman22/VR/refs/heads/main/Background.png"
$DesktopImageValue = "C:\MDM\Desktop.png"
$url2 = "https://raw.githubusercontent.com/gurrman22/VR/refs/heads/main/Background.png"
$LockscreenImageValue = "C:\MDM\Lockscreen.png"
$directory = "C:\MDM\"


If ((Test-Path -Path $directory) -eq $false)
{
	New-Item -Path $directory -ItemType directory
}

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url1, $DesktopImageValue)
$wc.DownloadFile($url2, $LockscreenImageValue)

# local path of images
$WallpaperLocalIMG = "C:\MDM\Desktop.png"
$LockscreenLocalIMG = "C:\MDM\Lockscreen.png"

# Check whether both image file variables have values, output warning message and exit if either is missing
if (!$LockscreenIMG -and !$WallpaperIMG){
    Write-Warning "Either LockscreenIMG or WallpaperIMG must has a value."
}
else{
    # Check whether registry key path exists, create it if it does not
    if(!(Test-Path $RegKeyPath)){
        Write-Host "Creating registry path: $($RegKeyPath)."
        New-Item -Path $RegKeyPath -Force
    }
    if ($LockscreenIMG){
        #Write-Host "Copy lockscreen ""$($LockscreenIMG)"" to ""$($LockscreenLocalIMG)"""
        #Copy-Item ".\Data\$LockscreenIMG" $LockscreenLocalIMG -Force
        Write-Host "Creating regkeys for lockscreen"
        New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $StatusValue -PropertyType DWORD -Force
        New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $LockscreenLocalIMG -PropertyType STRING -Force
        New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $LockscreenLocalIMG -PropertyType STRING -Force
    }
    if ($WallpaperIMG){
        #Write-Host "Copy wallpaper ""$($WallpaperIMG)"" to ""$($WallpaperLocalIMG)"""
        #Copy-Item ".\Data\$WallpaperIMG" $WallpaperLocalIMG -Force
        Write-Host "Creating regkeys for wallpaper"
        New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $StatusValue -PropertyType DWORD -Force
        New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $WallpaperLocalIMG -PropertyType STRING -Force
        New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $WallpaperLocalIMG -PropertyType STRING -Force
    }  
}


New-Item -Path "C:\ProgramData\scloud\Validation\$PackageName" -ItemType "file" -Force -Value $Version

Stop-Transcript
