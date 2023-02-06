
drop table TBL_Kundendaten cascade constraints;
drop table TBL_Vertragsdetails cascade constraints;
drop table TBL_Zahlungseingaenge cascade constraints;
drop table TBL_Beschwerde cascade constraints;
drop table TBL_Mitarbeiter cascade constraints;
drop table TBL_LagerModule cascade constraints;
drop table TBL_Zugangsprotokoll cascade constraints;
drop table TBL_NFCKey cascade constraints;
drop table TBL_LagerModuleWebseite cascade constraints;
drop table TBL_Region cascade constraints;
drop table TBL_Eigentuemer cascade constraints;
drop table TBL_InfoMietvertrag cascade constraints;
drop table TBL_Lagerobjekt cascade constraints;
drop table TBL_Spenglerei cascade constraints;
drop table TBL_Auftragsliste cascade constraints;
drop table TBL_Kundenbetreuung cascade constraints;
drop table TBL_Module_Kunde cascade constraints;
drop table TBL_Kundenmanagement cascade constraints;

CREATE TABLE TBL_Kundendaten (
  KundenID INT Not null PRIMARY KEY,
  Name VARCHAR(255),
  Adresse VARCHAR(255),
  Telefonnummer INT,
  EMailadresse VARCHAR(255),
  Zahlungsinformationen VARCHAR(255),
  Zahlungsrueckstand Number(1)
);


CREATE TABLE TBL_Vertragsdetails (
  VertragsID INT PRIMARY KEY,
  KundeID INT REFERENCES TBL_Kundendaten(KundenID),
  Laufzeit_start Date,
  Laufzeit_ende Date,
  Vertagablage VARCHAR(255),
  Kosten FLOAT NOT NULL,
  Instandhaltung VARCHAR(255),
  Inventarbeschreibung VARCHAR(255)
);


CREATE TABLE TBL_Zahlungseingaenge (
  ZahlungsID INT NOT NULL PRIMARY KEY,
  KundeID INT REFERENCES TBL_Kundendaten(KundenID),
  Datum DATE NOT NULL,
  Betrag FLOAT NOT NULL,
  Zahlungsmethode VARCHAR(255) NOT NULL,
  ReferenzNummer INT NOT NULL,
  MietVertrag INT NOT NULL
);

CREATE TABLE TBL_Beschwerde (
  BeschwerdeID INT PRIMARY KEY,
  KundeID INT REFERENCES TBL_Kundendaten(KundenID),
  LagerModulID INT,
  Beschreibung VARCHAR(255),
  Datum DATE,
  Status VARCHAR(255),
  Geloest NUMBER(1)
);



CREATE TABLE TBL_Kundenbetreuung (
  EintragsID INT PRIMARY KEY,
  MitarbeiterID INT ,
  Datum DATE,
  ServiceType VARCHAR(255),
  Beschreibung VARCHAR(255)
);

CREATE TABLE TBL_Kundenmanagement (
    IDs INT PRIMARY KEY,
    BeschwerdeID INT REFERENCES TBL_Beschwerde (BeschwerdeID),
    EintragsID INT REFERENCES TBL_Kundenbetreuung (EintragsID)
    );



CREATE TABLE TBL_Mitarbeiter (
  MitarbeiterID INT PRIMARY KEY,
  Abteilung VARCHAR(50),
  Gehalt FLOAT,
  Namen VARCHAR(50),
  Adresse VARCHAR(100),
  Geburtsdatum DATE
);





CREATE TABLE TBL_LagerModule (
    LagerModulID INT PRIMARY KEY,
    LagerobjektID INT ,
    Zugangsart VARCHAR(50),
    Groeﬂe FLOAT CHECK (Groeﬂe >= 4 AND Groeﬂe <= 25),
    Verfuegbar NUMBER(1),
    Feuermelder NUMBER(1),
    Stromanschluss NUMBER(1),
    Klimatisierung NUMBER(1)
);

create Table TBL_Module_Kunde (

    IDs Int Primary Key,
    KundenID INT REFERENCES TBL_Kundendaten(KundenID),
    LagerModulID INT REFERENCES TBL_LagerModule (LagerModulID)
    );

