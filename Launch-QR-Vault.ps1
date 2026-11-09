<#
    QR Vault — PowerShell Launcher
    Launches as a dedicated offline Windows Desktop App Window
#>
$htmlPath = "$PSScriptRoot\index.html"
$edgePaths = @(
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
)

$launched = $false
foreach ($browser in $edgePaths) {
    if (Test-Path $browser) {
        Start-Process $browser -ArgumentList "--app=`"file:///$htmlPath`" --window-size=1280,850"
        $launched = $true
        break
    }
}

if (-not $launched) {
    Start-Process $htmlPath
}
