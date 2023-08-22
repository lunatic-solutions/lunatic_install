#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

# Test that we can install the latest version at the default location.
Remove-Item "~\.lunatic" -Recurse -Force -ErrorAction SilentlyContinue
$env:LUNATIC_INSTALL = ""
$v = $null; .\install.ps1
~\.lunatic\bin\lunatic.exe --version

# Test that we can install a specific version at a custom location.
Remove-Item "~\lunatic-0.12.0" -Recurse -Force -ErrorAction SilentlyContinue
$env:LUNATIC_INSTALL = "$Home\lunatic-0.12.0"
$v = "0.12.0"; .\install.ps1
$lunaticVersion = ~\lunatic-0.12.0\bin\lunatic.exe --version
if (!($lunaticVersion -like '*0.12.0*')) {
  throw $lunaticVersion
}

# Test that we can install at a relative custom location.
Remove-Item "bin" -Recurse -Force -ErrorAction SilentlyContinue
$env:LUNATIC_INSTALL = "."
$v = "0.12.0"; .\install.ps1
$lunaticVersion = bin\lunatic.exe --version
if (!($lunaticVersion -like '*0.12.0*')) {
  throw $lunaticVersion
}

# Test that the old temp file installer still works.
Remove-Item "~\lunatic-0.12.0" -Recurse -Force -ErrorAction SilentlyContinue
$env:LUNATIC_INSTALL = "$Home\lunatic-0.12.0"
$v = $null; .\install.ps1 v0.12.0
$lunaticVersion = ~\lunatic-0.12.0\bin\lunatic.exe --version
if (!($lunaticVersion -like '*0.12.0*')) {
  throw $lunaticVersion
}