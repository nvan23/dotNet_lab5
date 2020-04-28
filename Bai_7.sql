select * from [Order Details]

---------------------------7.1 7.2------------------------------
Go
Create Proc CalulateMoney_Order @Order_ID char(5)
AS
select sum(UnitPrice*Quantity- UnitPrice*Quantity*Discount) 
as Total_Price
from [Order Details]
where OrderId=@Order_ID
------
Exec CalulateMoney_Order '10249'

GO

create function dbo.CalulateMoney(@Order_ID char(5))
returns table
as
return (select sum(UnitPrice*Quantity-
			UnitPrice*Quantity*Discount) 
		as Total_Price
		from [Order Details] where OrderId=@Order_ID)
--------
select *
from dbo.CalulateMoney('10249')

GO
create function dbo.Calulate(@Order_ID char(5))
returns money
as
Begin
	Declare @a money
	select @a = sum(UnitPrice*Quantity - UnitPrice*Quantity*Discount)
	from [Order Details]
	where OrderId=@Order_ID
	return @a
End
--------
select dbo.Calulate('10249')
