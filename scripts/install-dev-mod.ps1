param(
    [string]$FactorioModsPath = ""
)

$ErrorActionPreference = "Stop"

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message"
}

function Write-Warn {
    param([string]$Message)
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Remove-IfExists {
    param([string]$Path)
    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Recurse -Force
    }
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
    Write-Info "Mods directory does not exist, creating: $FactorioModsPath"
    New-Item -ItemType Directory -Path $FactorioModsPath -Force | Out-Null
}

$TargetPath = Join-Path $FactorioModsPath $ModName

Write-Info "Repo root: $RepoRoot"
Write-Info "Factorio mods path: $FactorioModsPath"
Write-Info "Target mod path: $TargetPath"

Remove-IfExists -Path $TargetPath

$ZipMatches = Get-ChildItem -LiteralPath $FactorioModsPath -Filter "$ModName_*.zip" -ErrorAction SilentlyContinue
if ($ZipMatches) {
    foreach ($ZipFile in $ZipMatches) {
        Write-Info "Removing old package: $($ZipFile.Name)"
        Remove-Item -LiteralPath $ZipFile.FullName -Force
    }
}

$Linked = $false
try {
    New-Item -ItemType SymbolicLink -Path $TargetPath -Target $RepoRoot | Out-Null
    $Linked = $true
    Write-Info "Installed via symlink (hot-reload friendly for development)."
} catch {
    Write-Warn "Symlink creation failed, fallback to file copy."
    Write-Warn $_.Exception.Message
}

if (-not $Linked) {
    New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
    Get-ChildItem -LiteralPath $RepoRoot -Force |
        Where-Object { $_.Name -notin @(".git", ".cursor") } |
        ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $TargetPath -Recurse -Force
        }
    Write-Info "Installed via directory copy."
}

Write-Host ""
Write-Host "Done. You can now enable '$ModName' in Factorio mod menu." -ForegroundColor Green
