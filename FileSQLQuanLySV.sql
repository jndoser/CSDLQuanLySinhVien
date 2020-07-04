create database QUANLYSINHVIENUPDATE

use QUANLYSINHVIENUPDATE

create table Khoa
(
	Ma_Khoa nchar(10) primary key not null,
	Ten_Khoa nchar(20) not null,
)

create table GiaoVien
(
	MSGV int primary key not null,
	Ten_Day_Du nchar(20) not null,
	--Gioi tinh chi co the la nam hoac nu
	Gioi_Tinh nchar(5) constraint check_gt check(Gioi_Tinh in (N'Nam', N'Nữ')) not null,
	Ngay_Sinh datetime not null,
	Dia_Chi nchar(50) not null,
	SDT int not null,
	Ma_Khoa nchar(10) constraint FK_GV_MK foreign key references Khoa(Ma_Khoa) not null,
)


create table Lop
(
	Ma_Lop nchar(10) primary key not null,
	Ten_Lop nchar(50) not null,
	So_SV int not null,
	MSGV int constraint FK_L_MSGV foreign key references GiaoVien(MSGV) not null,
	Ma_Khoa nchar(10) constraint FK_L_MK foreign key references Khoa(Ma_Khoa) not null,
)


create table SinhVien
(
	MSSV int primary key not null,
	Ten_Day_Du nchar(30) not null,
	--Gioi tinh chi co the la nam hoac nu
	Gioi_Tinh nchar(5) constraint check_gtsv  check(Gioi_Tinh in (N'Nam', N'Nữ')) not null,
	--Sinh vien thi phai tren 18 tuoi
	Ngay_Sinh datetime constraint check_ns check(YEAR(GETDATE()) - YEAR(Ngay_Sinh) > 18) not null,
	Email nchar(20) null,
	SDT int not null,
	Dia_Chi nchar(50) not null,
	Khoa_Hoc nchar(10) not null,
	--Diem ren luyen cua sinh vien phai nam trong khoang tu 0 den 100
	Diem_Ren_Luyen float constraint check_diem check(Diem_Ren_Luyen between 0 and 100) not null,
	Ma_Lop nchar(10) constraint FK_SV_ML foreign key references Lop(Ma_Lop) not null ,
)



create table MonHoc
(
	Ma_Mon_Hoc nchar(10) primary key not null,
	Ten_Mon_Hoc nchar(20) not null,
	So_Tin_Chi int not null,
	--So sinh vien dang ky mon hoc phai lon hon 15 sinh vien
	So_SV_Dang_Ky int check (So_SV_Dang_Ky >= 15) not null,
	Ngay_BD datetime not null,
	Ngay_KT datetime not null,
)



create table Phong
(
	Ten_Phong nchar(10) primary key not null,
	Suc_Chua int not null,
)

create table BTLon
(
	De_Tai nchar(100) primary key not null,
	Han_Nop datetime not null,
)

create table DaySV
(
	MSSV int constraint FK_DSV_MSSV foreign key references SinhVien(MSSV) not null,
	MSGV int constraint FK_DSV_MSGV foreign key references GiaoVien(MSGV) not null,
	constraint PK_DSV_MSSV_MSGV primary key(MSSV, MSGV)
)

create table DayMonHoc
(
	MSGV int constraint FK_DMH_MSGV foreign key references GiaoVien(MSGV) not null,
	Ma_Mon_Hoc nchar(10) constraint FK_DMH_MMH foreign key references MonHoc(Ma_Mon_Hoc) not null,
	constraint PK_DMH_MSGV_MMH primary key(MSGV, Ma_Mon_Hoc)
)

create table DangKy
(
	MSSV int constraint FK_DK_MSSV foreign key references SinhVien(MSSV) not null,
	Ma_Mon_Hoc nchar(10) constraint FK_DK_MMH foreign key references MonHoc(Ma_Mon_Hoc) not null,
	constraint PK_DK_MSSV_MMH primary key(MSSV, Ma_Mon_Hoc)
)

