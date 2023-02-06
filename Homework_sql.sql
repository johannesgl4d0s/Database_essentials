select * from employees;


select * from invoices
where customer_id = 56 or customer_id = 58
and total between 1 and 5;

select id, invoice_date from invoices
where id = 315;


select * from tracks
where name like 'All%';

select email from customers
where (email like 'j%' and email like '%gmail%');

select albums.id, title, COUNT(DISTINCT tracks.name) from albums
inner join tracks on albums.id = tracks.album_id
group by albums.id having COUNT(DISTINCT tracks.name) >= 15;

select COUNT(Distinct name) as name2, album_id from tracks

group by album_id
having COUNT(Distinct name) > 15;


select artists.name, a.title, t.unit_price from artists
inner join albums a on artists.id = a.artist_id
inner join tracks t on a.id = t.album_id
where artists.name like 'Audioslave';