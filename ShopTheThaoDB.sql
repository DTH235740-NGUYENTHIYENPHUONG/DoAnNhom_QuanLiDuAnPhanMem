CREATE DATABASE IF NOT EXISTS `ShopTheThaoDB` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `ShopTheThaoDB`;

-- 1. Bảng NguoiDung
CREATE TABLE `nguoidung` (
  `NguoiDungId` INT AUTO_INCREMENT PRIMARY KEY,
  `HoTen` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(100) NOT NULL UNIQUE,
  `MatKhauHash` VARCHAR(255) NOT NULL,
  `SoDienThoai` VARCHAR(20),
  `VaiTro` VARCHAR(20) DEFAULT 'Customer',
  `TrangThaiKhoa` TINYINT(1) DEFAULT 0,
  `NgayTao` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Bảng DanhMuc
CREATE TABLE `danhmuc` (
  `DanhMucId` INT AUTO_INCREMENT PRIMARY KEY,
  `TenDanhMuc` VARCHAR(100) NOT NULL,
  `MoTa` TEXT
) ENGINE=InnoDB;

-- 3. Bảng SanPham
CREATE TABLE `sanpham` (
  `SanPhamId` INT AUTO_INCREMENT PRIMARY KEY,
  `TenSanPham` VARCHAR(150) NOT NULL,
  `GiaGoc` DECIMAL(12,2),
  `GiaBan` DECIMAL(12,2) NOT NULL,
  `TyLeGiamGia` INT DEFAULT 0,
  `SoLuongTon` INT DEFAULT 0,
  `MoTa` TEXT,
  `HinhAnh` VARCHAR(255),
  `DanhMucId` INT NOT NULL,
  `LuotXem` INT DEFAULT 0,
  `LuotMua` INT DEFAULT 0,
  FOREIGN KEY (`DanhMucId`) REFERENCES `danhmuc`(`DanhMucId`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. Bảng MaGiamGia
CREATE TABLE `magiamgia` (
  `MaGiamGiaId` INT AUTO_INCREMENT PRIMARY KEY,
  `MaCode` VARCHAR(50) NOT NULL UNIQUE,
  `PhanTramGiam` INT NOT NULL,
  `DonHangToiThieu` DECIMAL(12,2) DEFAULT 0,
  `NgayBatDau` DATETIME,
  `NgayKetThuc` DATETIME,
  `SoLuong` INT DEFAULT 0
) ENGINE=InnoDB;

-- 5. Bảng DiaChi
CREATE TABLE `diachi` (
  `DiaChiId` INT AUTO_INCREMENT PRIMARY KEY,
  `NguoiDungId` INT NOT NULL,
  `DiaChiChiTiet` VARCHAR(255) NOT NULL,
  `PhuongXa` VARCHAR(50),
  `QuanHuyen` VARCHAR(50),
  `TinhThanh` VARCHAR(50),
  `LaMacDinh` TINYINT(1) DEFAULT 0,
  FOREIGN KEY (`NguoiDungId`) REFERENCES `nguoidung`(`NguoiDungId`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 6. Bảng DonHang
CREATE TABLE `donhang` (
  `DonHangId` INT AUTO_INCREMENT PRIMARY KEY,
  `NguoiDungId` INT NOT NULL,
  `DiaChiId` INT NOT NULL,
  `MaGiamGiaId` INT NULL,
  `NgayDat` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `TongTien` DECIMAL(12,2) NOT NULL,
  `PhuongThucThanhToan` VARCHAR(50) DEFAULT 'COD',
  `TrangThai` VARCHAR(50) DEFAULT 'ChoDuyet',
  FOREIGN KEY (`NguoiDungId`) REFERENCES `nguoidung`(`NguoiDungId`),
  FOREIGN KEY (`DiaChiId`) REFERENCES `diachi`(`DiaChiId`),
  FOREIGN KEY (`MaGiamGiaId`) REFERENCES `magiamgia`(`MaGiamGiaId`)
) ENGINE=InnoDB;

-- 7. Bảng ChiTietDonHang
CREATE TABLE `chitietdonhang` (
  `ChiTietId` INT AUTO_INCREMENT PRIMARY KEY,
  `DonHangId` INT NOT NULL,
  `SanPhamId` INT NOT NULL,
  `SoLuong` INT NOT NULL,
  `DonGia` DECIMAL(12,2) NOT NULL,
  `ThanhTien` DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (`DonHangId`) REFERENCES `donhang`(`DonHangId`) ON DELETE CASCADE,
  FOREIGN KEY (`SanPhamId`) REFERENCES `sanpham`(`SanPhamId`)
) ENGINE=InnoDB;

-- 8. Bảng DanhGia
CREATE TABLE `danhgia` (
  `DanhGiaId` INT AUTO_INCREMENT PRIMARY KEY,
  `NguoiDungId` INT NOT NULL,
  `SanPhamId` INT NOT NULL,
  `SoSao` INT CHECK (`SoSao` BETWEEN 1 AND 5),
  `BinhLuan` TEXT,
  `HinhAnh` VARCHAR(255),
  `NgayDanhGia` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `TrangThaiDuyet` TINYINT(1) DEFAULT 1,
  FOREIGN KEY (`NguoiDungId`) REFERENCES `nguoidung`(`NguoiDungId`),
  FOREIGN KEY (`SanPhamId`) REFERENCES `sanpham`(`SanPhamId`)
) ENGINE=InnoDB;