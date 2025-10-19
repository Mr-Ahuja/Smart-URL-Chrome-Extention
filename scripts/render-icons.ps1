param(
  [int[]]$Sizes = @(16,24,32,48,128)
)
$ErrorActionPreference = 'Stop'

function Find-BrowserBin {
  $candidates = @(
    (Get-Command chrome -ErrorAction SilentlyContinue | Select-Object -First 1).Source,
    (Get-Command msedge -ErrorAction SilentlyContinue | Select-Object -First 1).Source,
    "$Env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "$Env:ProgramFiles(x86)\Google\Chrome\Application\chrome.exe",
    "$Env:LocalAppData\Google\Chrome\Application\chrome.exe",
    "$Env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "$Env:ProgramFiles(x86)\Microsoft\Edge\Application\msedge.exe"
  ) | Where-Object { $_ -and (Test-Path $_) }
  if ($candidates.Count -gt 0) { return $candidates[0] }
  return $null
}

$bin = Find-BrowserBin
if (-not $bin) { throw 'Chrome/Edge not found. Install Chrome or Edge and re-run this script.' }

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$repo = Resolve-Path (Join-Path $root '..')
$svgPath = Join-Path $repo 'icons/smart-url.svg'
if (-not (Test-Path $svgPath)) { throw "SVG not found: $svgPath" }

$tmp = Join-Path $repo '.tmp-icons'
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $repo 'icons') | Out-Null
$svg = Get-Content -Raw $svgPath

function To-FileUri([string]$p) { return ([System.Uri]::new((Resolve-Path $p))).AbsoluteUri }
function Render-Icon([int]$size) {
  $htmlPath = Join-Path $tmp ("icon-$size.html")
  $outPath  = Join-Path (Join-Path $repo 'icons') ("icon$size.png")
  $html = @"
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <style>
      html, body { margin:0; padding:0; background: transparent; width:${size}px; height:${size}px; overflow:hidden; }
      svg { display:block; width:${size}px; height:${size}px; }
    </style>
  </head>
  <body>
    $svg
  </body>
</html>
"@
  Set-Content -LiteralPath $htmlPath -Value $html -Encoding UTF8
  $uri = To-FileUri $htmlPath
  $args = @('--headless=new','--disable-gpu',"--screenshot=$outPath","--window-size=$size,$size","--default-background-color=0",$uri)
  Start-Process -FilePath $bin -ArgumentList $args -Wait -NoNewWindow | Out-Null
  Write-Host "Rendered $outPath"
}

foreach ($s in $Sizes) { Render-Icon $s }
