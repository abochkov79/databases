use shop;

select * from products p join catalogs as c on p.catalog_id = c.id;

