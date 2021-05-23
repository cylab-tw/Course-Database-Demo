var async = require('async');
var moment = require('moment');
var fs = require('fs');

module.exports.sqlLog = function(functionName, sqlStr) {
    var obj = [];
    var jsonStr;
    var jsonButify;
    var datetime = moment().format("YYYY-MM-DD HH:mm:ss");
    async.waterfall([
        function(callback) {
            fs.readFile('../../data/log/sqlDOC.json', function(err, data) {
                if (err) throw err;
                callback(err, data);
            });
        },
        function(data, callback) {
            jsonStr = JSON.parse(JSON.stringify(data));
            jsonStr.push({
                "Name": functionName,
                "sqlStr": sqlStr,
                "datetime": datetime
            });
            jsonButify = JSON.stringify(jsonStr, null, 4);
            callback(null, jsonButify);
        },
        function(data, callback) {
            fs.appendFile('../../data/log/sqlDOC.json', data, function(err) {
                if (err) {
                    throw err;
                }
                console.log('file is updated');
            });
        }
    ], function(err, result) {
        // result now equals 'done'    
    });

}