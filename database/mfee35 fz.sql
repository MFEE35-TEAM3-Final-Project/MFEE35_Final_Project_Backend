-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3370
-- Generation Time: May 11, 2023 at 07:20 AM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mfee35`
--

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `coupon_id` int(5) NOT NULL,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_rate` decimal(10,2) NOT NULL,
  `discount_algorithm` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `usage_count` int(11) DEFAULT '0',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`coupon_id`, `code`, `name`, `discount_rate`, `discount_algorithm`, `description`, `usage_limit`, `usage_count`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(3, 'ABC123', '特惠日優惠券', '0.80', 'percentage', '特惠日優惠券，享有八折優惠', 1000, 0, '2022-06-01 00:00:00', '2022-06-30 23:59:59', '2023-05-10 07:06:38', '2023-05-10 07:06:38'),
(4, 'ABC123sss', '特惠日優惠券', '0.80', 'percentage', '特惠日優惠券，享有八折優惠', 1000, 0, '2022-06-01 00:00:00', '2022-06-30 23:59:59', '2023-05-11 06:49:44', '2023-05-11 06:49:44');

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `id` int(11) NOT NULL,
  `user_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `productid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` char(36) NOT NULL,
  `user_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `coupon_code` varchar(20) DEFAULT NULL,
  `total_quantity` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `shipping_method` varchar(20) DEFAULT NULL,
  `shipping_address` varchar(100) DEFAULT NULL,
  `ship_store` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `email`, `phone`, `name`, `coupon_code`, `total_quantity`, `total_price`, `payment_method`, `shipping_method`, `shipping_address`, `ship_store`, `status`, `create_time`) VALUES
('4428f229-bed4-4c40-8c1f-73c3d6709402', '4152607872', 'ppppppp@gmail.com', '0987654321', 'John Doe', NULL, 3, '1500.00', 'credit_card', NULL, 'No. 123, Main Street, Taipei City', 'My Store', 'created', '2023-05-11 14:00:18'),
('9084c680-e179-4e70-b8da-e43a48b5eb93', '4152607872', 'ppppppp@gmail.com', '0987654321', 'John Doe', NULL, 3, '1500.00', 'credit_card', NULL, 'No. 123, Main Street, Taipei City', 'My Store', 'created', '2023-05-11 14:04:57');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `detail_id` int(11) NOT NULL,
  `order_id` char(36) NOT NULL,
  `productid` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`detail_id`, `order_id`, `productid`, `quantity`, `price`) VALUES
(53, '4428f229-bed4-4c40-8c1f-73c3d6709402', '04b15522-6e0a-448a-86fe-6f2da58da30f', 2, '500.00'),
(54, '4428f229-bed4-4c40-8c1f-73c3d6709402', '0861bb46-c0b8-45c9-9b55-c53e812547de', 1, '500.00'),
(55, '9084c680-e179-4e70-b8da-e43a48b5eb93', '0861bb46-c0b8-45c9-9b55-c53e812547de', 1, '500.00'),
(56, '9084c680-e179-4e70-b8da-e43a48b5eb93', '04b15522-6e0a-448a-86fe-6f2da58da30f', 2, '500.00');

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `cart_id` varchar(10) NOT NULL,
  `user_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `productid` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shopping_cart`
--

INSERT INTO `shopping_cart` (`cart_id`, `user_id`, `productid`, `quantity`, `created_at`) VALUES
('172904', '4152607872', '09f437e8-169e-4dc0-80c1-f222b3719009', 4, '2023-05-11 02:29:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_idfk_1` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `product_id` (`productid`),
  ADD KEY `order_details_ibfk_1` (`order_id`);

--
-- Indexes for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `product_id` (`productid`),
  ADD KEY `shopping_cart_ibfk_2` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `coupon_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
