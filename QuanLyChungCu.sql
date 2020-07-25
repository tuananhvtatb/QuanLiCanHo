USE master
GO

-- Drop the database if it already exists
IF EXISTS ( SELECT name
                FROM sys.databases
                WHERE name = N'QuanLyChungCu' )
    DROP DATABASE QuanLyChungCu
GO

CREATE DATABASE QuanLyChungCu
GO

USE QuanLyChungCu
/*





*/
---------- Tables ----------

-- Account Table --
CREATE TABLE TAIKHOAN
    (
      TenTaiKhoan VARCHAR(25) CONSTRAINT pk_TAIKHOAN PRIMARY KEY ,
      MatKhau VARCHAR(16) NOT NULL ,
      VaiTro BIT NOT NULL
                 DEFAULT 0
    )
GO

-- Area Apartment Table
CREATE TABLE KHUCANHO
    (
      MaKhu CHAR(2) CONSTRAINT pk_KHUCANHO PRIMARY KEY ,
      TenKhu NVARCHAR(50) NOT NULL ,
      SoTang INT NOT NULL
                 DEFAULT 1 ,
      SoCanTT INT NOT NULL
                  DEFAULT 1 ,
      DiaChi NVARCHAR(100) NOT NULL,
	)

-- Resident Table --
CREATE TABLE CUDAN
    (
      MaCuDan CHAR(6) CONSTRAINT pk_CUDAN PRIMARY KEY ,
      TenCuDan NVARCHAR(50) NOT NULL ,
      NgaySinh DATE NOT NULL
                    DEFAULT GETDATE() ,
      GioiTinh BIT NOT NULL
                   DEFAULT 0 ,
      SoDT CHAR(10) NOT NULL ,
      SoCMT CHAR(12) NOT NULL ,
      QueQuan NVARCHAR(100) NOT NULL
    )
GO

-- Apartment Table --
CREATE TABLE CANHO
    (
      MaCanHo CHAR(6) CONSTRAINT pk_CANHO PRIMARY KEY ,
      DienTich FLOAT NOT NULL
                     DEFAULT 50 ,
      Gia BIGINT NOT NULL ,
      TrangThai BIT NOT NULL
                    DEFAULT 0 ,
      SoPhong INT NOT NULL
                  DEFAULT 5 ,
      MaCuDan CHAR(6)
        CONSTRAINT fk1_CANHO FOREIGN KEY REFERENCES dbo.CUDAN ( MaCuDan ) ,
      MaKhu CHAR(2)
        NOT NULL
        DEFAULT 'AA'
        CONSTRAINT fk2_CANHO
        FOREIGN KEY REFERENCES dbo.KHUCANHO ( MaKhu ) ON DELETE CASCADE
        ON UPDATE CASCADE --  (AA -> ZZ)
    )
GO

-- Contract Table --
CREATE TABLE HOPDONG
    (
      MaHopDong CHAR(12) NOT NULL
                         CONSTRAINT pk_HOPDONG PRIMARY KEY , -- HD0000000001
      NgayGiaoDich DATE NOT NULL
                        DEFAULT GETDATE() ,
      DiaChiKH NVARCHAR(100) NOT NULL ,
      MaCuDan CHAR(6)
        NOT NULL
        CONSTRAINT fk1_HOPDONG FOREIGN KEY REFERENCES dbo.CUDAN ( MaCuDan ) ,
      MaCanHo CHAR(6)
        NOT NULL
        CONSTRAINT fk2_HOPDONG
        FOREIGN KEY REFERENCES dbo.CANHO ( MaCanHo ) ON DELETE CASCADE
        ON UPDATE CASCADE,
		TenKH nvarchar(50) ,
    )
GO

-------- TaiKhoan ----------
INSERT [dbo].[TAIKHOAN] ([TenTaiKhoan], [MatKhau], [VaiTro]) VALUES (N'Admin', N'123456', 1)
INSERT [dbo].[TAIKHOAN] ([TenTaiKhoan], [MatKhau], [VaiTro]) VALUES (N'employee1', N'123456', 0)
INSERT [dbo].[TAIKHOAN] ([TenTaiKhoan], [MatKhau], [VaiTro]) VALUES (N'employee2', N'123456', 0)
GO