create table LamBTLon
(
	MSSV int constraint FK_LBTL_MSSV foreign key references SinhVien(MSSV) not null,
	De_Tai nchar(100) constraint FK_LBTL_DT foreign key references BTLon(De_Tai) not null,
	constraint PK_LBTL_MSSV_DT primary key(MSSV, De_Tai)
)


create table SDPhongHoc
(
	Ma_Mon_Hoc nchar(10) constraint FK_SDPH_MMH foreign key references MonHoc(Ma_Mon_Hoc) not null,
	Ten_Phong nchar(10) constraint FK_SDPH_TP foreign key references Phong(Ten_Phong) not null,
	constraint PK_SDPH_MMH_TP primary key(Ma_Mon_Hoc, Ten_Phong)
)

--nhap du lieu cho bang Khoa
insert Khoa (Ma_Khoa, Ten_Khoa) values (N'CK        ', N'Cơ khí              ')
insert Khoa (Ma_Khoa, Ten_Khoa) values (N'CNTT      ', N'Công nghệ thông tin ')
insert Khoa (Ma_Khoa, Ten_Khoa) values (N'CT        ', N'Công trình          ')
insert Khoa (Ma_Khoa, Ten_Khoa) values (N'DDT       ', N'Điện - Điện tử      ')
insert Khoa (Ma_Khoa, Ten_Khoa) values (N'KHCB      ', N'Khoa học cơ bản     ')
insert Khoa (Ma_Khoa, Ten_Khoa) values (N'VTKT      ', N'Vận tải kinh tế     ')

--nhap du lieu cho bang GiaoVien
insert GiaoVien (MSGV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Khoa) values (12354, N'Lê Mỹ Linh          ', N'Nữ', CAST(N'1985-12-12T00:00:00.000' AS DateTime), N'Quận 9                                            ', 5236589, N'KHCB      ')
insert GiaoVien (MSGV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Khoa) values (23645, N'Nguyễn Khánh An     ', N'Nữ',  CAST(N'1982-08-07T00:00:00.000' AS DateTime), N'Quận 4                                            ', 8789546, N'DDT       ')
insert GiaoVien (MSGV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Khoa) values (54689, N'Trịnh Vũ San        ', N'Nữ',  CAST(N'1978-07-17T00:00:00.000' AS DateTime), N'Quận 5                                            ', 7854526, N'CT        ')
insert GiaoVien (MSGV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Khoa) values (58654, N'Trần Thanh Tâm      ', N'Nam',  CAST(N'1979-10-03T00:00:00.000' AS DateTime), N'Thủ Đức                                           ', 7854251, N'CNTT      ')
insert GiaoVien (MSGV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Khoa) values (78512, N'Nguyễn Diễm Huỳnh   ', N'Nữ',  CAST(N'1990-04-27T00:00:00.000' AS DateTime), N'Quận 2                                            ', 7452652, N'VTKT      ')
insert GiaoVien (MSGV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Khoa) values (85456, N'Bùi Văn Mạnh        ', N'Nam',  CAST(N'1989-02-25T00:00:00.000' AS DateTime), N'Thủ Đức                                           ', 8545651, N'CK        ')

--nhap du lieu cho bang Lop
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'CNTT      ', N'Công nghệ thông tin                               ', 109, 58654, N'CNTT')
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'KTBCVT    ', N'Kinh tế bưu chính viễn thông                      ', 36, 78512, N'VTKT')
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'KTCK      ', N'Kỹ thuật cơ khí                                   ', 97, 85456, N'CK')
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'KTVT      ', N'Khai thác vận tải                                 ', 67, 78512, N'VTKT')
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'KTVTDL    ', N'Kinh tế vận tải du lịch                           ', 63, 78512, N'VTKT')
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'KTXD      ', N'Kỹ thuật xây dựng                                 ', 97, 85456, N'CK')
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'QLXD      ', N'Quản lý xây dựng                                  ', 48, 85456, N'CK')
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'QTKD      ', N'Quản trị kinh doanh                               ', 64, 78512, N'VTKT')
insert Lop (Ma_Lop, Ten_Lop, So_SV, MSGV, Ma_Khoa) values (N'TDH       ', N'Tự động hóa                                       ', 76, 85456, N'CK')

