const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);

router.get("/getActivity", async (req, res) => {
  try {
    const sql = "SELECT * FROM activity";
    const results = await query(sql);
    return res.json(results);
  } catch (err) {
    console.log(err);
    return res.sendStatus(500);
  }
});

module.exports = router;
