$url1 = "https://raw.githubusercontent.com/gurrman22/VR/refs/heads/main/Background1.jpg"
$DesktopImageValue = "C:\MDM\Desktop1.jpg"
$url2 = "https://raw.githubusercontent.com/gurrman22/VR/refs/heads/main/Lockscreen1.jpg"
$LockscreenImageValue = "C:\MDM\Lockscreen1.jpg"
$directory = "C:\MDM\"


If ((Test-Path -Path $directory) -eq $false)
{
	New-Item -Path $directory -ItemType directory
}

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url1, $DesktopImageValue)
$wc.DownloadFile($url2, $LockscreenImageValue)