CREATE TABLE TBL_Zugangsprotokoll (
  ZugangsprotokollID INT PRIMARY KEY,
  NFCKeyID int,
  ProtokollTyp VARCHAR(50),
  Beschreibung VARCHAR(255),
  DatumZugang DATE
);

CREATE TABLE TBL_NFCKey (
  NFCKeyID int PRIMARY KEY,
  KundenID INT REFERENCES TBL_Kundendaten(KundenID),
  LagerModulID INT REFERENCES TBL_LagerModule (LagerModulID),
  Status NUMBER(1)
);




CREATE TABLE TBL_LagerModuleWebseite (
    WebID int PRIMARY KEY,
    LagerModulID INT REFERENCES TBL_LagerModule (LagerModulID),
    Name VARCHAR(255),
    Beschreibung VARCHAR(255),
    Preis FLOAT,
    Bild VARCHAR(255)
);

CREATE TABLE TBL_Region (
    Regionskuerzel VARCHAR(4) PRIMARY KEY,
    Regionsname VARCHAR(255)
    );


CREATE TABLE TBL_Eigentuemer (
  EigentuemerID INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  KontaktInfo VARCHAR(255) NOT NULL
);



CREATE TABLE TBL_InfoMietvertrag (
  MietvertragID INT PRIMARY KEY,
  EigentuemerID INT REFERENCES TBL_Eigentuemer (EigentuemerID),
  LagerobjektID INT,
  StartDatum DATE,
  EndDatum DATE,
  Miete FLOAT,
  MvVerlaengerung Number(1),
  MvMindestkuendigfrist FLOAT,
  Sicherheitskaution FLOAT,
  Versicherung VARCHAR(255)
);


CREATE TABLE TBL_Lagerobjekt (
  LagerobjektID INT PRIMARY KEY,
  EigentuemerID INT REFERENCES TBL_Eigentuemer (EigentuemerID),
  MietvertragID INT REFERENCES TBL_InfoMietvertrag (MietvertragID ),
  Regionskuerzel VARCHAR(4) REFERENCES TBL_Region (Regionskuerzel),
  Anz_Module Int,
  Standort VARCHAR(50)
 
);





CREATE TABLE TBL_Spenglerei (
  SpenglerID INT PRIMARY KEY,
  Regionskuerzel VARCHAR(4) REFERENCES TBL_Region (Regionskuerzel),
  ServiceType VARCHAR(255),
  Fr_Name VARCHAR(255),
  Anschrift VARCHAR(255)
  
);

Create  Table TBL_Auftragsliste (
    AuftragsID INT PRIMARY KEY,
    SpenglerID INT REFERENCES TBL_Spenglerei (SpenglerID),
    LagerModulID INT REFERENCES TBL_LagerModule (LagerModulID),
    MitarbeiterID INT REFERENCES TBL_Mitarbeiter(MitarbeiterID),
    Datum DATE,
    Kosten FLOAT,
    Garantie VARCHAR(255),
    Ablage_Auftragsdokument VARCHAR(255),
    Status VARCHAR(255)
);




INSERT INTO TBL_Kundendaten (KundenID, Name, Adresse, Telefonnummer, EMailadresse, Zahlungsinformationen, Zahlungsrueckstand)
VALUES 
(1, 'Max Mustermann', 'Musterstraﬂe 1, 12345 Musterstadt', 1234567890, 'max.mustermann@email.com', 'Visa, 1234',0);
INSERT INTO TBL_Kundendaten (KundenID, Name, Adresse, Telefonnummer, EMailadresse, Zahlungsinformationen, Zahlungsrueckstand)
VALUES
(2, 'Eva Musterfrau', 'Musterstraﬂe 2, 12345 Musterstadt', 1234567891, 'eva.musterfrau@email.com', 'Mastercard, 5678', 0);
INSERT INTO TBL_Kundendaten (KundenID, Name, Adresse, Telefonnummer, EMailadresse, Zahlungsinformationen, Zahlungsrueckstand)
VALUES
(3, 'Franz Bauer', 'Hauptstraﬂe 3, 54321 Musterdorf', 1234567892, 'franz.bauer@email.com', 'American Express, 9101',0);
INSERT INTO TBL_Kundendaten (KundenID, Name, Adresse, Telefonnummer, EMailadresse, Zahlungsinformationen, Zahlungsrueckstand)
VALUES
(4, 'Claudia Schmidt', 'Hauptstraﬂe 4, 54321 Musterdorf', 1234567893, 'claudia.schmidt@email.com', 'PayPal, 7654',0);
INSERT INTO TBL_Kundendaten (KundenID, Name, Adresse, Telefonnummer, EMailadresse, Zahlungsinformationen, Zahlungsrueckstand)
VALUES
(5, 'Julia Meyer', 'Feldweg 5, 56789 Musterdrof', 1234567894, 'J.Meyer@email.com', 'Visa, 3216',0);


