-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主機： localhost:8889
-- 產生時間： 2023 年 05 月 17 日 06:53
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
-- 資料表結構 `onlineProducts`
--

CREATE TABLE `onlineProducts` (
  `productid` varchar(50) NOT NULL,
  `food_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
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
('166ed422-68f6-41d4-9b6d-76494fd52922', '051712', '地中海時蔬餐盒', '吃了該不會就會得地中海吧', '冷藏', '139.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304834/zphoe2l3wspxryhysajm.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304834/xnzpj1lnuxfvjhygq19h.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304835/kmeltioykelbevkdoo9n.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304836/yhds1yuewekxdpgbf6ye.jpg,', '2023-05-17 06:27:19', '2038-01-18 19:14:07'),
('1ab2ab7e-7324-48c3-b3b8-25c2941a5ef5', '051714', '蒜香台灣豬肉片餐盒', '台灣豬好彳拉', '冷藏', '259.00', 100, '餐盒', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304981/fug1blcawhy7fdln7opm.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304982/frvrg0w7kqvtvvtekjl6.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304984/psgshuibnqwz8vunxpwr.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304993/ionyc3kkel6v45nwjv1e.jpg,', '2023-05-17 06:30:09', '2038-01-18 19:14:07'),
('314607fb-fe79-499d-8c11-d75ce3916b5b', '1112', '100%全分離乳清|芋頭牛奶', '敲好喝', '常溫', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306305/z418dh8krckgwa0nrtri.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306315/duogpgfvtswg9obnnpyp.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306316/peimcxozdq9lrwbeogzx.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306316/eewree4rwscva8jfee6b.jpg,', '2023-05-17 06:51:59', '2038-01-18 19:14:07'),
('3e184959-a4cc-4f04-8c66-a8c6a469eb05', '05173', '舒肥墨西哥莎莎雞胸餐盒', '辣到哭墨西哥口味', '冷藏', '199.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304135/adlqf0mzbc13onyragfl.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304135/hcxlec2nizymsrorxfly.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304137/hqyaa1hpavqavgyfmgyv.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304142/am9chceg39wndhju6h0m.webp,', '2023-05-17 06:15:45', '2038-01-18 19:14:07'),
('40f6886f-d070-41d2-b583-6c817fa9a6a4', '051711', '挪威鹽烤鯖魚餐盒', '挪威人聽說都很勇哦', '冷藏', '189.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304697/dwz6d3gmlpa9u7o4fhlt.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304699/lptxaxmtpqss4la0yk28.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304699/ptnf1c4bvddjiqarjyau.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304701/itnamrbokq13tkcx2xpi.webp,', '2023-05-17 06:25:04', '2038-01-18 19:14:07'),
('50b0d8e1-0342-408b-af6e-12c38a020b83', '9999', '100%全分離乳清|花生芝麻', '', '常溫', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306240/smjg77llb6j3toujjn33.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306248/e6ixpfaadunw0wb5jqw5.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306249/xtqh84d3xislrwligigr.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306249/uuk9onwz8jghl2ojg8pv.jpg,', '2023-05-17 06:50:52', '2038-01-18 19:14:07'),
('51b46e7f-5fb4-42cf-a72b-b0bf4a82f60f', '051715', '泰式打拋餐盒', '別要很辣吧QQ', '冷藏', '179.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305049/jvb4wuwacjhhy9ugtdki.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305056/hzourygovh0oe99tmsg0.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305058/da3ubotyelrzkajlvk26.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305058/zmj2zslmcwqivmzqpyjp.webp,', '2023-05-17 06:31:04', '2038-01-18 19:14:07'),
('5cbfb6f8-d197-406a-a0ef-22d9d575c780', '051713', '法式水煮雞胸肉餐盒', '法式該不會給我沾芥末醬吧', '冷藏', '169.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304889/nmzvpdyrrhumgkyqwn6f.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304889/tn9psijzjw1lra0wafdq.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304890/kdpfqc2isaegkf2qzt5z.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304910/rckqb5j1fkkkznr53wyj.jpg,', '2023-05-17 06:28:33', '2038-01-18 19:14:07'),
('5f5a1f45-84e7-4b6d-ae83-a53eb2f995bb', '051716', '泰式舒肥雞胸肉', '肉片咩', '冷藏', '89.00', 100, '雞胸肉', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305287/xtjpfwfz0qzueoinmjcz.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305294/yudawawyedptn9v0kgfn.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305294/b9toieljsu6kk6mz4xci.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305295/mx8sq1k4k5uykscvnrnp.jpg,', '2023-05-17 06:35:04', '2038-01-18 19:14:07'),
('60b284ad-e6c1-4141-9ed8-093b72c19108', '05171', '輕輕蔬食餐盒', '就是菜菜餐盒', '冷藏', '149.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684303984/wpipeiy5ow1l1ca1dd2v.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684303985/nim1ouqcqjqrub3qrhto.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684303985/wucelyeti6anpdvsihms.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684303986/rcvgy3ofhpclnysziei4.webp,', '2023-05-17 06:13:10', '2038-01-18 19:14:07'),
('69d015ef-1168-48b3-98fd-ba7e19bf4438', '05176', '法式蒜香板腱牛排餐盒', '感覺就很柴啊', '冷藏', '289.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304398/sbo466fn0ozzzcc4y4wn.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304398/cixcqpfctlivbltg5jeb.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304399/coajvgfese4rwc7lcjko.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304406/c8i2cyply7n86q3r2n4f.webp,', '2023-05-17 06:20:12', '2038-01-18 19:14:07'),
('6d824040-798a-40a4-ab17-5c7ef19c9786', '1111', '100%全分離乳清|芝麻牛奶', '芝麻', '冷藏', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305714/fxnnlgusd2lhtrnoygfw.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305722/uymeiietdk8kv2ubyvun.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305724/fpp3ctf4qovbjnw2fmno.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305724/drxu9cws35au7w8uzqre.jpg,', '2023-05-17 06:42:07', '2038-01-18 19:14:07'),
('783b0b8d-bfdd-4689-a62a-c6b91e4352cd', '5555', '100%全分離乳清|草莓牛奶', '', '常溫', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306042/ayl6hxk2n1kchoulezuq.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306049/df7yfntuypbqkdrtzdpe.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306050/vqa5k4imqjo39fettjva.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306052/hkwpmcw4s3gclhubpjhz.jpg,', '2023-05-17 06:47:37', '2038-01-18 19:14:07'),
('8588d8ce-0947-42c5-8942-ca4f2ff92f65', '05174', '舒肥酪梨優格雞胸餐盒', '酪梨不知道配優格會拉肚子吧', '冷藏', '219.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304243/oejmgdc0qazvxnfpnrbd.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304245/p4wwhkwkjnu5smmdiudv.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304245/zm4tcnul9t68siabqqem.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304246/oxxzhrrk8bynm4vqxadu.webp,', '2023-05-17 06:17:29', '2038-01-18 19:14:07'),
('8a335e61-cc7e-47dc-bc3c-8c3abe44c73c', '7777', '100%全分離乳清|巧克力', '', '常溫', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306146/l5c6ljm5ymq7bsttfpfs.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306154/p9axzrnpgk2be1dfcjuc.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306155/prs2ewf2qbhfwlzvtpup.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306157/v2mlgss4v2fuoeddwbc1.jpg,', '2023-05-17 06:49:19', '2038-01-18 19:14:07'),
('8d00332f-a12b-4259-a8b3-db5a3122755f', '05179', '阿嬤的滷牛腱心餐盒', '阿嬤的口味你敢質疑?', '冷藏', '219.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304590/pluuzr7rg5rforgq5cyr.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304591/cbes1hlv4zanyh5qilhn.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304593/zxecyyxvr3uccljn72yo.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304594/jntx2jp0cpliir5k0j6m.webp,', '2023-05-17 06:23:18', '2038-01-18 19:14:07'),
('a79a8fca-ad67-40db-a464-1fb1f880f412', '2222', '100%全分離乳清|原味', '', '冷藏', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305789/skwwam3t5ofbkaoc2wim.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305799/hmrfoz7kqze5yncisf6w.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305800/zoqbje4fc6edj369uwl2.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305803/db5rbzu4arobdkchj0mn.jpg,', '2023-05-17 06:43:27', '2038-01-18 19:14:07'),
('a82f7936-51b1-4d4f-a06a-dd7f9afaa4f9', '8888', '100%全分離乳清|奶茶', '', '常溫', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306200/v7e4rqufwhhwqvrvnlky.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306207/rbbk11gfsxddf9ltzzo9.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306208/rux073xspwvuq4u5o98e.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306209/uaoxrrg1zmjzsubly6ll.jpg,', '2023-05-17 06:50:11', '2038-01-18 19:14:07'),
('b0b231f5-1ff1-4236-bbf9-6eade0fef146', '05172', '炙燒青檸鮭魚餐盒', '鮭魚敲好吃', '冷藏', '189.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304069/mz7t3ucc8mr6jl4f0wum.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304070/g389dftenqw2utalsct7.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304070/nfjfivnshxma458wbi6j.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304072/w97pbri4tebuteikcho5.webp,', '2023-05-17 06:14:35', '2038-01-18 19:14:07'),
('b4bcd897-455c-4325-98e3-1740f5f97fb5', '6666', '100%全分離乳清|麥芽牛奶', '', '常溫', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306084/y8pz5vdcuvrbkh2zfked.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306091/voxqrhdr0bpitylattk2.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306091/i4inagds7fbf6wr10cjw.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306092/wzouibcdvrfrf9mo8txs.jpg,', '2023-05-17 06:48:15', '2038-01-18 19:14:07'),
('bcd8b525-22bb-45ff-b2d0-acdce18c2b0b', '05177', '七味子滑蛋鯛魚餐盒', '滑蛋加辣是邪教吧', '冷凍', '199.00', 100, '餐盒', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304488/qe9yb4hp2ix5y0cgovwz.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304488/pqo0ltmtyuosmj4fmtpv.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304491/bx5bhnfhfnjb2oohbsqp.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304491/rppyh5huetvupj2bpv5p.webp,', '2023-05-17 06:21:34', '2038-01-18 19:14:07'),
('ca24dcfd-70cc-4fe2-b58d-e5c0a15c57fa', '051719', '椒鹽舒肥雞胸肉', '椒鹽是炸的吧', '冷藏', '89.00', 100, '雞胸肉', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305549/igz9wog2arevtss6hr3s.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305556/zrfzta8dbfjxtwdrpez6.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305556/opdnxgerhwjtsxsm5pny.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305557/rb8mi8wbnaunacmoakij.jpg,', '2023-05-17 06:39:19', '2038-01-18 19:14:07'),
('cb641d52-773e-4cc0-95dc-d95ce34a582d', '051717', '辣子舒肥雞胸肉', '很辣', '冷藏', '89.00', 100, '雞胸肉', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305378/a3c5vtk65pk06el9jwue.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305385/jpwevrkin2tpbo2bb2qk.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305385/kyzpkjyscfvbzjk3r02k.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305386/mvskzw8rkzs3s9euondl.jpg,', '2023-05-17 06:36:29', '2038-01-18 19:14:07'),
('ccfc8e9a-a93e-4b20-9f51-635a71391459', '051710', '義國風情雞腿排餐盒', '最好是給我符合台灣味哦', '冷藏', '179.00', 100, '餐盒', '2', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304642/wjs4llzggozbiytdxo1o.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304642/qridi0ujpgrj3luno5zl.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304643/pschwamzz3lj0siq8zxc.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304644/zn1u4udyycdzommh4uqt.webp,', '2023-05-17 06:24:07', '2038-01-18 19:14:07'),
('d5ff3a62-5617-46b7-8d59-ee7715643f7c', '4444', '100%全分離乳清|乳酸', '', '常溫', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305996/egtwfohjdnsut5tuhdmn.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306005/b8k7mfzh47yrerdmzf8n.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306005/kpbr6zirsaki8v26n70d.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684306006/xdkviyaxtwxwt0klbnvd.jpg,', '2023-05-17 06:46:50', '2038-01-18 19:14:07'),
('de8e7bca-809f-4db6-a3fe-4bf5610a500f', '05175', '薄鹽嫩烤牛肉片餐盒', '最好肉片給我大片點', '冷藏', '249.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304312/mqtamqbka9jvofturjwy.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304313/svkomljjylqftvg1lz25.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304314/pfybiwkdw3nvuynv97gd.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304314/o5yll1basa5lh8f3ro1y.webp,', '2023-05-17 06:19:05', '2038-01-18 19:14:07'),
('dec66446-e76e-40da-9b82-e2cc35da6a3e', '3333', '100%全分離乳清|抹茶', '', '常溫', '59.00', 100, '乳清蛋白', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305948/vzvgfwa56s68eqp9366l.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305954/bgiww1y2oa1wensnh8w9.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305955/w5abefuk77fwve9jveh2.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305958/s0maofr6swxhxbe9zhwa.jpg,', '2023-05-17 06:46:01', '2038-01-18 19:14:07'),
('e8fb8ecf-b400-4a71-bb08-5dbfa55c2ec0', '05178', '黑胡椒嫩煎雞胸餐盒', '為啥不弄舒肥', '冷藏', '179.00', 100, '餐盒', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304540/i4rm5pdza1wzeewhbkbf.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304540/cq5uy9rptspihyx3gvm3.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304542/nx6ro3maoue3cmjjpsjq.webp,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684304543/pc27rmt96ffvedhvbv3f.webp,', '2023-05-17 06:22:26', '2038-01-18 19:14:07'),
('fbbbdc56-4774-43b5-9edb-fce2e8db217a', '051718', '沙漠湖鹽舒肥雞胸肉', '沙漠的特好吃嗎', '冷藏', '99.00', 100, '雞胸肉', '1', 'https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305504/zekcusu3su5sko15ceob.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305509/qvmqjmswwqubdrybypwx.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305509/d6wf5jaqxylefykrvkwx.jpg,https://res.cloudinary.com/ddh6e9dad/image/upload/v1684305509/v4dtqsxuef1iw9js8yyr.jpg,', '2023-05-17 06:38:34', '2038-01-18 19:14:07');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `onlineProducts`
--
ALTER TABLE `onlineProducts`
  ADD PRIMARY KEY (`productid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
