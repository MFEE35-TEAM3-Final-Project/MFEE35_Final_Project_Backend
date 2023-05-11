const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);
const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const {
  registerValidation,
  loginValidation,
  exerciseRecordsValidation,
  articleMegValid,
  mealRecordValid
} = require("../models/validation");
const xss = require("xss");

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


module.exports = router;