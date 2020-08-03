create database if not exists my_flights;

use my_flights;

drop table if exists flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  flight_from VARCHAR(50),
  flight_to VARCHAR(50)
);

drop table if exists cities;
CREATE TABLE cities (
  label VARCHAR(50),
  name VARCHAR(50)
);

INSERT INTO flights VALUES 
	(1, 'moscow', 'omsk'), 
	(2, 'novgorod', 'kazan'),
	(3, 'irkutsk', 'moscow'),
	(4, 'omsk', 'irkutsk'),
	(5, 'moscow', 'kazan');

INSERT INTO cities VALUES 
	('moscow', 'Москва'), 
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');

select id, city_from, city_to from 
(select id, name as city_from from flights as f join cities as c on f.flight_from = c.label) as fl_1
join 
(select id as id_2, name as city_to from flights as f join cities as c on f.flight_to = c.label) as fl_2 on fl_1.id = fl_2.id_2 order by id;





