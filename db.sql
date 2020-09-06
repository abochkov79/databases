# Курсовой проект по курсу "Базы данных"
# Студент - Бочков Александр

# Проект - создание базы данных для системы учета личных финансов. Аналог - www.toshl.com
# База данных позволяет вести учет пользователей, для каждого пользователя позволять вести бюджеты и учет фактических операций
# отдельно по доходам и расходам в разрезе:
# - календарных месяцев и отдельных периодов, заданных пользователем
# - отдельных счетов (наличные, банковские карты, банковские счета)
# - статей доходов и расходов
# - меток внутри отдельных статей доходов и расходов (расширенная аналитика - например статья "Расходы на машин", метки - "Мойка", "Запчасти", "Сервис", "Страхование") 

# База данных содержит как стандартный перечень статей доходов и расходов "по умолчанию", так и позволяет пользователям добавлять свои собственные статьи и метки.

# База данных позволяет выводить информацию о бюджете, фактических доходах и расходах пользователя за выбранный период времени.

# Таблица 1. users - информация о пользователях, включае поля:
#		- user_id 					- идентификатор пользователя
#		- name						- имя пользователя
#		- surname					- фамилия пользователя
#		- user_alias				- псевдоним пользователя
#		- gender					- пол пользователя
#		- birthday					- дата рождения пользователя
#		- phone						- контактный телефон пользователя
#		- email						- email пользователя, он же - логин
#		- pass						- пароль к учетной записи пользователя
#		- created_at				- дата и время создания учетной записи пользователя

# Таблица 2. income_default - информация о стандартных статьях доходов:
#		- id 						- идентификатор статьи доходов
#		- income_name				- наименование статьи доходов

# Таблица 3. income_user - информация о статьях доходов, добавленных пользователями:
#		- id 						- идентификатор статьи доходов
#		- user_id					- идентификатор пользователя
#		- income_user_name			- наименование статьи доходов

# Таблица 4. expenditure_default - информация о стандартных статьях расходов:
#		- id 						- идентификатор статьи доходов
#		- expenditure_name			- наименование статьи расходов

# Таблица 5. expenditure_user - информация о статьях расходов, добавленных пользователями:
#		- id 						- идентификатор статьи расходов
#		- user_id					- идентификатор пользователя
#		- expenditure_user_name		- наименование статьи расходов

# Таблица 6. expenditure_tags - информация о метках к статьям расходов:
#		- id 						- идентификатор метки
#		- user_id					- идентификатор пользователя
#		- expenditure_id			- идентификатор стандартной статьи расхода
#		- expenditure_user_id		- идентификатор статьи расхода, добавленной пользователем
#		- expenditure_tag_name		- наименование метки расходов

# Таблица 7. user_accounts - информация о счетах учета доходов и расходов пользователей:
#		- id 						- идентификатор счета пользователя
#		- user_id					- идентификатор пользователя
#		- user_account_name			- наименование счета пользователя
#		- created_at				- дата и время добавления счета пользователя

# Таблица 8. incomes_budget - информация о бюджетах доходов пользователей:
#		- id 						- идентификатор записи бюджета доходов пользователя
#		- user_id					- идентификатор пользователя
#		- user_account_id			- идентификатор счета пользователя
#		- income_default_id			- идентификатор стандартной статьи дохода
#		- income_user_id			- идентификатор статьи дохода, добавленной пользователем
#		- income_amount				- сумма дохода
#		- income_date				- дата дохода

# Таблица 9. expenditure_budget - информация о бюджетах расходов пользователей:
#		- id 						- идентификатор записи бюджета расходов пользователя
#		- user_id					- идентификатор пользователя
#		- user_account_id			- идентификатор счета пользователя
#		- expenditure_default_id	- идентификатор стандартной статьи расходов
#		- expenditure_user_id		- идентификатор статьи расходов, добавленной пользователем
#		- expenditure_amount		- сумма расхода
#		- expenditure_date			- дата дохода

