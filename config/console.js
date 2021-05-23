var config = require('../config/setting.js');
var util = require('util');
var fs = require('fs');

if (config.BUILD_MODE == "DEBUG") {
    //do nothing.
} else if (config.BUILD_MODE == "VERBOSE") {
    console.debug = function () {};
} else if (config.BUILD_MODE == "PRODCUTION") {
    var log_file = fs.createWriteStream(__dirname + config.LOG_PATH, {
        flags: 'a+'
    });
    var log_stdout = process.stdout;
    console.log = function () {
        log_file.write("LOG: " + util.format.apply(null, arguments) + ", " + '\n');
        log_stdout.write("LOG: " + util.format.apply(null, arguments) + '\n');
    };
    console.error = function () {
        log_file.write("ERROR: " + util.format.apply(null, arguments) + '\n');
        log_stdout.write("ERROR: " + util.format.apply(null, arguments) + '\n');
    };
    console.info = function () {
        log_file.write("INFO: " + util.format.apply(null, arguments) + '\n');
        log_stdout.write("INFO: " + util.format.apply(null, arguments) + '\n');
    };
}