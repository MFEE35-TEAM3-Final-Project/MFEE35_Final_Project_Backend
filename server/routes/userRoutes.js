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
const { userPassport } = require("../models/passport");
const xss = require("xss");

// middleware
router.use((req, res, next) => {
  console.log("A request is coming in to userRoute!");
  next();
});

// routes
// async/await
router.post("/register", async (req, res) => {
  try {
    // 檢查傳入格式
    const { error: validError } = registerValidation(req.body);
    if (validError)
      return res.json({
        success: false,
        message: validError.details[0].message
      });

    const { email, password, username, phone, address } = req.body;

    // 檢查email是否已經存在
    const checkEmailSql = "SELECT COUNT(*) AS count FROM users WHERE email = ?";
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

      // 新增使用者
      let userId = Math.floor(1000000000 + Math.random() * 9000000000);
      const userData = {
        user_id: userId,
        email,
        password: hashedPassword,
        username,
        phone,
        address
      };
      let insertSql = "INSERT INTO users SET ?";
      const result = await query(insertSql, userData);
      const affectedRows = result.affectedRows;
      if (affectedRows === 1) {
        res.status(201).json({
          success: true,
          message: `會員資料新增 ${result.affectedRows}筆 成功 ${result.insertId}`,
          user_id: userId
        });
      } else {
        res.json({ success: false, message: "無法新增會員資料" });
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
    // 檢查輸入資料的格式
    const { error: validError } = loginValidation(req.body);
    if (validError) {
      return res.json({
        success: false,
        message: validError.details[0].message
      });
    }

    const { email, password } = req.body;
    // 檢查email是否已經存在
    const checkEmailSql = "SELECT * FROM users WHERE email = ?";
    const checkResults = await query(checkEmailSql, [email]);

    if (checkResults.length === 0) {
      // email不存在
      return res.json({ success: false, message: "email 不存在" });
    } else {
      const matchUser = checkResults[0];
      // 驗證密碼
      const isMatch = await bcrypt.compare(password, matchUser.password);
      if (isMatch) {
        // 密碼正確
        let expDate = Date.now() + 1000 * 60 * 60 * 24 * 100;
        const tokenObj = {
          _id: matchUser.user_id,
          email: matchUser.email,
          exp: expDate
        };
        let token = jwt.sign(tokenObj, process.env.PASSPORT_SECRET);

        return res.status(200).send({
          success: true,
          message: `會員登入成功`,
          user_id: matchUser.user_id,
          token: "JWT " + token,
          exp: expDate
        });
      } else {
        // 密碼錯誤
        return res.json({
          success: false,
          message: `密碼錯誤 ${matchUser.user_id}`
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
  userPassport,
  (req, res) => {
    console.log("anything come this OK fn");
    return res.status(200).json({
      success: true,
      message: "已認證 Token",
      user: req.user
    });
  },
  (err, req, res, next) => {
    if (err) {
      return res.status(401).json({
        success: false,
        message: "Token 錯誤，請重新登入"
      });
    }
  }
);

//body_specific
router.post("/exercise_records", userPassport, async (req, res) => {
  try {
    const userId = req.user[0].user_id;
    const { gender, birthday, weight, height, exercise_level, record_date } =
      req.body;
    // 檢查輸入資料的格式
    const { error: validError } = exerciseRecordsValidation(req.body);
    if (validError) {
      return res.json({
        success: false,
        message: validError.details[0].message
      });
    }
    let bodyData = {
      user_id: userId,
      gender: gender,
      birthday: birthday,
      weight: weight,
      height: height,
      exercise_level: exercise_level,
      record_date: record_date
    };
    // 檢查紀錄天是否已經有紀錄
    const checkdateSql =
      "SELECT * FROM exercise_records WHERE user_id = ? AND DATE(record_date) = ?";
    const checkResults = await query(checkdateSql, [userId, record_date]);
    console.log(checkResults);
    if (checkResults.length < 1) {
      // 新增
      let recordId = uuidv4();
      const insertSql = "INSERT INTO exercise_records SET ?";
      const result = await query(insertSql, {
        ...bodyData,
        exercise_records_id: recordId
      });
      const affectedRows = result.affectedRows;
      console.log(result);
      if (affectedRows === 1) {
        return res.status(201).json({
          success: true,
          message: `會員體態追蹤新增 ${result.affectedRows}筆 成功`,
          recordId
        });
      } else {
        return res.json({ success: false, message: "無法新增會員體態追蹤" });
      }
    } else {
      const alterSql =
        "UPDATE exercise_records SET ? WHERE exercise_records_id = ?";
      const recordId = checkResults[0].exercise_records_id;
      console.log(recordId);
      const result = await query(alterSql, [bodyData, recordId]);
      return res.json({
        success: true,
        message: "該日期資料更新完成",
        recordId
      });
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.get("/exercise_records", userPassport, async (req, res) => {
  try {
    const userId = req.user[0].user_id;
    const startDate = req.query.start_date;
    const endDate = req.query.end_date;
    let getSql =
      "SELECT exercise_records_id, gender, birthday, weight, height, exercise_level, record_date FROM exercise_records WHERE user_id = ? ORDER BY record_date";
    let queryParams = [userId];
    // 指定日期
    if (startDate && endDate) {
      getSql =
        "SELECT exercise_records_id, gender, birthday, weight, height, exercise_level, record_date FROM exercise_records WHERE user_id = ? AND record_date BETWEEN ? AND ? ORDER BY record_date";
      queryParams.push(startDate, endDate);
    }
    const getResults = await query(getSql, queryParams);
    return res.status(200).json({
      success: true,
      user_id: userId,
      records: getResults
    });
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.delete(
  "/exercise_record/:exercise_records_id",
  userPassport,
  async (req, res) => {
    try {
      const userId = req.user[0].user_id;
      const recordId = req.params.exercise_records_id;
      const deleteSql =
        "DELETE FROM exercise_records WHERE user_id = ? AND exercise_records_id = ?";
      const deleteResult = await query(deleteSql, [userId, recordId]);
      const affectedRows = deleteResult.affectedRows;
      if (!affectedRows) {
        return res.status(404).json({
          success: false,
          message: "找不到紀錄",
          recordId
        });
      } else {
        return res.status(200).json({
          success: true,
          message: "已刪除紀錄"
        });
      }
    } catch (error) {
      console.error(error);
      return res.status(500).json({
        success: false,
        message: "伺服器錯誤"
      });
    }
  }
);

//article_meg
router.post(
  "/article_comments/article_id=:article_id",
  userPassport,
  async (req, res) => {
    try {
      const userId = req.user[0].user_id;
      const articleId = req.params.article_id;
      const { comment } = req.body;
      const { error: validError } = articleMegValid(req.body);
      if (validError) {
        return res.json({
          success: false,
          message: validError.details[0].message
        });
      }
      const filteredComment = xss(comment);
      const commentDate = {
        article_id: articleId,
        user_id: userId,
        comment: filteredComment
      };
      const postSql = "INSERT INTO article_comments SET ? ";
      const postResult = await query(postSql, commentDate);
      const affectedRows = postResult.affectedRows;
      if (affectedRows >= 1) {
        return res.status(201).json({
          success: true,
          message: "新增留言成功",
          article_id: articleId
        });
      } else {
        return res.json({
          success: false,
          message: "留言失敗"
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json({
        success: false,
        message: "伺服器錯誤"
      });
    }
  }
);

router.delete(
  "/article_comments/comment_id=:comment_id",
  userPassport,
  async (req, res) => {
    try {
      const userId = req.user[0].user_id;
      const cmtId = req.params.comment_id;
      const delSql =
        "DELETE FROM article_comments WHERE user_id = ? AND comment_id = ?";
      const { affectedRows } = await query(delSql, [userId, cmtId]);
      if (affectedRows >= 1) {
        return res.status(200).json({
          success: true,
          message: "已刪除留言"
        });
      } else {
        return res.status(404).json({
          success: false,
          message: "找不到留言"
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json({
        success: false,
        message: "伺服器錯誤"
      });
    }
  }
);

// diet_records
router.post("/meal_records", userPassport, async (req, res) => {
  try {
    const userId = req.user[0].user_id;
    const { meal_date, meal_type, food_id, food_qty } = req.body;
    // check format
    const { error: validError } = mealRecordValid(req.body);
    if (validError) {
      return res.json({
        success: false,
        message: validError.details[0].message
      });
    }
    const recordData = {
      user_id: userId,
      meal_date: meal_date,
      meal_type: meal_type,
      food_id: food_id,
      food_qty: food_qty
    };
    const postSql = "INSERT INTO meal_records SET ? ";
    const { affectedRows } = await query(postSql, recordData);
    if (affectedRows > 0) {
      return res.status(200).json({
        success: true,
        message: "新增紀錄成功",
        user_id: userId
      });
    } else {
      return res.status(422).json({
        success: false,
        message: "新增紀錄錯誤"
      });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.get("/meal_records", userPassport, async (req, res) => {
  try {
    const userId = req.user[0].user_id;
    const startDate = req.query.start_date;
    const endDate = req.query.end_date;
    let getSql =
      "SELECT record_id, user_id, CONVERT_TZ(meal_date, '+0:00', '+8:00') as meal_date, meal_type, food.food_id, food_qty, sample_name AS name, content_des, unit, Calories_adjusted AS calories, carbohydrate, crude_protein AS protein, saturated_fat, sodium FROM meal_records AS mr INNER JOIN food ON food.food_id = mr.food_id WHERE mr.user_id = ? ";
    let getParams = [userId];
    if (startDate && endDate) {
      getSql += " AND meal_date BETWEEN ? AND ? ORDER BY meal_date";
      getParams.push(startDate, endDate);
    }
    const results = await query(getSql, getParams);

    const formattedResults = results.map((result) => ({
      record_id: result.record_id,
      user_id: result.user_id,
      meal_date: result.meal_date,
      meal_type: result.meal_type,
      food_qty: result.food_qty,
      food_info: {
        food_id: result.food_id,
        name: result.name,
        content_des: result.content_des,
        unit: result.unit,
        calories: result.calories,
        carbohydrate: result.carbohydrate,
        protein: result.protein,
        saturated_fat: result.saturated_fat,
        sodium: result.sodium
      },
      total_weight: result.unit * result.food_qty,
      total_calories: result.calories * result.food_qty,
      total_carbohydrate: result.carbohydrate * result.food_qty,
      total_protein: result.protein * result.food_qty,
      total_saturated_fat: result.saturated_fat * result.food_qty,
      total_sodium: result.sodium * result.food_qty
    }));

    if (results.length > 0) {
      return res.status(200).json({
        success: true,
        message: "取得紀錄成功",
        user_id: userId,
        records: formattedResults
      });
    } else {
      return res.status(404).json({
        success: false,
        message: "該時間段沒有紀錄"
      });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "伺服器錯誤"
    });
  }
});

router.put(
  "/meal_record/record_id=:record_id",
  userPassport,
  async (req, res) => {
    try {
      const userId = req.user[0].user_id;
      const recordId = req.params.record_id;
      const { meal_date, meal_type, food_id, food_qty } = req.body;
      // check format
      const { error: validError } = mealRecordValid(req.body);
      if (validError) {
        return res.json({
          success: false,
          message: validError.details[0].message
        });
      }
      const recordData = {
        user_id: userId,
        meal_date: meal_date,
        meal_type: meal_type,
        food_id: food_id,
        food_qty: food_qty
      };
      const putSql =
        "UPDATE meal_records SET ? WHERE user_id = ? AND record_id = ? ";
      const { affectedRows } = await query(putSql, [
        recordData,
        userId,
        recordId
      ]);
      if (affectedRows > 0) {
        return res.status(200).json({
          success: true,
          message: "紀錄編輯成功"
        });
      } else {
        return res.status(422).json({
          success: false,
          message: "紀錄編輯錯誤"
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json({
        success: false,
        message: "伺服器錯誤"
      });
    }
  }
);

router.delete(
  "/meal_record/record_id=:record_id",
  userPassport,
  async (req, res) => {
    try {
      const userId = req.user[0].user_id;
      const recordId = req.params.record_id;
      const delSql =
        "DELETE FROM meal_records WHERE user_id = ? AND record_id = ? ";
      const { affectedRows } = await query(delSql, [userId, recordId]);
      if (affectedRows > 0) {
        return res.status(200).json({
          success: true,
          message: "已刪除紀錄"
        });
      } else {
        return res.status(422).json({
          success: false,
          message: "找不到紀錄"
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json({
        success: false,
        message: "伺服器錯誤"
      });
    }
  }
);

module.exports = router;
