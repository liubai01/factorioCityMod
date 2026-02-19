param(
    [string]$FactorioModsPath = ""
)

$ErrorActionPreference = "Stop"

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message"
}

function Remove-IfExists {
    param([string]$Path)
    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Recurse -Force
        return $true
    }
    return $false
}

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$InfoJsonPath = Join-Path $RepoRoot "info.json"

if (-not (Test-Path -LiteralPath $InfoJsonPath)) {
    throw "Cannot find info.json at: $InfoJsonPath"
}

$Info = Get-Content -LiteralPath $InfoJsonPath -Raw | ConvertFrom-Json
$ModName = $Info.name

if ([string]::IsNullOrWhiteSpace($ModName)) {
    throw "Field 'name' is missing in info.json."
}

if ([string]::IsNullOrWhiteSpace($FactorioModsPath)) {
    $FactorioModsPath = Join-Path $env:APPDATA "Factorio\mods"
}

if (-not (Test-Path -LiteralPath $FactorioModsPath)) {
    Write-Info "Mods directory not found, nothing to uninstall: $FactorioModsPath"
    exit 0
}

$TargetPath = Join-Path $FactorioModsPath $ModName

Write-Info "Factorio mods path: $FactorioModsPath"
Write-Info "Target mod path: $TargetPath"

$RemovedTarget = Remove-IfExists -Path $TargetPath
if ($RemovedTarget) {
    Write-Info "Removed mod directory/link: $ModName"
} else {
    Write-Info "Mod directory/link not found: $ModName"
}

$RemovedZipCount = 0
$ZipMatches = Get-ChildItem -LiteralPath $FactorioModsPath -Filter "$ModName_*.zip" -ErrorAction SilentlyContinue
if ($ZipMatches) {
    foreach ($ZipFile in $ZipMatches) {
        Remove-Item -LiteralPath $ZipFile.FullName -Force
        $RemovedZipCount++
        Write-Info "Removed package: $($ZipFile.Name)"
    }
}

if ($RemovedZipCount -eq 0) {
    Write-Info "No matching package zip found."
}

Write-Host ""
Write-Host "Done. Development mod '$ModName' is uninstalled." -ForegroundColor Green
