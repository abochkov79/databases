use shop;

select * from storehouses_products where value <> 0 order by value;
select * from storehouses_products where value = 0 order by value;


