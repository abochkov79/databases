use shop;

start transaction;
delete from sample.users where id = 1;
insert into sample.users select * from shop.users where id = 1;
delete from shop.users where id = 1;
commit;
