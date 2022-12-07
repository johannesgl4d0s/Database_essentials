-- Funktionen
-- vgl. Excel zB SUMME(Methodensignatur) --> liefert Rückgabewert
-- PL/SQL
--          fertige Funktionen: UPPER, LOWER, ROUND, TRUNC, SUM, ...
--          eigene Funktionen: UDF ("Black box")



-- Quartalsfunktion fn_quartal(datum) --> 1 .. 4



/*create or replace function fn_quartal(p_date date)
    return number
    as
    begin
        return ceil(extract(month from p_date)/3);
    end;




-- ausprobieren:



select fn_quartal(sysdate)from dual;




create or replace function vertname(p_vnr varchar2)
    return varchar2
    as
        v_name varchar2(200);
    begin
        select upper(nachname)||'  '||vorname into v_name from tbl_vertreter
            where vertretercode = p_vnr;
        
        return v_name;    
    end;





-- ausprobieren: V-66



select vertname('V-66') from dual;




-- Funktion zur ABC-Analyse
-- fn_ABC(betrag, AB_grenze, BC_grenze) --> 'A'|'B'|'C'
-- ELSIF(!)



create or replace function fn_abc(betrag number, ab_grenze number, bc_grenze number)
    return varchar2
    as
    begin
    IF betrag > ab_grenze THEN
        return 'A';
    ELSIF betrag < bc_grenze THEN
        return 'C';
    ELSE
        return 'B';
    END IF;
    end;



-- ausprobieren
select fn_abc(10000, 8000, 2000) from dual;
select bezeichnung1, bezeichnung2, fn_abc(listenpreis, 1000, 50) from tbl_artikel;




select bezeichnung1, bezeichnung2, fn_abc(listenpreis, 1000, 50)||'-Artikel' from tbl_artikel;



*/



-- Übung: 10 Min fn_Umrechnung (betrag, Umrechnungskurs, Spesen_als_Prozent) --> Auszahlungsbetrag Fremdwährung



create or replace function fn_Umrechnung(betrag number, kurs number, spesen number)
    return number
    as
    begin
        return (betrag*kurs)*(1-(spesen/100));
    end;



-- ausprobieren
select fn_umrechnung(1000, 330, 2) from dual;



----------------------------------------------
-- Trigger DML (Insert, Update, Delete) auf eine Tabelle
-- Trigger "hängen" an einer Tabelle
-- Wahlmöglichkeiten:
-- Insert, Update, Delete
-- Before, After (für Views: instead of)
-- for each row, (default) statement level



-- demotabelle - das Löschen aus dieser Tabelle soll protokolliert werden (via Trigger)



create table tridemo
    ( id    number
    , wert  number
    , txt   varchar2(10)
    );



insert into tridemo values (1, 99, 'first');
insert into tridemo values (2, 88, 'second');
insert into tridemo values (3, 77, 'third');



select * from tridemo;
select * from tridemo_log;



-- Kopie einer Tabelle anlegen :-)
create table tridemo_log as
    select * from tridemo where 1=0;




create or replace trigger deletelog
    before delete on tridemo
    for each row
    begin
        insert into tridemo_log (id, wert, txt)
        values (:old.id, :old.wert, :old.txt);
    end;



-- jetzt wird jedes Löschen aus Tridemo in Tridemo_log protokolliert
-- zB
delete from tridemo where id = 3;