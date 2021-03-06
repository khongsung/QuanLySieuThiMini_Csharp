USE [master]
GO
/****** Object:  Database [QuanLyBanHangSieuThiMini]    Script Date: 21-Jul-2018 9:07:28 PM ******/
CREATE DATABASE [QuanLyBanHangSieuThiMini]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyBanHangSieuThiMini', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLyBanHangSieuThiMini.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyBanHangSieuThiMini_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLyBanHangSieuThiMini_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyBanHangSieuThiMini].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QuanLyBanHangSieuThiMini]
GO
/****** Object:  StoredProcedure [dbo].[sp_insertChitietnhaphang]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_insertChitietnhaphang]
	@gia float,
	@mahang int,
	@sl int
as 
	declare @mahd int
	begin 
		set @mahd = (SELECT MAX(PK_iMahoadonnhapID) FROM tblHoaDonNhap)
		insert into tblChiTietNhap(FK_iMahoadonnhapID,FK_iMathangID,iSoluong,dGianhap) values(@mahd, @mahang, @sl, @gia)
		update tblMatHang set iSoluong += @sl where PK_iMamathangID = @mahang
	end
return 0

GO
/****** Object:  StoredProcedure [dbo].[sp_insertNhaphang]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_insertNhaphang]
	@mancc int,
	@manv int
as 
	begin 
		insert into tblHoaDonNhap( FK_iManhacungcapID, FK_iManhanvienID, dNgaythang) values(@mancc, @manv, GETDATE() )
	end
return 0

GO
/****** Object:  StoredProcedure [dbo].[sp_tblBanhang_insert]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblBanhang_insert]
	@mamh varchar(50),
	@sl int,
	@giaban float
	as
		declare @mahdb int
		begin
			set @mahdb = (select max(PK_iMahoadonbanID) from tblHoaDonBan)
			insert into tblChiTietBan (FK_iMahoadonbanID, FK_iMamathangID, iSoluong, dGiaban) values (@mahdb, @mamh, @sl, @giaban)
		end

GO
/****** Object:  StoredProcedure [dbo].[sp_tblBanhang_insertHD]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblBanhang_insertHD]
	@manv int
	as 
		insert into tblHoaDonBan(FK_iManhanvienID,dNgaythang) values (@manv, GETDATE())

GO
/****** Object:  StoredProcedure [dbo].[sp_tblChiTietBan_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblChiTietBan_getData]
as
	select tblMatHang.dGiaban, tblMatHang.sTenhang, sMavach, tblChiTietBan.iSoluong, sDonvitinh, (tblChiTietBan.iSoluong*tblMatHang.dGiaban) as sThanhTien
	from tblHoaDonBan right join tblChiTietBan on tblHoaDonBan.PK_iMahoadonbanID = tblChiTietBan.FK_iMahoadonbanID
		left join tblMatHang on tblChiTietBan.FK_iMamathangID = tblMatHang.PK_iMamathangID
	where tblChiTietBan.FK_iMahoadonbanID = tblHoaDonBan.PK_iMahoadonbanID
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblChiTietBan_getDataByHoaDon]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblChiTietBan_getDataByHoaDon]
	@mahoadon int
as
	select tblMatHang.dGiaban, tblMatHang.sTenhang, sMavach, tblChiTietBan.iSoluong, sDonvitinh, (tblChiTietBan.iSoluong*tblMatHang.dGiaban) as sThanhTien
	from tblHoaDonBan right join tblChiTietBan on tblHoaDonBan.PK_iMahoadonbanID = tblChiTietBan.FK_iMahoadonbanID
		left join tblMatHang on tblChiTietBan.FK_iMamathangID = tblMatHang.PK_iMamathangID
	where tblChiTietBan.FK_iMahoadonbanID = @mahoadon
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblChiTietNhap_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_tblChiTietNhap_getData]
as
	select mh.sMavach, mh.sTenhang, ctn.dGianhap, ctn.iSoluong, mh.sDonvitinh,(ctn.iSoluong*ctn.dGianhap) as sThanhTien
	from tblChiTietNhap as ctn, tblMatHang as mh
	where  ctn.FK_iMathangID = mh.PK_iMamathangID

GO
/****** Object:  StoredProcedure [dbo].[sp_tblChiTietNhap_getDataByHoaDon]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblChiTietNhap_getDataByHoaDon]
 @mahd int
as
	select mh.sMavach, mh.sTenhang, ctn.dGianhap, ctn.iSoluong, (ctn.iSoluong*ctn.dGianhap) as sThanhTien
	from tblChiTietNhap as ctn, tblMatHang as mh
	where  ctn.FK_iMathangID = mh.PK_iMamathangID and ctn.FK_iMahoadonnhapID = @mahd

GO
/****** Object:  StoredProcedure [dbo].[sp_tblChiTietNhap_insertData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblChiTietNhap_insertData]
	@gia float,
	@mahang int,
	@sl int
as 
	declare @mahd int
	begin 
		set @mahd = (SELECT MAX(PK_iMahoadonnhapID) FROM tblHoaDonNhap)
		insert into tblChiTietNhap(FK_iMahoadonnhapID,FK_iMathangID,iSoluong,dGianhap) values(@mahd, @mahang, @sl, @gia)
	end
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHangHong_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_tblHangHong_getData]
as
	select tblMatHang.sMavach, tblMatHang.sTenhang, tblHangHong.iSoluong, dNgaythang, sMota 
	from tblHangHong left join tblMatHang on tblHangHong.FK_iMamathangID = tblMatHang.PK_iMamathangID
return
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHanghong_insertData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblHanghong_insertData]
	@mamathang nvarchar(50),
	@mota nvarchar(50),
	@ngaylap date,
	@soluong int
as
	insert into tblHangHong values(@mamathang, @soluong, @ngaylap, @mota)
return;
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHangHong_searchData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_tblHangHong_searchData]
	@search nvarchar(50)
as
	select tblMatHang.sMavach, tblMatHang.sTenhang, tblHangHong.iSoluong, dNgaythang, sMota 
	from tblHangHong left join tblMatHang on tblHangHong.FK_iMamathangID = tblMatHang.PK_iMamathangID
	where sTenhang like '%'+@search+'%'
return
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHoaDonBan_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_tblHoaDonBan_getData]
as
	select PK_iMahoadonbanID, tblNhanVien.sHoten, tblHoaDonBan.dNgaythang, SUM(tblChiTietBan.dGiaban*tblChiTietBan.iSoluong) as sThanhtien
	from tblNhanVien right join tblHoaDonBan on PK_iManhanvienID = FK_iManhanvienID
		left join tblChiTietBan on tblHoaDonBan.PK_iMahoadonbanID = tblChiTietBan.FK_iMahoadonbanID
	group by PK_iMahoadonbanID,tblNhanVien.sHoten, tblHoaDonBan.dNgaythang
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHoaDonBan_searchDataByNgayLap]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblHoaDonBan_searchDataByNgayLap]
	@ngaybatdau nvarchar(50),
	@ngayketthuc nvarchar(50)
as
	select PK_iMahoadonbanID, tblNhanVien.sHoten, tblHoaDonBan.dNgaythang, SUM(tblChiTietBan.dGiaban*tblChiTietBan.iSoluong) as sThanhtien
	from tblNhanVien right join tblHoaDonBan on PK_iManhanvienID = FK_iManhanvienID
		left join tblChiTietBan on tblHoaDonBan.PK_iMahoadonbanID = tblChiTietBan.FK_iMahoadonbanID
	where tblHoaDonBan.dNgaythang between CONVERT(date,@ngaybatdau,103) and CONVERT(date,@ngayketthuc,103)
	group by PK_iMahoadonbanID,tblNhanVien.sHoten, tblHoaDonBan.dNgaythang
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHoaDonBan_searchDataByTenANDNgayLap]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblHoaDonBan_searchDataByTenANDNgayLap]
	@ngaybatdau nvarchar(50),
	@ngayketthuc nvarchar(50),
	@manv int
as
	select PK_iMahoadonbanID, tblNhanVien.sHoten, tblHoaDonBan.dNgaythang, SUM(tblChiTietBan.dGiaban*tblChiTietBan.iSoluong) as sThanhtien
	from tblNhanVien right join tblHoaDonBan on PK_iManhanvienID = FK_iManhanvienID
		left join tblChiTietBan on tblHoaDonBan.PK_iMahoadonbanID = tblChiTietBan.FK_iMahoadonbanID
	where tblHoaDonBan.dNgaythang between CONVERT(date,@ngaybatdau,103) and CONVERT(date,@ngayketthuc,103) and tblHoaDonBan.FK_iManhanvienID = @manv
	group by PK_iMahoadonbanID,tblNhanVien.sHoten, tblHoaDonBan.dNgaythang
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHoaDonBan_searchDataByTenNV]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblHoaDonBan_searchDataByTenNV]
	@manv nvarchar(50)
as
	select PK_iMahoadonbanID, tblNhanVien.sHoten, tblHoaDonBan.dNgaythang, SUM(tblChiTietBan.dGiaban*tblChiTietBan.iSoluong) as sThanhtien
	from tblNhanVien right join tblHoaDonBan on PK_iManhanvienID = FK_iManhanvienID
		left join tblChiTietBan on tblHoaDonBan.PK_iMahoadonbanID = tblChiTietBan.FK_iMahoadonbanID
	where tblHoaDonBan.FK_iManhanvienID = @manv
	group by PK_iMahoadonbanID,tblNhanVien.sHoten, tblHoaDonBan.dNgaythang
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHoaDonNhap_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_tblHoaDonNhap_getData]
as
	select hd.PK_iMahoadonnhapID, ncc.sTennhacungcap, nv.sHoten, hd.dNgaythang, SUM(ctn.iSoluong*ctn.dGianhap) as sThanhTien
	from tblHoaDonNhap as hd, tblNhaCungCap as ncc,tblNhanVien as nv, tblChiTietNhap as ctn
	where hd.FK_iManhacungcapID = ncc.PK_iManhacungcapID and nv.PK_iManhanvienID = hd.FK_iManhanvienID and hd.PK_iMahoadonnhapID = ctn.FK_iMahoadonnhapID
	group by hd.PK_iMahoadonnhapID, ncc.sTennhacungcap, nv.sHoten, hd.dNgaythang
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHoaDonNhap_searchDataByNgayLap]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_tblHoaDonNhap_searchDataByNgayLap]

	@ngaybatdau nvarchar(50),
	@ngayketthuc nvarchar(50)
as
	select hd.PK_iMahoadonnhapID, ncc.sTennhacungcap, nv.sHoten, hd.dNgaythang, SUM(ctn.iSoluong*ctn.dGianhap) as sThanhTien
	from tblHoaDonNhap as hd, tblNhaCungCap as ncc,tblNhanVien as nv, tblChiTietNhap as ctn
	where hd.FK_iManhacungcapID = ncc.PK_iManhacungcapID 
			and nv.PK_iManhanvienID = hd.FK_iManhanvienID 
			and hd.PK_iMahoadonnhapID = ctn.FK_iMahoadonnhapID 
			and hd.dNgaythang between CONVERT(date,@ngaybatdau,103) and CONVERT(date,@ngayketthuc,103)
	group by hd.PK_iMahoadonnhapID, ncc.sTennhacungcap, nv.sHoten, hd.dNgaythang
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHoaDonNhap_searchDataByTenANDNgayLap]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblHoaDonNhap_searchDataByTenANDNgayLap]
	@manv int,
	@ngaybatdau nvarchar(50),
	@ngayketthuc nvarchar(50)
as
	select hd.PK_iMahoadonnhapID, ncc.sTennhacungcap, nv.sHoten, hd.dNgaythang, SUM(ctn.iSoluong*ctn.dGianhap) as sThanhTien
	from tblHoaDonNhap as hd, tblNhaCungCap as ncc,tblNhanVien as nv, tblChiTietNhap as ctn
	where hd.FK_iManhacungcapID = ncc.PK_iManhacungcapID 
			and nv.PK_iManhanvienID = hd.FK_iManhanvienID 
			and hd.PK_iMahoadonnhapID = ctn.FK_iMahoadonnhapID 
			and hd.dNgaythang between CONVERT(date,@ngaybatdau,103) and CONVERT(date,@ngayketthuc,103)
			and hd.FK_iManhanvienID = @manv
	group by hd.PK_iMahoadonnhapID, ncc.sTennhacungcap, nv.sHoten, hd.dNgaythang
GO
/****** Object:  StoredProcedure [dbo].[sp_tblHoaDonNhap_searchDataByTenNV]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblHoaDonNhap_searchDataByTenNV]
	@manv int
as
	select hd.PK_iMahoadonnhapID, ncc.sTennhacungcap, nv.sHoten, hd.dNgaythang, SUM(ctn.iSoluong*ctn.dGianhap) as sThanhTien
	from tblHoaDonNhap as hd, tblNhaCungCap as ncc,tblNhanVien as nv, tblChiTietNhap as ctn
	where hd.FK_iManhacungcapID = ncc.PK_iManhacungcapID 
			and nv.PK_iManhanvienID = hd.FK_iManhanvienID 
			and hd.PK_iMahoadonnhapID = ctn.FK_iMahoadonnhapID 
			and hd.FK_iManhanvienID = @manv
	group by hd.PK_iMahoadonnhapID, ncc.sTennhacungcap, nv.sHoten, hd.dNgaythang
GO
/****** Object:  StoredProcedure [dbo].[sp_tblLoaiHang_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblLoaiHang_getData]
as
	Select * from tblLoaiHang
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblLoaiHang_insertData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblLoaiHang_insertData]
	@tenloaihang nvarchar(50)
as
	insert into tblLoaiHang(sTenloaihang) values(@tenloaihang)
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblLoaiHang_searchData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblLoaiHang_searchData]
	@search nvarchar(50)
as
	Select * from tblLoaiHang where sTenloaihang like '%'+@search+'%'
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblLoaiHang_updateDataById]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblLoaiHang_updateDataById]
	@ma nvarchar(50),
	@ten nvarchar(50)
as
	update tblLoaiHang set sTenloaihang = @ten
	where PK_iMaloaihangID = @ma
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblMatHang_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_tblMatHang_getData]
as
select PK_iMamathangID, tblLoaiHang.sTenloaihang as loaihang, sTenhang, dGiaban, iSoluong, sDonvitinh, sMavach
from tblMatHang left join tblLoaiHang on tblLoaiHang.PK_iMaloaihangID = tblMatHang.FK_iMaloaihangID
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblMatHang_getDataByLoaiHang]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblMatHang_getDataByLoaiHang]
	@maloai nvarchar(50)
as
select PK_iMamathangID, tblLoaiHang.sTenloaihang as loaihang, sTenhang, dGiaban, iSoluong, sDonvitinh, sMavach
from tblMatHang left join tblLoaiHang on tblLoaiHang.PK_iMaloaihangID = tblMatHang.FK_iMaloaihangID
where tblMatHang.FK_iMaloaihangID = @maloai
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblMatHang_getDataByMaVach]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblMatHang_getDataByMaVach]
	@mavach nvarchar(50)
as
	select * from tblMatHang where sMavach = @mavach
return
GO
/****** Object:  StoredProcedure [dbo].[sp_tblMatHang_insertData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblMatHang_insertData]
	@maloai int,
	@tenhang nvarchar(50),
	@giaban decimal,
	@soluong int,
	@donvitinh nvarchar(50),
	@mavach nvarchar(50)
as
	insert into tblMatHang values(@maloai,
								  @tenhang,
								  @giaban,
								  @soluong,
								  @donvitinh,
								  @mavach)
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblMatHang_searchData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblMatHang_searchData]
	@search nvarchar(50)
as
select PK_iMamathangID, tblLoaiHang.sTenloaihang as loaihang, sTenhang, dGiaban, iSoluong, sDonvitinh, sMavach
from tblMatHang left join tblLoaiHang on tblLoaiHang.PK_iMaloaihangID = tblMatHang.FK_iMaloaihangID
where tblMatHang.sTenhang like '%'+@search+'%' or tblMatHang.sMavach like '%'+@search+'%'
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblMatHang_updateData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblMatHang_updateData]
	@mahang int,
	@maloai int,
	@tenhang nvarchar(50),
	@giaban decimal,
	@soluong int,
	@donvitinh nvarchar(50),
	@mavach nvarchar(50)
as
	Update tblMatHang set FK_iMaloaihangID = @maloai,
								 sTenhang = @tenhang,
								 dGiaban = @giaban,
								 iSoluong = @soluong,
								 sDonvitinh = @donvitinh,
								 sMavach = @mavach
							where PK_iMamathangID = @mahang
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblMatHang_updateDataById]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblMatHang_updateDataById]
	@ma nvarchar(50),
	@malh int,
	@ten nvarchar(50),
	@dvt nvarchar(50),
	@sl int,
	@mavach varchar(50),
	@gia decimal(18,0) 

as
	update tblMatHang set sTenhang = @ten,  FK_iMaloaihangID = @malh , iSoluong = @sl, dGiaban = @gia,  sDonvitinh = @dvt, sMavach = @mavach
	where PK_iMamathangID = @ma
return 0

GO
/****** Object:  StoredProcedure [dbo].[sp_tblMatHang_updateSL]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblMatHang_updateSL]
	@ma nvarchar(50),
	@sl int

as
	update tblMatHang set  iSoluong = @sl
	where PK_iMamathangID = @ma
return 0

GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhaCungCap_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhaCungCap_getData]
as
	select * from tblNhaCungCap
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhaCungCap_insertData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhaCungCap_insertData]
	@ten nvarchar(50),
	@sdt nvarchar(50),
	@diachi nvarchar(50)
as
	insert into tblNhaCungCap values (@ten, @sdt, @diachi)
return 0;
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhaCungCap_searchData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhaCungCap_searchData]
	@search nvarchar(50)
as
	select * from tblNhaCungCap
	where sTennhacungcap like '%'+@search+'%' or
		  sDiachi like '%'+@search+'%' or
		  sSDT like '%'+@search+'%'
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhaCungCap_updateData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhaCungCap_updateData]
	@ma nvarchar(50),
	@ten nvarchar(50),
	@sdt nvarchar(50),
	@diachi nvarchar(50)
as
	update tblNhaCungCap set sTennhacungcap = @ten, 
							 sSDT = @sdt,
							 sDiachi = @diachi
						where PK_iManhacungcapID = @ma
return 0;
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhanVien_getData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_tblNhanVien_getData]
as
	select PK_iManhanvienID, sHoten, dNgaysinh, case bGioitinh when 'true' then 'Nam' else N'Nữ' end as bGioitinh, 
		   sSDT, sEmail, sDiachi, sUser, sPass, case bQuyen when 'true' then 'Admin' else N'Nhân viên' end as sQuyen
	from tblNhanVien;
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhanVien_getDataByUser]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhanVien_getDataByUser]
	@username nvarchar(50)
as
	Select * from tblNhanVien where sUser = @username
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhanVien_getDataByUserAndPass]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhanVien_getDataByUserAndPass]
	@username nvarchar(50),
	@password nvarchar(50)
as
	Select * from tblNhanVien where sUser = @username and sPass = @password
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhanVien_insertData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhanVien_insertData]
	@hoten nvarchar(50),
	@ngaysinh nvarchar(50),
	@gioitinh bit,
	@sdt nvarchar(50),
	@email nvarchar(50),
	@diachi nvarchar(50),
	@user nvarchar(50),
	@pass nvarchar(50),
	@quyen bit
as
	insert into tblNhanVien values(@hoten,CONVERT(date, @ngaysinh,103), @gioitinh, @sdt, @email, @diachi, @user, @pass, @quyen)
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhanVien_searchData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhanVien_searchData]
	@search nvarchar(50)
as
	select PK_iManhanvienID, sHoten, dNgaysinh, case bGioitinh when 'true' then 'Nam' else N'Nữ' end as bGioitinh, 
		   sSDT, sEmail, sDiachi, sUser, sPass, case bQuyen when 'true' then 'Admin' else N'Nhân viên' end as sQuyen
	from tblNhanVien
	where sHoten like '%'+@search+'%' or
		  sDiachi like '%'+@search+'%' or
		  sUser like '%'+@search+'%'
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhanVien_updateData]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhanVien_updateData]
	@ma nvarchar(50),
	@hoten nvarchar(50),
	@ngaysinh nvarchar(50),
	@gioitinh bit,
	@sdt nvarchar(50),
	@email nvarchar(50),
	@diachi nvarchar(50),
	@user nvarchar(50),
	@pass nvarchar(50),
	@quyen bit
as
	Update tblNhanVien set sHoten=@hoten, 
							dNgaysinh = CONVERT(date, @ngaysinh,103), 
							bGioitinh = @gioitinh, 
							sSDT = @sdt,
							sEmail = @email, 
							sDiachi = @diachi,
							sUser = @user,
							sPass = @pass,
							bQuyen = @quyen
			where PK_iManhanvienID = @ma
return 0
GO
/****** Object:  StoredProcedure [dbo].[sp_tblNhanVien_updatePass]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tblNhanVien_updatePass]
	@username nvarchar(50),
	@password nvarchar(50)
as
	update tblNhanVien set sPass = @password where sUser = @username 
return 0
GO
/****** Object:  Table [dbo].[tblChiTietBan]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChiTietBan](
	[FK_iMahoadonbanID] [int] NOT NULL,
	[FK_iMamathangID] [int] NOT NULL,
	[iSoluong] [int] NOT NULL,
	[dGiaban] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_tblChiTietBan_1] PRIMARY KEY CLUSTERED 
(
	[FK_iMahoadonbanID] ASC,
	[FK_iMamathangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblChiTietNhap]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChiTietNhap](
	[FK_iMahoadonnhapID] [int] NOT NULL,
	[FK_iMathangID] [int] NOT NULL,
	[iSoluong] [int] NOT NULL,
	[dGianhap] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_tblChiTietNhap_1] PRIMARY KEY CLUSTERED 
(
	[FK_iMahoadonnhapID] ASC,
	[FK_iMathangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblGiamGia]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGiamGia](
	[PK_iMagiamgiaID] [int] IDENTITY(1,1) NOT NULL,
	[FK_iMamathangID] [int] NOT NULL,
	[iTilegiam] [int] NOT NULL,
	[dNgaybatdau] [datetime] NULL,
	[dNgayketthuc] [datetime] NULL,
 CONSTRAINT [PK_tblGiamGia] PRIMARY KEY CLUSTERED 
(
	[PK_iMagiamgiaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHangHong]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHangHong](
	[PK_iMahanghongID] [int] IDENTITY(1,1) NOT NULL,
	[FK_iMamathangID] [int] NOT NULL,
	[iSoluong] [int] NOT NULL,
	[dNgaythang] [date] NOT NULL,
	[sMota] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblhangHong] PRIMARY KEY CLUSTERED 
(
	[PK_iMahanghongID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHoaDonBan]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHoaDonBan](
	[PK_iMahoadonbanID] [int] IDENTITY(1,1) NOT NULL,
	[FK_iManhanvienID] [int] NOT NULL,
	[dNgaythang] [datetime] NOT NULL,
 CONSTRAINT [PK_tblHoaDonBan_1] PRIMARY KEY CLUSTERED 
(
	[PK_iMahoadonbanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHoaDonNhap]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHoaDonNhap](
	[PK_iMahoadonnhapID] [int] IDENTITY(1,1) NOT NULL,
	[FK_iManhacungcapID] [int] NOT NULL,
	[FK_iManhanvienID] [int] NOT NULL,
	[dNgaythang] [date] NOT NULL,
 CONSTRAINT [PK_tblHoaDonNhap] PRIMARY KEY CLUSTERED 
(
	[PK_iMahoadonnhapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLoaiHang]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLoaiHang](
	[PK_iMaloaihangID] [int] IDENTITY(1,1) NOT NULL,
	[sTenloaihang] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblLoaiHang] PRIMARY KEY CLUSTERED 
(
	[PK_iMaloaihangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMatHang]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblMatHang](
	[PK_iMamathangID] [int] IDENTITY(1,1) NOT NULL,
	[FK_iMaloaihangID] [int] NOT NULL,
	[sTenhang] [nvarchar](100) NOT NULL,
	[dGiaban] [decimal](18, 0) NOT NULL,
	[iSoluong] [int] NOT NULL,
	[sDonvitinh] [nvarchar](20) NOT NULL,
	[sMavach] [varchar](20) NOT NULL,
 CONSTRAINT [PK_tblMatHang] PRIMARY KEY CLUSTERED 
(
	[PK_iMamathangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblNhaCungCap]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblNhaCungCap](
	[PK_iManhacungcapID] [int] IDENTITY(1,1) NOT NULL,
	[sTennhacungcap] [nvarchar](100) NOT NULL,
	[sSDT] [varchar](20) NULL,
	[sDiachi] [nvarchar](250) NULL,
 CONSTRAINT [PK_tblNhaCungCap] PRIMARY KEY CLUSTERED 
(
	[PK_iManhacungcapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblNhanVien]    Script Date: 21-Jul-2018 9:07:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblNhanVien](
	[PK_iManhanvienID] [int] IDENTITY(1,1) NOT NULL,
	[sHoten] [nvarchar](50) NOT NULL,
	[dNgaysinh] [date] NULL,
	[bGioitinh] [bit] NULL,
	[sSDT] [varchar](20) NULL,
	[sEmail] [varchar](50) NULL,
	[sDiachi] [nvarchar](250) NULL,
	[sUser] [varchar](30) NOT NULL,
	[sPass] [varchar](30) NOT NULL,
	[bQuyen] [bit] NOT NULL,
 CONSTRAINT [PK_tblNhanVien] PRIMARY KEY CLUSTERED 
(
	[PK_iManhanvienID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (1, 1, 2, CAST(200 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (1, 6, 2, CAST(18 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (2, 2, 1, CAST(25 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (2, 5, 2, CAST(45 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (3, 1, 3, CAST(200 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (3, 2, 10, CAST(25 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (4, 1, 5, CAST(200 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (5, 1, 10, CAST(200 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (6, 6, 101, CAST(18 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (7, 3, 90, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (8, 5, 50, CAST(45 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (11, 1, 1, CAST(200 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (12, 1, 2, CAST(200 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietBan] ([FK_iMahoadonbanID], [FK_iMamathangID], [iSoluong], [dGiaban]) VALUES (12, 5, 1, CAST(45 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (3, 1, 20, CAST(200 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (4, 2, 10, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (5, 3, 100, CAST(3 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (6, 1, 10, CAST(180 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (6, 5, 50, CAST(40 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (7, 6, 100, CAST(15 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (8, 1, 10, CAST(180 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (8, 2, 10, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[tblChiTietNhap] ([FK_iMahoadonnhapID], [FK_iMathangID], [iSoluong], [dGianhap]) VALUES (8, 4, 10, CAST(15 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[tblHangHong] ON 

INSERT [dbo].[tblHangHong] ([PK_iMahanghongID], [FK_iMamathangID], [iSoluong], [dNgaythang], [sMota]) VALUES (6, 3, 10, CAST(0x7B3E0B00 AS Date), N'bị rách')
INSERT [dbo].[tblHangHong] ([PK_iMahanghongID], [FK_iMamathangID], [iSoluong], [dNgaythang], [sMota]) VALUES (7, 6, 5, CAST(0x7B3E0B00 AS Date), N'bị bật nắp')
INSERT [dbo].[tblHangHong] ([PK_iMahanghongID], [FK_iMamathangID], [iSoluong], [dNgaythang], [sMota]) VALUES (8, 1, 1, CAST(0x7E3E0B00 AS Date), N'thiu')
INSERT [dbo].[tblHangHong] ([PK_iMahanghongID], [FK_iMamathangID], [iSoluong], [dNgaythang], [sMota]) VALUES (9, 5, 1, CAST(0x7E3E0B00 AS Date), N'rách túi')
SET IDENTITY_INSERT [dbo].[tblHangHong] OFF
SET IDENTITY_INSERT [dbo].[tblHoaDonBan] ON 

INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (1, 1, CAST(0x0000A91E00000000 AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (2, 2, CAST(0x0000A91F00000000 AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (3, 1, CAST(0x0000A923018AF652 AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (4, 2, CAST(0x0000A92400024D04 AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (5, 5, CAST(0x0000A9240004BA6D AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (6, 1, CAST(0x0000A92400053EF7 AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (7, 1, CAST(0x0000A9240005D020 AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (8, 1, CAST(0x0000A924000602FC AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (9, 1, CAST(0x0000A92401591DC8 AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (10, 1, CAST(0x0000A9240159AEDD AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (11, 1, CAST(0x0000A924015A7040 AS DateTime))
INSERT [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID], [FK_iManhanvienID], [dNgaythang]) VALUES (12, 1, CAST(0x0000A924015B0A2F AS DateTime))
SET IDENTITY_INSERT [dbo].[tblHoaDonBan] OFF
SET IDENTITY_INSERT [dbo].[tblHoaDonNhap] ON 

INSERT [dbo].[tblHoaDonNhap] ([PK_iMahoadonnhapID], [FK_iManhacungcapID], [FK_iManhanvienID], [dNgaythang]) VALUES (3, 1, 1, CAST(0x793E0B00 AS Date))
INSERT [dbo].[tblHoaDonNhap] ([PK_iMahoadonnhapID], [FK_iManhacungcapID], [FK_iManhanvienID], [dNgaythang]) VALUES (4, 3, 1, CAST(0x7D3E0B00 AS Date))
INSERT [dbo].[tblHoaDonNhap] ([PK_iMahoadonnhapID], [FK_iManhacungcapID], [FK_iManhanvienID], [dNgaythang]) VALUES (5, 2, 1, CAST(0x7D3E0B00 AS Date))
INSERT [dbo].[tblHoaDonNhap] ([PK_iMahoadonnhapID], [FK_iManhacungcapID], [FK_iManhanvienID], [dNgaythang]) VALUES (6, 2, 1, CAST(0x7E3E0B00 AS Date))
INSERT [dbo].[tblHoaDonNhap] ([PK_iMahoadonnhapID], [FK_iManhacungcapID], [FK_iManhanvienID], [dNgaythang]) VALUES (7, 4, 1, CAST(0x7E3E0B00 AS Date))
INSERT [dbo].[tblHoaDonNhap] ([PK_iMahoadonnhapID], [FK_iManhacungcapID], [FK_iManhanvienID], [dNgaythang]) VALUES (8, 2, 1, CAST(0x7E3E0B00 AS Date))
SET IDENTITY_INSERT [dbo].[tblHoaDonNhap] OFF
SET IDENTITY_INSERT [dbo].[tblLoaiHang] ON 

INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (9, N'Đồ ăn vặt')
INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (6, N'Đồ uống có cồn')
INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (5, N'Gia vị')
INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (3, N'Hóa chất')
INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (7, N'Nước ngọt')
INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (8, N'Quần áo')
INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (2, N'Sách Vở')
INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (4, N'Thau chậu')
INSERT [dbo].[tblLoaiHang] ([PK_iMaloaihangID], [sTenloaihang]) VALUES (1, N'Thực Phẩm')
SET IDENTITY_INSERT [dbo].[tblLoaiHang] OFF
SET IDENTITY_INSERT [dbo].[tblMatHang] ON 

INSERT [dbo].[tblMatHang] ([PK_iMamathangID], [FK_iMaloaihangID], [sTenhang], [dGiaban], [iSoluong], [sDonvitinh], [sMavach]) VALUES (1, 1, N'Thịt bò', CAST(200 AS Decimal(18, 0)), 27, N'kg', N'1234567891234')
INSERT [dbo].[tblMatHang] ([PK_iMamathangID], [FK_iMaloaihangID], [sTenhang], [dGiaban], [iSoluong], [sDonvitinh], [sMavach]) VALUES (2, 6, N'Riệu gạo', CAST(25 AS Decimal(18, 0)), 30, N'chai', N'1236546541233')
INSERT [dbo].[tblMatHang] ([PK_iMamathangID], [FK_iMaloaihangID], [sTenhang], [dGiaban], [iSoluong], [sDonvitinh], [sMavach]) VALUES (3, 9, N'Bim Bim OMI', CAST(5 AS Decimal(18, 0)), 100, N'gói', N'1234567897894')
INSERT [dbo].[tblMatHang] ([PK_iMamathangID], [FK_iMaloaihangID], [sTenhang], [dGiaban], [iSoluong], [sDonvitinh], [sMavach]) VALUES (4, 5, N'Nức mắm Nam ngư', CAST(22 AS Decimal(18, 0)), 30, N'chai', N'1231233211')
INSERT [dbo].[tblMatHang] ([PK_iMamathangID], [FK_iMaloaihangID], [sTenhang], [dGiaban], [iSoluong], [sDonvitinh], [sMavach]) VALUES (5, 9, N'Mít Sấy (300gm)', CAST(45 AS Decimal(18, 0)), 98, N'túi', N'8931245678933')
INSERT [dbo].[tblMatHang] ([PK_iMamathangID], [FK_iMaloaihangID], [sTenhang], [dGiaban], [iSoluong], [sDonvitinh], [sMavach]) VALUES (6, 7, N'Cocacola (350ml)', CAST(18 AS Decimal(18, 0)), 94, N'chai', N'8936558475783')
SET IDENTITY_INSERT [dbo].[tblMatHang] OFF
SET IDENTITY_INSERT [dbo].[tblNhaCungCap] ON 

INSERT [dbo].[tblNhaCungCap] ([PK_iManhacungcapID], [sTennhacungcap], [sSDT], [sDiachi]) VALUES (1, N'Hải Anh', N'0123456789', N'Hà Nội')
INSERT [dbo].[tblNhaCungCap] ([PK_iManhacungcapID], [sTennhacungcap], [sSDT], [sDiachi]) VALUES (2, N'Tuấn Hòa', N'123456023', N'Bắc Ninh')
INSERT [dbo].[tblNhaCungCap] ([PK_iManhacungcapID], [sTennhacungcap], [sSDT], [sDiachi]) VALUES (3, N'Phạm Hoa', N'123456', N'Bắc Giang')
INSERT [dbo].[tblNhaCungCap] ([PK_iManhacungcapID], [sTennhacungcap], [sSDT], [sDiachi]) VALUES (4, N'Thu Minh', N'123456', N'Hà nội')
SET IDENTITY_INSERT [dbo].[tblNhaCungCap] OFF
SET IDENTITY_INSERT [dbo].[tblNhanVien] ON 

INSERT [dbo].[tblNhanVien] ([PK_iManhanvienID], [sHoten], [dNgaysinh], [bGioitinh], [sSDT], [sEmail], [sDiachi], [sUser], [sPass], [bQuyen]) VALUES (1, N'Khổng Sứng', CAST(0xCD200B00 AS Date), 1, N'0123456789', N'khongsung', N'Bắc Giang', N'khongsung', N'123', 1)
INSERT [dbo].[tblNhanVien] ([PK_iManhanvienID], [sHoten], [dNgaysinh], [bGioitinh], [sSDT], [sEmail], [sDiachi], [sUser], [sPass], [bQuyen]) VALUES (2, N'Nguyễn Thùy Linh', CAST(0x77200B00 AS Date), 0, N'0123654987', N'nguyenlinh', N'Hà Nội', N'linh', N'123', 0)
INSERT [dbo].[tblNhanVien] ([PK_iManhanvienID], [sHoten], [dNgaysinh], [bGioitinh], [sSDT], [sEmail], [sDiachi], [sUser], [sPass], [bQuyen]) VALUES (3, N'Hà', CAST(0x3B290B00 AS Date), 1, N'123456789', N'ha', N'Hà Nội', N'ha', N'123456', 1)
INSERT [dbo].[tblNhanVien] ([PK_iManhanvienID], [sHoten], [dNgaysinh], [bGioitinh], [sSDT], [sEmail], [sDiachi], [sUser], [sPass], [bQuyen]) VALUES (5, N'Khổng Văn Sinh', CAST(0x3B290B00 AS Date), 1, N'0123456789', N'khongsinh', N'Bắc Giang', N'sinh', N'123456', 0)
INSERT [dbo].[tblNhanVien] ([PK_iManhanvienID], [sHoten], [dNgaysinh], [bGioitinh], [sSDT], [sEmail], [sDiachi], [sUser], [sPass], [bQuyen]) VALUES (6, N'kien', CAST(0xFB200B00 AS Date), 1, N'0123456789', N'kien', N'Hưng Yên', N'kien', N'123456', 0)
SET IDENTITY_INSERT [dbo].[tblNhanVien] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [U_Name]    Script Date: 21-Jul-2018 9:07:28 PM ******/
ALTER TABLE [dbo].[tblLoaiHang] ADD  CONSTRAINT [U_Name] UNIQUE NONCLUSTERED 
(
	[sTenloaihang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [U_NameMatHang]    Script Date: 21-Jul-2018 9:07:28 PM ******/
ALTER TABLE [dbo].[tblMatHang] ADD  CONSTRAINT [U_NameMatHang] UNIQUE NONCLUSTERED 
(
	[sTenhang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [U_NameNhanVien]    Script Date: 21-Jul-2018 9:07:28 PM ******/
ALTER TABLE [dbo].[tblNhanVien] ADD  CONSTRAINT [U_NameNhanVien] UNIQUE NONCLUSTERED 
(
	[sUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblChiTietBan]  WITH CHECK ADD  CONSTRAINT [FK_tblChiTietBan_tblHoaDonBan] FOREIGN KEY([FK_iMahoadonbanID])
REFERENCES [dbo].[tblHoaDonBan] ([PK_iMahoadonbanID])
GO
ALTER TABLE [dbo].[tblChiTietBan] CHECK CONSTRAINT [FK_tblChiTietBan_tblHoaDonBan]
GO
ALTER TABLE [dbo].[tblChiTietBan]  WITH CHECK ADD  CONSTRAINT [FK_tblChiTietBan_tblMatHang] FOREIGN KEY([FK_iMamathangID])
REFERENCES [dbo].[tblMatHang] ([PK_iMamathangID])
GO
ALTER TABLE [dbo].[tblChiTietBan] CHECK CONSTRAINT [FK_tblChiTietBan_tblMatHang]
GO
ALTER TABLE [dbo].[tblChiTietNhap]  WITH CHECK ADD  CONSTRAINT [FK_tblChiTietNhap_tblHoaDonNhap] FOREIGN KEY([FK_iMahoadonnhapID])
REFERENCES [dbo].[tblHoaDonNhap] ([PK_iMahoadonnhapID])
GO
ALTER TABLE [dbo].[tblChiTietNhap] CHECK CONSTRAINT [FK_tblChiTietNhap_tblHoaDonNhap]
GO
ALTER TABLE [dbo].[tblChiTietNhap]  WITH CHECK ADD  CONSTRAINT [FK_tblChiTietNhap_tblMatHang] FOREIGN KEY([FK_iMathangID])
REFERENCES [dbo].[tblMatHang] ([PK_iMamathangID])
GO
ALTER TABLE [dbo].[tblChiTietNhap] CHECK CONSTRAINT [FK_tblChiTietNhap_tblMatHang]
GO
ALTER TABLE [dbo].[tblGiamGia]  WITH CHECK ADD  CONSTRAINT [FK_tblGiamGia_tblMatHang] FOREIGN KEY([FK_iMamathangID])
REFERENCES [dbo].[tblMatHang] ([PK_iMamathangID])
GO
ALTER TABLE [dbo].[tblGiamGia] CHECK CONSTRAINT [FK_tblGiamGia_tblMatHang]
GO
ALTER TABLE [dbo].[tblHangHong]  WITH CHECK ADD  CONSTRAINT [FK_tblHangHong_tblMatHang] FOREIGN KEY([FK_iMamathangID])
REFERENCES [dbo].[tblMatHang] ([PK_iMamathangID])
GO
ALTER TABLE [dbo].[tblHangHong] CHECK CONSTRAINT [FK_tblHangHong_tblMatHang]
GO
ALTER TABLE [dbo].[tblHoaDonBan]  WITH CHECK ADD  CONSTRAINT [FK_tblHoaDonBan_tblNhanVien] FOREIGN KEY([FK_iManhanvienID])
REFERENCES [dbo].[tblNhanVien] ([PK_iManhanvienID])
GO
ALTER TABLE [dbo].[tblHoaDonBan] CHECK CONSTRAINT [FK_tblHoaDonBan_tblNhanVien]
GO
ALTER TABLE [dbo].[tblHoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_tblHoaDonNhap_tblNhaCungCap] FOREIGN KEY([FK_iManhacungcapID])
REFERENCES [dbo].[tblNhaCungCap] ([PK_iManhacungcapID])
GO
ALTER TABLE [dbo].[tblHoaDonNhap] CHECK CONSTRAINT [FK_tblHoaDonNhap_tblNhaCungCap]
GO
ALTER TABLE [dbo].[tblHoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_tblHoaDonNhap_tblNhanVien] FOREIGN KEY([FK_iManhanvienID])
REFERENCES [dbo].[tblNhanVien] ([PK_iManhanvienID])
GO
ALTER TABLE [dbo].[tblHoaDonNhap] CHECK CONSTRAINT [FK_tblHoaDonNhap_tblNhanVien]
GO
ALTER TABLE [dbo].[tblMatHang]  WITH CHECK ADD  CONSTRAINT [FK_tblMatHang_tblLoaiHang] FOREIGN KEY([FK_iMaloaihangID])
REFERENCES [dbo].[tblLoaiHang] ([PK_iMaloaihangID])
GO
ALTER TABLE [dbo].[tblMatHang] CHECK CONSTRAINT [FK_tblMatHang_tblLoaiHang]
GO
USE [master]
GO
ALTER DATABASE [QuanLyBanHangSieuThiMini] SET  READ_WRITE 
GO
