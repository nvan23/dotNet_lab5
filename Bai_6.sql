Create table nhanvien (
	manv int not null primary key,
	hoten varchar(30) not null,
	diachi varchar(30) not null
)

GO
-----------------------------------------6.1 6. 2---------------------------------------------
CREATE PROCEDURE insert_nhanvien
	@manv int, @hoten varchar(30), @diachi varchar(30)
AS
BEGIN
	INSERT INTO nhanvien 
	values(@manv, @hoten, @diachi)
	
	SELECT *
	FROM nhanvien
END
--drop procedure insert_nhanvien
Execute insert_nhanvien 2, 'Nguyen Van Thanh 2', '02 Ly Tu Trong, NK– TPCT'
GO

---------------------------------------------6.3 6.4--------------------------------------------
CREATE PROCEDURE update_diachi_nv
	@manv int, @diachi varchar(30)
AS
BEGIN
	UPDATE nhanvien
	SET nhanvien.diachi = @diachi
	WHERE nhanvien.manv = @manv
	
	SELECT *
	FROM nhanvien
END

Execute update_diachi_nv 1, 'updated 01 Ly Tu Trong, NK– TPCT'
GO