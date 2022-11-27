[23.11 20:13] Woltron Thomas
[16.11 20:01] Woltron Thomas
-- Joins
-- Inner joins
-- Outer joins -- left outer               -- right outer               -- full outer

-- cross join (Kartesisches Produkt)

-- DUAL? -- für syntaktisch korrekte SELECTS (Oracle)

select sysdate from tbl_kunden;

select sysdate from dual;

select sqrt(power(3, 2)+power(4,2)) Hypothenuse from dual;

-- Datum
-- extract (!)

select extract(year from sysdate) from dual;
-- zB für Tabelle
select extract(year from rechnungsdatum) from tbl_ar;

select extract(month from sysdate) from dual;
select extract(month from rechnungsdatum) from tbl_ar;

select systimestamp from dual;
select extract(second from systimestamp) from dual;
--
select months_between(sysdate, '18-01-1965') from dual;

select to_char(sysdate,'DD MM YY') from dual;
select to_char(rechnungsdatum,'DD MM YY') from tbl_ar;

-- String-Funktionen
select upper(bezeichnung1), bezeichnung1 from tbl_artikel;
select lower(bezeichnung1), bezeichnung1 from tbl_artikel;
select initcap(bezeichnung1), bezeichnung1 from tbl_artikel;

-- stringverknüpfung conCATENAtion
-- ||
select vorname||nachname from tbl_vertreter;
select vorname||' '||nachname from tbl_vertreter;
select initcap(vorname)||' '||upper(nachname) from tbl_vertreter;

select to_char(listenpreis, '999,999.00'), to_char(listenpreis, '000,000.00') from tbl_artikel;

-- runden
-- round geht auch mit Vorkommastellen

select round(listenpreis,2) from tbl_artikel;
select round(listenpreis,-2) from tbl_artikel;
select round(listenpreis, 0) from tbl_artikel;

select floor(listenpreis) from tbl_artikel;
select ceil(listenpreis) from tbl_artikel;
select ceil(listenpreis)-0.01 from tbl_artikel;

select trunc(13.7603, 1) from dual;
select trunc(13.7603, -1) from dual;
select trunc(13.7603, 0) from dual;

--
-- DML (insert, update, delete)
-- Artikel, unter 100 --> neue Warengruppe KRIMSKRAMS

select * from tbl_warengruppen;
insert into tbl_warengruppen(wgcode, Beschreibung)                     values ('KR', 'Krimskrams');

select * from tbl_artikel where listenpreis < 100;
update tbl_artikel set wgcode = 'KR' where listenpreis < 100;

select * from tbl_warengruppen;

select tbl_warengruppen.wgcode, count(artikelcode)                            from tbl_warengruppen left outer join tbl_artikel                            on tbl_warengruppen.wgcode = tbl_artikel.wgcode       group by tbl_warengruppen.wgcode;                     

-- einfaches Löschen
delete from tbl_warengruppen where wgcode = 'BA';

-- komplexer: delete from ... where wgcode in (select ...)

commit;

-- Transaktionsverwaltung (Video anschauen!)
-- Verändernde Transaktionen (DML)
-- erfolgreich: COMMIT
-- nicht erfolgreich: ROLLBACK

-- A C I D
-- A tomarität (ganz oder garnicht)
-- C onsistency (alle constraints eingehalten PK, FK, CHECK, NOT NULL, UNIQUE)
-- I solation (andere Transaktionen sehen während Verarbeitung keine Zwischenstände 'dirty data')
-- D urability (einmal in der DB committed - bleibt sicher erhalten)

-------------------------------------------------------------------

-- DDL Data DEFINITION Language
-- DatenbankOBJEKTE werden angelegt, geändert und gelöscht
-- CREATE, ALTER, DROP

-- neue Tabelle: BERGE

-- DDL --> DML --> DQL (Select)

create table berge    (lfdNr      number    ,Bezeichnung    varchar2(50)    ,Hoehe          number    ,Erstbest       number    );    
insert into berge (lfdNr, bezeichnung, hoehe, erstbest)    values (1, 'Mount Everest', 8848, 1953);

insert into berge (lfdNr, bezeichnung, hoehe, erstbest)    values (2, 'Mont Blanc', 4810, 1786);

insert into berge (lfdNr, bezeichnung, hoehe, erstbest)    values (3, 'Mount Vinson', 4892, 1966);

insert into berge (lfdNr, bezeichnung, hoehe, erstbest)    values (4, 'Aconcagua', 6962, 1897);

