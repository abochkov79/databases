use shop;

DELIMITER //

drop trigger if exists check_products_ins;
create trigger check_products_ins before insert on products
for each row
begin
	if ((products.name == null) and (products.desription == null)) then
	rollback;
	end if;
end//

drop trigger if exists check_products_upd;
create trigger check_products_upd before update on products
for each row
begin
	if ((products.name == null) and (products.desription == null)) then
	rollback;
	end if;
end//

