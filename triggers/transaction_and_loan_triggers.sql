/*this trigger is to when a user make a transaction to other account*/
delimiter $$
create trigger make_transaction 
after insert on transaction_user
for each row
begin
	update account_banrural
	set account_balance = account_balance - NEW.transaction_balance
	where id = NEW.account_out_id;

	update account_banrural 
	set account_balance = account_balance + NEW.transaction_balance
	where id = NEW.account_in_id;
end$$

/*this trigger is to when a user make a loan, the ammount of loan is add to ammount of 
 account of user*/

delimiter $$
create trigger make_loan 
after insert on loan
for each row
begin
	update account_banrural 
	set loan_limit = loan_limit - NEW.loan_balance
	where id = NEW.account_id; 

	update account_banrural 
	set account_balance = account_balance + NEW.loan_balance
	where id = NEW.account_id;
end$$

/*this trigger is to when user make a payment online, and have a 4 pyament methods*/
drop trigger make_online_payment;
delimiter $$
create trigger make_online_payment
after insert on online_payment
for each row
begin
	IF NEW.type_payment = 1 THEN
		update card
		set card_balance = card_balance - (select @payment_balance)
		where user_id = NEW.user_id and type_card_id = 1;
	ELSEIF NEW.type_payment = 2 THEN
		update card 
		set card_balance = card_balance - (select @payment_balance)
		where user_id = NEW.user_id and type_card_id = 2;
	ELSEIF NEW.type_payment = 3 THEN
		update account_banrural 
		set account_balance = account_balance - (select @payment_balance)
		where user_id = NEW.user_id
		and type_account_id = 1;
	ELSE
		update account_banrural 
		set account_balance = account_balance - (select @payment_balance)
		where user_id = NEW.user_id
		and type_account_id = 2;
	END IF;

	update loan 
	set loan_balance = loan_balance - (select @payment_balance),
    next_payment_date = (select @payment_day)
	where id=(select @loan_id) and user_id = NEW.user_id;
end$$

