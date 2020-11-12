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

queries = [
  //1
  `SELECT ps_id, ps_name FROM Posts
  WHERE ps_id IN
  (
    SELECT ps_id FROM Posts, Events, Programs, Subscriptions, Users WHERE ps_eventID = e_id AND e_programID = pr_id AND pr_id = s_programID AND s_userID = u_id AND u_username = "user #2"
    UNION
    SELECT ps_id FROM Posts, Events, Subscriptions, Users WHERE ps_eventID = e_id AND s_eventID = e_id AND s_userID = u_id AND u_username = "user #2"
  )
  ORDER BY ps_dateAdded LIMIT 10 OFFSET 0
    `,
    //2
  `SELECT e_id, e_name FROM Events, Users
  WHERE e_addedBy = u_id AND u_username = "admin user #1" `,
  //3
  `SELECT ps_id, ps_name FROM Posts, Events Where ps_eventID = e_id AND e_name = "event #2" `,
  //4
  `SELECT pr_id, pr_name, COUNT(ps_id) FROM Posts, Events, Programs WHERE ps_eventID = e_id AND e_programID = pr_id GROUP BY pr_id`,
  //5
  `SELECT u_id, u_username, u_schoolEmail, COUNT(*) FROM Users WHERE u_programPriv = 1 GROUP BY u_schoolEmail`,
  //6
  `SELECT u_id, u_username, COUNT(*) FROM Users, Events WHERE u_programPriv = 1 AND e_addedBy = u_id GROUP BY u_id`,
  //7
  `SELECT u_id, u_username FROM Users, Programs WHERE u_programPriv = 1 AND pr_programManagerUserID = u_id AND pr_name = "program #3" GROUP BY u_id`,
  //8
  `INSERT INTO Users (u_firstname, u_lastname, u_username, u_pictureURL, u_schoolEmail, u_schoolID, u_password, u_genderTitle, u_professionalTitle, u_affiliatedProgramID, u_adminPriv, u_programPriv, u_lastLoggedIn, u_currentlyLoggedIPAddress, u_addedBy)
  VALUES
      ('user', '11', 'user #11', "https://loremflickr.com/640/360", 'user11@ucmerced.edu', '802789240', 'password1', "He/His/Him", "Student", NULL, 0, 0, NULL, NULL, NULL);
  `,
  //9
  `
  Insert INTO Subscriptions (s_dateAdded, s_userID, s_programID, s_eventID, s_sendPushNotification)
  VALUES (${Date.now()}, (SELECT u_id from Users where u_username = "user #11" LIMIT 1), (SELECT pr_id FROM Programs where pr_name = "program #1" LIMIT 1), NULL, 0);
  `,
  //10
  `
  UPDATE Subscriptions
  SET s_programID = (Select pr_id FROM Programs Where pr_name = "program #2" LIMIT 1)
  WHERE s_programID = (Select pr_id FROM Programs Where pr_name = "program #1" LIMIT 1)
  `,
  //11
  `
  SELECT ect+pct FROM (
    SELECT COUNT(e_id) as ect FROM Events WHERE e_addedBy = (SELECT u_id From Users WHERE u_username = "admin user #1")
  ), (
    SELECT COUNT(ps_id) as pct FROM Posts WHERE ps_addedByUserID = (SELECT u_id From Users WHERE u_username = "admin user #1")
  )
  `
  //12
]

async function dbq(q) {
  return await new Promise(function(resolve, reject) {
    let sql = queries[q-1];
    db.all(sql, [], (err,rows) => {
      console.log(err);
      console.log(rows);
      resolve(rows);
    });
  });
}

app.get("/test", async function(req, res) {
  // console.log(req.body['query']);
  var d = await dbq(req.body['query']);
  // console.log(Date.now());
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
