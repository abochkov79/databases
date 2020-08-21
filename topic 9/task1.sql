# —оздайте таблицу logs типа Archive. ѕусть при каждом создании записи в таблицах users, catalogs и products 
# в таблицу logs помещаетс€ врем€ и дата создани€ записи, название таблицы, идентификатор первичного ключа 
# и содержимое пол€ name.

use shop;

drop table if exists logs ;
create table logs (
	id bigint usigned primary key,
	rec_date_time DATETIME,
	tab_name VARCHAR(255),
	rec_id bigint unsigned,
	rec_name VARCHAR(255)
) ENGINE=archive;

use shop;

DELIMITER //
drop trigger if exists rec_log;
create trigger rec_log after insert on users
for each row
begin
	insert into logs select NOW(), @nametable, id, name from users;
end

// 

drop trigger if exists rec_log;
create trigger rec_log after insert on catalogs
for each row
begin
	insert into logs select NOW(), @nametable, id, name from catalogs;
end

//

drop trigger if exists rec_log;
create trigger rec_log after insert on products
for each row
begin
	insert into logs select NOW(), @nametable, id, name from products;
end

//
DELIMITER ;
