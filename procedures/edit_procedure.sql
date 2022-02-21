delimiter $$
create procedure signout_user(in user_id int)
begin
	update user_banrural set user_state = False where id = user_id;
end$$

delimiter $$
create procedure signin_user(in user_id int)
begin
	update user_banrural set user_state = True where id = user_id;
end$$
