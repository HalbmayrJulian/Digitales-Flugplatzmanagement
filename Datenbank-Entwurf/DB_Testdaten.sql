-- Aktualisierte Testdaten für die neue Datenbankstruktur
USE Flugplatzmanagement;

-- Grunddaten
INSERT INTO t_Kostenstelle (Name, Strasse, PLZ, Ort, Aktiv) VALUES
('Aeroclub Nord', 'Hangarweg 1', 3340, 'Waidhofen', TRUE),
('SkyFly GmbH', 'Flugstraße 12', 3300, 'Amstetten', TRUE),
('Pilotenschule OST', 'Aeroallee 5', 1010, 'Wien', TRUE);

INSERT INTO t_Benutzer (Vorname, Nachname, Email, Passwort, KostenstelleId) VALUES
('Max', 'Mustermann', 'max@example.com', 'pass123', 1),
('Julia', 'Flieger', 'julia@example.com', 'flug456', 2),
('Tom', 'Wolke', 'tom@example.com', 'sky789', 3);

INSERT INTO t_Rolle (Rollentyp) VALUES
('Admin'),
('Pilot'),
('Techniker');

INSERT INTO t_BenutzerRolle (BenutzerId, RolleId) VALUES
(1, 2),
(2, 2),
(3, 1);

INSERT INTO t_Preiskategorie (Kategorie, Preis) VALUES
('Standard', 2.50),
('Premium', 3.75),
('Schulung', 1.80);

INSERT INTO t_Flugart (Flugtyp) VALUES
('Vereinsflug'),
('Privatflug'),
('Schulflug');

INSERT INTO t_Flugzeugtyp (Flugzeugtyp, PreisId) VALUES
('Cessna 172', 1),
('Diamond DA40', 2),
('Piper PA28', 3);

-- Flugzeuge mit korrektem Spaltennamen 'Zaehlerstand' statt 'Zahlerstand'
INSERT INTO t_Flugzeug (Kennzeichen, Zaehlerstand, Grounded, FlugzeugtypId, KostenstelleId, DatumARC, DatumFlugzeitwartung, Wartungsart) VALUES
('OE-ABC', 1200, FALSE, 1, 1, '2025-04-01', '2025-06-15', 'Jahreswartung'),
('OE-DEF', 900, FALSE, 2, 2, '2025-03-10', '2025-05-30', 'Ölwechsel'),
('OE-GHI', 1500, TRUE, 3, 3, '2025-05-20', '2025-07-01', 'Propellerwartung');

INSERT INTO t_Flugminutenkosten (FlugartId, FlugzeugId, KostenMinuten) VALUES
(1, 1, 2.50),
(2, 2, 3.75),
(3, 3, 1.80);

-- Neue Tabelle t_Flug
INSERT INTO t_Flug (FlugzeugId, FlugartId, StartTs, EndeTs, Bemerkung, Status) VALUES
(1, 1, '2025-07-24 09:00:00', '2025-07-24 10:00:00', 'Trainingsflug', 'EndeErfasst'),
(2, 2, '2025-07-25 11:00:00', '2025-07-25 12:00:00', 'Prüfungsflug', 'EndeErfasst'),
(1, 1, '2025-08-01 10:00:00', '2025-08-01 11:00:00', 'Gastflug', 'EndeErfasst'),
(2, 2, '2025-08-02 12:00:00', '2025-08-02 13:00:00', 'Vereinsausflug', 'EndeErfasst');

-- Neue Tabelle t_Pilotenflug mit Verknüpfung zu t_Flug
INSERT INTO t_Pilotenflug (Id, Pilot, StartZaehler, EndZaehler) VALUES
(1, 'Max Mustermann', 1200, 1220),
(2, 'Julia Flieger', 900, 925);

-- Neue Tabelle t_Reservierung mit Verknüpfung zu t_Flug
INSERT INTO t_Reservierung (Id, Pilot, Datum, Gastname, Gastkontakt, Status) VALUES
(3, 'Max Mustermann', '2025-08-01', 'Herr Gast', '06601234567', 'Erledigt'),
(4, 'Julia Flieger', '2025-08-02', NULL, NULL, 'Erledigt');

-- Start-Landeliste
INSERT INTO t_StartLandeListe (Einflug, Ausflug, Startzeit, Landezeit, Bemerkung, Bezahlt, Pilot1, Pilot2, FlugzeugId, FlugartId) VALUES
(TRUE, FALSE, NULL, '2025-07-25 10:00:00', 'Einflug aus Deutschland', FALSE, 'Max Mustermann', '', 1, 1),
(FALSE, TRUE, '2025-07-26 12:00:00', NULL, 'Abflug nach Salzburg', FALSE, 'Julia Flieger', 'Tom Wolke', 2, 2),
(FALSE, FALSE, '2025-07-27 14:00:00', '2025-07-27 15:00:00', 'Schulflug mit Landung', TRUE, 'Tom Wolke', '', 3, 3);