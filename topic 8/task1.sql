use shop;



drop function if exists hello;
DELIMITER //
create function hello ()
returns TEXT deterministic
begin
	if (CURTIME() >= cast('6:00:00' as TIME)) and (CURTIME() < cast('12:00:00' as TIME)) then
		return '������ ����';
	elseif (CURTIME() >= cast('12:00:00' as TIME)) and (CURTIME() < cast('18:00:00' as TIME)) then
		return '������ ����';
	elseif (CURTIME() >= cast('18:00:00' as TIME)) and (CURTIME() <= cast('23:59:59' as TIME)) then
		return '������ �����';
	else 
		return '������ ����';
	end if;
end//

DELIMITER ;

select hello();
