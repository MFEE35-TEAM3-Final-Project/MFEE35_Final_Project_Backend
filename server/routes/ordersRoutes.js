const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);
const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// middleware
router.use((req, res, next) => {
  console.log("A request is coming in to orderRRRRRR!");
  next();
});

//根據query查詢訂單(非會員)
router.get('/search', async (req, res) => {
  try {
    const { email, order_id } = req.query;

    let getOrdersSql = "SELECT * FROM orders WHERE ";
    const sqlParams = [];

    if (email) {
      getOrdersSql += " email = ? AND ";
      sqlParams.push(email);
    }

    if (order_id) {
      getOrdersSql += " order_id = ? AND ";
      sqlParams.push(order_id);
    }

    getOrdersSql = getOrdersSql.slice(0, -4);

    const orders = await query(getOrdersSql, sqlParams);

    if (!orders.length) {
      return res.status(404).json({
        success: false,
        message: "找不到任何訂單",
      });
    }

    const orderDetailsPromises = orders.map(async order => {
      const { order_id } = order;
      const getOrderDetailsSql = "SELECT order_details.quantity, order_details.price, onlineproducts.* FROM order_details JOIN onlineproducts ON order_details.productid = onlineproducts.productid WHERE order_id = ?";
      const orderDetails = await query(getOrderDetailsSql, [order_id]);
      return {
        ...order,
        order_details: orderDetails,
      };
    });

    const ordersWithDetails = await Promise.all(orderDetailsPromises);

    res.status(200).json({
      success: true,
      data: ordersWithDetails
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      message: "伺服器錯誤",
    });
  }
});

router.post("/order", async (req, res) => {
  try {
    const status = "created";
    const order_id = uuidv4();

    const {
      phone,
      name,
      email,
      coupon_code,
      total_quantity,
      total_price,
      payment_method,
      shipping_address,
      ship_store,
      order_details
    } = req.body;
    let user_id = null
    if (!order_details || order_details.length === 0) {
      return res.status(400).json({
        success: false,
        message: "訂單詳情為空"
      });
    }

    // 驗證商品庫存
    const invalidDetails = await Promise.all(
      order_details.map(async (detail) => {
        const { productid, quantity } = detail;
        const [product] = await query(
          "SELECT stock FROM onlineproducts WHERE productid = ?",
          [productid]
        );
        if (product.stock < quantity) {
          return productid;
        }
        return null;
      })
    ).then((productIds) => productIds.filter((id) => id !== null));

    if (invalidDetails.length > 0) {
      return res.status(400).json({
        success: false,
        message: `商品 ${invalidDetails.join(", ")} 庫存不足`
      });
    }

    if (coupon_code) {
      const [coupon] = await query("SELECT * FROM coupons WHERE code = ?", [
        coupon_code
      ]);
      if (coupon) {
        if (coupon.usage_count >= coupon.usage_limit) {
          return res.status(400).json({
            success: false,
            message: "優惠券已達到使用上限"
          });
        } else {
          const updateSql =
            "UPDATE coupons SET usage_count = usage_count + 1 WHERE code = ?";
          await query(updateSql, [coupon_code]);
        }
      } else {
        return res.status(400).json({
          success: false,
          message: "優惠券不存在"
        });
      }
    }

    const postSql =
      "INSERT INTO orders (order_id, user_id, phone, name,email,coupon_code, total_quantity, total_price, payment_method, shipping_address, ship_store, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    const orderValues = [
      order_id,
      user_id,
      phone,
      name,
      email,
      coupon_code,
      total_quantity,
      total_price,
      payment_method,
      shipping_address,
      ship_store,
      status
    ];
    const result = await query(postSql, orderValues);

    const detailInsertPromises = order_details.map((detail) => {
      const { productid, quantity, price } = detail;
      const addDetailSql =
        "INSERT INTO order_details (order_id, productid, quantity, price) VALUES (?, ?, ?, ?)";
      const detailValues = [order_id, productid, quantity, price];
      return query(addDetailSql, detailValues);
    });

    const detailUpdatePromises = order_details.map((detail) => {
      const { productid, quantity } = detail;
      const updateProductSql =
        "UPDATE onlineproducts SET stock = stock - ? WHERE productid = ?";
      const updateValues = [quantity, productid];
      return query(updateProductSql, updateValues);
    });

    await Promise.all([...detailInsertPromises, ...detailUpdatePromises]);

    res.status(201).json({
      success: true,
      message: `訂單新增成功，訂單ID為 ${order_id}`,
      orderId: order_id
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});


module.exports = router;