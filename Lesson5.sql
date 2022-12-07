/*
Datenbankobjekte:
    Tabellen
    Views (gespeicherte Selects - virtuelle Tabellen)
    Functions UDF (Unterschied zu den mitgelieferten Funktionen UPPER, FLOOR, CEIL ...)
    Stored Procedures (Unterprogramme) eigenständig aufgerufen EXECUTE ...
    Trigger (vor/nach DML Operation Insert/update/delete)



-- Function DAYSBETWEEN (Datum, Datum) --> Anzahl Tage dazwischen
*/



create or replace function daysbetween(p_date1 date, p_date2 date)
    return number
    as
    begin
        return abs (trunc(p_date1) - trunc(p_date2));
    end;
    
-- testen
select daysbetween(sysdate, '1-1-2022') from dual;



--------------------------------------------------
-- Stored Procedure zum Interpolieren
--------------------------------------------------
-- Table INTERPOL
-- Sp    MYINTERPOLATOR
-- simple lineare Interpolation - fehlende Datensätze und deren Werte ergänzen
-- dynamischer: REFCURSOR (nicht hier behandelt)
-- mix aus E und D deutsch: Tabelle, englisch: SP
/*
drop table interpol; -- zum Säubern



create table interpol
    (datum date
    ,txt   varchar2(10)
    ,wert  number
    );



insert into interpol values('1-1-2022', 'gemessen', 11);
insert into interpol values('21-1-2022', 'gemessen', 33);
insert into interpol values('31-1-2022', 'gemessen', 0);



select * from interpol;



create or replace procedure myinterpolator
as



   cursor cur is select * from interpol order by datum asc; -- übernimmt
                                                -- Struktur und Attributnamen aus dem Select
    tuple cur%rowtype; -- tuple übernimmt Struktur und Attributnamen vom Cursor
    
    startdate date;
    enddate   date;
    datediff number := 0;
    
    startval number;
    endval   number;
    incr     number;
    insval   number;
    
begin
    select min(datum) into startdate from interpol;
    select min(datum) into enddate   from interpol;
    select wert into startval from interpol where datum = startdate;
    --
    open cur;
    loop
        fetch cur into tuple;
        exit when cur%notfound;
        enddate := tuple.datum;
        endval := tuple.wert;
        
        datediff := daysbetween(startdate, enddate);
        
        if (datediff > 1) then
           incr := (endval - startval)/(datediff);
           insval := startval;
           for i in 1 .. (datediff -1) loop
               insval := insval+incr;
               insert into interpol values (startdate+1, 'interpolated', insval);
          end loop;
          startdate := tuple.datum;
          startval := tuple.wert;
    end loop;
    close cur;
end;
   



select * from interpol order by datum asc;    



execute myinterpolator;
*/



-- EXCEPTIONS



/*
declare



begin



EXCEPTION
end;
*/



-- von Oracle benannte Fehler
-- DUP_VAL_ON_INDEX (wenn man versucht eine UNIQUE Spalte mit einem Duplikat zu füllen)
-- NO_DATA_FOUND
-- ZERO_DIVIDE
-- ...



set serveroutput on;



declare
    v_gehalt number;
begin
    select gehalt into v_gehalt from tbl_vertreter where vertretercode = 'V-666';
    dbms_output.put_line(v_gehalt);
exception
    when no_data_found then
    dbms_output.put_line('Vertretercode ist unbekannt');
end;



-- eigene Übung: ZERO_DIVIDE



declare
    v_var number;
begin
    select 1/0 into v_var from dual;
exception
    when zero_divide then
    dbms_output.put_line('Division durch Null - Parameter prüfen!');
end;



-- selbst benannte Exceptions
-- mehr als 3D



declare
    more_than_3D exception;
    v_dim_anz number := 4;
begin
    if v_dim_anz > 3 then
        raise more_than_3D;
    end if;    
exception
    when more_than_3D then
    dbms_output.put_line('Mehr als 3 Dimensionen sind nicht möglich');
end;