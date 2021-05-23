/**
 * @fileoverview configure and start the http server
 * @author Chung-Yueh Lien
 */

var config = require('../config/setting.js'); /* make sure OS specific configuration is included first */
var http = require('http');
var express = require('express');
var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser');
var passport = require('passport');
var session = require('express-session');

var app = express();
app.set('views', config.HTTPServer.viewsRoot);
app.use(express.static(config.HTTPServer.viewsRoot));
app.use(cookieParser());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: false
}));
app.use(session({
    secret: 'ntunhsimsecret',
    resave: false,
    saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());
app.engine('html', require('ejs').renderFile);

require('../models/user/passport.js')(passport);
require("../controller/routes.js")(app, passport);

http.createServer(app).on('connection', function (socket) {
    socket.setTimeout(config.HTTPServer.timeout);
}).listen(config.HTTPServer.httpPort, function () {
    console.log('HTTP server is listening on port: ' + config.HTTPServer.httpPort);
});