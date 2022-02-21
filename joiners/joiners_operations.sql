/*this joiner is to login*/
delimiter $$
create procedure get_user_to_validation(in user_id int)
begin
    select * from user_banrural where id = user_id;
end$$

delimiter $$
create procedure get_user_informacion_to_login(in NIT int)
begin
	select id, first_name, NIT_number, password 
	from user_banrural where NIT_number = NIT;
end$$

/*this joiner is to get accounts information*/

delimiter $$
create procedure get_account_information(in user_id int)
begin
	select account_banrural.id, account_banrural.account_number, user_banrural.first_name, 
	user_banrural.last_name, user_banrural.NIT_number,
	account_banrural.account_balance, account_banrural.loan_limit,
	type_account.account_type from account_banrural 
	inner join user_banrural on account_banrural.user_id = user_banrural.id
	inner join type_account on account_banrural.type_account_id = type_account.id
	where account_banrural.user_id = user_id;
end$$

delimiter $$
create procedure get_account_id(in account_number_in int)
begin
   select id from account_banrural
   where account_number = account_number_in;
end$$

/*this joiner is to get card or cards information, only cards of user*/

delimiter $$
create procedure get_card_information(in user_id int)
begin
	select card.id, card.card_number, card.card_balance, 
	type_card.card_type, user_banrural.first_name,
	user_banrural.last_name, user_banrural.NIT_number
	from card 
	inner join user_banrural on card.user_id = user_banrural.id
	inner join type_card on card.type_card_id = type_card.id
	where card.user_id = user_id;
end$$

/*this joiner is to get information of loan or loans to user*/
drop procedure get_loan_information;
delimiter $$
create procedure get_loan_information (in user_id int)
begin
	select loan.loan_balance, loan.loan_cuote, loan.next_payment_date,
	user_banrural.first_name, user_banrural.last_name,
	user_banrural.NIT_number, loan.id
	from loan 
	inner join user_banrural on loan.user_id = user_banrural.id
	where loan.user_id = user_id;
end$$

/*this procedure is to get transaction information or transaction register*/

delimiter $$
create procedure get_transactions_information(in account_number int)
begin
	select * from transaction_user where account_out_id = account_number;
end$$

/*this joiner is to get online payment register*/

delimiter $$
create procedure get_payment_register(in user_id int)
begin
	select user_banrural.first_name, user_banrural.DPI_number,
	online_payment.date_payment, type_payment.payment_type
	from online_payment 
	inner join user_banrural on online_payment.user_id = user_banrural.id
	inner join type_payment on online_payment.type_payment = type_payment.id
	where online_payment.user_id = user_id; 
end$$

