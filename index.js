var express = require('express');
var app = express();
const sqlite3 = require('sqlite3').verbose();
const crypto = require('crypto');

var datetime = require('node-datetime');
var dt = datetime.create(); //dt.now()

var cors = require('cors');
var bodyParser = require('body-parser');
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true, parameterLimit: 1000000}));
app.use(cors());
app.use(express.json());

var db = new sqlite3.Database('rapp.db');
//usage api here https://github.com/mapbox/node-sqlite3/wiki/API

// async function dbinsert(table, col, val) {
//   let sql = `INSERT INTO ${table} ${col} VALUES (${val});`;
//   db.run(sql);
// }

// async function dbselect(table, attr, val, num) {
//   return await new Promise(function(resolve, reject) {
//     let sql = `SELECT * FROM ${table} WHERE ${attr} = '${val}' LIMIT ${num};`;
//     db.all(sql, [], async (err, rows) => {
//       resolve(rows)
//     })
//   });
// }

//app.post ....


app.get("/", function(req, res) {
  res.send({
    "status": "success",
    "data": "Hello world!"
  });
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Our app is running on port ${ PORT }`);
});
