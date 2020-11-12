var express = require('express');
var app = express();
const sqlite3 = require('sqlite3').verbose();
const crypto = require('crypto');

var datetime = require('node-datetime');
var dt = datetime.create(); //dt.now()

var cors = require('cors');
var bodyParser = require('body-parser');
app.use(bodyParser.json({limit: '50mb'}));
// app.use(bodyParser.urlencoded({limit: '50mb', extended: true, parameterLimit: 1000000}));
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

async function dbq(q) {
  return await new Promise(function(resolve, reject) {
    let sql = ``;
    if(q == 1) {
      sql = `SELECT ps_id FROM Posts
      WHERE ps_id IN
      (
        SELECT ps_id FROM Posts, Events, Programs, Subscriptions, Users WHERE ps_eventID = e_id AND e_programID = pr_id AND pr_id = s_programID AND s_userID = u_id
        INTERSECT
        SELECT ps_id FROM Posts, Events, Subscriptions, Users WHERE ps_eventID = e_id AND s_eventID = e_id AND s_userID = u_id
      )
      ORDER BY ps_dateAdded LIMIT 10 OFFSET 0
        `;
    }
    if(q == 2) {
      sql = ``;
    }
    if(q == 3) {
      sql = ``;
    }
    db.all(sql, [], (err,rows) => {
      console.log(err);
      resolve(rows);
    });
  });
}

app.get("/test", async function(req, res) {
  console.log(req.body['query']);
  var d = await dbq(req.body['query'])
  res.send({
    "status": "success",
    "data": d
  });
});

app.get("/", function(req, res) {
  res.send({
    "status": "success",
    "data": "Visit /q# for each of the 20 queries to execute"
  });
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Our app is running on port ${ PORT }`);
});
