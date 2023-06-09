const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);
const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const xss = require("xss");
const { json } = require("express");
const {
  adminRegValidation,
  adminLoginValidation,
  articleValid,
  foodValid
} = require("../models/validation");
const { adminPassport } = require("../models/passport");

// middleware
router.use((req, res, next) => {
  console.log("A request is coming in to AAAAAAAAAAdmin ROute!");
  next();
});

// routes
// async/await
router.post("/register", async (req, res) => {
  try {
    // 檢查傳入格式
    const { error: validError } = adminRegValidation(req.body);
    if (validError)
      return res.json({
        success: false,
        message: validError.details[0].message
      });

    const { adminname, password, email, avatar } = req.body;

    // 檢查email是否已經存在
    const checkEmailSql =
      "SELECT COUNT(*) AS count FROM admins WHERE email = ?";
    const checkResults = await query(checkEmailSql, [email]);
    let count = checkResults[0].count;
    if (count > 0) {
      // email已存在，傳回error
      res.json({ success: false, message: "email 已經存在" });
      return;
    } else {
      // email不存在
      // 密碼加密
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);
      const fAvatar = xss(avatar);

      // 新增使用者
      let adminId = Math.floor(1000000000 + Math.random() * 9000000000);
      const adminData = {
        admin_id: adminId,
        adminname,
        avatar: fAvatar,
        password: hashedPassword,
        email
      };
      let insertSql = "INSERT INTO admins SET ?";
      const result = await query(insertSql, adminData);
      const affectedRows = result.affectedRows;
      if (affectedRows === 1) {
        res.status(201).json({
          success: true,
          message: `管理員資料新增 ${result.affectedRows}筆 成功 ${result.insertId}`,
          admin_id: adminId
        });
      } else {
        res.json({ success: false, message: "無法新增管理員資料" });
      }
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "伺服器發生錯誤" });
  }
});

