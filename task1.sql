use shop;

#INSERT INTO orders VALUES
#  (1, 1, now(), now()),
#  (2, 5, now(), now()),
#  (3, 2, now(), now());

select * from users where id in (select user_id from orders group by user_id) ;



