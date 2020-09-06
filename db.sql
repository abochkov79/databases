# �������� ������ �� ����� "���� ������"
# ������� - ������ ���������

# ������ - �������� ���� ������ ��� ������� ����� ������ ��������. ������ - www.toshl.com
# ���� ������ ��������� ����� ���� �������������, ��� ������� ������������ ��������� ����� ������� � ���� ����������� ��������
# �������� �� ������� � �������� � �������:
# - ����������� ������� � ��������� ��������, �������� �������������
# - ��������� ������ (��������, ���������� �����, ���������� �����)
# - ������ ������� � ��������
# - ����� ������ ��������� ������ ������� � �������� (����������� ��������� - �������� ������ "������� �� �����", ����� - "�����", "��������", "������", "�����������") 

# ���� ������ �������� ��� ����������� �������� ������ ������� � �������� "�� ���������", ��� � ��������� ������������� ��������� ���� ����������� ������ � �����.

# ���� ������ ��������� �������� ���������� � �������, ����������� ������� � �������� ������������ �� ��������� ������ �������.

# ������� 1. users - ���������� � �������������, ������� ����:
#		- user_id 					- ������������� ������������
#		- name						- ��� ������������
#		- surname					- ������� ������������
#		- user_alias				- ��������� ������������
#		- gender					- ��� ������������
#		- birthday					- ���� �������� ������������
#		- phone						- ���������� ������� ������������
#		- email						- email ������������, �� �� - �����
#		- pass						- ������ � ������� ������ ������������
#		- created_at				- ���� � ����� �������� ������� ������ ������������

# ������� 2. income_default - ���������� � ����������� ������� �������:
#		- id 						- ������������� ������ �������
#		- income_name				- ������������ ������ �������

# ������� 3. income_user - ���������� � ������� �������, ����������� ��������������:
#		- id 						- ������������� ������ �������
#		- user_id					- ������������� ������������
#		- income_user_name			- ������������ ������ �������

# ������� 4. expenditure_default - ���������� � ����������� ������� ��������:
#		- id 						- ������������� ������ �������
#		- expenditure_name			- ������������ ������ ��������

# ������� 5. expenditure_user - ���������� � ������� ��������, ����������� ��������������:
#		- id 						- ������������� ������ ��������
#		- user_id					- ������������� ������������
#		- expenditure_user_name		- ������������ ������ ��������

# ������� 6. expenditure_tags - ���������� � ������ � ������� ��������:
#		- id 						- ������������� �����
#		- user_id					- ������������� ������������
#		- expenditure_id			- ������������� ����������� ������ �������
#		- expenditure_user_id		- ������������� ������ �������, ����������� �������������
#		- expenditure_tag_name		- ������������ ����� ��������

# ������� 7. user_accounts - ���������� � ������ ����� ������� � �������� �������������:
#		- id 						- ������������� ����� ������������
#		- user_id					- ������������� ������������
#		- user_account_name			- ������������ ����� ������������
#		- created_at				- ���� � ����� ���������� ����� ������������

# ������� 8. incomes_budget - ���������� � �������� ������� �������������:
#		- id 						- ������������� ������ ������� ������� ������������
#		- user_id					- ������������� ������������
#		- user_account_id			- ������������� ����� ������������
#		- income_default_id			- ������������� ����������� ������ ������
#		- income_user_id			- ������������� ������ ������, ����������� �������������
#		- income_amount				- ����� ������
#		- income_date				- ���� ������

# ������� 9. expenditure_budget - ���������� � �������� �������� �������������:
#		- id 						- ������������� ������ ������� �������� ������������
#		- user_id					- ������������� ������������
#		- user_account_id			- ������������� ����� ������������
#		- expenditure_default_id	- ������������� ����������� ������ ��������
#		- expenditure_user_id		- ������������� ������ ��������, ����������� �������������
#		- expenditure_amount		- ����� �������
#		- expenditure_date			- ���� ������

# ������� 10. incomes_fact - ���������� � ����������� ������� �������������:
#		- id 						- ������������� ������ ������� ������� ������������
#		- user_id					- ������������� ������������
#		- user_account_id			- ������������� ����� ������������
#		- income_default_id			- ������������� ����������� ������ ������
#		- income_user_id			- ������������� ������ ������, ����������� �������������
#		- income_amount				- ����� ������
#		- income_date				- ���� ������

