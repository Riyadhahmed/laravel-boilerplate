-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5332
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table laravel_boilerplate.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.migrations: ~4 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_02_02_112609_create_settings_table', 1),
	(4, '2019_04_01_053540_create_permission_tables', 1),
	(5, '2019_03_20_115129_create_news_table', 2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.model_has_permissions: ~0 rows (approximately)
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.model_has_roles: ~0 rows (approximately)
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 1);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.news
CREATE TABLE IF NOT EXISTS `news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL DEFAULT 'assets/images/blog/default_news_a.jpg',
  `uploaded_by` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.news: ~2 rows (approximately)
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` (`id`, `title`, `description`, `category`, `file_path`, `uploaded_by`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Cambridge digs in at the top of university league table', 'W3 School was founded in 1992 as an English Medium school to provide a world class education for the students of Chittagong. Since those humble beginnings, the school has evolved to cater to the changing needs of young people in both Chittagong and the capital city of Dhaka. The school is known for its academic accomplishment in the British styled O and A levels but also as a designated examination centre for the SAT tests for U.S. college admissions. More recently, we have added the option for students to follow the Bangladesh National Curriculum. We believe that this option will cater to more specific needs and requirements of our pupils. We are very proud that unlike most academic institutions, W3 is in a position to offer this flexibility to our students. We believe that our National Curriculum option has allowed W3 to complete its journey to becoming a holistic academic institution, meeting the needs of students both at home and abroad. W3 fosters a common vision amongst all our students by celebrating diversity, Bangladeshi nationalism and by focusing on the pursuit of excellence in both academic as well as extra-curricular activities in order to develop young men and women who have a solid foundation to pursue any educational path as well as career in their future.', 'Latest News', 'assets/images/blog/1554102169.jpg', 1, 1, '2019-04-01 07:02:49', '2019-04-01 07:02:49'),
	(2, 'Private schools adopt a Ucas style application system', 'W3 School was founded in 1992 as an English Medium school to provide a world class education for the students of Chittagong. Since those humble beginnings, the school has evolved to cater to the changing needs of young people in both Chittagong and the capital city of Dhaka. The school is known for its academic accomplishment in the British styled O and A levels but also as a designated examination centre for the SAT tests for U.S. college admissions. More recently, we have added the option for students to follow the Bangladesh National Curriculum. We believe that this option will cater to more specific needs and requirements of our pupils. We are very proud that unlike most academic institutions, W3 is in a position to offer this flexibility to our students. We believe that our National Curriculum option has allowed W3 to complete its journey to becoming a holistic academic institution, meeting the needs of students both at home and abroad. W3 fosters a common vision amongst all our students by celebrating diversity, Bangladeshi nationalism and by focusing on the pursuit of excellence in both academic as well as extra-curricular activities in order to develop young men and women who have a solid foundation to pursue any educational path as well as career in their future.', 'Latest News', 'assets/images/blog/1554102264.jpg', 1, 1, '2019-04-01 07:04:24', '2019-04-01 07:05:54');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.permissions: ~15 rows (approximately)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'role-view', 'web', '2019-04-01 05:40:59', '2019-04-01 05:40:59'),
	(2, 'role-create', 'web', '2019-04-01 05:40:59', '2019-04-01 05:40:59'),
	(3, 'role-edit', 'web', '2019-04-01 05:40:59', '2019-04-01 05:40:59'),
	(4, 'role-delete', 'web', '2019-04-01 05:40:59', '2019-04-01 05:40:59'),
	(5, 'permission-view', 'web', '2019-04-01 05:40:59', '2019-04-01 05:40:59'),
	(6, 'permission-create', 'web', '2019-04-01 05:41:00', '2019-04-01 05:41:00'),
	(7, 'permission-edit', 'web', '2019-04-01 05:41:00', '2019-04-01 05:41:00'),
	(8, 'permission-delete', 'web', '2019-04-01 05:41:00', '2019-04-01 05:41:00'),
	(9, 'user-view', 'web', '2019-04-01 05:41:00', '2019-04-01 05:41:00'),
	(10, 'user-create', 'web', '2019-04-01 05:41:00', '2019-04-01 05:41:00'),
	(11, 'user-edit', 'web', '2019-04-01 05:41:00', '2019-04-01 05:41:00'),
	(12, 'user-delete', 'web', '2019-04-01 05:41:00', '2019-04-01 05:41:00'),
	(13, 'news-create', 'web', '2019-04-01 05:47:53', '2019-04-01 14:16:09'),
	(14, 'news-view', 'web', '2019-04-01 14:17:19', '2019-04-01 14:17:19'),
	(15, 'news-edit', 'web', '2019-04-01 14:17:25', '2019-04-01 14:17:25'),
	(16, 'news-delete', 'web', '2019-04-01 14:17:30', '2019-04-01 14:17:30');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.roles: ~2 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'web', '2019-04-01 05:40:59', '2019-04-01 05:40:59'),
	(2, 'members', 'web', '2019-04-01 14:16:51', '2019-04-01 14:16:51');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.role_has_permissions: ~7 rows (approximately)
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 2),
	(5, 2),
	(9, 2),
	(13, 2),
	(14, 2),
	(15, 2),
	(16, 2);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slogan` varchar(255) DEFAULT NULL,
  `reg` varchar(255) DEFAULT NULL,
  `stablished` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `layout` varchar(255) NOT NULL DEFAULT '1',
  `running_year` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.settings: ~1 rows (approximately)
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `name`, `slogan`, `reg`, `stablished`, `email`, `contact`, `address`, `website`, `logo`, `layout`, `running_year`, `created_at`, `updated_at`) VALUES
	(1, 'Laravel Boilerplate', 'Exploring Coding', '123456', '1965', 'riyadhahmed777@gmail.com', '01851334226', 'Chittagong,Bangladesh', 'https://github.com/Riyadhahmed', 'assets/images/logo/default.png', '1', '2018-2019', '2019-04-01 16:04:06', '2019-04-01 16:04:06');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

-- Dumping structure for table laravel_boilerplate.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table laravel_boilerplate.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin@admin.com', NULL, '$2y$10$J48B4iPentoi4YS5QdY.7.88bWj89cxsIMXxismwIhI6U.UyQUane', NULL, '2019-04-01 00:00:00', '2019-04-01 14:15:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
