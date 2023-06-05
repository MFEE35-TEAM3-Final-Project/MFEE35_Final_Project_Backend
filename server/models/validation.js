const Joi = require("joi");

// general users
const registerValidation = (data) => {
  const userSchema = Joi.object({
    email: Joi.string().min(6).max(50).required().email(),
    password: Joi.string().min(6).max(255).required(),
    repeat_password: Joi.ref("password"),
    username: Joi.string().max(30).empty(""),
    avatar: Joi.string().max(255).empty(""),
    gender: Joi.string().valid("female", "male"),
    birthday: Joi.date().empty(""),
    phone: Joi.string()
      .pattern(/^\d{9,10}$/)
      .empty(""),
    address: Joi.string().max(100, "utf8").empty("")
  });

  return userSchema.validate(data);
};
const loginValidation = (data) => {
  const schema = Joi.object({
    email: Joi.string().min(6).max(50).required().email(),
    password: Joi.string().min(6).max(255).required()
  });
  return schema.validate(data);
};
const updeteUserValid = (data) => {
  const schema = Joi.object({
    username: Joi.string().max(30).empty(""),
    avatar: Joi.string().max(255).empty(""),
    gender: Joi.string().valid("female", "male"),
    birthday: Joi.date().empty(""),
    phone: Joi.string()
      .pattern(/^\d{9,10}$/)
      .empty(""),
    address: Joi.string().max(100, "utf8").empty("")
  });

  return schema.validate(data);
};

// Admins
const adminRegValidation = (data) => {
  const schema = Joi.object({
    adminname: Joi.string().min(6).max(30).required(),
    avatar: Joi.string().empty(""),
    email: Joi.string().min(6).max(50).required().email(),
    password: Joi.string().min(6).max(255).required(),
    repeat_password: Joi.ref("password")
  });

  return schema.validate(data);
};
const adminLoginValidation = (data) => {
  const schema = Joi.object({
    email: Joi.string().min(6).max(50).required().email(),
    password: Joi.string().min(6).max(255).required()
  });
  return schema.validate(data);
};
const exerciseRecordsValidation = (data) => {
  const schema = Joi.object({
    gender: Joi.string().valid("female", "male"),
    birthday: Joi.date(),
    weight: Joi.number().min(0),
    height: Joi.number().min(0),
    exercise_level: Joi.number().min(0),
    record_date: Joi.date()
  });
  return schema.validate(data);
};

const articleValid = (data) => {
  const schema = Joi.object({
    title: Joi.string().max(45).empty("").required(),
    sub_title: Joi.string().max(100).empty(""),
    category: Joi.string().max(45).required(),
    cover_image: Joi.string().max(255).empty(""),
    content: Joi.string()
      .pattern(/<("[^"]*"|'[^']*'|[^'">])*>/)
      .empty(""),
    is_published: Joi.number().valid(0, 1).required()
  });
  return schema.validate(data);
};

const articleMegValid = (data) => {
  const schema = Joi.object({
    comment: Joi.string().max(200).required()
  });
  return schema.validate(data);
};

const mealRecordValid = (data) => {
  const schema = Joi.object({
    meal_date: Joi.date().required(),
    meal_type: Joi.string()
      .valid("breakfast", "lunch", "dinner", "snack")
      .required(),
    food_id: Joi.string().required(),
    food_qty: Joi.number().min(0).default(1).required()
  });
  return schema.validate(data);
};

const foodValid = (data) => {
  const schema = Joi.object({
    category: Joi.string().required(),
    sample_name: Joi.string().required(),
    content_des: Joi.string().empty(""),
    common_name: Joi.string().empty(""),
    unit: Joi.number().min(0).required(),
    calories: Joi.number().min(0).required(),
    calories_adjusted: Joi.number().min(0).required(),
    water: Joi.number().min(0),
    crude_protein: Joi.number().min(0).required(),
    crude_fat: Joi.number().min(0),
    saturated_fat: Joi.number().min(0).required(),
    carbohydrate: Joi.number().min(0).required(),
    sodium: Joi.number().min(0).required(),
    dietary_fiber: Joi.number().min(0),
    trans_fat: Joi.number().min(0),
    popularity: Joi.number().min(0)
  });
  return schema.validate(data);
};
module.exports = {
  registerValidation,
  loginValidation,
  updeteUserValid,
  adminRegValidation,
  adminLoginValidation,
  exerciseRecordsValidation,
  articleValid,
  articleMegValid,
  mealRecordValid,
  foodValid
};