# Таблица 10. incomes_fact - информация о фактических доходах пользователей:
#		- id 						- идентификатор записи бюджета доходов пользователя
#		- user_id					- идентификатор пользователя
#		- user_account_id			- идентификатор счета пользователя
#		- income_default_id			- идентификатор стандартной статьи дохода
#		- income_user_id			- идентификатор статьи дохода, добавленной пользователем
#		- income_amount				- сумма дохода
#		- income_date				- дата дохода

# Таблица 11. expenditure_fact - информация о фактических расходах пользователей:
#		- id 						- идентификатор записи бюджета расходов пользователя
#		- user_id					- идентификатор пользователя
#		- user_account_id			- идентификатор счета пользователя
#		- expenditure_default_id	- идентификатор стандартной статьи расходов
#		- expenditure_user_id		- идентификатор статьи расходов, добавленной пользователем
#		- expenditure_amount		- сумма расхода
#		- expenditure_date			- дата дохода



drop database if exists my_budget;
create database my_budget;
use my_budget;

drop table if exists users;
create table users (
	user_id bigint unsigned primary key,
	name varchar(50),
	surname varchar(50),
	user_alias varchar(50),
	gender char(1),
	birthday date,
	phone varchar(30),
	email varchar(30),
	pass varchar(30),
	created_at datetime
);

drop table if exists income_default;
create table income_default (
	id bigint unsigned primary key,
	income_name varchar(50)
);

drop table if exists income_user;
create table income_user (
	id bigint unsigned primary key,
	user_id bigint unsigned,
	income_user_name varchar(50),
	foreign key (user_id) references users(user_id)
);

drop table if exists expenditure_default;
create table expenditure_default (
	id bigint unsigned primary key,
	expenditure_name varchar(50)
);

drop table if exists expenditure_user;
create table expenditure_user (
	id bigint unsigned primary key,
	user_id bigint unsigned,
	expenditure_user_name varchar(50),
	foreign key (user_id) references users(user_id)
);

drop table if exists expenditure_tags;
create table expenditure_tags (
	id bigint unsigned primary key,
	user_id bigint unsigned,
	expenditure_id bigint unsigned,
	expenditure_user_id bigint unsigned,
	expenditure_tag_name varchar(50),
	foreign key (user_id) references users(user_id),
	foreign key (expenditure_id) references expenditure_default(id),
	foreign key (expenditure_user_id) references expenditure_user(id)
);

drop table if exists user_accounts;
create table user_accounts (
	id serial primary key,
	user_id bigint unsigned not null,
	user_account_name varchar(50),
	created_at datetime,
	foreign key (user_id) references users(user_id)
);

drop table if exists incomes_budget;
create table incomes_budget (
	id serial primary key,
	user_id bigint unsigned,
	user_account_id bigint unsigned,
	income_default_id bigint unsigned,
	income_user_id bigint unsigned,
	income_amount float,
	income_date	date,
	foreign key (user_id) references users(user_id),
	foreign key (user_account_id) references user_accounts(id),
	foreign key (income_default_id) references income_default(id),
	foreign key (income_user_id) references income_user(id)
);

drop table if exists expenditure_budget;
create table expenditure_budget (
	id serial primary key,
	user_id bigint unsigned,
	user_account_id bigint unsigned,
	expenditure_default_id bigint unsigned,
	expenditure_user_id bigint unsigned,
	expenditure_tag bigint unsigned,
	expenditure_amount float,
	expenditure_date	date,
	foreign key (user_id) references users(user_id),
	foreign key (user_account_id) references user_accounts(id),
	foreign key (expenditure_default_id) references expenditure_default(id),
	foreign key (expenditure_user_id) references expenditure_user(id),
	foreign key (expenditure_tag) references expenditure_tags(id)
);

drop table if exists incomes_fact;
create table incomes_fact (
	id serial primary key,
	user_id bigint unsigned,
	user_account_id bigint unsigned,
	income_default_id bigint unsigned,
	income_user_id bigint unsigned,
	income_amount float,
	income_date	date,
	foreign key (user_id) references users(user_id),
	foreign key (user_account_id) references user_accounts(id),
	foreign key (income_default_id) references income_default(id),
	foreign key (income_user_id) references income_user(id)
);