---------- KhuCanHo ----------
INSERT [dbo].[KHUCANHO] ([MaKhu], [TenKhu], [SoTang], [SoCanTT], [DiaChi]) VALUES (N'HM', N'HATECO Hoàng Mai', 25, 20, N'Hoàng Mai, Hà Nội')
INSERT [dbo].[KHUCANHO] ([MaKhu], [TenKhu], [SoTang], [SoCanTT], [DiaChi]) VALUES (N'DA', N'HATECO Đông Anh', 30, 25, N'Đông Anh, Hà Nội')
INSERT [dbo].[KHUCANHO] ([MaKhu], [TenKhu], [SoTang], [SoCanTT], [DiaChi]) VALUES (N'XP', N'HATECO Xuân Phương', 25, 20, N'Nam Từ Liêm, Hà Nội')
GO

---------- CuDan ----------
INSERT [dbo].[CUDAN] ([MaCuDan], [TenCuDan], [NgaySinh], [GioiTinh], [SoDT], [SoCMT], [QueQuan]) VALUES (N'111111', N'Mai Thành Công', CAST(N'1998-05-21' AS Date), 1, N'0123456789', N'012345678985', N'Yên Bái')
INSERT [dbo].[CUDAN] ([MaCuDan], [TenCuDan], [NgaySinh], [GioiTinh], [SoDT], [SoCMT], [QueQuan]) VALUES (N'111112', N'Park Ji Sung', CAST(N'1997-02-25' AS Date), 1, N'0123456789', N'012365897456', N'Korea')
INSERT [dbo].[CUDAN] ([MaCuDan], [TenCuDan], [NgaySinh], [GioiTinh], [SoDT], [SoCMT], [QueQuan]) VALUES (N'111113', N'Đời Còn Khổ', CAST(N'1991-02-28' AS Date), 1, N'0123658974', N'000256398745', N'Hà Nội')
GO

--------- CanHo ----------
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'HM1203', 46, 1400000000, 0, 4, NULL, N'HM')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'DA2102', 65.2, 1500000000, 0, 6, NULL, N'DA')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'XP0103', 50, 1200000000, 1, 5, N'111111', N'XP')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'XP2301', 50, 2000000000, 0, 4, NULL, N'XP')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'XP2502', 50, 2000000000, 0, 5, NULL, N'XP')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'DA2104', 70, 900000000, 0, 4, NULL, N'DA')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'DA2199', 45, 1400000000, 0, 6, NULL, N'DA')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'HM1244', 55, 1800000000, 0, 5, NULL, N'HM')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'HM1212', 100, 950000000, 0, 6, NULL, N'HM')
GO

---------- HopDong ----------
INSERT [dbo].[HOPDONG] ([MaHopDong], [NgayGiaoDich], [DiaChiKH], [MaCuDan], [MaCanHo]) VALUES (N'XP0103111110', CAST(N'2019-03-30' AS Date), N'Yên Bái', N'111111', N'XP0103')
INSERT [dbo].[HOPDONG] ([MaHopDong], [NgayGiaoDich], [DiaChiKH], [MaCuDan], [MaCanHo]) VALUES (N'XP2502111111', CAST(N'2020-04-03' AS Date), N'Korea', N'111112', N'XP2502')
INSERT [dbo].[HOPDONG] ([MaHopDong], [NgayGiaoDich], [DiaChiKH], [MaCuDan], [MaCanHo]) VALUES (N'XP2301111119', CAST(N'2019-05-07' AS Date), N'Hà Nội', N'111113', N'XP2301')
GO

---------- Views ----------

