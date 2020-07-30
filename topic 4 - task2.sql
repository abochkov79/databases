use shop;


select dayname(makedate(year(NOW()),dayofyear(birthday_at))) as Weekday, count(*) from users group by Weekday;

