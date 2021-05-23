var QueryParams = require('../models/common/httparams.js');
var bank_log = require('../models/DB/bank.js');
var url = require('url');

module.exports = function (app, passport) {
    /* HOME PAGE (with login links) */
    app.get('/', function (req, res) {
        res.header('Cache-Control', 'no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0');
        res.render('index.html');
    });

    /* process the login form */
    app.post('/login', passport.authenticate('local-login', {
        successRedirect: '/atm',
        failureRedirect: '/', // redirect back to the signup page if there is an error
        session: true
    }));

    app.get('/atm', isLoggedIn, function (req, res) {
        res.header('Cache-Control', 'no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0');
        res.render('./atm/log.html', {
            user: req.user
        });
    });

    app.route('/api/log', isLoggedIn).all(function (req, res, next) {
        var urlStr = QueryParams.normalize(url.parse(req.url, false).query);
        var instance = QueryParams.getQueryStringToJSON(urlStr);
        switch (req.method) {
            case "GET":
                bank_log.queryLog(instance, function (err, LogList) {
                    if (err) {
                        res.status(404).send(err.message);
                    } else {
                        if (LogList.length == 0)
                            LogList = "";
                        res.send(LogList);
                    }
                });
                break;
            case "POST":
                if (instance.method=="delete") {
                    bank_log.DeleteLog(instance, function (err, rsp) {
                        if (err) {
                            res.status(404).send(err.message);
                        } else if (rsp == "fail") {
                            res.send("fail");
                        } else {
                            res.send("success");
                        }
                    });
                } else if (instance.method=="update") {
                    bank_log.UpdateLog(instance, function (err, rsp) {
                        if (err) {
                            res.status(404).send(err.message);
                        } else if (rsp[0].count != 1) {
                            res.send("fail");
                        } else {
                            res.send("success");
                        }
                    });
                } else {
                    bank_log.InsertLog(instance, function (err, rsp) {
                        if (err) {
                            res.status(404).send(err.message);
                        } else if (rsp[0].count != 1) {
                            res.send("fail");
                        } else {
                            res.send("success");
                        }
                    });
                }
                break;
            default:
                break;
        }
    });   
};

function isLoggedIn(req, res, next) {
    if (req.isAuthenticated()) {
        return next();
    }
    res.writeHead(401);
    res.write("Unauthorized");
    res.end();
}