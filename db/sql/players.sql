select a.id, a.first_name, a.last_name, count(b.id) from players as a left outer join results as b on b.player_id = a.id group by a.id, a.first_name, a.last_name order by count(b.id) desc;
select a.id, a.first_name, a.last_name, count(b.id) from players as a left outer join results as b on b.player_id = a.id group by a.id, a.first_name, a.last_name order by a.last_name;

/*

update players set first_name = 'Tommy', last_name = '?' where id = 22 and last_name = '';

*/
/*

delete from players where id = 50 and not exists (select 1 from results where results.player_id = players.id);

*/