// login
router.post("/login", async (req, res) => {
  try {
    // 檢查輸入參數的格式
    const { error: validError } = adminLoginValidation(req.body);
    if (validError) {
      return res.json({
        success: false,
        message: validError.details[0].message
      });
    }

    const { email, password } = req.body;
    // 檢查email是否已經存在
    const checkEmailSql = "SELECT * FROM admins WHERE email = ?";
    const checkResults = await query(checkEmailSql, [email]);
    if (checkResults.length === 0) {
      // email不存在
      return res.status(404).json({ success: false, message: "email 不存在" });
    } else {
      const matchAdmin = checkResults[0];
      // 驗證密碼
      const isMatch = await bcrypt.compare(password, matchAdmin.password);
      if (isMatch) {
        // 密碼正確
        let expDate = Date.now() + 1000 * 60 * 60 * 24 * 7;
        const tokenObj = {
          _id: matchAdmin.admin_id,
          email: matchAdmin.email,
          exp: expDate
        };
        let token = jwt.sign(tokenObj, process.env.PASSPORT_SECRET);
        return res.status(200).send({
          success: true,
          message: `管理員登入成功 `,
          admin: {
            admin_id: matchAdmin.admin_id,
            adminname: matchAdmin.adminname,
            avatar: matchAdmin.avatar,
            email: matchAdmin.email
          },
          token: "JWT " + token,
          exp: expDate
        });
      } else {
        // 密碼錯誤
        return res.status(401).json({
          success: false,
          message: `密碼錯誤 ${matchAdmin.adminId}`
        });
      }
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

// check
router.post(
  "/check",
  adminPassport,
  (req, res) => {
    console.log("anything come this OK fn");
    const admin = req.user[0];
    const adminData = {
      admin_id: admin.admin_id,
      adminname: admin.adminname,
      avatar: admin.avatar,
      email: admin.email
    };
    return res.status(200).json({
      success: true,
      message: "已認證 Token",
      admin: adminData
    });
  },
  (err, req, res, next) => {
    if (err) {
      return res.json({
        success: false,
        message: "Token 錯誤，請重新登入"
      });
    }
  }
);

// articles
router.post("/article", adminPassport, async (req, res) => {
  try {
    const { error: validError } = articleValid(req.body);
    if (validError)
      return res.json({
        success: false,
        message: validError.details[0].message
      });

    const adminId = req.user[0].admin_id;
    const { title, sub_title, category, cover_image, content, is_published } =
      req.body;
    const fCover = xss(cover_image);
    const filterContent = xss(content);
    let articleId = uuidv4();
    const articleData = {
      article_id: articleId,
      admin_id: adminId,
      title: title,
      sub_title,
      category,
      cover_image: fCover,
      content: filterContent,
      is_published: is_published
    };
    const postArticleSql = "INSERT INTO articles SET ?";
    const postResult = await query(postArticleSql, articleData);
    const affectedRows = postResult.affectedRows;
    if (affectedRows > 0) {
      return res.status(200).json({
        success: true,
        message: "成功送出文章",
        admin_id: adminId,
        article_id: articleId
      });
    } else {
      res.json({ success: false, message: "無法新增文章" });
    }
  } catch (err) {
    console.log(err);
  }
});

router.put("/article/:article_id", adminPassport, async (req, res) => {
  try {
    const adminId = req.user[0].admin_id;
    const { article_id: articleId } = req.params;
    const { error: validError } = articleValid(req.body);
    if (validError)
      return res.json({
        success: false,
        message: validError.details[0].message
      });
    const { title, sub_title, category, cover_image, content, is_published } =
      req.body;
    const fCover = xss(cover_image);
    const filterContent = xss(content);
    const articleData = {
      admin_id: adminId,
      title: title,
      sub_title,
      category,
      cover_image: fCover,
      content: filterContent,
      is_published: is_published
    };

    const updateSql = "UPDATE articles SET ? WHERE article_id = ? ";
    const updateResult = await query(updateSql, [articleData, articleId]);
    const affectedRows = updateResult.affectedRows;
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "文章編輯成功",
        admin_id: adminId,
        article_id: articleId
      });
    } else {
      res.json({
        success: false,
        message: "文章編輯失敗、找不到文章、編輯人不對"
      });
    }
  } catch {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.delete("/article/:article_id", adminPassport, async (req, res) => {
  try {
    const { article_id: articleId } = req.params;
    const delSql = "DELETE FROM articles WHERE article_id = ? ";
    const { affectedRows } = await query(delSql, [articleId]);
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "已刪除文章"
      });
    } else {
      res.json({
        success: false,
        message: "找不到文章"
      });
    }
  } catch {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.post("/food", adminPassport, async (req, res) => {
  try {
    // const adminId = req.user[0].admin_id;
    const { error: validError } = foodValid(req.body);
    if (validError)
      return res.json({
        success: false,
        message: validError.details[0].message
      });
    const {
      category,
      sample_name,
      content_des,
      common_name,
      unit,
      popularity,
      calories,
      calories_adjusted,
      water,
      crude_protein,
      crude_fat,
      saturated_fat,
      carbohydrate,
      sodium,
      dietary_fiber,
      trans_fat
    } = req.body;
    let foodId = uuidv4();
    const foodData = {
      food_id: foodId,
      calories: calories,
      calories_adjusted: calories_adjusted,
      category,
      sample_name,
      content_des: content_des || "",
      common_name: common_name || "",
      unit,
      popularity: popularity || 0,
      water: water || 0,
      crude_protein,
      crude_fat: crude_fat || 0,
      saturated_fat,
      carbohydrate,
      sodium,
      dietary_fiber: dietary_fiber || 0,
      trans_fat: trans_fat || 0
    };
    const postSql = "INSERT INTO food SET ?";
    const { affectedRows } = await query(postSql, foodData);
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "已新增食物",
        food_name: sample_name,
        food_id: foodId
      });
    } else {
      res.json({
        success: false,
        message: "新增食物失敗",
        food_name: sample_name
      });
    }
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});
router.put("/food/food_id=:food_id", adminPassport, async (req, res) => {
  try {
    const foodId = req.params.food_id;
    const { error: validError } = foodValid(req.body);
    if (validError)
      return res.json({
        success: false,
        message: validError.details[0].message
      });
    const {
      category,
      sample_name,
      content_des,
      common_name,
      unit,
      popularity,
      calories,
      calories_adjusted,
      water,
      crude_protein,
      crude_fat,
      saturated_fat,
      carbohydrate,
      sodium,
      dietary_fiber,
      trans_fat
    } = req.body;

    const foodData = {
      food_id: foodId,
      calories: calories,
      calories_adjusted: calories_adjusted,
      category,
      sample_name,
      content_des,
      common_name,
      unit,
      popularity,
      water,
      crude_protein,
      crude_fat,
      saturated_fat,
      carbohydrate,
      sodium,
      dietary_fiber,
      trans_fat
    };
    const updateSql = "UPDATE food SET ? WHERE food_id = ?";
    const { affectedRows } = await query(updateSql, [foodData, foodId]);
    if (affectedRows > 0) {
      res.status(200).json({
        success: true,
        message: "已更新食物資訊",
        food_name: sample_name,
        food_id: foodId
      });
    } else {
      res.json({
        success: false,
        message: "更新食物資訊失敗"
      });
    }
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.delete("/food/food_id=:food_id", adminPassport, async (req, res) => {
  try {
    const foodId = req.params.food_id;
    const delSql = "DELETE FROM food WHERE food_id = ? ";
    const { affectedRows } = await query(delSql, [foodId]);
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "已刪除食物資訊"
      });
    } else {
      res.json({
        success: false,
        message: "找不到食物資訊"
      });
    }
  } catch {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

// 新增商城產品的API
router.post("/addProducts", async (req, res) => {
  try {
    const productID = uuidv4();
    const {
      activityId,
      name,
      description,
      storage_method,
      price,
      stock,
      category,
      image,
      food_id
    } = req.body;
    const productData = {
      productid: productID,
      activityId,
      name,
      description,
      storage_method,
      price,
      stock,
      category,
      image,
      food_id
    };
    const sql = "INSERT INTO onlineProducts SET ?";
    const { affectedRows } = await query(sql, productData);
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "產品新增成功！"
      });
    } else {
      res.json({
        success: false,
        message: "產品新增失敗。"
      });
    }
  } catch (err) {
    console.error(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤。"
    });
  }
});

// 更新產品
router.put("/products/:product_id", adminPassport, async (req, res) => {
  try {
    const productId = req.params.product_id;
    const {
      activityId,
      name,
      description,
      storage_method,
      price,
      stock,
      category,
      image,
      food_id
    } = req.body;
    const fImg = xss(image);
    const productData = {
      activityId,
      name,
      description,
      storage_method,
      price,
      stock,
      category,
      image: fImg,
      food_id
    };
    const sql = "UPDATE onlineProducts SET ? WHERE productid = ?";
    const { affectedRows } = await query(sql, [productData, productId]);
    if (affectedRows >= 1) {
      res.status(200).json({
        success: true,
        message: "產品更新成功！"
      });
    } else {
      res.json({
        success: false,
        message: "產品更新失敗。"
      });
    }
  } catch (err) {
    console.error(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤。"
    });
  }
});
router.delete("/products/:product_id", adminPassport, async (req, res) => {
  try {
    const productId = req.params.product_id;

    const sql = "DELETE FROM onlineProducts WHERE productid = ?";
    const { affectedRows } = await query(sql, [productId]);
    if (affectedRows >= 1) {
      res.status(200).json({
        success: true,
        message: "產品刪除成功！"
      });
    } else {
      res.json({
        success: false,
        message: "產品刪除失敗。"
      });
    }
  } catch (err) {
    console.error(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤。"
    });
  }
});

