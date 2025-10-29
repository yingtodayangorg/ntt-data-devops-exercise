param(
    [string]$Environment = "dev"
)

# Obtiene versión de git o usa fallback
try {
    $gitTag = (git describe --tags --always)
} catch {
    $gitTag = "v0.0.1"
}

# Limpia tag si está vacío
if (-not $gitTag) { $gitTag = "v0.0.1" }

# Construye nombre de imagen
$ImageName = "nttdevops-flask"
$FullTag = "$gitTag-$Environment"

Write-Host "Building image: $($ImageName):$FullTag" -ForegroundColor Cyan

docker build -t "$($ImageName):$FullTag" .