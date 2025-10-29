# Obtener la etiqueta Git más reciente o usar "dev" si no está disponible
try {
    $gitTag = (git describe --tags --always --dirty)
} catch {
    $gitTag = "dev"
}

if (-not $gitTag) { $gitTag = "dev" }

Write-Host "Construyendo imagen con tag: $gitTag" -ForegroundColor Cyan

# Construir imagen Docker con la etiqueta obtenida
docker build -t "nttdevops-flask:$gitTag" .

# Levantando la stack con docker-compose usando la etiqueta obtenida
Write-Host "Levantando stack con docker-compose..." -ForegroundColor Yellow
$env:IMAGE_TAG = $gitTag
docker compose up --build