DROP DATABASE IF EXISTS meditation_db;
CREATE DATABASE meditation_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE meditation_db;

-- -----------------------
-- Table: categories
-- -----------------------
CREATE TABLE categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- -----------------------
-- Table: users
-- -----------------------
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(60) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  role ENUM('user','admin') DEFAULT 'user'
) ENGINE=InnoDB;

-- -----------------------
-- Table: meditations
-- -----------------------
CREATE TABLE meditations (
  meditation_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  instructor VARCHAR(100),
  category_id INT DEFAULT NULL,
  duration_seconds INT,
  media_url VARCHAR(500),
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- -----------------------
-- Table: sessions
-- -----------------------
CREATE TABLE sessions (
  session_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  meditation_id INT NOT NULL,
  started_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  duration_seconds INT,
  mood ENUM('great','good','okay','bad','stressed') NULL,
  notes TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (meditation_id) REFERENCES meditations(meditation_id) ON DELETE CASCADE,
  INDEX idx_sessions_user_started (user_id, started_at),
  INDEX idx_sessions_meditation (meditation_id)
) ENGINE=InnoDB;

-- -----------------------
-- Sample Data: categories
-- -----------------------
INSERT INTO categories (category_name) VALUES
  ('Mindfulness'),
  ('Sleep'),
  ('Relaxation'),
  ('Focus'),
  ('Breathing');

-- -----------------------
-- Sample Data: meditations
-- -----------------------
INSERT INTO meditations (title, description, instructor, category_id, duration_seconds, media_url, is_active)
VALUES
  ('10-Minute Mindfulness', 'A short mindfulness meditation for beginners', 'A. Rivera', 1, 600, 'https://cdn.example.com/meditations/mindfulness_10.mp3', 1),
  ('Body Scan for Sleep', 'Guided body scan to help you fall asleep', 'L. Chen', 2, 1200, 'https://cdn.example.com/meditations/body_scan_sleep.mp3', 1),
  ('Breathing Reset', 'Quick breathing exercise to reduce stress', 'M. Singh', 5, 300, 'https://cdn.example.com/meditations/breathing_reset.mp3', 1);

-- -----------------------
-- Sample Data: users
-- -----------------------
INSERT INTO users (username, email, password_hash, role)
VALUES
  ('demo_user', 'demo@example.com', '$2y$10$PLACEHOLDER_HASH_FOR_DEMO_USER', 'user'),
  ('admin_user', 'admin@example.com', '$2y$10$PLACEHOLDER_HASH_FOR_ADMIN', 'admin');

-- -----------------------
-- Sample Data: sessions
-- -----------------------
INSERT INTO sessions (user_id, meditation_id, started_at, duration_seconds, mood, notes)
VALUES
  (1, 1, NOW() - INTERVAL 7 DAY, 600, 'good', 'Felt calmer after this one.'),
  (1, 2, NOW() - INTERVAL 3 DAY, 1200, 'okay', 'Slept better after trying it.');

-- -----------------------
-- Stored procedure to record a session
-- -----------------------
DELIMITER $$
CREATE PROCEDURE record_session (
  IN p_user_id INT,
  IN p_meditation_id INT,
  IN p_duration_seconds INT,
  IN p_mood ENUM('great','good','okay','bad','stressed'),
  IN p_notes TEXT
)
BEGIN
  INSERT INTO sessions (user_id, meditation_id, started_at, duration_seconds, mood, notes)
  VALUES (p_user_id, p_meditation_id, NOW(), p_duration_seconds, p_mood, p_notes);
END$$
DELIMITER ;
