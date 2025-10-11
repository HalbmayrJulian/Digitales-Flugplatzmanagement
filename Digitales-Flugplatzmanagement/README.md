# DOCKER COMPOSE BEFEHLE
# =====================

# Alle Services im Hintergrund starten (detached mode)
docker compose up -d

# Services neu bauen und im Hintergrund starten
docker compose up --build -d

# Alle Services stoppen und Container/Netzwerke entfernen
docker compose down

# Alle Services nur stoppen (Container bleiben bestehen)
docker compose stop

# Live-Logs aller Services anzeigen (Ctrl+C zum Beenden)
docker compose logs -f

# Status aller Compose-Services anzeigen
docker compose ps


# CONTAINER AUFLISTEN
# ===================

# Nur laufende Container in Tabellenformat anzeigen
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"

# ALLE Container (laufend + gestoppt) in Tabellenformat anzeigen
docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"

# Nur gestoppte/beendete Container anzeigen
docker ps -a --filter "status=exited" --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"


# IMAGES AUFLISTEN
# ================

# Alle Docker Images in Tabellenformat anzeigen
docker image ls --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}"

# Kurze Variante (Alias für obigen Befehl)
docker images

# Nur "dangling" Images anzeigen (ungelinkte/unbenutzte Images)
docker image ls -f dangling=true


# CONTAINER LÖSCHEN
# =================

# Einzelnen Container löschen (muss gestoppt sein)
docker rm <container-id-or-name>

# Container erzwungen löschen (stoppt und entfernt gleichzeitig)
docker rm -f <container-id-or-name>

# Sicherer Weg: Erst alle Container anzeigen, dann ID/Name prüfen
docker ps -a
# prüfe ID/Name, dann
docker rm <id>


# IMAGES LÖSCHEN
# ==============

# Einzelnes Image löschen (darf nicht von Container benutzt werden)
docker rmi <image-id-or-repo:tag>

# Image erzwungen löschen (auch wenn Abhängigkeiten bestehen)
docker rmi -f <image-id-or-repo:tag>


# BATCH-LÖSCHUNG (VORSICHT!)
# ===========================

# Alle gestoppten Container entfernen
docker ps -aq -f status=exited | xargs -r docker rm

# Alternative: Alle gestoppten Container entfernen (mit Bestätigung)
docker container prune

# Nur unbenutzte Images entfernen (sicher)
docker image prune

# ALLE ungenutzten Images entfernen - auch getaggte (VORSICHTIG!)
docker image prune -a

# Alle ungenutzten Images ohne Bestätigung entfernen (GEFÄHRLICH!)
docker image prune -a -f

# =============================================================================
# .NET BEFEHLE
# ===========================
# Projekt mit der Blazor App starten
cd Flugplatzmanager
# Optional: --launch-profile https (normalerweise reicht ohne --launch-profile http)
dotnet run
# Projekt mit der Docker Compose starten
docker compose up -d (in dem Verzeichnis mit der docker-compose.yml)
# Projekt neu laden/bauen/clean
dotnet build
dotnet clean
# Projekt veröffentlichen (publish) für Release
dotnet publish -c Release
# =============================================================================


