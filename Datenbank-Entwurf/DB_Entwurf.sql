DROP DATABASE IF EXISTS Flugplatzmanagement;
CREATE DATABASE Flugplatzmanagement;
USE Flugplatzmanagement;

CREATE TABLE t_Kostenstelle (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Strasse VARCHAR(255) NOT NULL,
    PLZ INT NOT NULL,
    Ort VARCHAR(255) NOT NULL
);

CREATE TABLE t_Benutzer (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Vorname VARCHAR(255) NOT NULL,
    Nachname VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Passwort VARCHAR(255) NOT NULL,
    KostenstelleId INT,
    FOREIGN KEY (KostenstelleId) REFERENCES t_Kostenstelle(Id)
);

CREATE TABLE t_Rolle (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Rollentyp VARCHAR(255) NOT NULL
);

CREATE TABLE t_Preiskategorie (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Kategorie VARCHAR(255) NOT NULL,
    Preis DECIMAL(10, 2) NOT NULL
);

CREATE TABLE t_Flugart (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Flugtyp VARCHAR(255) NOT NULL
);

CREATE TABLE t_Flugzeugtyp (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Flugzeugtyp VARCHAR(255) NOT NULL,
    PreisId INT,
    FOREIGN KEY (PreisId) REFERENCES t_Preiskategorie(Id)
);

CREATE TABLE t_Flugzeug (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Kennzeichen VARCHAR(255) UNIQUE NOT NULL,
    Zahlerstand INT NOT NULL,
    Grounded BOOLEAN ,
    FlugzeugtypId INT,
    KostenstelleId INT,
    DatumARC DATE,
    DatumFlugzeitwartung DATE,
    Wartungsart VARCHAR(255),
    FOREIGN KEY (FlugzeugtypId) REFERENCES t_Flugzeugtyp(Id),
    FOREIGN KEY (KostenstelleId) REFERENCES t_Kostenstelle(Id)
);

CREATE TABLE t_BenutzerRolle (
    BenutzerId INT,
    RolleId INT,
    PRIMARY KEY (BenutzerId, RolleId),
    FOREIGN KEY (BenutzerId) REFERENCES t_Benutzer(Id),
    FOREIGN KEY (RolleId) REFERENCES t_Rolle(Id)
);


CREATE TABLE t_Flugminutenkosten (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FlugartId INT,
    FlugzeugId INT,
    KostenMinuten DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (FlugartId) REFERENCES t_Flugart(Id),
    FOREIGN KEY (FlugzeugId) REFERENCES t_Flugzeug(Id)
);

CREATE TABLE t_StartLandeListe (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Einflug BOOLEAN,
    Ausflug BOOLEAN,
    Startzeit DATETIME,
    Landezeit DATETIME,
    Bemerkung VARCHAR(255),
    bezahlt BOOLEAN DEFAULT FALSE,
    Pilot1 VARCHAR(255),
    Pilot2 VARCHAR(255),
    FlugzeugId INT,
    FlugartId INT,
    FOREIGN KEY (FlugzeugId) REFERENCES t_Flugzeug(Id),
    FOREIGN KEY (FlugartId) REFERENCES t_Flugart(Id),
    CONSTRAINT chk_Einflug CHECK (
        (Einflug = TRUE AND Startzeit IS NULL) OR (Einflug = FALSE AND Startzeit IS NOT NULL)
    ),
    CONSTRAINT chk_Ausflug CHECK (
        (Ausflug = TRUE AND Landezeit IS NULL) OR (Ausflug = FALSE AND Landezeit IS NOT NULL)
    ),
    CONSTRAINT chk_Startzeit_Landezeit CHECK (
        Startzeit < Landezeit
    )
);

CREATE TABLE t_Pioltenflug (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    PioltenId INT,
    FlugzeugId INT,
    Startzeit DATETIME,
    Landezeit DATETIME,
    FlugartId INT,
    Bemerkung VARCHAR(255),
    FOREIGN KEY (PioltenId) REFERENCES t_Benutzer(Id),
    FOREIGN KEY (FlugzeugId) REFERENCES t_Flugzeug(Id),
    FOREIGN KEY (FlugartId) REFERENCES t_Flugart(Id)
);

CREATE TABLE t_Reservierung (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    PioltenId INT,
    FlugzeugId INT,
    FlugartId INT,
    Datum DATE,
    Startzeit TIME,
    Landezeit TIME,
    Bemerkung VARCHAR(255),
    Gastname VARCHAR(255) NULL,
    Gastkontakt VARCHAR(255) NULL,
    FOREIGN KEY (PioltenId) REFERENCES t_Benutzer(Id),
    FOREIGN KEY (FlugzeugId) REFERENCES t_Flugzeug(Id),
    FOREIGN KEY (FlugartId) REFERENCES t_Flugart(Id),
    
    CONSTRAINT chk_Reservierung CHECK (
        Startzeit < Landezeit
    )
);