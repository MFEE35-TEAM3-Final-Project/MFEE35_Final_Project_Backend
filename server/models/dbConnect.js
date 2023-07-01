const mysql = require("mysql2");

const pool = mysql.createPool({
  host: process.env.LOCAL_HOSTNAME,
  port: process.env.LOCAL_PORT,
  user: process.env.LOCAL_USERNAME,
  password: process.env.LOCAL_PASSWORD,
  database: process.env.LOCAL_DB_NAME,
  waitForConnections: true
  // connectionLimit: 10,
  // queueLimit: 0,
});

// RDS
// const pool = mysql.createPool({
//   host: process.env.RDS_HOSTNAME,
//   port: process.env.RDS_PORT,
//   user: process.env.RDS_USERNAME,
//   password: process.env.RDS_PASSWORD,
//   database: process.env.RDS_DB_NAME,
//   waitForConnections: true
//   // connectionLimit: 10,
//   // queueLimit: 0,
// });

module.exports = pool;
