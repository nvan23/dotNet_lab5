CREATE DATABASE QL_HANGHOA;
DROP DATABASE QL_HANGHOA;

IF (SELECT object_id('DAILY')) IS NOT NULL 
BEGIN
	DROP TABLE DAILY
END;

CREATE TABLE DAILY (
	STT_DL INT IDENTITY PRIMARY KEY,
	TEN_DL NVARCHAR(20) NOT NULL,
	DCHI_DL NVARCHAR(20) NOT NULL,
	SDT_DL NVARCHAR(11),
);

INSERT INTO DAILY VALUES('LAZADA 3', 'VietNam 3', '09111111111')
select * from daily

IF (SELECT object_id('LOAI_HG')) IS NOT NULL 
BEGIN
	DROP TABLE LOAI_HG
END;
CREATE TABLE LOAI_HG (
	MA_LOAI CHAR(2) PRIMARY KEY, 
	TEN_LOAI CHAR(50),
);

INSERT INTO LOAI_HG VALUES('07', 'SMART PHONE 7')
select * from LOAI_HG

IF (SELECT object_id('HANGHOA')) IS NOT NULL 
BEGIN
	DROP TABLE HANGHOA
END;

CREATE TABLE HANGHOA (
	MA_HANG NVARCHAR(3) PRIMARY KEY,
	TEN_HG NVARCHAR(20) NOT NULL,
	DVT CHAR(12),
	NCC CHAR(30),
	MA_LOAI CHAR(2),

	CONSTRAINT FK_HANGHOA_LOAI_HG 
	FOREIGN KEY (MA_LOAI)
    REFERENCES LOAI_HG(MA_LOAI)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
);

INSERT INTO HANGHOA VALUES('002', 'MI 8 SE', 'DVT NAME', 'XIAOMI', '06');
INSERT INTO HANGHOA VALUES('001', 'MI SE', 'DVT NAME', 'XIAOMI', '06');
INSERT INTO HANGHOA VALUES('003', 'MI8 SE', 'DVT NAME', 'XIAOMI', '06');
INSERT INTO HANGHOA VALUES('004', 'MISE', 'DVT NAME', 'XIAOMI', '06');
INSERT INTO HANGHOA VALUES('005', 'M8 SE', 'DVT NAME', 'XIAOMI', '06');
INSERT INTO HANGHOA VALUES('006', 'I 8 SE', 'DVT NAME', 'XIAOMI', '06');
select * from HANGHOA

IF (SELECT object_id('MUA')) IS NOT NULL 
BEGIN
	DROP TABLE MUA
END;

CREATE TABLE MUA (
	NGAY_MUA SMALLDATETIME PRIMARY KEY 
	CHECK(NGAY_MUA <= GETDATE())
	DEFAULT GETDATE(),

	SOLG_MUA INT NOT NULL 
	CHECK(SOLG_MUA > 0),

	TRIGIA_MUA FLOAT NOT NULL 
	CHECK(TRIGIA_MUA > 0),

	STT_DL INT NOT NULL,
	MA_HANG NVARCHAR(3),

	CONSTRAINT FK_MUA_DAILY 
	FOREIGN KEY (STT_DL)
    REFERENCES DAILY(STT_DL)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

	CONSTRAINT FK_MUA_HANGHOA 
	FOREIGN KEY (MA_HANG)
    REFERENCES HANGHOA(MA_HANG)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
);

INSERT INTO MUA VALUES('10-10-2019', 4, 5000, 2, '002');
INSERT INTO MUA VALUES('10-1-2019', 2, 2500, 2, '002');
INSERT INTO MUA VALUES('10-2-2019', 1, 1000, 1, '003');
INSERT INTO MUA VALUES('10-3-2019', 1, 1000, 1, '003');
INSERT INTO MUA VALUES('10-7-2019', 1, 1000, 1, '002');
INSERT INTO MUA VALUES('10-4-2019', 1, 3000, 3, '001');
INSERT INTO MUA VALUES('10-5-2019', 1, 3000, 3, '001');

IF (SELECT object_id('BAN')) IS NOT NULL 
BEGIN
	DROP TABLE BAN
END;

CREATE TABLE BAN(
	NGAY_BAN SMALLDATETIME PRIMARY KEY 
	CHECK(NGAY_BAN <= GETDATE())
	DEFAULT GETDATE(),

	SOLG_BAN INT NOT NULL 
	CHECK(SOLG_BAN > 0),

	TRIGIA_BAN FLOAT NOT NULL 
	CHECK(TRIGIA_BAN > 0),

	STT_DL INT NOT NULL,
	MA_HANG NVARCHAR(3),

	CONSTRAINT FK_BAN_DAILY 
	FOREIGN KEY (STT_DL)
    REFERENCES DAILY(STT_DL)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

	CONSTRAINT FK_BAN_HANGHOA 
	FOREIGN KEY (MA_HANG)
    REFERENCES HANGHOA(MA_HANG)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
);

INSERT INTO BAN VALUES('10-11-2019', 3, 5000, 2, '002');
INSERT INTO BAN VALUES('10-11-2019', 1, 2500, 2, '002');
INSERT INTO BAN VALUES('10-12-2019', 1, 1000, 1, '003');
INSERT INTO BAN VALUES('10-4-2019', 1, 1000, 1, '003');
INSERT INTO BAN VALUES('10-5-2019', 1, 3000, 3, '001');
INSERT INTO BAN VALUES('10-6-2019', 1, 3000, 3, '001');