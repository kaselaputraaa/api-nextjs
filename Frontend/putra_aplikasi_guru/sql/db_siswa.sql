-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.4.3 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping data for table belajar_express.siswa: ~2 rows (approximately)
INSERT INTO `siswa` (`id`, `nipd`, `nama_lengkap`, `jenis_kelamin`, `alamat`, `kelas`, `jurusan`, `created_at`) VALUES
	(1, '242510072', 'Putra KAsela', 'L', 'Sentraland', '12', 'RPL', '2026-10-31 01:23:31'),
	(3, '242510056', 'Dims Surya Putra', 'L', 'Jl kabasiran', '12', 'RPL', '2026-10-31 01:38:25');

-- Dumping data for table belajar_express.users: ~5 rows (approximately)
INSERT INTO `users` (`id`, `nama`, `email`, `password`, `created_at`) VALUES
	(1, 'cicak', 'cicakcicakdidinding@gmail.com', '$2b$10$DzR9cudI0MLithuIkjMYmOF4.9yN60uiJKgdTgEZyvENa6fCDmANG', '2026-09-25 03:03:54'),
	(2, 'rina', 'rinarusliana@gmail.com', '$2b$10$SZpX3d5DqwpQI3rz3c9Ixeuy6MRZjH.atTng7LV3FxkhVIADjNrnO', '2026-09-25 03:04:47'),
	(3, 'ica', 'ica@gmail.com', '$2b$10$KeBeFyJdg1BbFeKTdw81Yud4cr38k1qodmT9sxcE4QONcPc1huvne', '2026-09-25 03:05:34'),
	(5, 'Putra Kasela', 'kaselaaaka@gmail.com', '$2a$12$HavNgqxYWJM34AjW33YAYuFCuagHV8DifgGhPZKCQKvTAtljUXPwK', '2026-10-30 02:05:52'),
	(7, 'Dimas Rurya', 'dimass@gmail.com', '$2a$12$msNBRKM/SM5VFaiUC.Bb2Oy0BEH3CHOJFl5iVur.ZrCtKJAxDebZa', '2026-10-30 02:28:12');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