drop table if exists expenditure_fact;
create table expenditure_fact (
	id serial primary key,
	user_id bigint unsigned,
	user_account_id bigint unsigned,
	expenditure_default_id bigint unsigned,
	expenditure_user_id bigint unsigned,
	expenditure_tag bigint unsigned,
	expenditure_amount float,
	expenditure_date	date,
	foreign key (user_id) references users(user_id),
	foreign key (user_account_id) references user_accounts(id),
	foreign key (expenditure_default_id) references expenditure_default(id),
	foreign key (expenditure_user_id) references expenditure_user(id),
	foreign key (expenditure_tag) references expenditure_tags(id)
);



INSERT INTO `users` values
(0, 'Default name', 'Default surname', 'Default alias', 'M', date('2000-01-01'), 'Default phone', 'Default email', 'Default pass', now()),
(1,'Александр','Поляков','apol1982','M',date('1982-04-01'),'+79263153104','apolyakov@gmail.com','dsk33fs43',now()),
(2,'Виктор','Исаев','vik55','M',date('1976-07-18'),'+79262516180','vik55@gmail.com','dsfiowe543',now()),
(3,'Михаил','Кокляев','MichaelFist','M',date('1974-05-23'),'+79269026101','fistfury@gmail.com','jgf32gdsggset',now()),
(4,'Анна','Родионова','arod83','F',date('1983-06-21'),'+79268157510','arod83@gmail.com','3er23tj3t',now()),
(5,'Ольга','Королева','olga_kor','F',date('1994-03-06'),'+79035180257','olga_kor@gmail.com','093284gasklj324',now()),
(6,'Андрей','Кузнецов','akuz77','M',date('1977-04-22'),'+79215130571','akuz77@gmail.com','jklsd394jdgflkjsdg',now()),
(7,'Виктор','Михайлов','michvik','M',date('1997-01-15'),'+79268904103','michvik@gmail.com','opier34098gd',now()),
(8,'Арина','Круглова','arina_84','F',date('1984-09-27'),'+79261501349','arina_84@gmail.com','sopgb2398g1',now()),
(9,'Скотт','Стивенс','sleepystevens','M',date('1980-02-28'),'+459195239835','sleepystevens@gmail.com','coalheadwear56',now()),
(10,'Максим','Комолов','max98','M',date('1998-01-12'),'+79268155183','max98@gmail.com','9034gsfdklg734',now());

INSERT INTO `income_default` values
(0, 'Default income'),
(1,'Заработная плата'),
(2,'Премия'),
(3,'Проценты по вкладам'),
(4,'Доход от продажи имущества'),
(5,'Подарок'),
(6,'Грант');

INSERT INTO `income_user` values
(0, 0, 'Default user income'),
(1, 10, 'Подработка'),
(2, 7, 'Фриланс'),
(3, 9, 'Призовые на соревнованиях');

INSERT INTO `expenditure_default` values
(0, 'Default expenditure'),
(1,'Квартплата'),
(2,'Продукты'),
(3,'Ресторан/кафе'),
(4,'Общественный транспорт'),
(5,'Бензин'),
(6,'Машина'),
(7,'Мобильная связь'),
(8,'Подарки'),
(9,'Лекарства'),
(10, 'Развлечения');

INSERT INTO `expenditure_user` values
(0, 0, 'Default user expenditure'),
(1, 1, 'Подписки'),
(2, 1, 'Спорт'),
(3, 1, 'Путешествия'),
(4, 1, 'Благотворительность'),
(5, 10, 'Алкоголь'),
(6, 10, 'Сигареты'),
(7, 10, 'Дискотеки'),
(8, 10, 'Каршеринг'),
(9, 3, 'Такси'),
(10, 2, 'Уроки английского');