INSERT INTO TBL_Vertragsdetails (VertragsID, KundeID, Laufzeit_start, Laufzeit_ende, Kosten, Instandhaltung, Inventarbeschreibung)
VALUES 
  (1, 1, '03.12.2004','03.12.2023',550.5, 'Laufend', 'Weink¸hler, Safe');
INSERT INTO TBL_Vertragsdetails (VertragsID, KundeID, Laufzeit_start, Laufzeit_ende, Kosten, Instandhaltung, Inventarbeschreibung)
VALUES 
  (2, 2, '03.12.2022','03.10.2023',550.5, 'Laufend', 'Weink¸hler, Safe');
INSERT INTO TBL_Vertragsdetails (VertragsID, KundeID, Laufzeit_start, Laufzeit_ende, Kosten, Instandhaltung, Inventarbeschreibung)
VALUES 
  (3, 3, '03.12.2022','03.10.2023',550.5, 'Laufend', 'Weink¸hler, Safe');
INSERT INTO TBL_Vertragsdetails (VertragsID, KundeID, Laufzeit_start, Laufzeit_ende, Kosten, Instandhaltung, Inventarbeschreibung)
VALUES 
  (4, 4, '03.12.2022','03.10.2023',550.5, 'Laufend', 'Weink¸hler, Safe');
INSERT INTO TBL_Vertragsdetails (VertragsID, KundeID, Laufzeit_start, Laufzeit_ende, Kosten, Instandhaltung, Inventarbeschreibung)
VALUES 
  (5, 5, '03.12.2022','03.10.2023',550.5, 'Laufend', 'Weink¸hler, Safe');

-----
INSERT INTO TBL_Zahlungseingaenge (ZahlungsID,KundeID, Datum, Betrag, Zahlungsmethode, ReferenzNummer, MietVertrag)
VALUES
(1,1, '03.12.2022', 500.5, '‹berweisung', 123456789, 1001);
INSERT INTO TBL_Zahlungseingaenge (ZahlungsID,KundeID, Datum, Betrag, Zahlungsmethode, ReferenzNummer, MietVertrag)
VALUES
(2,2, '03.12.2022', 500.5, '‹berweisung', 123456789, 1001);
INSERT INTO TBL_Zahlungseingaenge (ZahlungsID,KundeID, Datum, Betrag, Zahlungsmethode, ReferenzNummer, MietVertrag)
VALUES
(3,3, '03.12.2022', 500.5, '‹berweisung', 123456789, 1001);

INSERT INTO TBL_Zahlungseingaenge (ZahlungsID,KundeID, Datum, Betrag, Zahlungsmethode, ReferenzNummer, MietVertrag)
VALUES
(4,4, '03.12.2022', 500.5, '‹berweisung', 123456789, 1001);
INSERT INTO TBL_Zahlungseingaenge (ZahlungsID,KundeID, Datum, Betrag, Zahlungsmethode, ReferenzNummer, MietVertrag)
VALUES
(5,5, '03.12.2022', 500.5, '‹berweisung', 123456789, 1001);

