param(
  [string]$OutDir = 'dist'
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path 'manifest.json')) { throw 'Run this script from the project root (manifest.json not found).' }

# Read version from manifest
$manifest = Get-Content -Raw manifest.json | ConvertFrom-Json
$version = $manifest.version
if (-not $version) { throw 'manifest.json has no version' }

$zipName = "curls-$version.zip"
$dist = Join-Path (Get-Location) $OutDir
New-Item -ItemType Directory -Force -Path $dist | Out-Null
$zipPath = Join-Path $dist $zipName

# Paths to include in the package
$include = @(
  'manifest.json',
  'popup.html',
  'popup.js',
  'icons',
  'PRIVACY.md',
  'README.md',
  'CHANGELOG.md',
  'store-listing'
) | Where-Object { Test-Path $_ }

if ($include.Count -eq 0) { throw 'Nothing to package. Check paths.' }

if (Test-Path $zipPath) { Remove-Item -LiteralPath $zipPath -Force }
Compress-Archive -Path $include -DestinationPath $zipPath -Force
Write-Host "Created package: $zipPath"
