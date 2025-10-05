-- Datenbank-Entwurf für das Flugplatzmanagement
DROP DATABASE IF EXISTS Flugplatzmanagement;
CREATE DATABASE Flugplatzmanagement;
USE Flugplatzmanagement;

CREATE TABLE t_Kostenstelle (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Strasse VARCHAR(255) NOT NULL,
    PLZ INT NOT NULL,
    Ort VARCHAR(255) NOT NULL,
    Aktiv BOOLEAN DEFAULT TRUE
);

CREATE TABLE t_Benutzer (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Vorname VARCHAR(255) NOT NULL,
    Nachname VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Passwort VARCHAR(255) NOT NULL,
    KostenstelleId INT NULL,
    FOREIGN KEY (KostenstelleId) REFERENCES t_Kostenstelle(Id)
);

CREATE TABLE t_Rolle (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Rollentyp VARCHAR(255) NOT NULL
);

CREATE TABLE t_BenutzerRolle (
    BenutzerId INT NOT NULL,
    RolleId INT NOT NULL,
    PRIMARY KEY (BenutzerId, RolleId),
    FOREIGN KEY (BenutzerId) REFERENCES t_Benutzer(Id),
    FOREIGN KEY (RolleId) REFERENCES t_Rolle(Id)
);

CREATE TABLE t_Preiskategorie (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Kategorie VARCHAR(255) NOT NULL,
    Preis DECIMAL(10,2) NOT NULL
);

CREATE TABLE t_Flugart (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Flugtyp VARCHAR(255) NOT NULL
);

CREATE TABLE t_Flugzeugtyp (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Flugzeugtyp VARCHAR(255) NOT NULL,
    PreisId INT NULL,
    FOREIGN KEY (PreisId) REFERENCES t_Preiskategorie(Id)
);

CREATE TABLE t_Flugzeug (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Kennzeichen VARCHAR(255) UNIQUE NOT NULL,
    Zaehlerstand INT NOT NULL,
    Grounded BOOLEAN NOT NULL DEFAULT FALSE,
    FlugzeugtypId INT NOT NULL,
    KostenstelleId INT NULL,
    DatumARC DATE NULL,
    DatumFlugzeitwartung DATE NULL,
    Wartungsart VARCHAR(255) NULL,
    FOREIGN KEY (FlugzeugtypId) REFERENCES t_Flugzeugtyp(Id),
    FOREIGN KEY (KostenstelleId) REFERENCES t_Kostenstelle(Id)
);

CREATE TABLE t_Flugminutenkosten (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FlugartId INT NOT NULL,
    FlugzeugId INT NOT NULL,
    KostenMinuten DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (FlugartId) REFERENCES t_Flugart(Id),
    FOREIGN KEY (FlugzeugId) REFERENCES t_Flugzeug(Id),
    UNIQUE KEY uq_minutenkosten (FlugartId, FlugzeugId)
);


CREATE TABLE t_Flug (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FlugzeugId INT NOT NULL,
    FlugartId  INT NOT NULL,
    StartTs    DATETIME NOT NULL,
    EndeTs     DATETIME NULL,
    Bemerkung  VARCHAR(255),
    Status ENUM('Geplant','StartErfasst','EndeErfasst','Storniert') DEFAULT 'Geplant',
    CONSTRAINT chk_flug_zeitfolge CHECK (EndeTs IS NULL OR StartTs < EndeTs),
    FOREIGN KEY (FlugzeugId) REFERENCES t_Flugzeug(Id),
    FOREIGN KEY (FlugartId)  REFERENCES t_Flugart(Id),
    INDEX ix_flug_flz_zeit (FlugzeugId, StartTs, EndeTs)
);


CREATE TABLE t_Pilotenflug (
    Id INT PRIMARY KEY,
    Pilot VARCHAR(255) NOT NULL,
    StartZaehler INT NOT NULL,
    EndZaehler   INT NULL,
    DauerMinuten INT GENERATED ALWAYS AS (
        CASE WHEN EndZaehler IS NULL THEN NULL ELSE ROUND((EndZaehler - StartZaehler) * 6) END
    ) STORED,
    CONSTRAINT chk_pf_zaehler_monoton CHECK (EndZaehler IS NULL OR EndZaehler >= StartZaehler),
    FOREIGN KEY (Id) REFERENCES t_Flug(Id) ON DELETE CASCADE,
    INDEX ix_pf_pilot (Pilot)
);

CREATE TABLE t_Reservierung (
    Id INT PRIMARY KEY,
    Pilot VARCHAR(255) NOT NULL,
    Datum DATE NOT NULL,
    Gastname    VARCHAR(255),
    Gastkontakt VARCHAR(255),
    Status ENUM('Offen','Erledigt','Storniert') DEFAULT 'Offen',
    FOREIGN KEY (Id) REFERENCES t_Flug(Id) ON DELETE CASCADE,
    INDEX ix_res_pilot (Pilot),
    INDEX ix_res_datum (Datum)
);

CREATE TABLE t_StartLandeListe (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Einflug BOOLEAN,
    Ausflug BOOLEAN,
    Startzeit DATETIME,
    Landezeit DATETIME,
    Bemerkung VARCHAR(255),
    Bezahlt BOOLEAN DEFAULT FALSE,
    Pilot1 VARCHAR(255),
    Pilot2 VARCHAR(255),
    FlugzeugId INT NOT NULL,
    FlugartId INT NOT NULL,
    FOREIGN KEY (FlugzeugId) REFERENCES t_Flugzeug(Id),
    FOREIGN KEY (FlugartId) REFERENCES t_Flugart(Id),
    CONSTRAINT chk_Einflug CHECK (
        (Einflug = TRUE AND Startzeit IS NULL) OR (Einflug = FALSE AND Startzeit IS NOT NULL)
    ),
    CONSTRAINT chk_Ausflug CHECK (
        (Ausflug = TRUE AND Landezeit IS NULL) OR (Ausflug = FALSE AND Landezeit IS NOT NULL)
    ),
    CONSTRAINT chk_Startzeit_Landezeit CHECK (
        Startzeit IS NULL OR Landezeit IS NULL OR Startzeit < Landezeit
    )
);