INSERT INTO `expenditure_tags` values
(0, 0, 0, 0, 'Default tag'),
(1, 1, 6, 0, 'Автомойка'),
(2, 1, 6, 0, 'КАСКО'),
(3, 1, 6, 0, 'ОСАГО'),
(4, 1, 6, 0, 'Запчасти'),
(5, 1, 6, 0, 'Автосервис'),
(6, 10, 0, 1, 'Музыкальные сервисы'),
(7, 10, 0, 1, 'Электронные книги'),
(8, 10, 0, 1, 'Новости'),
(9, 10, 0, 1, 'Кино и сериалы'),
(10, 10, 0, 1, 'Образовательные сервисы');

INSERT INTO `user_accounts` values
(1, 1, 'Наличные', now()),
(2, 1, 'Сбербанк', now()),
(3, 1, 'Тинькофф Банк', now()),
(4, 2, 'Наличные', now()),
(5, 2, 'Сбербанк', now()),
(6, 2, 'Альфа-Банк', now()),
(7, 3, 'Наличные', now()),
(8, 3, 'Ситибанк', now()),
(9, 3, 'Банк "Открытие"', now()),
(10, 4, 'Наличные', now()),
(11, 4, 'Райффайзен Банк', now()),
(12, 4, 'Промсвязьбанк', now()),
(13, 5, 'Наличные', now()),
(14, 5, 'Сбербанк', now()),
(15, 10, 'Наличные', now()),
(16, 10, 'Сбербанк', now()),
(17, 10, 'Тинкофф Банк', now());

INSERT INTO `incomes_budget` values
(1, 1, 1, 1, 0, 100000, date('2020-09-01')),
(2, 1, 1, 2, 0, 50000, date('2020-09-01')),
(3, 10, 14, 1, 0, 250000, date('2020-09-01')),
(4, 10, 14, 2, 0, 70000, date('2020-09-01')),
(5, 10, 14, 0, 1, 30000, date('2020-09-01'));


INSERT INTO `expenditure_budget` values
(1, 1, 1, 1, 0, 0, 7000, date('2020-09-01')),
(2, 1, 1, 2, 0, 0, 25000, date('2020-09-01')),
(3, 1, 1, 3, 0, 0, 10000, date('2020-09-01')),
(4, 1, 1, 6, 0, 2, 3000, date('2020-09-01')),
(5, 1, 1, 0, 1, 0, 400, date('2020-09-01')),
(6, 10, 14, 1, 0, 0, 9000, date('2020-09-01')),
(7, 10, 14, 2, 0, 0, 32000, date('2020-09-01')),
(8, 10, 14, 3, 0, 0, 7000, date('2020-09-01')),
(9, 10, 14, 4, 0, 0, 5000, date('2020-09-01')),
(10, 10, 14, 0, 1, 6, 2000, date('2020-09-01'));

INSERT INTO `incomes_fact` values
(1, 1, 1, 1, 0, 110000, date('2020-09-25')),
(2, 1, 1, 2, 0, 65000, date('2020-09-30')),
(3, 10, 14, 1, 0, 230000, date('2020-09-25')),
(4, 10, 14, 2, 0, 40000, date('2020-09-30')),
(5, 10, 14, 0, 1, 15000, date('2020-09-15'));

INSERT INTO `expenditure_fact` values
(1, 1, 1, 1, 0, 0, 7300, date('2020-09-10')),
(2, 1, 1, 2, 0, 0, 10000, date('2020-09-5')),
(3, 1, 1, 2, 0, 0, 18000, date('2020-09-10')),
(4, 1, 1, 2, 0, 0, 4000, date('2020-09-25')),
(5, 1, 1, 2, 0, 0, 4000, date('2020-09-27')),
(6, 1, 1, 3, 0, 0, 11000, date('2020-09-05')),
(7, 1, 1, 6, 0, 0, 4500, date('2020-09-11')),
(8, 1, 1, 0, 1, 2, 430, date('2020-09-21')),
(9, 10, 14, 1, 0, 0, 8600, date('2020-09-14')),
(10, 10, 14, 2, 0, 0, 30500, date('2020-09-22')),
(11, 10, 14, 3, 0, 0, 7400, date('2020-09-28')),
(12, 10, 14, 4, 0, 0, 5200, date('2020-09-09')),
(13, 10, 14, 0, 1, 6, 1800, date('2020-09-03'));


