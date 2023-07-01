const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);

// middleware
router.use((req, res, next) => {
  console.log("有人要瀏覽商品清單了喔~");
  next();
});

// 根據 產品id來進行分類,若沒有帶初值為提取全部的產品
// router.get("/getProductsById", async (req, res) => {
//   try {
//     const { productId } = req.query || "";
//     if (productId === "") {
//       const sql = "SELECT * FROM online_products";
//       const results = await query(sql);
//       results.forEach((product) => {
//         product.image = product.image
//           .split(",")
//           .filter((img) => img.trim() !== "");
//       });
//       return res.json(results);
//     } else {
//       const sql = "SELECT * FROM online_products WHERE productId = ?";
//       const results = await query(sql, [productId]);
//       results.forEach((product) => {
//         product.image = product.image
//           .split(",")
//           .filter((img) => img.trim() !== "");
//       });
//       return res.json(results);
//     }
//   } catch (err) {
//     console.error(err);
//     return res.sendStatus(500);
//   }
// });
router.get("/getProductsById", async (req, res) => {
  try {
    const { productId } = req.query || "";
    let sql;
    if (productId === "") {
      sql =
        "SELECT online_products.*, activity.activityDiscount FROM online_products LEFT JOIN activity ON online_products.activityId = activity.activityId";
    } else {
      sql =
        "SELECT online_products.*, activity.activityDiscount FROM online_products LEFT JOIN activity ON online_products.activityId = activity.activityId WHERE online_products.productId = ?";
    }
    const results = await query(sql, [productId]);
    results.forEach((product) => {
      product.image = product.image
        .split(",")
        .filter((img) => img.trim() !== "");
      product.afterPrice = Math.round(product.price * product.activityDiscount);
      product.discountedPrice = Math.round(product.price - product.afterPrice);
    });
    return res.json(results);
  } catch (err) {
    console.error(err);
    return res.sendStatus(500);
  }
});

// 根據看是種類 還是活動ID
router.get("/getProducts", async (req, res) => {
  try {
    const { category, activityId, page = 1 } = req.query || "";
    const limit = 12;
    const offset = (page - 1) * limit;

    let countSql = "SELECT COUNT(*) AS count FROM online_products";
    let querySql =
      // "SELECT * FROM online_products LIMIT ? OFFSET ?";
      "SELECT online_products.*, activity.activityDiscount FROM online_products LEFT JOIN activity ON online_products.activityId = activity.activityId LIMIT ? OFFSET ?";
    let queryParams = [limit, offset];

    if (category) {
      countSql =
        "SELECT COUNT(*) AS count FROM online_products WHERE category = ?";
      querySql =
        "SELECT online_products.*, activity.activityDiscount FROM online_products LEFT JOIN activity ON online_products.activityId = activity.activityId WHERE category = ? LIMIT ? OFFSET ?";
      queryParams = [category, limit, offset];
    } else if (activityId) {
      countSql =
        "SELECT COUNT(*) AS count FROM online_products WHERE activityId = ?";
      querySql =
        "SELECT online_products.*, activity.activityDiscount FROM online_products LEFT JOIN activity ON online_products.activityId = activity.activityId WHERE online_products.activityId = ? LIMIT ? OFFSET ?";

      queryParams = [activityId, limit, offset];
    }

    const countResult = await query(countSql, queryParams);
    const count = countResult[0].count;
    const totalPages = Math.ceil(count / limit);

    const results = await query(querySql, queryParams);
    results.forEach((product) => {
      product.image = product.image
        .split(",")
        .filter((img) => img.trim() !== "");
      product.afterPrice = Math.round(product.price * product.activityDiscount);
      product.discountedPrice = Math.round(product.price - product.afterPrice);
    });

    return res.json({ totalPages, results });
  } catch (err) {
    console.error(err);
    return res.sendStatus(500);
  }
});

module.exports = router;
