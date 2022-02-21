create database banrural_database;

use banrural_database;

/*
tables to banrural app and website
user:
	-id
	-first_name
	-last_name
  -user_status
	-DPI_number
	-NIT_number
	-password
account:
	-id
	-account_number
	-user_id
	-account_balance
	-loan_limit
	-type_account_id
type_account:
	-id
	-type
card:
	-id
	-user_id
	-card_number
	-card_balance
	-type_card_id
type_card:
	-id
	-type
loan:
	-id
	-id_user
	-loan_balance
	-loan_cuote
	-next_payment_date
transaction:
	-id
	-description
	-account_out_id
	-account_in_id
	-transaction_balance
	-transaction_date
online_payment:
	-id	
	-account_id
	-type_payment
	-date_payment
type_payment:
	-id
	-type
 */

create table user_banrural(
	id int primary key auto_increment,
	first_name varchar(200) not null,
	last_name varchar(200) not null,
  user_state boolean not null,
	DPI_number int not null,
	NIT_number int not null,
	password  varchar(300) not null
);

create table account_banrural(
	id int primary key auto_increment,
	account_number int not null,
	user_id int not null,
	account_balance float not null,
	loan_limit float not null,
	type_account_id int not null
);

create table type_account(
	id int primary key auto_increment,
	account_type varchar(40) not null
);

create table card(
	id int primary key auto_increment,
	user_id int not null,
	card_number int not null,
	card_balance float not null,
	type_card_id int not null
);

create table type_card(
	id int primary key auto_increment,
	card_type varchar(40)
);

create table loan(
	id int primary key auto_increment,
	account_id int not null,
	user_id int not null,
	loan_balance float not null,
	loan_cuote float not null,
	next_payment_date date
);

create table transaction_user(
	id int primary key auto_increment,
	description varchar(400),
	account_out_id int not null,
	account_in_id int not null,
	transaction_balance float not null,
	transaction_date date not null
);

create table online_payment(
	id int primary key auto_increment,	
	user_id int not null,
	type_payment int not null,
	date_payment date not null
);

create table type_payment(
	id int primary key auto_increment,
	payment_type varchar(40)
);

/* relationship of tables */
alter table account_banrural add foreign key(user_id) references user_banrural(id);
alter table account_banrural add foreign key(type_account_id) references type_account(id);
alter table card add foreign key(user_id) references user_banrural(id);
alter table card add foreign key(type_card_id) references type_card(id);
alter table loan add foreign key(account_id) references account_banrural(id);
alter table loan add foreign key(user_id) references user_banrural(id);
alter table transaction_user add foreign key(account_in_id) references account_banrural(id);
alter table transaction_user add foreign key(account_out_id) references account_banrural(id);
alter table online_payment add foreign key(user_id) references user_banrural(id);
alter table online_payment add foreign key(type_payment) references type_payment(id);

/*default values of database*/

insert into type_account values(default, 'savings account'),
															 (default, 'monetary account');

insert into type_card values(default, 'credit card'),
						    (default, 'debit card');


insert into type_payment values(default, 'with credit card'),
															 (default, 'with debit card'),
															 (default, 'with savings account'),
															 (default, 'with monetary account');