---------- Storage Procedure ----------

  USE QuanLyChungCu
  GO
  CREATE PROC [dbo].[searchApartmentWithCriterias]
    @trangthai BIT ,
    @tugia BIGINT ,
    @dengia BIGINT ,
    @tudt FLOAT ,
    @dendt FLOAT
  AS
    BEGIN
  -----
        IF ( @dendt = 0 AND @dengia = 0 ) -- dt > 50, gia > 2000000000
            SELECT c.MaCanHo, c.DienTich, c.Gia, c.TrangThai, c.SoPhong,
                    c.MaCuDan, k.TenKhu
                FROM [QuanLyChungCu].[dbo].[CANHO] c
                    JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                    ON k.MaKhu = c.MaKhu
                WHERE TrangThai = @trangthai AND Gia > @tugia AND DienTich > @tudt
        ELSE -- dt > 50, 0 <gia <= 2000000000
            IF ( @dendt = 0 AND ( ( @tugia = 0 AND @dengia = 1000000000 ) OR ( @tugia = 1000000000 AND @dengia = 2000000000 ) ) )
                SELECT c.MaCanHo, c.DienTich, c.Gia, c.TrangThai, c.SoPhong,
                        c.MaCuDan, k.TenKhu
                    FROM [QuanLyChungCu].[dbo].[CANHO] c
                        JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                        ON k.MaKhu = c.MaKhu
                    WHERE TrangThai = @trangthai AND Gia BETWEEN @tugia AND @dengia AND DienTich > @tudt
            ELSE -- 30 <= dt <= 50, gia > 2000000000
                IF ( @dengia = 0 AND ( ( @tudt = 30 AND @dendt = 40 ) OR ( @tudt = 40 AND @dendt = 50 ) ) )
                    SELECT c.MaCanHo, c.DienTich, c.Gia, c.TrangThai,
                            c.SoPhong, c.MaCuDan, k.TenKhu
                        FROM [QuanLyChungCu].[dbo].[CANHO] c
                            JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                            ON k.MaKhu = c.MaKhu
                        WHERE TrangThai = @trangthai AND Gia > @tugia AND DienTich BETWEEN @tudt AND @dendt
                ELSE --  30 <= dt <= 50 , 0 < gia <= 2000000000
                    SELECT c.MaCanHo, c.DienTich, c.Gia, c.TrangThai,
                            c.SoPhong, c.MaCuDan, k.TenKhu
                        FROM [QuanLyChungCu].[dbo].[CANHO] c
                            JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                            ON k.MaKhu = c.MaKhu
                        WHERE TrangThai = @trangthai AND Gia BETWEEN @tugia AND @dengia AND DienTich BETWEEN @tudt AND @dendt
  -----
    END

GO
SELECT * FROM  dbo.CANHO
EXEC dbo.searchApartmentWithCriterias 0,2000000000,0,40,50 -- 
GO 
CREATE PROC [dbo].[searchApartments]
    @tugia BIGINT ,
    @dengia BIGINT ,
    @tudt FLOAT ,
    @dendt FLOAT,
	@sophong INT
  AS
    BEGIN
  -----
        IF ( @dendt = 0 AND @dengia = 0 ) -- dt > 50, gia > 2000000000
            SELECT c.MaCanHo, c.DienTich, c.Gia, c.SoPhong, k.TenKhu
                FROM [QuanLyChungCu].[dbo].[CANHO] c
                    JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                    ON k.MaKhu = c.MaKhu
                WHERE TrangThai = 0 AND Gia > @tugia AND DienTich > @tudt AND SoPhong=@sophong
        ELSE -- dt > 50, 0 <gia <= 2000000000
            IF ( @dendt = 0 AND ( ( @tugia = 0 AND @dengia = 1000000000 ) OR ( @tugia = 1000000000 AND @dengia = 2000000000 ) ) )
                SELECT c.MaCanHo, c.DienTich, c.Gia, c.SoPhong, k.TenKhu
                    FROM [QuanLyChungCu].[dbo].[CANHO] c
                        JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                        ON k.MaKhu = c.MaKhu
                    WHERE Gia BETWEEN @tugia AND @dengia AND DienTich > @tudt AND SoPhong=@sophong
            ELSE -- 30 <= dt <= 50, gia > 2000000000
                IF ( @dengia = 0 AND ( ( @tudt = 30 AND @dendt = 40 ) OR ( @tudt = 40 AND @dendt = 50 ) ) )
                    SELECT c.MaCanHo, c.DienTich, c.Gia, c.SoPhong, k.TenKhu
                        FROM [QuanLyChungCu].[dbo].[CANHO] c
                            JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                            ON k.MaKhu = c.MaKhu
                        WHERE Gia > @tugia AND DienTich BETWEEN @tudt AND @dendt AND SoPhong=@sophong
                ELSE --  30 <= dt <= 50 , 0 < gia <= 2000000000
                    SELECT c.MaCanHo, c.DienTich, c.Gia, c.SoPhong, k.TenKhu
                        FROM [QuanLyChungCu].[dbo].[CANHO] c
                            JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                            ON k.MaKhu = c.MaKhu
                        WHERE  Gia BETWEEN @tugia AND @dengia AND DienTich BETWEEN @tudt AND @dendt AND SoPhong=@sophong
  -----
    END
GO
EXEC [dbo].[searchApartments] 1000000000,2000000000,40,50,4
GO
---------- Funtions ----------

---------- Triggers ----------

---------- Write Select, Insert, Update, Delete Alter below!  -----------
SELECT * FROM HOPDONG
SELECT * FROM CANHO
SELECT * FROM KHUCANHO
SELECT * FROM CUDAN
SELECT * FROM TAIKHOAN