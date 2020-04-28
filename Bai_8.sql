Create table Account(
	Account_ID int not null primary key,
	Account_Name nvarchar(30),
	check(dbo.Check_Account_ID(Account_ID) = 1)
)

create function dbo.Check_Account_ID(@ID int)
returns int
as
begin
	declare @check int = 0
	declare @result int = 0, @index int = 0
	declare @element int = 0
	declare @set_id_str char(9)

	set @set_id_str = cast(@ID as char(9))
	while(@index <= 9)
		begin
			select @element = cast(SUBSTRING(@set_id_str, @index + 1, 1) as int) * (9-@index)
			set @result = @result + @element;
			set @index = @index + 1;
		end
	if(@result % 11) = 0
		set @check = 1
	return @check
end
drop table Account
drop function dbo.Check_Account_ID
insert into Account values(972428577, 'vanb1606952')

select * from Account
