const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);
const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { json } = require("express");
const {
  adminRegValidation,
  adminLoginValidation,
  articleValid,
  foodValid,
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
        message: validError.details[0].message,
      });

    const { adminname, password, email } = req.body;

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
      // console.log(hashedPassword);
      // 新增使用者
      let adminId = Math.floor(1000000000 + Math.random() * 9000000000);
      const adminData = {
        admin_id: adminId,
        adminname,
        password: hashedPassword,
        email,
      };
      let insertSql = "INSERT INTO admins SET ?";
      const result = await query(insertSql, adminData);
      const affectedRows = result.affectedRows;
      if (affectedRows === 1) {
        res.status(201).json({
          success: true,
          message: `管理員資料新增 ${result.affectedRows}筆 成功 ${result.insertId}`,
          admin_id: adminId,
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
        message: validError.details[0].message,
      });
    }

    const { email, password } = req.body;
    // 檢查email是否已經存在
    const checkEmailSql = "SELECT * FROM admins WHERE email = ?";
    const checkResults = await query(checkEmailSql, [email]);
    if (checkResults.length === 0) {
      // email不存在
      return res.json({ success: false, message: "email 不存在" });
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
          exp: expDate,
        };
        let token = jwt.sign(tokenObj, process.env.PASSPORT_SECRET);
        return res.status(200).send({
          success: true,
          message: `管理員登入成功 `,
          admin_id: matchAdmin.admin_id,
          token: "JWT " + token,
          exp: expDate,
        });
      } else {
        // 密碼錯誤
        return res.json({
          success: false,
          message: `密碼錯誤 ${matchAdmin.adminId}`,
        });
      }
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤",
    });
  }
});

// check
router.post(
  "/check",
  adminPassport,
  (req, res) => {
    console.log("anything come this OK fn");
    return res.status(200).json({
      success: true,
      message: "已認證 Token",
      admin: req.user[0],
    });
  },
  (err, req, res, next) => {
    if (err) {
      return res.json({
        success: false,
        message: "Token 錯誤，請重新登入",
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
        message: validError.details[0].message,
      });

    const adminId = req.user[0].admin_id;
    const { title, sub_title, category, cover_image, content, is_published } =
      req.body;
    let articleId = uuidv4();
    const articleData = {
      article_id: articleId,
      admin_id: adminId,
      title: title,
      sub_title: sub_title,
      category: category,
      cover_image: cover_image,
      content: content,
      is_published: is_published,
    };
    const postArticleSql = "INSERT INTO articles SET ?";
    const postResult = await query(postArticleSql, articleData);
    const affectedRows = postResult.affectedRows;
    if (affectedRows > 0) {
      return res.status(200).json({
        success: true,
        message: "成功送出文章",
        admin_id: adminId,
        article_id: articleId,
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
        message: validError.details[0].message,
      });

    const { title, sub_title, category, cover_image, content, is_published } =
      req.body;

    const articleData = {
      title: title,
      sub_title: sub_title,
      category: category,
      cover_image: cover_image,
      content: content,
      is_published: is_published,
    };

    const updateSql =
      "UPDATE articles SET ? WHERE admin_id = ? AND article_id = ? ";

    const updateResult = await query(updateSql, [
      articleData,
      adminId,
      articleId,
    ]);
    const affectedRows = updateResult.affectedRows;
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "文章編輯成功",
        admin_id: adminId,
        article_id: articleId,
      });
    } else {
      res.json({
        success: false,
        message: "文章編輯失敗、找不到文章、編輯人不對",
      });
    }
  } catch {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤",
    });
  }
});

router.delete("/article/:article_id", adminPassport, async (req, res) => {
  try {
    const adminId = req.user[0].admin_id;
    const { article_id: articleId } = req.params;
    const delSql =
      "DELETE FROM articles WHERE admin_id = ? AND article_id = ? ";
    const { affectedRows } = await query(delSql, [adminId, articleId]);
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "已刪除文章",
      });
    } else {
      res.json({
        success: false,
        message: "找不到文章",
      });
    }
  } catch {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤",
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
        message: validError.details[0].message,
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
      trans_fat,
    } = req.body;
    let foodId = uuidv4();
    const foodData = {
      food_id: foodId,
      Calories: calories,
      Calories_adjusted: calories_adjusted,
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
      trans_fat,
    };
    const postSql = "INSERT INTO food SET ?";
    const { affectedRows } = await query(postSql, foodData);
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "已新增食物",
        food_name: sample_name,
      });
    } else {
      res.json({
        success: false,
        message: "新增食物失敗",
        food_name: sample_name,
      });
    }
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤",
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
        message: validError.details[0].message,
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
      trans_fat,
    } = req.body;

    const foodData = {
      food_id: foodId,
      Calories: calories,
      Calories_adjusted: calories_adjusted,
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
      trans_fat,
    };
    const updateSql = "UPDATE food SET ? WHERE food_id = ?";
    const { affectedRows } = await query(updateSql, [foodData, foodId]);
    if (affectedRows > 0) {
      res.status(200).json({
        success: true,
        message: "已更新食物資訊",
        food_name: sample_name,
      });
    } else {
      res.json({
        success: false,
        message: "更新食物資訊失敗",
      });
    }
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤",
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
        message: "已刪除食物資訊",
      });
    } else {
      res.json({
        success: false,
        message: "找不到食物資訊",
      });
    }
  } catch {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤",
    });
  }
});

// 新增商城產品的API
router.post("/addProducts", async (req, res) => {
  try {
    const productID = uuidv4();
    const { name, description, price, stock, category, image } = req.body;
    const productData = {
      productid: productID,
      name,
      description,
      price,
      stock,
      category,
      image,
    };
    const sql = "INSERT INTO onlineProducts SET ?";
    const { affectedRows } = await query(sql, productData);
    if (affectedRows >= 1) {
      res.status(201).json({
        success: true,
        message: "產品新增成功！",
      });
    } else {
      res.json({
        success: false,
        message: "產品新增失敗。",
      });
    }
  } catch (err) {
    console.error(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤。",
    });
  }
});

module.exports = router;
