use shop;

select * from users where monthname(birthday_at) in ('may', 'august')