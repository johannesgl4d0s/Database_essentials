[09.11 20:22] Woltron Thomas
-- SQL Structured Query Language--  DQL: select ...--  DML: insert, update, delete--  DDL: create, alter, drop

-- select

select * from tbl_artikel;

select * from tbl_artikel    where listenpreis > 1000;    
select * from tbl_artikel    where listenpreis > 1000    order by listenpreis desc;

select * from tbl_kunden;

select * from tbl_kunden    where plz = '2700'     or    plz = '2500';

select * from tbl_kunden    where plz in ('2500', '2700', '1010')    ;

select * from tbl_kunden;

select * from tbl_kunden    where plz is null     or    ort is null    or    strasse is null;

select * from tbl_kunden    where name like '%soft%'    or    name like '%Soft%';

select * from tbl_kunden    where upper(name) like '%SOFT%';

select * from tbl_vertreter;

select * from tbl_vertreter    where gehalt between 20000 and 50000;    
select nachname, vorname, gehalt from tbl_vertreter;

select nachname, vorname, gehalt, gehalt*300 from tbl_vertreter;    
select nachname, vorname, gehalt GehaltInEUR, gehalt*300 HUF from tbl_vertreter;

select * from tbl_artikel;

-- Joins

select * from tbl_artikel inner join tbl_warengruppen            on tbl_artikel.wgcode = tbl_warengruppen.wgcode;            
select Bezeichnung1, bezeichnung2, beschreibung from tbl_artikel inner join tbl_warengruppen            on tbl_artikel.wgcode = tbl_warengruppen.wgcode;


select Bezeichnung1, bezeichnung2, beschreibung from tbl_artikel right outer join tbl_warengruppen            on tbl_artikel.wgcode = tbl_warengruppen.wgcode       where bezeichnung1 is null;

select Bezeichnung1, bezeichnung2, beschreibung from tbl_artikel,tbl_warengruppen;

-- Aggregatfunktionen SUM, AVG, MIN, MAX, COUNT

select stk*preis ZeilenUmsatz from tbl_ar_pos;

select sum(stk*preis) Umsatz from tbl_ar_pos;

select artikelcode, sum(stk*preis) Umsatz from tbl_ar_pos    group by artikelcode;    
select tbl_artikel.artikelcode, bezeichnung1, bezeichnung2, sum(stk*preis) Umsatz from tbl_ar_pos inner join tbl_artikel                                          on tbl_ar_pos.artikelcode = tbl_artikel.artikelcode    group by tbl_artikel.artikelcode, bezeichnung1, bezeichnung2    order by 4 desc;    

