-- PostgreSQL Initialisierungsskript
-- Stellt sicher, dass der Benutzer und die Datenbank korrekt eingerichtet sind

-- Erstelle Benutzer falls er nicht existiert
DO $$ 
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'flugplatzmanager') THEN
      CREATE USER flugplatzmanager WITH PASSWORD 'Dc#9EnhHj6WzhYt@@2079TwokG81mwNsa#';
   END IF;
END
$$;

-- Gebe dem Benutzer alle notwendigen Rechte
ALTER USER flugplatzmanager CREATEDB;
ALTER USER flugplatzmanager WITH SUPERUSER;

-- Stelle sicher, dass das Passwort gesetzt ist
ALTER USER flugplatzmanager PASSWORD 'Dc#9EnhHj6WzhYt@@2079TwokG81mwNsa#';

-- Gebe Rechte auf die Datenbank
GRANT ALL PRIVILEGES ON DATABASE flugplatzmanager TO flugplatzmanager;