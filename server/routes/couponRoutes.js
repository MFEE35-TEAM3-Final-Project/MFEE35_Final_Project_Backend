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
router.post('/use', async (req, res) => {
  try {
    const { code } = req.body;
    const [coupon] = await query('SELECT * FROM coupons WHERE code = ?', [code]);
    if (!coupon) {
      return res.status(400).json({
        success: false,
        message: '該優惠券代碼不存在'
      });
    };
    res.json({
      success: true,
      message: coupon
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: '發生錯誤，請稍後再試'
    });
  }
});

module.exports = router;