--nhap du lieu cho bang SinhVien
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'10400082            ', N'Nguyễn Đình Chính             ', N'Nam' , CAST(N'2000-07-15T00:00:00.000' AS DateTime), N'dchinnh@naver.com   ', 875412569, N'Quận 9',N'K59       ', 7, N'KTCK      ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'10710403            ', N'Nguyễn Thị Ngọc Hiền          ', N'Nữ', CAST(N'2001-09-04T00:00:00.000' AS DateTime), N'hiennru@outlook.com ', 785469856, N'Quận 7',N'K60       ', 8, N'CNTT      ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'14021025            ', N'Nguyễn Trần Hoài Nghi         ', N'Nữ',  CAST(N'2000-08-28T00:00:00.000' AS DateTime), N'nnghi@outlook.com   ', 587465845, N'Quận 9',N'K59       ', 8, N'KTBCVT    ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'51050005            ', N'Võ Ngọc Ánh                   ',  N'Nữ', CAST(N'2001-09-29T00:00:00.000' AS DateTime), N'anhnek@naver.com    ', 845657895, N'Quận 5',N'K60       ', 7.5, N'KTVT      ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh,  Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'51071045            ', N'Đoàn Lê Mỹ Linh               ', N'Nữ',  CAST(N'2000-06-20T00:00:00.000' AS DateTime), N'linkgm@gmail.com    ', 512458967, N'Quận 12',N'K59       ', 8, N'KTVT      ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'51071108            ', N'Trần Lê Thanh Tính            ',  N'Nam' ,  CAST(N'2000-05-26T00:00:00.000' AS DateTime), N'ttutc2@gmail.com    ', 325164789, N'Thủ Đức',N'K59       ', 7, N'CNTT      ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'51232548            ', N'Bùi Hồng Quốc                 ',  N'Nam' , CAST(N'2000-08-10T00:00:00.000' AS DateTime), N'hquocb@gmail.com    ', 215478956, N'Quận 7',N'K59       ', 7, N'QTKD      ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'51235468            ', N'Đặng Ngọc Thiên Kim           ',  N'Nữ', CAST(N'2000-02-14T00:00:00.000' AS DateTime), N'thinkim@gmail.com   ', 231547899, N'Quận 7',N'K59       ', 9, N'KTVTDL    ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'54021001            ', N'Nguyễn Thị Mỹ Ái              ',  N'Nữ', CAST(N'2001-04-17T00:00:00.000' AS DateTime), N'meiai@gmail.com     ', 548785565, N'Quận 9',N'K60       ', 6.5, N'KTBCVT    ')
insert SinhVien (MSSV, Ten_Day_Du, Gioi_Tinh, Ngay_Sinh, Email, SDT, Dia_Chi, Khoa_Hoc, Diem_Ren_Luyen, Ma_Lop) values (N'61245865            ', N'Nguyễn Thu Thảo               ',  N'Nữ', CAST(N'2000-12-28T00:00:00.000' AS DateTime), N'hanlucha@gmail.com  ', 562135478, N'Quận 9',N'K59       ', 8.5, N'QTKD      ')

