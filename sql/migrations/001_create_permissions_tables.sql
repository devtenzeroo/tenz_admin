-- SQL migrations for tenz_admin permissions
-- Place this file into sql/migrations and run it once during deployment.

CREATE TABLE IF NOT EXISTS `tenz_admin_groups` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL UNIQUE,
  `rank` INT NOT NULL DEFAULT 99,
  `permissions` JSON DEFAULT NULL,
  `ace_group` VARCHAR(128) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tenz_admin_players` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `identifier` VARCHAR(255) NOT NULL UNIQUE,
  `discord_id` VARCHAR(64) DEFAULT NULL,
  `group_id` INT DEFAULT NULL,
  `added_by` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`group_id`) REFERENCES `tenz_admin_groups`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tenz_admin_audit` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `actor_identifier` VARCHAR(255) DEFAULT NULL,
  `action` VARCHAR(128) NOT NULL,
  `target_identifier` VARCHAR(255) DEFAULT NULL,
  `metadata` JSON DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