-----
INSERT INTO TBL_Beschwerde (BeschwerdeID, KundeID, LagerModulID, Beschreibung, Datum, Status, Geloest)
VALUES 
(1,1,1, 'Licht defekt', '03.12.2022', 'Offen', 0);
INSERT INTO TBL_Beschwerde (BeschwerdeID, KundeID, LagerModulID, Beschreibung, Datum, Status, Geloest)
VALUES 
(2,1,2, 'Schloss defekt', '03.12.2021', 'geschlossen', 0);
INSERT INTO TBL_Beschwerde (BeschwerdeID, KundeID, LagerModulID, Beschreibung, Datum, Status, Geloest)
VALUES 
(3,3,3, 'Tuere quitscht', '03.12.2022', 'Offen', 0);
INSERT INTO TBL_Beschwerde (BeschwerdeID, KundeID, LagerModulID, Beschreibung, Datum, Status, Geloest)
VALUES 
(4,4,4, 'Rechnungsbetrag falsch', '03.12.2022', 'Offen', 0);
INSERT INTO TBL_Beschwerde (BeschwerdeID, KundeID, LagerModulID, Beschreibung, Datum, Status, Geloest)
VALUES 
(5,5,5, 'Verschmutzung im Gang', '03.12.2022', 'Offen', 0);

-----

INSERT INTO TBL_Kundenbetreuung (EintragsID,MitarbeiterID, Datum, ServiceType, Beschreibung)
VALUES
  (2,1, '13.12.2021', 'Reparatur', 'Reparatur des defekten Teils');
-----

INSERT INTO TBL_Kundenmanagement (IDs,EintragsID,BeschwerdeID)
VALUES
  (1,2, 1);
  
---


INSERT INTO TBL_Mitarbeiter (MitarbeiterID, Abteilung, Gehalt, Namen, Adresse, Geburtsdatum)
VALUES
  (1, 'Verwaltung', 50000, 'Max Mustermann', 'Musterstraﬂe 1, 12345 Musterstadt', '01.01.1980');
INSERT INTO TBL_Mitarbeiter (MitarbeiterID, Abteilung, Gehalt, Namen, Adresse, Geburtsdatum)
VALUES
  (2, 'Technik', 55000, 'Maria Musterfrau', 'Musterstraﬂe 2, 12345 Musterstadt', '01.01.1981');
INSERT INTO TBL_Mitarbeiter (MitarbeiterID, Abteilung, Gehalt, Namen, Adresse, Geburtsdatum)
VALUES
  (3, 'Marketing', 60000, 'John Doe', 'Musterstraﬂe 3, 12345 Musterstadt', '01.01.1983');
INSERT INTO TBL_Mitarbeiter (MitarbeiterID, Abteilung, Gehalt, Namen, Adresse, Geburtsdatum)
VALUES
  (4, 'Verwaltung', 65000, 'Jane Doe', 'Musterstraﬂe 4, 12345 Musterstadt', '01.01.1982');
  INSERT INTO TBL_Mitarbeiter (MitarbeiterID, Abteilung, Gehalt, Namen, Adresse, Geburtsdatum)
VALUES
  (5, 'Technik', 70000, 'Bob Smith', 'Musterstraﬂe 5, 12345 Musterstadt', '01.01.1985');

-----

INSERT INTO TBL_LagerModule (LagerModulID, LagerobjektID, Zugangsart, Groeﬂe, Verfuegbar, Feuermelder, Stromanschluss, Klimatisierung)
VALUES 
  (1, 1001, 'Schl¸ssel',  4.5, 1, 0, 1, 1);
INSERT INTO TBL_LagerModule (LagerModulID, LagerobjektID, Zugangsart, Groeﬂe, Verfuegbar, Feuermelder, Stromanschluss, Klimatisierung)
VALUES 
  (2, 1002, 'NFC-Chip',  5.5, 0, 0, 0, 1);
INSERT INTO TBL_LagerModule (LagerModulID, LagerobjektID, Zugangsart, Groeﬂe, Verfuegbar, Feuermelder, Stromanschluss, Klimatisierung)
VALUES 
  (3, 1003, 'Schl¸ssel', 6.5, 1, 0, 1, 0);
INSERT INTO TBL_LagerModule (LagerModulID, LagerobjektID, Zugangsart, Groeﬂe, Verfuegbar, Feuermelder, Stromanschluss, Klimatisierung)
VALUES 
  (4, 1004, 'NFC-Chip', 7.5, 1, 0, 1, 1);
INSERT INTO TBL_LagerModule (LagerModulID, LagerobjektID, Zugangsart, Groeﬂe, Verfuegbar, Feuermelder, Stromanschluss, Klimatisierung)
VALUES 
  (5, 1005, 'NFC-Chip', 7.5, 1, 0, 1, 1);

