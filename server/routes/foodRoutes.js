const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);
const { json } = require("express");
const { error } = require("console");

// middleware
router.use((req, res, next) => {
  console.log("A request is coming in to FOOOOOD~");
  next();
});

router.get("/category=:category", async (req, res) => {
  try {
    const category = req.params.category;
    let getResults;
    if (category === "all") {
      let getAllCategorySql =
        "SELECT GROUP_CONCAT(DISTINCT Category ORDER BY Category) as categories FROM food";
      getResults = await query(getAllCategorySql);
      const allCategories = getResults[0].categories.split(",");
      return res.status(200).json({
        success: true,
        categories: allCategories,
      });
    } else if (category !== "") {
      let getAllCategorySql = "SELECT * FROM food WHERE Category= ?";
      getResults = await query(getAllCategorySql, [category]);
      return res.status(200).json({
        success: true,
        results: getResults,
      });
    } else {
      return res.status(404).json({
        success: false,
        message: "Nothing",
      });
    }
  } catch (err) {
    console.log(err);
  }
});

router.get("/search", async (req, res) => {
  const searchKeyword = req.query.keyword;
  const searchCategory = req.query.category;
  const resultQty = parseInt(req.query.qty) || 20;
  const foodId = req.query.food_id;
  let searchSql = "SELECT *, sample_name as name FROM food WHERE ";
  let searchParams = [];

  // 特定食物
  if (foodId && foodId !== "") {
    searchSql += "food_id = ?";
    getResults = await query(searchSql, [foodId]);

    if (getResults.length > 0) {
      return res.json({
        success: true,
        message: "已取得特定食物",
        food_info: getResults[0],
      });
    } else {
      return res.status(404).json({
        success: false,
        message: "找不到該食物",
      });
    }
  }

  if (searchCategory && searchCategory !== "all") {
    searchSql += "category = ? AND ";
    searchParams.push(searchCategory);
  }
  searchSql += `sample_name LIKE '%${searchKeyword}%' ORDER BY popularity DESC LIMIT ?`;
  searchParams.push(resultQty);
  getResults = await query(searchSql, searchParams);
  if (getResults.length > 0) {
    return res.json({
      success: true,
      message: "search~~",
      category: searchCategory,
      keyword: searchKeyword,
      suggestions: getResults,
    });
  } else {
    return res.status(404).json({
      success: false,
      message: "Nothing",
    });
  }
});

module.exports = router;
