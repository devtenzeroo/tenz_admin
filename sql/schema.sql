-- SQL schema placeholder
-- Purpose: keep production SQL migrations and schema files here. This file is a starting point only.

-- Example table for audit logs (minimal schema). Adapt to your database setup and suffixes.
-- Run these manually or via migration tooling during production deployment.

-- CREATE TABLE IF NOT EXISTS tenz_admin_audit (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   actor_identifier VARCHAR(64) NOT NULL,
--   action VARCHAR(255) NOT NULL,
--   target_identifier VARCHAR(64),
--   metadata JSON
-- );

-- NOTE: This file is intentionally non-destructive. Add migration files per-release in this folder.
