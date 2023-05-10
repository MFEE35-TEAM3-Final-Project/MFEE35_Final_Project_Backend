const connectPool = require("./dbConnect");
const passport = require("passport");
const JwtStrategy = require("passport-jwt").Strategy;
const ExtractJwt = require("passport-jwt").ExtractJwt;

const opts = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderWithScheme("jwt"),
  secretOrKey: process.env.PASSPORT_SECRET
};

passport.use(
  "user",
  new JwtStrategy(opts, function(jwt_payload, done) {
    if (Date.now() > jwt_payload.exp) {
      return done(null, false, { message: "Token 已經過期" });
    }
    connectPool.query(
      "SELECT * FROM users WHERE user_id = ? AND email = ?",
      [jwt_payload._id, jwt_payload.email],
      (error, user) => {
        if (error) {
          return done(error, false);
        } else if (user) {
          return done(null, user);
        } else {
          return done(null, false);
        }
      }
    );
  })
);

passport.use(
  "admin",
  new JwtStrategy(opts, function(jwt_payload, done) {
    if (Date.now() > jwt_payload.exp) {
      return done(null, false, { message: "Token 已經過期" });
    }
    connectPool.query(
      "SELECT * FROM admins WHERE admin_id = ? AND email = ?",
      [jwt_payload._id, jwt_payload.email],
      (error, user) => {
        if (error) {
          return done(error, false);
        } else if (user) {
          return done(null, user);
        } else {
          return done(null, false);
        }
      }
    );
  })
);

module.exports = {
  userPassport: passport.authenticate("user", {
    session: false,
    failWithError: true
  }),
  adminPassport: passport.authenticate("admin", {
    session: false,
    failWithError: true
  })
};
