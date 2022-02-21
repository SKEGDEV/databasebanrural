delimiter $$
create procedure add_user(in first_name varchar(200), in last_name varchar(200), in user_state boolean, in DPI int, in NIT int, in password varchar(300))
begin
	insert into user_banrural values(default, first_name, last_name, user_state , DPI, NIT, password);
end$$

delimiter $$
create procedure add_bank_account(in account_number int, in user_id int, in account_balance float, in loan_limit float, in type_account int)
begin
	insert into account_banrural values(default, account_number, user_id, account_balance, loan_limit, type_account);
end$$

delimiter $$
create procedure add_bank_card(in user_id int, in card_number int, in card_balance float, in type_card int)
begin
	insert into card values(default, user_id, card_number, card_balance, type_card);
end$$
drop procedure add_user_loan;
delimiter $$
create procedure add_user_loan(in user_id int, in account_id int, in loan_balance float, in loan_cuote float, in next_payment_date date)
begin 
	insert into loan values(default, account_id, user_id, loan_balance, loan_cuote, next_payment_date);
end$$

delimiter $$
create procedure make_transaction(in description varchar(400), in account_out int, in account_in int, in transaction_balance float, in date_transaction date)
begin
	start transaction;
	insert into transaction_user values(default, description, account_out, account_in, transaction_balance, date_transaction);
	commit;
end$$
drop procedure make_payment;
delimiter $$
create procedure make_payment(in user_id int, in type_payment int, in date_payment date, in next_payment_day date, in id_loan int)
begin
	start transaction;
    set @loan_id := id_loan;
    set @payment_day := next_payment_day;
    set @paymet_balance := 0;
	select @payment_balance := loan_cuote 
	from loan
	where id = id_loan and user_id = user_id; 
	insert into online_payment values(default, user_id, type_payment, date_payment);
	commit;
end$$