----

Insert into TBL_Module_Kunde (IDs, LagerModulID,KundenID) values
(1, 2,2);
Insert into TBL_Module_Kunde (IDs, LagerModulID,KundenID) values
(2, 4,4);
Insert into TBL_Module_Kunde (IDs, LagerModulID,KundenID) values
(3, 5,5);

-----

INSERT INTO TBL_Zugangsprotokoll (ZugangsprotokollID,NFCKeyID, ProtokollTyp, Beschreibung, DatumZugang)
VALUES
  (1,1, 'NFC-Zugang', 'NFC-Zugang zu Lagerobjekt 2', to_date('15.12.2022 10:30:22', 'DD-MM-YYYY hh24:mi:ss'));
  INSERT INTO TBL_Zugangsprotokoll (ZugangsprotokollID,NFCKeyID, ProtokollTyp, Beschreibung, DatumZugang)
VALUES
  (2,1, 'NFC-Zugang', 'NFC-Zugang zu Lagerobjekt 2', to_date('17.12.2022 15:15:45', 'DD-MM-YYYY hh24:mi:ss'));
  INSERT INTO TBL_Zugangsprotokoll (ZugangsprotokollID,NFCKeyID, ProtokollTyp, Beschreibung, DatumZugang)
VALUES
  (3,1, 'NFC-Zugang', 'NFC-Zugang zu Lagerobjekt 2', to_date('19.12.2022 22:03:07', 'DD-MM-YYYY hh24:mi:ss'));


-------

INSERT INTO TBL_NFCKey (NFCKeyID, KundenID, LagerModulID, Status)
VALUES
  (1, 2, 2,  1);
INSERT INTO TBL_NFCKey (NFCKeyID, KundenID, LagerModulID, Status)
VALUES
  (3, 4,4,  1);
INSERT INTO TBL_NFCKey (NFCKeyID, KundenID, LagerModulID, Status)
VALUES
  (2, 5, 5,  1);

-----

INSERT INTO TBL_LagerModuleWebseite (WEbID, LagerModulID, Name, Beschreibung, Preis, Bild)
VALUES
    (1,1, 'Modul 1', 'Kleines Lagermodul mit 4,5 Quadratmetern', 100.0, 'https://www.example.com/modul1.jpg');
INSERT INTO TBL_LagerModuleWebseite (WEbID, LagerModulID, Name, Beschreibung, Preis, Bild)
VALUES
    (2,3, 'Modul 3', 'Kleines Lagermodul mit 6,5 Quadratmetern', 140.0, 'https://www.example.com/modul3.jpg');
    
------

Insert into TBL_Region ( Regionskuerzel, Regionsname) values
('A321', 'Lungau');

Insert into TBL_Region ( Regionskuerzel, Regionsname) values
('A224', 'Oststeiermark');

Insert into TBL_Region ( Regionskuerzel, Regionsname) values
('A111', 'Mittelburgenland');


------
INSERT INTO TBL_Eigentuemer (EigentuemerID, Name, KontaktInfo)
VALUES
  (1, 'Max Lagerhaus', 'max@lagerhaus.de');
  INSERT INTO TBL_Eigentuemer (EigentuemerID, Name, KontaktInfo)
VALUES
  (2, 'Erika Muster-Frau', 'erika@muster-frau.de');
  INSERT INTO TBL_Eigentuemer (EigentuemerID, Name, KontaktInfo)
VALUES
  (3, 'Johann Hauser', 'johann@hauser.com');
------

INSERT INTO TBL_InfoMietvertrag (MietvertragID, EigentuemerID, LagerobjektID, StartDatum, EndDatum, Miete, MvVerlaengerung, MvMindestkuendigfrist, Sicherheitskaution, Versicherung)
VALUES
  (1, 1, 1001, '01.01.2012', '31.12.2022', 50000.0, 1, 6.0, 1000.0, 'Standard');
INSERT INTO TBL_InfoMietvertrag (MietvertragID, EigentuemerID, LagerobjektID, StartDatum, EndDatum, Miete, MvVerlaengerung, MvMindestkuendigfrist, Sicherheitskaution, Versicherung)
VALUES
  (2, 1, 1002, '01.01.2015', '31.12.2025', 50000.0, 0, 6.0, 1000.0, 'Standard');
