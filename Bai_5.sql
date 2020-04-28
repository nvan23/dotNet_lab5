------
------------------------------------------Bài 5----------------------------------------
------
------
------------------------------------------Bài 5.1--------------------------------------------
------
GO
Create Procedure TonKho
	@STT_DL int, @Ma_HAng nvarchar(3),
	@TongMua int Output, @TongBan int Output, @Ton int Output
As
Begin
	Select @TongMua=Sum(SoLg_Mua)
	From Mua
	Where STT_DL=@STT_DL and Ma_HAng=@Ma_Hang
	
	If @TongMua Is NULL Return
	Select @TongBan=Sum(SoLg_Ban)
	From Ban
	Where STT_DL=@STT_DL and Ma_Hang=@Ma_Hang

	If @TongBan Is NULL
		Set @TongBan = 0

	Set @Ton = @TongMua-@TongBan
End

GO

Declare @Mua int, @Ban int, @Ton int
Execute TonKho 2, '002', @Mua Output, @Ban Output, @Ton Output
print 'Tong mua: ' + Cast(@Mua as VArchar(20)) +
		'. Tong ban ' + Cast(@Ban as varchar(20)) +
		'. Ton: '+ Cast(@Ton as varchar(20))

------
------------------------------------------Bài 5.2--------------------------------------------
------
GO

Create Procedure BanHang
	@STT_DL int, @Ma_Hang nvarchar(3), @SoLgBan int, @DonGia int
As
Begin
	Declare @TongMua int, @TongBan int
	
	Select @TongMua=Sum(SoLg_Mua)
	From Mua
	Where STT_DL=@STT_DL and Ma_HAng=@Ma_Hang

	If @TongMua Is NULL
	Begin
		print 'Mat hang ' + @Ma_Hang + ' khong co' + ' o dai ly'
		Return
	End
	
	Select @TongBan=Sum(SoLg_Ban)
	From Ban
	Where STT_DL=@STT_DL and Ma_Hang=@Ma_Hang
	
	If @TongBan Is Null
		Set @TongBan=0

	if @TongMua >= @TongBan + @SoLgBan
		Insert Into Ban Values(GetDate(), @SoLgBan, @DonGia, @STT_DL, @Ma_Hang)
	else
		print 'Khong du hang de ban'
End

Execute BanHang 2, '002', 160, 12

------
------------------------------------------Bài 5.3--------------------------------------------
------

GO
drop procedure TonKho_DAILY;
go
Create Procedure TonKho_DAILY
	@STT_DL int
As
Begin
	Declare @Mua int, @Ban int, @Ton_kho int
	Declare @Ma_hang nvarchar(3), @Ten_hang nvarchar(30)

	Declare Ma_Hang_Cursor cursor for
	SELECT DISTINCT MUA.MA_HANG
	FROM MUA
	WHERE MUA.STT_DL = @STT_DL

	Print '		Ma Hang		|	Ten Hang	|	Tong mua	|	Tong ban	|	Ton		'

	OPEN Ma_Hang_Cursor
		FETCH NEXT FROM Ma_Hang_Cursor INTO @Ma_Hang
		--Print @Ma_Hang;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @Ten_hang = HANGHOA.TEN_HG
			FROM HANGHOA
			WHERE HANGHOA.MA_HANG = @Ma_hang

			Execute Tonkho @STT_DL, @Ma_Hang, @Mua Output, @Ban Output, @Ton_Kho Output
			print 
				'		' + Cast(@Ma_Hang as Varchar(20)) +
				'				' + Cast(@Ten_hang as Varchar(30)) +
				'				' + Cast(@Mua as Varchar(20)) +
				'				' + Cast(@Ban as varchar(20)) +
				'			'+ Cast(@Ton_kho as varchar(20))
			FETCH NEXT FROM Ma_Hang_Cursor INTO @Ma_Hang	
			--Print @Ma_Hang;		
		END
	CLOSE Ma_Hang_Cursor
	DEALLOCATE Ma_Hang_Cursor;
End

go
Execute TonKho_DAILY 1

------
------------------------------------------Bài 5.4--------------------------------------------
------
GO
drop procedure TonKho_DAILYS;
GO
Create Procedure TonKho_DAILYS
AS
Begin
	Declare @STT_DL int
	Declare @Ten_DL nvarchar(30)

	Declare STT_DL_Cursor cursor for
	SELECT DAILY.STT_DL
	FROM DAILY

	OPEN STT_DL_Cursor
		FETCH NEXT FROM STT_DL_Cursor INTO @STT_DL
		--Print @@STT_DL;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @Ten_DL = DAILY.TEN_DL
			FROM DAILY
			WHERE DAILY.STT_DL= @STT_DL

			Execute TonKho_DAILY @STT_DL
			print '-----------------------------------' + Cast(@Ten_DL as Varchar(30)) + '-------------------------------------'
			
			FETCH NEXT FROM STT_DL_Cursor INTO @STT_DL	
			--Print @STT_DL;		
		END
	CLOSE STT_DL_Cursor
	DEALLOCATE STT_DL_Cursor;
End

Execute TonKho_DAILYS


------
------------------------------------------Bài 5.5--------------------------------------------
------
GO
Create procedure delete_HangHoa
	@Ma_hang nvarchar(3)
AS
BEGIN
	delete BAN 
	WHERE BAN.MA_HANG = @Ma_hang

	delete MUA 
	WHERE MUA.MA_HANG = @Ma_hang

	delete HANGHOA 
	WHERE HANGHOA.MA_HANG = @Ma_hang
END

Execute delete_HangHoa '002'