//會員列表
router.get("/user_list", adminPassport, async (req, res) => {
  try {
    const { page, per_page } = req.query;
    // 確認頁數
    let perPage = parseInt(per_page) || 20;
    let nowPage = parseInt(page) || 1;
    const countSql = "SELECT COUNT(*) AS total_count FROM users ";
    const [{ total_count: totalCount }] = await query(countSql);
    let totalPages = Math.ceil(totalCount / perPage);
    nowPage = nowPage > totalPages ? totalPages : nowPage;
    // 取得會員列表
    let getSql =
      "SELECT user_id, username, email, avatar, gender, birthday, phone, address FROM users ORDER BY created_at DESC ";
    let getParams = [];
    if (!isNaN(nowPage) && nowPage > 0) {
      getSql += "LIMIT ? OFFSET ? ";
      getParams.push(perPage);
      getParams.push((nowPage - 1) * perPage);
    }
    const getResults = await query(getSql, getParams);
    const paginations = {
      total_pages: totalPages,
      current_page: nowPage,
      per_page: perPage,
      has_pre: nowPage >= 2,
      has_next: nowPage < totalPages
    };
    if (getResults.length > 0) {
      res.status(200).json({
        success: true,
        message: "已取得會員列表",
        user_qty: totalCount,
        users: getResults,
        paginations
      });
    } else {
      res.json({
        success: false,
        message: "沒有會員"
      });
    }
  } catch {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

//訂單

router.get("/orders", adminPassport, async (req, res) => {
  try {
    let getquery = "SELECT * FROM orders WHERE 1=1";
    const params = [];

    // 如果有產品ID參數，則加上產品ID條件
    if (req.query.productid) {
      const productId = req.query.productid;
      getquery +=
        " AND order_id IN (SELECT order_id FROM order_details WHERE productid = ?)";
      params.push(productId);
    }

    // 如果有狀態參數，則加上狀態條件
    if (req.query.status) {
      const status = req.query.status;
      getquery += " AND status = ?";
      params.push(status);
    }

    // 如果有時間範圍參數，則加上時間範圍條件
    if (req.query.start_date && req.query.end_date) {
      const startDate = req.query.start_date;
      const endDate = req.query.end_date;
      getquery += " AND order_time BETWEEN ? AND ?";
      params.push(startDate, endDate);
    }
    getquery += " ORDER BY create_time DESC";
    // 執行查詢

    const getOrdersResults = await query(getquery, params);

    if (getOrdersResults.length > 0) {
      const orderIds = getOrdersResults
        .map((orders) => `'${orders.order_id}'`)
        .join(",");
      const getOrderDetailsSql = `SELECT * , onlineproducts.* FROM  order_details JOIN onlineproducts WHERE order_id IN (${orderIds})`;
      const getOrderDetailsResults = await query(getOrderDetailsSql);
      const orders = getOrdersResults.map((orders) => {
        orders.order_details = getOrderDetailsResults.filter(
          (detail) => detail.order_id === orders.order_id
        );
        orders.order_details.forEach((product) => {
          product.image = product.image
            .split(",")
            .filter((img) => img.trim() !== "");
        });
        return orders;
      });
      res.status(200).json({
        success: true,
        data: orders
      });
    } else {
      return res.status(404).json({
        success: false,
        message: "沒有任何符合條件的紀錄"
      });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.put("/orders/:order_id", adminPassport, async (req, res) => {
  try {
    const orderId = req.params.order_id;
    const {
      user_id,
      phone,
      name,
      coupon_code,
      total_quantity,
      total_price,
      payment_method,
      shipping_method,
      shipping_address,
      ship_store,
      status
    } = req.body;

    const updateSql =
      "UPDATE orders SET user_id = ?, phone = ?, name = ?, coupon_code = ?, total_quantity = ?, total_price = ?, payment_method = ?, shipping_method = ?, shipping_address = ?, ship_store = ?, status = ? WHERE order_id = ?";
    const params = [
      user_id,
      phone,
      name,
      coupon_code,
      total_quantity,
      total_price,
      payment_method,
      shipping_method,
      shipping_address,
      ship_store,
      status,
      orderId
    ];
    const { affectedRows } = await query(updateSql, params);

    if (affectedRows > 0) {
      res.status(200).json({
        success: true,
        message: "已更新訂單"
      });
    } else {
      res.json({
        success: false,
        message: "更新訂單失敗"
      });
    }
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.delete("/orders/:order_id", adminPassport, async (req, res) => {
  try {
    const orderId = req.params.order_id;
    const deleteOrderSql = "DELETE FROM orders WHERE order_id = ?";
    const deleteOrderDetailSql = "DELETE FROM order_details WHERE order_id = ?";
    const { affectedRows: orderRows } = await query(deleteOrderSql, [orderId]);
    const { affectedRows: orderDetailRows } = await query(
      deleteOrderDetailSql,
      [orderId]
    );

    if (orderRows > 0 && orderDetailRows > 0) {
      res.status(200).json({
        success: true,
        message: "已刪除訂單"
      });
    } else {
      res.json({
        success: false,
        message: "刪除訂單失敗"
      });
    }
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

// 優惠券
router.post("/coupon", adminPassport, async (req, res) => {
  try {
    const {
      code,
      name,
      discount_rate,
      discount_algorithm,
      description,
      usage_limit,
      start_date,
      end_date
    } = req.body;
    const [coupon] = await query("SELECT * FROM coupons WHERE code = ?", [
      code
    ]);
    if (coupon) {
      return res.status(400).json({
        success: false,
        message: "該優惠券代碼已存在"
      });
    }
    await query(
      "INSERT INTO coupons (code, name, discount_rate, discount_algorithm, description, usage_limit, start_date, end_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [
        code,
        name,
        discount_rate,
        discount_algorithm,
        description,
        usage_limit,
        start_date,
        end_date
      ]
    );
    res.json({
      success: true,
      message: "新增優惠券成功"
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: "發生錯誤，請稍後再試"
    });
  }
});

// GET /coupon
// 取得所有優惠券列表
router.get("/coupon", adminPassport, async (req, res) => {
  try {
    const coupons = await query("SELECT * FROM coupons");
    res.json({
      success: true,
      data: coupons
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: "發生錯誤，請稍後再試"
    });
  }
});

// PUT /coupon/:id
// 修改指定優惠券
router.put("/coupon/:coupon_id", adminPassport, async (req, res) => {
  try {
    const { coupon_id } = req.params;
    const {
      name,
      discount_rate,
      discount_algorithm,
      description,
      usage_limit,
      start_date,
      end_date
    } = req.body;

    const [coupon] = await query("SELECT * FROM coupons WHERE coupon_id = ?", [
      coupon_id
    ]);
    if (!coupon) {
      return res.status(404).json({
        success: false,
        message: "找不到該優惠券"
      });
    }

    await query(
      "UPDATE coupons SET name=?, discount_rate=?, discount_algorithm=?, description=?, usage_limit=?, start_date=?, end_date=? WHERE coupon_id=?",
      [
        name,
        discount_rate,
        discount_algorithm,
        description,
        usage_limit,
        start_date,
        end_date,
        coupon_id
      ]
    );

    res.json({
      success: true,
      message: "修改優惠券成功"
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

// 刪除指定優惠券
router.delete("/coupon/:code", adminPassport, async (req, res) => {
  try {
    const { code } = req.params;

    const [coupon] = await query("SELECT * FROM coupons WHERE code = ?", [
      code
    ]);
    if (!coupon) {
      return res.status(404).json({
        success: false,
        message: "找不到該優惠券"
      });
    }

    await query("DELETE FROM coupons WHERE code = ?", [code]);

    res.json({
      success: true,
      message: "刪除優惠券成功"
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: "發生錯誤，請稍後再試"
    });
  }
});

module.exports = router;
