const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);

// 不須驗證的取得文章get
router.get("/", async (req, res) => {
  try {
    let { page, per_page } = req.query;

    // 確認頁數
    let perPage = parseInt(per_page) || 20;
    let nowPage = parseInt(page) || 1;
    let countSql = "SELECT COUNT(*) AS total_count FROM articles ";
    let countParams = [];

    const [{ total_count: totalCount }] = await query(countSql, countParams);
    let totalPages = Math.ceil(totalCount / perPage);
    totalPages = totalPages === 0 ? 1 : totalPages;
    nowPage = nowPage > totalPages ? totalPages : nowPage;

    // 取得文章
    let getArticlesSql =
      "SELECT article_id, admin_id, title, is_published, created_at, updated_at FROM articles ";
    let getParams = [];

    getArticlesSql += "ORDER BY created_at DESC ";

    if (!isNaN(nowPage) && nowPage > 0) {
      getArticlesSql += "LIMIT ? OFFSET ? ";
      getParams.push(perPage);
      getParams.push((nowPage - 1) * perPage);
    }
    const getResults = await query(getArticlesSql, getParams);

    const pagination = {
      total_pages: totalPages,
      current_page: nowPage,
      per_page: perPage,
      has_pre: nowPage >= 2,
      has_next: nowPage < totalPages,
    };

    if (getResults.length === 0) {
      return res.status(404).json({
        success: false,
        message: "沒有符合的資料",
      });
    } else {
      return res.status(200).json({
        success: true,
        message: "成功取得文章",
        article_count: totalCount,
        articles: getResults,
        pagination,
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

// 取得特定文章
router.get("/id=:article_id", async (req, res) => {
  try {
    const articleId = req.params.article_id;
    let getSql = "SELECT * FROM articles WHERE article_id = ?";
    const [getResult] = await query(getSql, [articleId]);
    if (getResult) {
      return res.status(200).json({
        success: true,
        message: "成功取得文章",
        article: getResult,
      });
    } else {
      return res.status(404).json({
        success: false,
        message: "沒有符合的文章",
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

router.get("/article_comments/article_id=:article_id", async (req, res) => {
  try {
    const articleId = req.params.article_id;
    const getSql = "SELECT * FROM article_comments WHERE article_id = ?";
    const getResults = await query(getSql, [articleId]);
    if (getResults.length !== 0) {
      res.status(200).json({
        success: true,
        article_id: articleId,
        comments_count: getResults.length,
        comments: getResults,
      });
    } else {
      res.status(404).json({
        success: false,
        message: "文章沒有留言",
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
module.exports = router;
