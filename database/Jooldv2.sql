-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主機： localhost:8889
-- 產生時間： 2023 年 05 月 15 日 06:27
-- 伺服器版本： 5.7.39
-- PHP 版本： 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `products`
--

-- --------------------------------------------------------

--
-- 資料表結構 `activity`
--

CREATE TABLE `activity` (
  `activityId` varchar(255) NOT NULL,
  `activityUrl` varchar(255) NOT NULL,
  `activityDescription` varchar(500) DEFAULT NULL,
  `activityName` varchar(50) NOT NULL,
  `activityDiscount` varchar(50) NOT NULL,
  `productid` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 傾印資料表的資料 `activity`
--

INSERT INTO `activity` (`activityId`, `activityUrl`, `activityDescription`, `activityName`, `activityDiscount`, `productid`) VALUES
('1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683006807/activity2_kb7e9p.jpg', '第一個活動描述:\r\n商品全面特價9折', '畢業歡送季節', '0.9', NULL),
('2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683006807/activity1_k7ljoh.jpg', '第二個活動描述:\r\n老闆找到頭路，買一個送三個', '買一送三買一送三', '0.3', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `discounts`
--

CREATE TABLE `discounts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `discount_percent` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 傾印資料表的資料 `discounts`
--

INSERT INTO `discounts` (`id`, `name`, `discount_percent`) VALUES
(1, '活動同種類第二件五折', '0.50');

-- --------------------------------------------------------

--
-- 資料表結構 `onlineProducts`
--

CREATE TABLE `onlineProducts` (
  `productid` varchar(50) NOT NULL,
  `food_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `storage_method` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  `activityId` varchar(255) NOT NULL,
  `image` varchar(1500) DEFAULT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT '2038-01-18 19:14:07'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 傾印資料表的資料 `onlineProducts`
--

INSERT INTO `onlineProducts` (`productid`, `food_id`, `name`, `description`, `storage_method`, `price`, `stock`, `category`, `activityId`, `image`, `start_date`, `end_date`) VALUES
('04b15522-6e0a-448a-86fe-6f2da58da30f', 'A0310101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:49', '2038-01-18 19:14:07'),
('0861bb46-c0b8-45c9-9b55-c53e812547de', 'A0320101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:07', '2038-01-18 19:14:07'),
('09f437e8-169e-4dc0-80c1-f222b3719009', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '3', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:40', '2038-01-18 19:14:07'),
('0b1b3b6c-7a94-468a-8a4b-6fc7d2899cc0', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:33', '2038-01-18 19:14:07'),
('1a5d939b-a7cd-49b4-83cc-7a662a522bed', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:06', '2038-01-18 19:14:07'),
('1b523d52-ba1d-4e85-81d9-5b5f1d4a39a3', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:48', '2038-01-18 19:14:07'),
('1faf2d28-dc53-42ed-9c8a-9bf510660114', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '3', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:44', '2038-01-18 19:14:07'),
('1fd5fdd6-3417-44e6-8e0b-fac63eeb14dd', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:01', '2038-01-18 19:14:07'),
('21155101-78ba-44f6-91eb-818604969198', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:58', '2038-01-18 19:14:07'),
('222ff8d9-f312-4943-8422-d9998176306d', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:03', '2038-01-18 19:14:07'),
('28193ba4-7a92-4780-ba34-40b480dec326', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:56', '2038-01-18 19:14:07'),
('2c41ba38-1a41-4dc8-b303-7cedd6916dad', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '3', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:05', '2038-01-18 19:14:07'),
('2c9e966a-7d3e-4733-946e-7adc0c152b60', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '3', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:29', '2038-01-18 19:14:07'),
('3901b983-b839-4eb9-8bdd-78dd0b2b835d', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:30', '2038-01-18 19:14:07'),
('3ae3a4bd-1b4a-4a1c-b446-ee975d1abb19', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:07', '2038-01-18 19:14:07'),
('3b36b512-f340-4d1b-bf2b-e8c4d119b3b6', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:04', '2038-01-18 19:14:07'),
('3d38974b-b4b7-4fdf-8957-0eeb5af604a9', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:08', '2038-01-18 19:14:07'),
('424de054-2c92-45bd-87e8-f714068e02f1', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:01', '2038-01-18 19:14:07'),
('4452cc33-f2d6-4f71-b150-c873595c5a1e', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:55', '2038-01-18 19:14:07'),
('47e19324-abc0-4208-a4cd-a8819e346e2e', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:35', '2038-01-18 19:14:07'),
('49e26bb5-bae5-4740-93b7-8249f9dfd502', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:08', '2038-01-18 19:14:07'),
('5010d18a-bfb2-402c-8659-186151480f15', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:55', '2038-01-18 19:14:07'),
('544bc500-7c01-4933-ba38-3790a8233bc5', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:54', '2038-01-18 19:14:07'),
('5c05c859-3f21-4e88-b033-14755e71c224', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:02', '2038-01-18 19:14:07'),
('5dfda339-ddf4-4ca7-a9b2-091d141c1a41', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:34', '2038-01-18 19:14:07'),
('61d6b226-94c4-480f-8472-87ba7c779465', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:10', '2038-01-18 19:14:07'),
('789f1098-6fb7-4717-8dc3-b1ceb6308a9f', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:05', '2038-01-18 19:14:07'),
('853e1640-5363-4d88-987a-c4757878b151', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '1', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:51', '2038-01-18 19:14:07'),
('85b906a8-54ce-4512-9b8e-688fa165ebbb', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:38', '2038-01-18 19:14:07'),
('9271a9aa-667c-45a2-b76d-037109b9eaa2', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:00', '2038-01-18 19:14:07'),
('962a4d48-700b-4196-ba73-45d2aef62222', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:04', '2038-01-18 19:14:07'),
('97977897-be9f-4438-92d7-e9614c5e1014', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:51', '2038-01-18 19:14:07'),
('9b4a5051-ec5c-4208-8e3e-a9173416995d', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:54', '2038-01-18 19:14:07'),
('a2942d53-ba32-40c6-b4fd-caab2a3eb83c', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:53', '2038-01-18 19:14:07'),
('aaad59b4-97d4-4c1a-9d42-a4cc52027ae6', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:53', '2038-01-18 19:14:07'),
('afb9161a-2b0c-4f8b-af44-7987460ef14f', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:59', '2038-01-18 19:14:07'),
('b1273aac-8566-4ea5-ba76-5c3d85f84e89', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:32', '2038-01-18 19:14:07'),
('b27a004e-5ef2-45a9-8500-ffb2abc7d417', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:23', '2038-01-18 19:14:07'),
('bca53ae4-5543-46e0-9a3f-4fabcc8480b0', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '2', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:00', '2038-01-18 19:14:07'),
('c0079ed6-e6bd-4ccd-abc7-817eae6d6a77', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:47', '2038-01-18 19:14:07'),
('c56cbb30-c63f-4ca9-8105-ff15cc35fbf7', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:09', '2038-01-18 19:14:07'),
('c74e9aea-b576-4a75-a8fd-76a7a3b69e8c', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:52', '2038-01-18 19:14:07'),
('c7bfac87-288d-4cab-b391-bef82af434ec', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:27', '2038-01-18 19:14:07'),
('cc6844fd-87ec-46aa-b47a-7a3b009b4d5a', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:33', '2038-01-18 19:14:07'),
('ce18bb2b-6fe5-4d97-93f1-2966ddef5a3f', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:53', '2038-01-18 19:14:07'),
('d35d46ac-c0e9-4099-8c19-e6595a034026', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:09', '2038-01-18 19:14:07'),
('e61d070f-b852-45f5-8a87-24e9d5fba02f', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:47', '2038-01-18 19:14:07'),
('f10c15e2-50c4-4b35-8b29-c1382555b4e6', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:49:46', '2038-01-18 19:14:07'),
('f1d982bf-d45e-4182-9d97-a9c39cf66f7a', 'A0350101', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:48:57', '2038-01-18 19:14:07'),
('fc775994-9bc3-4f94-be6a-b645d8cb9e9d', '', '我是測試產品', '測試', '', '123123.00', 213123, '測試', '', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/ipltppdac2iqofo7hu2s.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013671/id84bscatdbf3cd4xlxi.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/sikm69rxk7tt0cucxpwf.png,https://res.cloudinary.com/ddh6e9dad/image/upload/v1683013672/jzptrshdckcbeyxac933.png,', '2023-05-02 07:50:03', '2038-01-18 19:14:07');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `activity`
--
ALTER TABLE `activity`
  ADD PRIMARY KEY (`activityId`),
  ADD KEY `productid` (`productid`);

--
-- 資料表索引 `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `onlineProducts`
--
ALTER TABLE `onlineProducts`
  ADD PRIMARY KEY (`productid`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `activity`
--
ALTER TABLE `activity`
  ADD CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`productid`) REFERENCES `onlineProducts` (`productid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
