use shop;

alter table users change column created_at created_at DATETIME as (DATE(created_at));
alter table users change column updated_at updated_at DATETIME as (DATE(updated_at));
select * from users;