INSERT INTO TBL_InfoMietvertrag (MietvertragID, EigentuemerID, LagerobjektID, StartDatum, EndDatum, Miete, MvVerlaengerung, MvMindestkuendigfrist, Sicherheitskaution, Versicherung)
VALUES
  (3, 3, 1003, '01.01.2002', '31.12.2022', 50000.0, 1, 6.0, 1000.0, 'Standard');
----
INSERT INTO TBL_Lagerobjekt (LagerobjektID, EigentuemerID, MietvertragID,Regionskuerzel, Anz_Module,  Standort)
VALUES
(1001, 1, 1,'A321', 20, '5580 Moertelsdorf');

INSERT INTO TBL_Lagerobjekt (LagerobjektID, EigentuemerID, MietvertragID,Regionskuerzel, Anz_Module,  Standort)
VALUES
(1002, 2, 1,'A224', 20, 'Beispeiladresse-Oststm');

INSERT INTO TBL_Lagerobjekt (LagerobjektID, EigentuemerID, MietvertragID,Regionskuerzel, Anz_Module,  Standort)
VALUES
(1003, 1, 1,'A321', 20, '5580 Moertelsdorf');

INSERT INTO TBL_Lagerobjekt (LagerobjektID, EigentuemerID, MietvertragID,Regionskuerzel, Anz_Module,  Standort)
VALUES
(1004, 3, 1,'A111', 20, 'Beispeiladresse-Burgenland');

INSERT INTO TBL_Lagerobjekt (LagerobjektID, EigentuemerID, MietvertragID,Regionskuerzel, Anz_Module,  Standort)
VALUES
(1005, 1, 1,'A321', 20, '5580 Moertelsdorf2');
----


INSERT INTO TBL_Spenglerei (SpenglerID, Regionskuerzel,ServiceType, Fr_Name,  Anschrift)
VALUES 
(1, 'A321', 'Dachdecker',  'Ossman Gmbh','Anschrift-Bsp.');

INSERT INTO TBL_Spenglerei (SpenglerID, Regionskuerzel,ServiceType, Fr_Name,  Anschrift)
VALUES 
(2, 'A224', 'Schlosser',  'Hebert Gmbh','Anschrift-Bsp.2');
INSERT INTO TBL_Spenglerei (SpenglerID, Regionskuerzel,ServiceType, Fr_Name,  Anschrift)
VALUES 
(3, 'A111', 'Installateur',  'Fuss Gmbh','Anschrift-Bsp.3');



Insert into TBL_Auftragsliste (AuftragsID,SpenglerID,LagerModulID,MitarbeiterID,Datum,Kosten,Garantie,Ablage_Auftragsdokument,Status)
values
(1,1,1,1,'01.11.2021',2500,3,'C:/ablage','erledigt');
  

ALTER TABLE TBL_Kundenbetreuung
ADD CONSTRAINT FK_MitarbeiterID_TBL_Mitarbeiter
FOREIGN KEY (MitarbeiterID) REFERENCES TBL_Mitarbeiter(MitarbeiterID);


ALTER TABLE TBL_Beschwerde
ADD CONSTRAINT FK_LagerModulID_TBL_LagerModul
FOREIGN KEY (LagerModulID) REFERENCES TBL_LagerModule(LagerModulID);

ALTER TABLE TBL_LagerModule
ADD CONSTRAINT FK_LagerobjectID_TBL_Lagerobjetk
FOREIGN KEY (LagerobjektID) REFERENCES TBL_Lagerobjekt (LagerobjektID);

ALTER TABLE TBL_InfoMietvertrag
ADD CONSTRAINT FK_LagerModulID_TBL_lagerobjekt
FOREIGN KEY (LagerobjektID) REFERENCES TBL_Lagerobjekt (LagerobjektID);


ALTER TABLE TBL_Zugangsprotokoll
ADD CONSTRAINT FK_NFCID_TBL_Nfc
FOREIGN KEY (NFCKeyID) REFERENCES TBL_NFCKey (NFCKeyID);




-----

select * from TBL_Zugangsprotokoll;