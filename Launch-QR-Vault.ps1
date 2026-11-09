<#
    QR Vault — Auto-Detecting Wi-Fi Launcher for Windows
#>
$wifiOutput = netsh wlan show interfaces 2>$null | Select-String "^\s*SSID\s*:\s*(.+)$"
$ssid = ""
if ($wifiOutput -and $wifiOutput.Matches.Groups.Count -gt 1) {
    $ssid = $wifiOutput.Matches.Groups[1].Value.Trim()
}

$htmlPath = "$PSScriptRoot\index.html"
$query = ""
if ($ssid) {
    $query = "?type=wifi&ssid=$([System.Web.HttpUtility]::UrlEncode($ssid))"
}

$edgePaths = @(
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
)

$launched = $false
foreach ($browser in $edgePaths) {
    if (Test-Path $browser) {
        Start-Process $browser -ArgumentList "--app=`"file:///$htmlPath$query`" --window-size=1100,800"
        $launched = $true
        break
    }
}

if (-not $launched) {
    Start-Process "$htmlPath$query"
}
