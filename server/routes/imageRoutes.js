const express = require("express");
const router = express.Router();
const connectPool = require("../models/dbConnect");
const { promisify } = require("util");
const query = promisify(connectPool.query).bind(connectPool);
const { json } = require("express");
const path = require("path");
const multer = require("multer");

const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const crypto = require("crypto");
const sharp = require("sharp");

// 產生名字的亂碼
const randomImgName = (bytes = 16) => crypto.randomBytes(bytes).toString("hex");

const s3 = new S3Client({
  credentials: {
    accessKeyId: process.env.ACCESS_KEY,
    secretAccessKey: process.env.SECRET_ACCESS_KEY
  },
  region: process.env.BUCKET_REGION
});

// middleware
router.use((req, res, next) => {
  console.log("A request is coming in to Images");
  next();
});

// 解析傳入的圖片檔案 製作multer middleware
const storage = multer.memoryStorage();
const multerSetting = multer({
  storage: storage,
  limits: {
    fileSize: 2000000
  },
  fileFilter: function (req, file, cb) {
    if (
      file.mimetype !== "image/jpeg" &&
      file.mimetype !== "image/png" &&
      file.mimetype !== "image/jpg"
    ) {
      cb(new Error("上傳的檔案類型不符合規定"));
    } else {
      cb(null, true);
    }
  }
});
const uploadFile = multerSetting.single("image");

router.post("/", (req, res) => {
  uploadFile(req, res, async (err) => {
    try {
      if (err instanceof multer.MulterError) {
        // 捕獲 Multer 的錯誤，例如文件大小超過限制等
        return res.status(400).json({ error: err.message });
      } else if (err) {
        // 捕獲其他錯誤
        return res.status(400).json({ error: err.message });
      }
      // console.log("req.file", req.file);

      // 使用原始文件名的擴展名
      const imgKey = randomImgName() + path.extname(req.file.originalname);

      const params = {
        Bucket: process.env.BUCKET_NAME,
        Key: imgKey,
        Body: req.file.buffer,
        ContentType: req.file.mimetype
      };

      const command = new PutObjectCommand(params);
      const uploadRes = await s3.send(command);

      return res.json({
        imgUrl: `${process.env.CLOUDFRONT_PATH}/${imgKey}`
      });
    } catch (err) {
      console.error(err);
      return res.status(500).json({ error: "文件上傳失敗" });
    }
  });
});

module.exports = router;