--nhap du lieu cho bang MonHoc
insert MonHoc (Ma_Mon_Hoc, Ten_Mon_Hoc, So_Tin_Chi, So_SV_Dang_Ky, Ngay_BD, Ngay_KT) values (N'CPM215.3  ', N'Lập trình nâng cao  ', 3, 89, CAST(N'2019-09-10T00:00:00.000' AS DateTime), CAST(N'2020-01-10T00:00:00.000' AS DateTime))
insert MonHoc (Ma_Mon_Hoc, Ten_Mon_Hoc, So_Tin_Chi, So_SV_Dang_Ky, Ngay_BD, Ngay_KT) values (N'GIT01.3   ', N'Giải tích           ', 3, 70, CAST(N'2019-02-15T00:00:00.000' AS DateTime), CAST(N'2019-06-29T00:00:00.000' AS DateTime))
insert MonHoc (Ma_Mon_Hoc, Ten_Mon_Hoc, So_Tin_Chi, So_SV_Dang_Ky, Ngay_BD, Ngay_KT) values (N'KVT201.4  ', N'Kinh tế học         ', 4, 75, CAST(N'2019-09-05T00:00:00.000' AS DateTime), CAST(N'2020-01-15T00:00:00.000' AS DateTime))
insert MonHoc (Ma_Mon_Hoc, Ten_Mon_Hoc, So_Tin_Chi, So_SV_Dang_Ky, Ngay_BD, Ngay_KT) values (N'MHT36.3   ', N'Thiết kế Web        ', 3, 89, CAST(N'2019-09-10T00:00:00.000' AS DateTime), CAST(N'2020-01-12T00:00:00.000' AS DateTime))
insert MonHoc (Ma_Mon_Hoc, Ten_Mon_Hoc, So_Tin_Chi, So_SV_Dang_Ky, Ngay_BD, Ngay_KT) values (N'QLY01.2   ', N'Pháp luật đại cương ', 2, 68, CAST(N'2019-09-05T00:00:00.000' AS DateTime), CAST(N'2020-01-30T00:00:00.000' AS DateTime))
insert MonHoc (Ma_Mon_Hoc, Ten_Mon_Hoc, So_Tin_Chi, So_SV_Dang_Ky, Ngay_BD, Ngay_KT) values (N'QLY17.2   ', N'Kỹ năng mềm         ', 2, 78, CAST(N'2019-09-12T00:00:00.000' AS DateTime), CAST(N'2020-01-20T00:00:00.000' AS DateTime))

--nhap du lieu cho bang Phong
insert Phong (Ten_Phong, Suc_Chua) values (N'101C2     ', 100)
insert Phong (Ten_Phong, Suc_Chua) values (N'102C2     ', 80)
insert Phong (Ten_Phong, Suc_Chua) values (N'1E5       ', 60)
insert Phong (Ten_Phong, Suc_Chua) values (N'201C2     ', 100)
insert Phong (Ten_Phong, Suc_Chua) values (N'2E5       ', 75)
insert Phong (Ten_Phong, Suc_Chua) values (N'4E6       ', 65)

--nhap du lieu cho bang BTLon
insert BTLon (De_Tai, Han_Nop) values (N'Dự toán chi tiêu trong một tháng của một của hàng tạp hóa                                           ', CAST(N'2020-06-29T00:00:00.000' AS DateTime))
insert BTLon (De_Tai, Han_Nop) values (N'Quản lý Bất động sản                                                                                ', CAST(N'2020-07-10T00:00:00.000' AS DateTime))
insert BTLon (De_Tai, Han_Nop) values (N'Thiết kế mô hình cầu vượt                                                                           ', CAST(N'2019-12-23T00:00:00.000' AS DateTime))
insert BTLon (De_Tai, Han_Nop) values (N'Vẽ sơ đồ ký túc xá                                                                                  ', CAST(N'2019-01-02T00:00:00.000' AS DateTime))
insert BTLon (De_Tai, Han_Nop) values (N'Xây dựng CSDL quản lý nhà sách                                                                      ', CAST(N'2020-07-08T00:00:00.000' AS DateTime))

--nhap du lieu cho bang DaySV
insert DaySV (MSSV, MSGV) values (61245865,12354) 
insert DaySV (MSSV, MSGV) values (14021025,23645 )
insert DaySV (MSSV, MSGV) values (54021001, 23645)
insert DaySV (MSSV, MSGV) values (10710403, 58654)
insert DaySV (MSSV, MSGV) values (51071108, 58654)
insert DaySV (MSSV, MSGV) values (51050005, 78512)
insert DaySV (MSSV, MSGV) values (51071045, 78512)
insert DaySV (MSSV, MSGV) values (51235468, 78512)
insert DaySV (MSSV, MSGV) values (10400082, 85456)


