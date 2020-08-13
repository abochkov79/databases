use shop;

create or replace view new_cat as 
	select 
		p.name as Product_name,
		c.name as Category
	from 
		products as p join catalogs as c
	on
		p.catalog_id = c.id;

select * from new_cat;