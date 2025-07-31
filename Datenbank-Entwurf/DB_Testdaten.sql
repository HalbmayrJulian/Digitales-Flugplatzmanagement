INSERT INTO t_Kostenstelle (Name, Strasse, PLZ, Ort) VALUES
('Aeroclub Nord', 'Hangarweg 1', 3340, 'Waidhofen'),
('SkyFly GmbH', 'Flugstraße 12', 3300, 'Amstetten'),
('Pilotenschule OST', 'Aeroallee 5', 1010, 'Wien');

INSERT INTO t_Benutzer (Vorname, Nachname, Email, Passwort, KostenstelleId) VALUES
('Max', 'Mustermann', 'max@example.com', 'pass123', 1),
('Julia', 'Flieger', 'julia@example.com', 'flug456', 2),
('Tom', 'Wolke', 'tom@example.com', 'sky789', 3);

INSERT INTO t_Rolle (Rollentyp) VALUES
('Admin'),
('Pilot'),
('Techniker');

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

INSERT INTO t_Flugzeug (Kennzeichen, Zahlerstand, Grounded, FlugzeugtypId, KostenstelleId, DatumARC, DatumFlugzeitwartung, Wartungsart) VALUES
('OE-ABC', 1200, FALSE, 1, 1, '2025-04-01', '2025-06-15', 'Jahreswartung'),
('OE-DEF', 900, FALSE, 2, 2, '2025-03-10', '2025-05-30', 'Ölwechsel'),
('OE-GHI', 1500, TRUE, 3, 3, '2025-05-20', '2025-07-01', 'Propellerwartung');

INSERT INTO t_BenutzerRolle (BenutzerId, RolleId) VALUES
(1, 2),
(2, 2),
(3, 1);

INSERT INTO t_Flugzeug (Kennzeichen, Zahlerstand, Grounded, FlugzeugtypId, KostenstelleId, DatumARC, DatumFlugzeitwartung, Wartungsart) VALUES
('AM-ABC', 1200, FALSE, 1, 1, '2025-04-01', '2025-06-15', 'Jahreswartung'),
('V-DEF', 900, FALSE, 2, 2, '2025-03-10', '2025-05-30', 'Ölwechsel'),
('WY-GHI', 1500, TRUE, 3, 3, '2025-05-20', '2025-07-01', 'Propellerwartung');

INSERT INTO t_Flugminutenkosten (FlugartId, FlugzeugId, KostenMinuten) VALUES
(1, 1, 2.50),
(2, 2, 3.75),
(3, 3, 1.80);

INSERT INTO t_StartLandeListe (Einflug, Ausflug, Startzeit, Landezeit, Bemerkung, bezahlt, Pilot1, Pilot2, FlugzeugId, FlugartId) VALUES
(TRUE, FALSE, NULL, '2025-07-25 10:00:00', 'Einflug aus Deutschland', FALSE, 'Max', '', 1, 1),
(FALSE, TRUE, '2025-07-26 12:00:00', NULL, 'Abflug nach Salzburg', FALSE, 'Julia', 'Tom', 2, 2),
(FALSE, FALSE, '2025-07-27 14:00:00', '2025-07-27 15:00:00', 'Schulflug mit Landung', TRUE, 'Tom', '', 3, 3);

INSERT INTO t_Pioltenflug (PioltenId, FlugzeugId, Startzeit, Landezeit, FlugartId, Bemerkung) VALUES
(1, 1, '2025-07-24 09:00:00', '2025-07-24 10:00:00', 1, 'Trainingsflug'),
(2, 2, '2025-07-25 11:00:00', '2025-07-25 12:00:00', 2, 'Prüfungsflug');

INSERT INTO t_Reservierung (PioltenId, FlugzeugId, FlugartId, Datum, Startzeit, Landezeit, Bemerkung, Gastname, Gastkontakt) VALUES
(1, 1, 1, '2025-08-01', '10:00:00', '11:00:00', 'Gastflug', 'Herr Gast', '06601234567'),
(2, 2, 2, '2025-08-02', '12:00:00', '13:00:00', 'Vereinsausflug', NULL, NULL);
