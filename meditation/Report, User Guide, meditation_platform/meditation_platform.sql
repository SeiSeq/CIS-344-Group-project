-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2025 at 12:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `meditation_platform`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_record_session` (IN `p_user_id` INT, IN `p_meditation_id` INT, IN `p_duration_seconds` INT, IN `p_mood` VARCHAR(20), IN `p_notes` TEXT)   BEGIN
  INSERT INTO sessions (user_id, meditation_id, started_at, duration_seconds, mood, notes)
  VALUES (p_user_id, p_meditation_id, NOW(), p_duration_seconds, p_mood, p_notes);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`) VALUES
(5, 'Breathing'),
(2, 'Mindfulness'),
(1, 'Relaxation'),
(3, 'Sleep'),
(4, 'Stress Relief');

-- --------------------------------------------------------

--
-- Table structure for table `event_rsvps`
--

CREATE TABLE `event_rsvps` (
  `rsvp_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rsvp_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_rsvps`
--

INSERT INTO `event_rsvps` (`rsvp_id`, `event_id`, `user_id`, `rsvp_at`) VALUES
(1, 1, 1, '2025-11-01 21:35:42');

-- --------------------------------------------------------

--
-- Table structure for table `live_events`
--

CREATE TABLE `live_events` (
  `event_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `start_datetime` datetime NOT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT 100,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `live_events`
--

INSERT INTO `live_events` (`event_id`, `title`, `description`, `start_datetime`, `duration_minutes`, `capacity`, `is_active`, `created_at`) VALUES
(1, 'Morning Group Breathwork', 'A live 20-minute breathwork session', '2025-11-03 17:35:42', 20, 50, 1, '2025-11-01 21:35:42');

-- --------------------------------------------------------

--
-- Table structure for table `meditations`
--

CREATE TABLE `meditations` (
  `meditation_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `instructor` varchar(100) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `duration_seconds` int(11) DEFAULT NULL,
  `media_url` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meditations`
--

INSERT INTO `meditations` (`meditation_id`, `title`, `description`, `instructor`, `category_id`, `duration_seconds`, `media_url`, `is_active`, `created_at`) VALUES
(1, '10-Minute Mindfulness', 'A short mindfulness meditation for beginners', 'A. Rivera', 2, 600, 'assets/10min.mp3', 1, '2025-11-01 21:35:42'),
(2, 'Body Scan for Sleep', 'Guided body scan to help you fall asleep', 'L. Chen', 3, 1200, 'assets/20min.mp3', 1, '2025-11-01 21:35:42'),
(3, 'Breathing Reset', 'Quick breathing exercise to reduce stress', 'M. Singh', 5, 300, 'assets/5min.mp3', 1, '2025-11-01 21:35:42');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `meditation_id` int(11) NOT NULL,
  `started_at` datetime NOT NULL DEFAULT current_timestamp(),
  `duration_seconds` int(11) DEFAULT NULL,
  `mood` enum('great','good','okay','bad','stressed') DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `user_id`, `meditation_id`, `started_at`, `duration_seconds`, `mood`, `notes`) VALUES
(1, 1, 1, '2025-10-25 17:35:42', 600, 'good', 'Felt calmer after this one.'),
(2, 1, 2, '2025-10-29 17:35:42', 1200, 'okay', 'Slept better after trying it.'),
(3, 3, 1, '2025-11-04 18:40:24', 500, '', 'need to take deep breaths'),
(4, 3, 2, '2025-11-04 18:41:07', 0, '', ''),
(5, 3, 2, '2025-11-04 18:42:15', 0, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` enum('user','admin') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `created_at`, `role`) VALUES
(1, 'demo_user', 'demo@example.com', '$2y$10$PLACEHOLDER_HASH_FOR_DEMO_USER', '2025-11-01 21:35:42', 'user'),
(2, 'admin_user', 'admin@example.com', '$2y$10$PLACEHOLDER_HASH_FOR_ADMIN', '2025-11-01 21:35:42', 'admin'),
(3, 'Sei', 'sarantejose56@gmail.com', 'sei', '2025-11-01 21:50:55', 'user'),
(7, 'j', 'h@gmail.com', 'h', '2025-11-04 05:19:40', 'user'),
(8, '', '', '', '2025-11-04 17:30:33', 'user');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_most_played`
-- (See below for the actual view)
--
CREATE TABLE `vw_most_played` (
`meditation_id` int(11)
,`title` varchar(255)
,`instructor` varchar(100)
,`play_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_user_sessions`
-- (See below for the actual view)
--
CREATE TABLE `vw_user_sessions` (
`session_id` int(11)
,`user_id` int(11)
,`meditation_id` int(11)
,`started_at` datetime
,`duration_seconds` int(11)
,`mood` enum('great','good','okay','bad','stressed')
,`notes` text
,`meditation_title` varchar(255)
,`instructor` varchar(100)
,`category_id` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_most_played`
--
DROP TABLE IF EXISTS `vw_most_played`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_most_played`  AS SELECT `m`.`meditation_id` AS `meditation_id`, `m`.`title` AS `title`, `m`.`instructor` AS `instructor`, coalesce(count(`s`.`session_id`),0) AS `play_count` FROM (`meditations` `m` left join `sessions` `s` on(`m`.`meditation_id` = `s`.`meditation_id`)) GROUP BY `m`.`meditation_id`, `m`.`title`, `m`.`instructor` ORDER BY coalesce(count(`s`.`session_id`),0) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `vw_user_sessions`
--
DROP TABLE IF EXISTS `vw_user_sessions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_user_sessions`  AS SELECT `s`.`session_id` AS `session_id`, `s`.`user_id` AS `user_id`, `s`.`meditation_id` AS `meditation_id`, `s`.`started_at` AS `started_at`, `s`.`duration_seconds` AS `duration_seconds`, `s`.`mood` AS `mood`, `s`.`notes` AS `notes`, `m`.`title` AS `meditation_title`, `m`.`instructor` AS `instructor`, `m`.`category_id` AS `category_id` FROM (`sessions` `s` join `meditations` `m` on(`s`.`meditation_id` = `m`.`meditation_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `event_rsvps`
--
ALTER TABLE `event_rsvps`
  ADD PRIMARY KEY (`rsvp_id`),
  ADD UNIQUE KEY `unique_event_user` (`event_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `live_events`
--
ALTER TABLE `live_events`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `meditations`
--
ALTER TABLE `meditations`
  ADD PRIMARY KEY (`meditation_id`),
  ADD KEY `idx_meditations_category` (`category_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `idx_sessions_user_started` (`user_id`,`started_at`),
  ADD KEY `idx_sessions_meditation` (`meditation_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `event_rsvps`
--
ALTER TABLE `event_rsvps`
  MODIFY `rsvp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `live_events`
--
ALTER TABLE `live_events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `meditations`
--
ALTER TABLE `meditations`
  MODIFY `meditation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `event_rsvps`
--
ALTER TABLE `event_rsvps`
  ADD CONSTRAINT `event_rsvps_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `live_events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_rsvps_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `meditations`
--
ALTER TABLE `meditations`
  ADD CONSTRAINT `meditations_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`meditation_id`) REFERENCES `meditations` (`meditation_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
