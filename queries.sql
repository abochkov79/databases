use my_budget;

# Группировки - вывести количество индивидуальных статей расходов каждого пользователя
select user_id as User_ID, count(*) as 'Количество индивидуальных статей расходов' from expenditure_user group by User_ID;

# Группировки - вывести количество счетов каждого пользователя
select user_id as User_ID, count(*) as 'Количество счетов' from user_accounts group by User_ID;

# JOIN - Вывести факт доходов пользователя 1 за период
select
	d.income_name as Income,
	sum(i.income_amount) as Amount
from 
	incomes_fact as i
join
	income_default as d
on
	i.income_default_id = d.id and i.income_default_id <> 0 and i.user_account_id = 1
group by Income
union all
select
	u.income_user_name as Income,
	sum(i.income_amount) as Amount
from 
	incomes_fact as i
join
	income_user as u
on
	i.income_user_id = u.id and i.income_default_id = 0 and i.user_account_id = 1
group by Income;


# JOIN - Вывести факт расходов пользователя 1 за период
select
	d.expenditure_name as Expenditure,
	sum(e.expenditure_amount) as Amount
from 
	expenditure_fact as e
join
	expenditure_default as d
on
	e.expenditure_default_id = d.id and e.expenditure_default_id <> 0 and e.user_account_id = 1
group by Expenditure
union all
select
	u.expenditure_user_name as Expenditure,
	sum(e.expenditure_amount) as Amount
from 
	expenditure_fact as e
join
	expenditure_user as u
on
	e.expenditure_user_id = u.id and e.expenditure_default_id = 0 and e.user_account_id = 1
group by Expenditure;

# Вложенные таблицы - вывести расходы самого молодого пользователя
select * from expenditure_fact where user_id = (select user_id from users where user_id <> 0 order by birthday desc limit 1);

# Вложенные таблицы - вывести данные пользователя с самыми большими расходами
select * from users where user_id =  
(select USER_I as my_user from
	(select user_id as USER_I, sum(expenditure_amount) as Expenditure from expenditure_fact group by user_id 
	order by Expenditure desc limit 1) as max_table); 


# Представление доходов пользователей за период
create or replace view show_income as 
select
	i.user_account_id as User_ID,
	d.income_name as Income,
	i.income_amount as Amount
from 
	incomes_fact as i
join
	income_default as d
on
	i.income_default_id = d.id and i.income_default_id <> 0
union all
select
	i.user_account_id as User_ID,
	u.income_user_name as Income,
	i.income_amount
from 
	incomes_fact as i
join
	income_user as u
on
	i.income_user_id = u.id and i.income_default_id = 0;

# Представление расходов пользователя за период
create or replace view show_expenditure as
select
	e.user_account_id as User_ID,
	d.expenditure_name as Expenditure,
	e.expenditure_amount as Amount
from 
	expenditure_fact as e
join
	expenditure_default as d
on
	e.expenditure_default_id = d.id and e.expenditure_default_id <> 0
union all
select
	e.user_account_id as User_ID,
	u.expenditure_user_name,
	e.expenditure_amount
from 
	expenditure_fact as e
join
	expenditure_user as u
on
	e.expenditure_user_id = u.id and e.expenditure_default_id = 0;

# Представление бюджета доходов пользователей за период
create or replace view show_budget_income as 
select
	i.user_account_id as User_ID,
	d.income_name as Income,
	i.income_amount as Amount
from 
	incomes_budget as i
join
	income_default as d
on
	i.income_default_id = d.id and i.income_default_id <> 0
union all
select
	i.user_account_id as User_ID,
	u.income_user_name as Income,
	i.income_amount
from 
	incomes_budget as i
join
	income_user as u
on
	i.income_user_id = u.id and i.income_default_id = 0;

# Представление бюджета расходов пользователя за период
create or replace view show_budget_expenditure as
select
	e.user_account_id as User_ID,
	d.expenditure_name as Expenditure,
	e.expenditure_amount as Amount
from 
	expenditure_budget as e
join
	expenditure_default as d
on
	e.expenditure_default_id = d.id and e.expenditure_default_id <> 0
union all
select
	e.user_account_id as User_ID,
	u.expenditure_user_name,
	e.expenditure_amount
from 
	expenditure_budget as e
join
	expenditure_user as u
on
	e.expenditure_user_id = u.id and e.expenditure_default_id = 0;


select * from show_income order by User_ID;
select * from show_expenditure order by User_ID;

# Хранимая процедура, отображающая план-факт доходов по пользователю
drop procedure if exists plan_fact_income;
delimiter //
create procedure plan_fact_income (in value bigint)
begin
	select
		b.Income as 'Статья доходов', b.Amount as 'План', f.Amount as 'Факт', f.Amount - b.Amount as 'Отклонение'
	from
		(select * from show_budget_income where User_ID = value group by Income) as b
	join
		(select * from show_income where User_ID = value group by Income) as f
	on 
		b.Income = f.Income;
end//

delimiter ;

# Хранимая процедура, отображающая план-факт расходов по пользователю
drop procedure if exists plan_fact_expenditure;
delimiter //
create procedure plan_fact_expenditure (in value bigint)
begin
	select
		b.Expenditure as 'Статья расходов', b.Amount as 'План', f.Amount as 'Факт', f.Amount - b.Amount as 'Отклонение'
	from
		(select * from show_budget_expenditure where User_ID = value group by Expenditure) as b
	join
		(select * from show_expenditure where User_ID = value group by Expenditure) as f
	on 
		b.Expenditure = f.Expenditure;
end//

delimiter ;

call plan_fact_income(1);
call plan_fact_expenditure(1);

# Триггер на добавление элемента в таблицу users - обновляет количество записей
drop trigger if exists check_users;
delimiter //
create trigger check_users after insert on users
for each row
begin
	select (count(*)-1) into @total from users;	
end//

delimiter ;


select @total;


