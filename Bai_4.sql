------
------------------------------------------Bài 4----------------------------------------
------
IF (SELECT object_id('product')) IS NOT NULL 
BEGIN
	DROP TABLE product
END;

create table product(
	prod_nr int not null primary key,
	name varchar(30) not null,
	price money not null,
	type varchar(30) not null
)

insert into product values (4,'ColorTv',700,'electronic')
insert into product values (5,'Fan',350,'electronic')
insert into product values (6,'Heater',200,'electronic')
insert into product values (7,'Webcam',60,'Computer')


select * from product;
------
------------------------------------------Bài 4.4--------------------------------------------
------
BEGIN
	DECLARE @_electronic float;
	DECLARE @_computer float;

	SELECT @_electronic = sum(price)/count(prod_nr) 
	FROM product
	WHERE type = 'electronic';

	SELECT @_computer = sum(price)/count(prod_nr) 
	FROM product
	WHERE type = 'Computer'

	PRINT 'Median of electronic types is ' + CAST(@_electronic AS NVARCHAR);
	PRINT 'Median of Computer types is ' + CAST(@_computer AS NVARCHAR);
END
------
------------------------------------------Bài 4.5--------------------------------------------
------
BEGIN
	DECLARE @electronic float;
	DECLARE @computer float;

	SELECT @electronic = sum(price)/count(prod_nr) 
	FROM product
	WHERE type = 'electronic';

	SELECT @computer = sum(price)/count(prod_nr) 
	FROM product
	WHERE type = 'Computer';

	WHILE (@electronic <= 500)
	BEGIN
		UPDATE product SET price = price + price * 0.05
		WHERE type = 'electronic';
		
		SELECT @electronic = sum(price)/count(prod_nr) 
		FROM product
		WHERE type = 'electronic'; 
	END

	WHILE (@computer <= 500)
	BEGIN
		UPDATE product SET price = price + price * 0.05
		WHERE type = 'Computer';
		
		SELECT @computer = sum(price)/count(prod_nr) 
		FROM product
		WHERE type = 'Computer'; 
	END

	SELECT *
	FROM product;

	PRINT 'Currently median of electronic types is ' + CAST(@electronic AS NVARCHAR);
	PRINT 'Currently median of Computer types is ' + CAST(@computer AS NVARCHAR);
END