commit;

select * from berge;
select * from berge order by hoehe desc;

select bezeichnung, hoehe from berge where erstbest < 1900;

select bezeichnung, hoehe from berge    where bezeichnung like '%Mount%'    or    bezeichnung like '%Mont%';    
describe berge;

------------------- VIEWS
-- "Sichten" -- virtuelle Tabellen

-- komplexe SELECTS werden als VIEW gespeichert und sind dadurch einfach abrufbar-- select ...   
-- create or replace view MySimple as select ...
-- abrufen: select * from MySimple


-- Umsatz pro Vertreter zunächst als SELECT --> SELECT in VIEW verpacken

-- tbl_ar_pos, tbl_ar, tbl_vertreter --> join (inner)
-- Idee: Nachname, Umsatz

select nachname, sum(stk*preis) Umsatz from tbl_ar_pos inner join tbl_ar                                       on tbl_ar_pos.rechnungsnummer = tbl_ar.rechnungsnummer                                                        inner join tbl_vertreter                                       on tbl_vertreter.vertretercode = tbl_ar.vertretercode       group by nachname       order by 2 desc;                                       

create or replace view vertreterumsatz
as
select nachname, sum(stk*preis) Umsatz from tbl_ar_pos inner join tbl_ar                                       on tbl_ar_pos.rechnungsnummer = tbl_ar.rechnungsnummer                                                        inner join tbl_vertreter                                       on tbl_vertreter.vertretercode = tbl_ar.vertretercode       group by nachname       order by 2 desc;                           
-- Verwendung
select * from vertreterumsatz;


-- ============ IMPEDANCE MISMATCH ===============
/*
Blöcke vs DatensätzeSQL    vs Programmiersprachen

Blöcke müssen von/für Programmiersprache zerlegt werden (Einzelne Datensätze)
Programmiersprachen kennen: Variablen, Kontrollstrukturen (IF), Schleifen

Lösung: CURSOR CURrent Set Of Records
1. Deklaration (woraus besteht der Block - select...)
2. Öffnen (Block im Zugriff)
Schleife
3. Fetch (einzelne Datensatz wird geholt)
Ende der Schleife
4. Schließen
(5. Speicherplatz freigeben - Deallocate)

*/

-- Beim nächsten Mal: PL/SQL (Procedural Language)
-- zum Erstellen von Funktionen, Prozeduren und Triggern

--******************************************************************************-- 23.11.2022   Intro in PL/SQL
--******************************************************************************

-- SQL: Abfragen, DDL (zB Tabellen anlegen), DML (Veränderungen am DATENbestand)
-- PL/SQL: eigene Funktionen, Stored Procedures, Trigger
-- UDF - User Defined Functions,
-- Stored Procedures: "standalone" excecute
-- Trigger: stored procedures, die durch eine DML Operation aufgerufen werden

-- Anonyme Blöcke

--declare

set serveroutput on;

begin    dbms_output.put_line('Meine PL/SQL-Karriere beginnt');
--exception
end;

--------------
declare    v_date  date := sysdate;
begin    DBMS_OUTPUT.PUT_LINE('Heute, am ' || v_date || ' ist ein guter Tag.');
end;

--------------
-- EXCPTION
--------------

declare    v_variable varchar2(50);
begin    select nachname into v_variable from tbl_vertreter where vertretercode = 'V-66';    dbms_output.put_line('Sie haben den Vertreter '||v_variable||' gewählt.');
exception    when value_error then    dbms_output.put_line('ERROR: Variable zu klein dimensioniert');
end;

-- Kontrolle - wie lang sollte die Variable sein?
describe tbl_vertreter;

--------------------------
-- Blockstruktur
/*
declare -- kann entfallen, wenn keine Variablen deklariert werden müssen

begin

exception -- nur dann notwendig, wenn Fehlerbehandlung vorgesehen ist.
end;

*/

declare    cursor c_artikel is select * from tbl_artikel;    artikelzeile tbl_artikel%rowtype;    -- hier die Variable i deklarieren, Datentyp: number initialisieren mit 1    i integer := 1;
begin    open c_artikel;    loop        exit when c_artikel%notfound;        fetch c_artikel into artikelzeile;        -- Variable im Output verwenden:         dbms_output.put_line(i||'. '||artikelzeile.bezeichnung1);        --dbms_output.put_line(artikelzeile.bezeichnung1);        -- hier die Variable inkrementieren: zB i := i+1        i := i+1;    end loop;    close c_artikel;
end;

--

