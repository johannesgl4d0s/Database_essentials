select * from jtracks limit 1;


SELECT body->>'artist' artist, sum((body->>'count')::int)  count
FROM jtracks
group by artist
order by count desc;


select * from tracks;


SELECT distinct jtracks.body->>'name' as p,((body->>'count')::float4) * tracks.unit_price::float4 as sp FROM jtracks
join tracks on tracks.name = jtracks.body->>'name'
group by p
order by sp desc ;

SELECT distinct body->>'artist' artists,sum(((body->>'count')::float4) * tracks.unit_price::float4) as sp FROM jtracks
join tracks on tracks.name = jtracks.body->>'name'
group by artists
order by sp desc;

SELECT distinct body->>'artist' artists,sum(((body->>'count')::float4)) as sp FROM jtracks
full outer join tracks on tracks.name = jtracks.body->>'name'
group by artists
order by sp desc;


select *
from tracks;

SELECT  jtracks.body ->> 'artist' an, sum((jtracks.body->> 'count')::int) c from jtracks
left join artists on artists.name = jtracks.body ->> 'artist'
where artists.name is null
group by an
order by c desc
limit 5;


SELECT * from customers
where (state like 'RJ'
        OR state like 'DF'
        OR state like 'AB'
        OR state like 'BC'
        OR state like 'CA'
        OR state like 'WA'
        OR state like 'NY');