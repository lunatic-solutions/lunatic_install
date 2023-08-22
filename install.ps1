#!/usr/bin/env pwsh

$ErrorActionPreferece = 'Stop'

if ($v) {
    $Version = "v${v}"
}
if ($Args.Length -eq 1) {
    $Version = $Args.Get(0)
}

$LunaticInstall = $env::LUNATIC_INSTALL
$BinDir = if ($LunaticInstall) {
    "${LunaticInstall}\bin"
} else {
    "${Home}\.lunatic\bin"
}

$LunaticZip = "$BinDir\lunatic.zip"
$LunaticExe = "$BinDir\lunatic.exe"
$Target = "windows-amd64"

$DownloadUrl = if (!$Version) {
    "https://github.com/lunatic-solutions/lunatic/releases/latest/download/lunatic-${Target}.zip"
} else {
    "https://github.com/lunatic-solutions/lunatic/releases/download/${Version}/lunatic-${Target}.zip"
}

if (!(Test-Path $BinDir)) {
    New-Item $BinDir -ItemType Directory | Out-Null
}

curl.exe -Lo $LunaticZip $DownloadUrl
tar.exe xf $LunaticZip -C $BinDir

Remove-Item $LunaticZip

$User = [System.EnvironmentVariableTarget]::User
$Path = [System.Environment]::GetEnvironmentVariable('Path', $User)
if (!(";${Path};".ToLower() -like "*;${BinDir};*".ToLower())) {
  [System.Environment]::SetEnvironmentVariable('Path', "${Path};${BinDir}", $User)
  $Env:Path += ";${BinDir}"
}

Write-Output "Lunatic was installed successfully to ${LunaticExe}"
Write-Output "Run 'lunatic --help' to get started"
Write-Output "Stuck? Join our Discord https://discord.gg/fZR5wxNp"

