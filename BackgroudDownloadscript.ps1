$url1 = "https://raw.githubusercontent.com/gurrman22/VR/refs/heads/main/Background.jpg"
$DesktopImageValue = "C:\MDM\Desktop.jpg"
$url2 = "https://raw.githubusercontent.com/gurrman22/VR/refs/heads/main/Background.jpg"
$LockscreenImageValue = "C:\MDM\Lockscreen.jpg"
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
