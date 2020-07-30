use shop;

select 
	ROUND(AVG(((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25)),2) as age 
from 
	users;