--nhap du lieu cho bang DayMonHoc
insert DayMonHoc (MSGV, Ma_Mon_Hoc) values (12354, N'KVT201.4  ')
insert DayMonHoc (MSGV, Ma_Mon_Hoc) values (23645, N'KVT201.4  ')
insert DayMonHoc (MSGV, Ma_Mon_Hoc) values (58654, N'CPM215.3  ')
insert DayMonHoc (MSGV, Ma_Mon_Hoc) values (58654, N'MHT36.3   ')
insert DayMonHoc (MSGV, Ma_Mon_Hoc) values (78512, N'QLY01.2   ')
insert DayMonHoc (MSGV, Ma_Mon_Hoc) values (78512, N'QLY17.2   ')

--nhap thong tin bang DangKy
insert DangKy (MSSV, Ma_Mon_Hoc) values (10710403, N'CPM215.3  ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (10710403, N'GIT01.3   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (10710403, N'QLY17.2   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (14021025, N'KVT201.4  ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (14021025, N'QLY01.2   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (14021025, N'QLY17.2   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (51050005, N'KVT201.4  ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (51050005, N'QLY17.2   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (51071045, N'KVT201.4  ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (51071045, N'QLY01.2   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (51071108, N'MHT36.3   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (51235468, N'KVT201.4  ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (51235468, N'QLY17.2   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (61245865, N'QLY01.2   ')
insert DangKy (MSSV, Ma_Mon_Hoc) values (61245865, N'QLY17.2   ')

--nhap thong tin bang LamBTLon
insert LamBTLon (MSSV, De_Tai) values (10400082, N'Thiết kế mô hình cầu vượt                                                                           ')
insert LamBTLon (MSSV, De_Tai) values (10710403, N'Quản lý Bất động sản                                                                                ')
insert LamBTLon (MSSV, De_Tai) values (14021025, N'Dự toán chi tiêu trong một tháng của một của hàng tạp hóa                                           ')
insert LamBTLon (MSSV, De_Tai) values (51050005, N'Dự toán chi tiêu trong một tháng của một của hàng tạp hóa                                           ')
insert LamBTLon (MSSV, De_Tai) values (51071108, N'Xây dựng CSDL quản lý nhà sách                                                                      ')


--nhap du lieu bang SDPhongHoc
insert SDPhongHoc (Ma_Mon_Hoc, Ten_Phong) values (N'CPM215.3  ', N'101C2     ')
insert SDPhongHoc (Ma_Mon_Hoc, Ten_Phong) values (N'GIT01.3   ', N'1E5       ')
insert SDPhongHoc (Ma_Mon_Hoc, Ten_Phong) values (N'KVT201.4  ', N'201C2     ')
insert SDPhongHoc (Ma_Mon_Hoc, Ten_Phong) values (N'MHT36.3   ', N'4E6       ')
insert SDPhongHoc (Ma_Mon_Hoc, Ten_Phong) values (N'QLY01.2   ', N'201C2     ')
insert SDPhongHoc (Ma_Mon_Hoc, Ten_Phong) values (N'QLY17.2   ', N'2E5       ')


--Mot so cau lenh truy van du lieu

--Tim nhung giao vien trong khoa CNTT
select * from GiaoVien where Ma_Khoa = 'CNTT'

--Tim nhung sinh vien co gioi tinh nu
select * from SinhVien where Gioi_Tinh = N'Nữ'

--Tim nhung giao vien co do tuoi > 30 trong khoa cong trinh
select * from GiaoVien where YEAR(GETDATE()) - YEAR(Ngay_Sinh) > 30 and Ma_Khoa = 'CT'

--Tim nhung mon co so tin chi bang 2
select * from MonHoc where So_Tin_Chi = 2

--Tim phong co suc chua > 60
select * from Phong where Suc_Chua > 60

--Tim lop co so sinh vien < 50 nguoi
select * from Lop where So_SV < 50