# ������� 11. expenditure_fact - ���������� � ����������� �������� �������������:
#		- id 						- ������������� ������ ������� �������� ������������
#		- user_id					- ������������� ������������
#		- user_account_id			- ������������� ����� ������������
#		- expenditure_default_id	- ������������� ����������� ������ ��������
#		- expenditure_user_id		- ������������� ������ ��������, ����������� �������������
#		- expenditure_amount		- ����� �������
#		- expenditure_date			- ���� ������



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
(1,'���������','�������','apol1982','M',date('1982-04-01'),'+79263153104','apolyakov@gmail.com','dsk33fs43',now()),
(2,'������','�����','vik55','M',date('1976-07-18'),'+79262516180','vik55@gmail.com','dsfiowe543',now()),
(3,'������','�������','MichaelFist','M',date('1974-05-23'),'+79269026101','fistfury@gmail.com','jgf32gdsggset',now()),
(4,'����','���������','arod83','F',date('1983-06-21'),'+79268157510','arod83@gmail.com','3er23tj3t',now()),
(5,'�����','��������','olga_kor','F',date('1994-03-06'),'+79035180257','olga_kor@gmail.com','093284gasklj324',now()),
(6,'������','��������','akuz77','M',date('1977-04-22'),'+79215130571','akuz77@gmail.com','jklsd394jdgflkjsdg',now()),
(7,'������','��������','michvik','M',date('1997-01-15'),'+79268904103','michvik@gmail.com','opier34098gd',now()),
(8,'�����','��������','arina_84','F',date('1984-09-27'),'+79261501349','arina_84@gmail.com','sopgb2398g1',now()),
(9,'�����','�������','sleepystevens','M',date('1980-02-28'),'+459195239835','sleepystevens@gmail.com','coalheadwear56',now()),
(10,'������','�������','max98','M',date('1998-01-12'),'+79268155183','max98@gmail.com','9034gsfdklg734',now());

INSERT INTO `income_default` values
(0, 'Default income'),
(1,'���������� �����'),
(2,'������'),
(3,'�������� �� �������'),
(4,'����� �� ������� ���������'),
(5,'�������'),
(6,'�����');

INSERT INTO `income_user` values
(0, 0, 'Default user income'),
(1, 10, '����������'),
(2, 7, '�������'),
(3, 9, '�������� �� �������������');

INSERT INTO `expenditure_default` values
(0, 'Default expenditure'),
(1,'����������'),
(2,'��������'),
(3,'��������/����'),
(4,'������������ ���������'),
(5,'������'),
(6,'������'),
(7,'��������� �����'),
(8,'�������'),
(9,'���������'),
(10, '�����������');

INSERT INTO `expenditure_user` values
(0, 0, 'Default user expenditure'),
(1, 1, '��������'),
(2, 1, '�����'),
(3, 1, '�����������'),
(4, 1, '�������������������'),
(5, 10, '��������'),
(6, 10, '��������'),
(7, 10, '���������'),
(8, 10, '���������'),
(9, 3, '�����'),
(10, 2, '����� �����������');

INSERT INTO `expenditure_tags` values
(0, 0, 0, 0, 'Default tag'),
(1, 1, 6, 0, '���������'),
(2, 1, 6, 0, '�����'),
(3, 1, 6, 0, '�����'),
(4, 1, 6, 0, '��������'),
(5, 1, 6, 0, '����������'),
(6, 10, 0, 1, '����������� �������'),
(7, 10, 0, 1, '����������� �����'),
(8, 10, 0, 1, '�������'),
(9, 10, 0, 1, '���� � �������'),
(10, 10, 0, 1, '��������������� �������');

INSERT INTO `user_accounts` values
(1, 1, '��������', now()),
(2, 1, '��������', now()),
(3, 1, '�������� ����', now()),
(4, 2, '��������', now()),
(5, 2, '��������', now()),
(6, 2, '�����-����', now()),
(7, 3, '��������', now()),
(8, 3, '��������', now()),
(9, 3, '���� "��������"', now()),
(10, 4, '��������', now()),
(11, 4, '���������� ����', now()),
(12, 4, '�������������', now()),
(13, 5, '��������', now()),
(14, 5, '��������', now()),
(15, 10, '��������', now()),
(16, 10, '��������', now()),
(17, 10, '������� ����', now());

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


