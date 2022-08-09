-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 09, 2022 at 05:24 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mart`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category` varchar(160) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `description` varchar(265) CHARACTER SET utf8 DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `uri` varchar(100) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=koi8r;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `date_created`, `description`, `status`, `uri`) VALUES
(1, 'Mens Shirt', '2022-08-07 11:37:40', 'Many of them', 1, NULL),
(2, 'Lady Shirt', '2022-08-07 11:39:44', 'Sell all', 1, NULL),
(3, 'Lady Shirt', '2022-08-07 11:40:57', 'Sell all', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1,
  `delete` smallint(1) NOT NULL DEFAULT 0,
  `uri` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `product` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=koi8r;

-- --------------------------------------------------------

--
-- Table structure for table `preferences`
--

CREATE TABLE `preferences` (
  `id` int(11) NOT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `status` smallint(1) DEFAULT 1,
  `product` int(11) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=koi8r;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `products` varchar(160) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(6) DEFAULT 1,
  `delete` smallint(6) DEFAULT 0,
  `Quantity` int(100) DEFAULT NULL,
  `Price` int(100) DEFAULT NULL,
  `description` varchar(265) CHARACTER SET utf8 DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `image_path` varchar(256) DEFAULT NULL,
  `uri` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `product_term` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=koi8r;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `products`, `date_created`, `status`, `delete`, `Quantity`, `Price`, `description`, `image`, `image_path`, `uri`, `category`, `product_term`) VALUES
(37, 'Shoes', '2022-08-09 12:38:56', 1, 0, 23, 56, 'unique attires.', 'cat-1.jpg', NULL, NULL, 2, 84),
(38, 'Fake Phones', '2022-08-09 12:39:53', 1, 0, 90, 2222, 'unique attires.', 'product-4.jpg', NULL, NULL, 2, 85),
(42, 'Fake Phones', '2022-08-09 12:55:38', 1, 0, 90, 2222, 'unique attires.', 'product-4.jpg', NULL, NULL, 2, 85),
(46, 'Indian Posho', '2022-08-09 13:01:19', 1, 0, 7676, 222, 'unique attires.', 'cat-1.jpg', NULL, NULL, 1, 83);

-- --------------------------------------------------------

--
-- Table structure for table `product_line`
--

CREATE TABLE `product_line` (
  `id` int(11) NOT NULL,
  `product_term` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `quantity` int(100) DEFAULT NULL,
  `quantity_left` int(111) DEFAULT NULL,
  `date_added` date DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `status` smallint(1) DEFAULT 1,
  `deleted` smallint(6) DEFAULT 0,
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=koi8r;

--
-- Dumping data for table `product_line`
--

INSERT INTO `product_line` (`id`, `product_term`, `quantity`, `quantity_left`, `date_added`, `date_created`, `status`, `deleted`, `description`) VALUES
(83, 'long term', 10, 3, '2022-08-08', '2022-08-07 10:40:26', 1, 0, 'unique attires.'),
(84, 'mid term', 20, 8, '2022-08-08', '2022-08-07 10:40:26', 1, 0, 'unique attires.'),
(85, 'short term', 100, 40, '2022-08-08', '2022-08-07 10:40:26', 1, 0, 'unique attires.');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `like` smallint(1) DEFAULT 0,
  `user` int(11) DEFAULT NULL,
  `product` int(11) DEFAULT NULL,
  `date_liked` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=koi8r;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role` char(50) CHARACTER SET utf8 DEFAULT NULL,
  `uri` varchar(233) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `status` smallint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=koi8r;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role`, `uri`, `date_created`, `description`, `status`) VALUES
(1, 'customer', 'DashboardCustomer.jsp', '2022-08-05 21:14:17', 'customer', 1),
(2, 'staff', 'DashboardStaff', '2022-08-06 05:38:15', 'Employee dashboard', 1),
(3, 'Manager', 'DashboardManager', '2022-08-06 05:40:36', 'Managerial roles', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user` char(100) CHARACTER SET utf8 DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `uri` char(64) CHARACTER SET utf8 DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `deleted` smallint(6) NOT NULL DEFAULT 2,
  `gender` char(10) CHARACTER SET utf8 DEFAULT 'M',
  `location` char(64) CHARACTER SET utf8 DEFAULT NULL,
  `email` char(100) CHARACTER SET utf8 DEFAULT NULL,
  `user_name` char(100) CHARACTER SET utf8 DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `role` int(11) DEFAULT 1,
  `product_line` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=koi8r;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user`, `date_added`, `uri`, `status`, `deleted`, `gender`, `location`, `email`, `user_name`, `password`, `role`, `product_line`) VALUES
(24, 'opio', '2022-08-05 08:54:40', '/ututu', 1, 2, 'm', 'gfgf', 'k', 'sam', 'rrr', 2, 85),
(25, 'Eluk', '2022-08-05 09:43:59', NULL, 1, 2, 'M', NULL, NULL, NULL, '1111', NULL, NULL),
(27, 'JUJU', '2022-08-05 09:49:39', NULL, 1, 2, 'M', 'JJJ', 's@w', 'hd', '55', 2, 85),
(28, 'yyy', '2022-08-05 20:35:02', NULL, 1, 2, 'M', 'hhh', 'a@W', 'bjj', '222', 1, NULL),
(29, 'okello', '2022-08-06 08:28:23', 'admin', 1, 2, 'M', 'kama', 'a@a', 'dan', '1122', 3, NULL),
(32, 'hdf', '2022-08-06 09:48:41', NULL, 1, 2, 'F', 'jdjd', 'e@w', 'ww', '11', 1, NULL),
(33, 'maya', '2022-08-07 08:46:15', NULL, 1, 2, 'M', 'luwero', 'mark@gmail', 'mac', '1234', 1, NULL),
(34, 'Opio', '2022-08-08 11:06:30', NULL, 1, 2, 'F', 'Jinja', 'a@W', 'Samack', '111', 2, 83),
(36, 'ronald', '2022-08-08 12:58:39', NULL, 1, 2, 'M', 'opop', 's@s', 'jj', '88', 3, NULL),
(37, 'PEDI', '2022-08-08 15:18:36', NULL, 1, 2, 'M', 'Gulu', 'h@w', 'dr', '111', 2, 85);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`,`product`),
  ADD KEY `price` (`price`),
  ADD KEY `orders_ibfk_3` (`product`);

--
-- Indexes for table `preferences`
--
ALTER TABLE `preferences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product` (`product`,`gender`),
  ADD KEY `gender` (`gender`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category`),
  ADD KEY `product_term` (`product_term`);

--
-- Indexes for table `product_line`
--
ALTER TABLE `product_line`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `product` (`product`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role` (`role`),
  ADD KEY `product_line` (`product_line`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `product_line`
--
ALTER TABLE `product_line`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`product`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`price`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `preferences`
--
ALTER TABLE `preferences`
  ADD CONSTRAINT `preferences_ibfk_1` FOREIGN KEY (`product`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `preferences_ibfk_2` FOREIGN KEY (`gender`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`product_term`) REFERENCES `product_line` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
