# Instala PoyeriaCare (ultima version) desde GitHub Releases.
# Uso (en PowerShell):  irm https://raw.githubusercontent.com/oiergonzalezth-png/PoyeriaCare/main/install.ps1 | iex
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$repo = 'oiergonzalezth-png/PoyeriaCare'
$h = @{ 'User-Agent' = 'PoyeriaCare-Install' }

Write-Host 'Buscando la ultima version de PoyeriaCare...'
$rel = Invoke-RestMethod "https://api.github.com/repos/$repo/releases/latest" -Headers $h
$asset = $rel.assets | Where-Object { $_.name -eq 'PoyeriaCare-Setup.exe' } | Select-Object -First 1
if (-not $asset) { throw 'No se encontro el instalador en la ultima version.' }
$m = [regex]::Match([string]$rel.body, 'SHA256:\s*([0-9A-Fa-f]{64})')
if (-not $m.Success) { throw 'La version no publica su huella (SHA-256); instalacion cancelada.' }

$tmp = Join-Path $env:TEMP 'PoyeriaCare-Setup.exe'
Write-Host "Descargando PoyeriaCare $($rel.tag_name)..."
Invoke-WebRequest $asset.browser_download_url -OutFile $tmp -UseBasicParsing -Headers $h

# comprueba que el archivo descargado no esta danado ni alterado
if ((Get-FileHash $tmp -Algorithm SHA256).Hash -ne $m.Groups[1].Value.ToUpper()) {
    Remove-Item $tmp -Force
    throw 'El archivo descargado no coincide con la huella publicada. Instalacion cancelada.'
}
Write-Host 'Archivo verificado. Abriendo el instalador (Windows pedira permisos de administrador)...'
Start-Process $tmp