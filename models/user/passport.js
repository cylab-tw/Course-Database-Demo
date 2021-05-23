var LocalStrategy = require('passport-local').Strategy;

module.exports = function (passport) {
    var users = {
        admin: {
            username: 'admin',
            password: '1'
        }
    };

    passport.serializeUser(function (user, done) {
        done(null, user);
    });
    passport.deserializeUser(function (id, done) {
        done(null, id);
    });

    passport.use('local-login', new LocalStrategy({
            usernameField: 'username',
            passwordField: 'password',
            session: true
        },
        function (username, password, done) {
            user = users[username];
            if (user == null) {
                return done(null, false, {
                    message: 'Invalid user'
                });
            }
            if (user.password !== password) {
                return done(null, false, {
                    message: 'Invalid password'
                });
            }
            return done(null, user.username);
        }));
};