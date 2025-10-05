-- Anmeldungsseite
SELECT * FROM t_Benutzer WHERE Email = 'max@example.com' AND Passwort = 'pass123';

-- Start-Landeliste
SELECT 
    ROW_NUMBER() OVER (ORDER BY sll.Startzeit, sll.Landezeit) AS Nr,
    fz.Kennzeichen,
    ft.Flugzeugtyp,
    sll.Pilot1,
    sll.Pilot2,
    CASE 
        WHEN sll.Pilot2 = '' OR sll.Pilot2 IS NULL THEN 1 
        ELSE 2 
    END AS Personen,
    sll.Startzeit,
    sll.Einflug AS EF,
    sll.Landezeit,
    sll.Ausflug AS AF,
    CASE 
        WHEN sll.Startzeit IS NOT NULL AND sll.Landezeit IS NOT NULL
        THEN TIMESTAMPDIFF(MINUTE, sll.Startzeit, sll.Landezeit) 
        ELSE NULL 
    END AS Dauer_Minuten,
    fa.Flugtyp AS Flugart,
    ks.Name AS Kostenstelle,
    COALESCE(fm.KostenMinuten, pk.Preis) AS Landegebuehr,
    sll.Bezahlt,
    sll.Bemerkung
FROM 
    t_StartLandeListe sll
LEFT JOIN 
    t_Flugzeug fz ON sll.FlugzeugId = fz.Id
LEFT JOIN 
    t_Flugzeugtyp ft ON fz.FlugzeugtypId = ft.Id
LEFT JOIN 
    t_Flugart fa ON sll.FlugartId = fa.Id
LEFT JOIN 
    t_Kostenstelle ks ON fz.KostenstelleId = ks.Id
LEFT JOIN 
    t_Preiskategorie pk ON ft.PreisId = pk.Id
LEFT JOIN 
    t_Flugminutenkosten fm ON sll.FlugartId = fm.FlugartId AND sll.FlugzeugId = fm.FlugzeugId
ORDER BY 
    sll.Startzeit, sll.Landezeit;

-- Pilotenseite - Verfügbare Flugzeuge
SELECT f.Kennzeichen FROM t_Flugzeug f WHERE f.Grounded = FALSE;

-- Fliegen Zählerstand mit korrigiertem Spaltennamen
SELECT f.Zaehlerstand FROM t_Flugzeug f WHERE f.Kennzeichen = 'OE-ABC';

SELECT 
    f.Id,
    fz.Kennzeichen,
    p.Pilot,
    f.StartTs,
    f.EndeTs,
    p.StartZaehler,
    p.EndZaehler,
    p.DauerMinuten,
    fa.Flugtyp,
    f.Bemerkung,
    f.Status
FROM 
    t_Pilotenflug p
JOIN 
    t_Flug f ON p.Id = f.Id
JOIN 
    t_Flugzeug fz ON f.FlugzeugId = fz.Id
JOIN 
    t_Flugart fa ON f.FlugartId = fa.Id
ORDER BY 
    f.StartTs DESC;

SELECT 
    r.Id,
    r.Pilot,
    fz.Kennzeichen,
    f.StartTs,
    f.EndeTs,
    fa.Flugtyp,
    r.Gastname,
    r.Gastkontakt,
    r.Status,
    f.Bemerkung
FROM 
    t_Reservierung r
JOIN 
    t_Flug f ON r.Id = f.Id
JOIN 
    t_Flugzeug fz ON f.FlugzeugId = fz.Id
JOIN 
    t_Flugart fa ON f.FlugartId = fa.Id
WHERE 
    r.Datum >= CURDATE()
ORDER BY 
    f.StartTs;

-- Adminseite
SELECT * FROM t_Benutzer;
SELECT * FROM t_Kostenstelle WHERE Aktiv = TRUE;
SELECT * FROM t_Rolle;
SELECT * FROM t_Preiskategorie;
SELECT * FROM t_Flugart;
SELECT * FROM t_Flugzeugtyp;
SELECT 
    fm.Id,
    fa.Flugtyp,
    fz.Kennzeichen,
    fm.KostenMinuten
FROM 
    t_Flugminutenkosten fm
JOIN 
    t_Flugart fa ON fm.FlugartId = fa.Id
JOIN 
    t_Flugzeug fz ON fm.FlugzeugId = fz.Id;

-- Adminseite - Benutzer-Rollen-Zuordnung
SELECT 
    b.Vorname,
    b.Nachname,
    r.Rollentyp
FROM 
    t_BenutzerRolle br
JOIN 
    t_Benutzer b ON br.BenutzerId = b.Id
JOIN 
    t_Rolle r ON br.RolleId = r.Id;
SELECT 
    f.Kennzeichen,
    f.DatumARC,
    f.DatumFlugzeitwartung,
    f.Wartungsart,
    f.Zaehlerstand
FROM 
    t_Flugzeug f
WHERE 
    f.DatumFlugzeitwartung IS NOT NULL
ORDER BY 
    f.DatumFlugzeitwartung DESC;