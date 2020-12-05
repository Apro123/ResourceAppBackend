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
  `,
  //12
  `
  UPDATE Users
  SET u_addedBy = (SELECT u_id FROM Users WHERE u_username = "admin #1" AND u_adminPriv = 1), u_affiliatedprogramID = (SELECT pr_id FROM Programs WHERE pr_name = "program #5" LIMIT 1),
  u_programPriv = 1
  WHERE u_id = (SELECT u_id from Users WHERE u_username = "user #11");
  `,
  //13
  `
  INSERT INTO Items (i_addedBy, i_name, i_description, i_picture, i_pointsWorth, i_quantity, i_programID)
  VALUES
      ((SELECT u_id FROM Users WHERE u_username = "user #3"), "Flask", "des7", "https://loremflickr.com/640/360", 20, 2, (SELECT pr_id FROM Programs WHERE pr_name = "program #1")),
      ((SELECT u_id FROM Users WHERE u_username = "user #3"), "Bottle Opener", "des8", "https://loremflickr.com/640/360", 40, 4, (SELECT pr_id FROM Programs WHERE pr_name = "program #1"));
  `
  ,
  //14
  `
  UPDATE Items SET i_quantity = 1 WHERE i_name = "item #1";
  `
  ,
  //15
  `
  DELETE FROM Items WHERE i_name = "item #2";
  `
  ,
  //16
  `
  INSERT INTO Events (e_name, e_description, e_pictureLocation, e_programID, e_repeated, e_date, e_addedBy) VALUES (
    "event #7",
    "des7",
    "https://loremflickr.com/640/360",
    (SELECT pr_id FROM Programs WHERE pr_name = "program #4"),
    "Weekly",
    "2021-01-21",
    (SELECT u_id FROM Users WHERE u_username = "user #4"));
  `
  ,
  //17
  `
  INSERT INTO Posts (ps_addedByUserID, ps_name, ps_description, ps_pictureLocation, ps_eventID, ps_pointOpportunity, ps_tags, ps_dateAdded)
  VALUES (
      (SELECT u_id FROM Users WHERE u_username = "user #3"),
      "post #13",
      "des #13",
      "https://loremflickr.com/640/360",
      (SELECT e_id FROM Events WHERE e_name = "event #2"),
      5,
      "faculty, seminar",
      "2020-12-01"
    );
  `
  ,
  //18
  `
  Insert into PointHistory (ph_userID, ph_pointOppID, ph_actualPointsEarned)
  Values (
    (SELECT u_id from Users WHERE u_username = "user #6"),
    (SELECT po_id FROM PointOpp WHERE po_id = (SELECT ps_pointOpportunity FROM Posts WHERE ps_name = "post #1")),
    1);
  Update Points
  Set p_currentPoints = p_currentPoints + (SELECT ph_actualPointsEarned FROM PointHistory WHERE ph_userID = (SELECT u_id FROM Users WHERE u_username = "user #6"))
  WHERE p_userID = (SELECT u_id FROM Users WHERE u_username = "user #6");
  `
  ,
  //19
  `
  Update Points
  Set
    p_currentPoints = (SELECT SUM(ph_actualPointsEarned) FROM PointHistory WHERE ph_userID = (SELECT u_id FROM Users WHERE u_username = "user #3")),
    p_totalPoints = (SELECT SUM(ph_actualPointsEarned) FROM PointHistory WHERE ph_userID = (SELECT u_id FROM Users WHERE u_username = "user #3"))
  WHERE p_userID = (SELECT u_id FROM Users WHERE u_username = "user #3");
  `
  ,
  //20
  `
  INSERT INTO ItemsBought (ib_userID, ib_itemID, ib_dateOrdered)
  VALUES (
    (SELECT u_id FROM Users WHERE u_username = "user #2"),
    (SELECT i_id FROM Items WHERE i_name = "item #1"),
    "2020-12-1");
    UPDATE Items SET i_quantity = i_quantity - 1;
    UPDATE Points SET p_currentPoints = p_currentPoints - (SELECT i_pointsWorth FROM Items WHERE i_name = "item #1") WHERE p_userID IN (SELECT u_id FROM Users WHERE u_username = "user #2");
  `
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

function collapse(arr, grpBy, multCols) {
  //collapse on key
  temp = [];
  for (const arrKey in arr) {
    //for each element add it into temp
    var found = false;
    //look to see if existing grp by attribute exists
    for (const tempKey in temp) {
      // if the group by column is the same then you have found a match
      if(temp[tempKey][grpBy] == arr[arrKey][grpBy]) {

        //for every multiple column
        for(const col in multCols) {
          if(Array.isArray(temp[tempKey][multCols[col]]) && arr[arrKey][multCols[col]] != null) {
            temp[tempKey][multCols[col]].push(arr[arrKey][multCols[col]]);
          } else {
            if(temp[tempKey][multCols[col]] != null && arr[arrKey][multCols[col]] != null) {
              temp[tempKey][multCols[col]] = [temp[tempKey][multCols[col]], arr[arrKey][multCols[col]]];
            } else if (arr[arrKey][multCols[col]] != null) {
              temp[tempKey][multCols[col]] = arr[arrKey][multCols[col]];
            }

          }
        }

        found = true;
      }
    }

    if(!found) {
      //add it into temp
      temp.push(arr[arrKey]);
    }
  }

  return temp;
}

async function dbprograms() {
  return await new Promise(function(resolve, reject) {
    let sql = `SELECT * FROM Programs ORDER BY pr_id`;
    db.all(sql, [], (err,rows) => {
      // console.log(err);
      // console.log(rows);

      resolve(collapse(rows, "pr_name", ["pr_eventID", "pr_programManagerUserID"]));
    });
  });
}

async function dbposts(id) {
  return await new Promise(function(resolve, reject) {
    let sql =  `
    SELECT * FROM Posts 
    INNER JOIN Events ON ps_eventID = e_id
    WHERE ps_id IN
    (
        SELECT ps_id FROM Posts, Events, Programs, Subscriptions, Users WHERE ps_eventID = e_id AND e_programID = pr_id AND pr_id = s_programID AND s_userID = u_id AND u_id = ?
    UNION
    SELECT ps_id FROM Posts, Events, Subscriptions, Users WHERE ps_eventID = e_id AND s_eventID = e_id AND s_userID = u_id AND u_id = ?
    ) 
    ORDER BY ps_dateAdded LIMIT 30 OFFSET 0
    `; //user #2
    db.all(sql, [id], (err,rows) => {
      // console.log(err);
      // console.log(rows);
      resolve(rows);
    });
  });
}

async function dblogin(email, password) {
  return await new Promise(function(resolve, reject) {
    let sql = `SELECT 
    u_id,
    u_firstname,
    u_lastname,
    u_username,
    u_pictureURL,
    u_schoolEmail,
    u_schoolID,
    u_genderTitle,
    u_professionalTitle,
    u_adminPriv,
    u_programPriv
    FROM Users WHERE u_schoolEmail=? AND u_password=?`;
    db.all(sql, [email, password], (err,rows) => {
      // console.log(err);
      // console.log(rows);
      resolve(rows);
    });
  });
}

async function dbgetSubs(userid) {
  return await new Promise(function(resolve, reject) {
    let sql = "SELECT * FROM Subscriptions WHERE s_userID = ?";
    db.all(sql, [userid], (err,rows) => {
      if(err) {
        console.log(err);
      }
      // console.log(err);
      // console.log(rows);
      resolve(collapse(rows, "s_userID", ["s_programID","s_eventID"]));
    });
  });
}

async function dbsubProgram(programid, userid) {
  return await new Promise(function(resolve, reject) {
    let sql = `Insert INTO Subscriptions (s_dateAdded, s_userID, s_programID, s_eventID, s_sendPushNotification)
    VALUES (${Date.now()}, (SELECT u_id from Users where u_username = ? LIMIT 1), (SELECT pr_id FROM Programs where pr_id = ? LIMIT 1), NULL, 0);
    `;
    db.all(sql, [programid, userid], (err,rows) => {
      if(err) {
        console.log(err);
        resolve("error");
      } else {
        resolve("success");
      }
    });
  });
}

async function dbunsubProgram(programid, userid) {
  return await new Promise(function(resolve, reject) {
    let sql = `DELETE FROM Subscriptions WHERE s_programID = ? AND s_userID = ?`;
    db.all(sql, [programid, userid], (err,rows) => {
      if(err) {
        console.log(err);
        resolve("error");
      } else {
        resolve("success");
      }
    });
  });
}

async function dbgetEvent(eventid) {
  return await new Promise(function(resolve, reject) {
    let sql = "SELECT * FROM Events WHERE e_id = ?";
    db.all(sql, [eventid], (err,rows) => {
      // console.log(err);
      // console.log(rows);
      resolve(rows);
    });
  });
}

async function dbgetEvents(eventid) {
  return await new Promise(function(resolve, reject) {
    let sql = "SELECT * FROM Events";
    db.all(sql, [], (err,rows) => {
      // console.log(err);
      // console.log(rows);
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

app.post("/post", async function(req,res) {
  console.log(req.body);
  res.send({
    "status": "success"
  });
});

app.post("/login", async function(req,res) {
  //{"email": email, "password": password}
  var d = await dblogin(req.body['email'], req.body['password']);
  if(d.length == 0) {
    res.send({
      "status": "invalid login"
    });
  } else {
    var programs = await dbprograms(); //get all programs
    var subs = await dbgetSubs(d[0].u_id);
    var posts = await dbposts(d[0].u_id);
    res.send({
      "status": "success",
      "user": d,
      "posts": posts,
      "program": programs,
      "subs": subs
    });
  }
});


app.post("/subscribeProgram", async function(req,res) {
  // req.body = {"program_id": program, "user_id": u_id}
  var status = await dbsubProgram(req.body['program_id'], req.body['user_id']);
  res.send({
    "status": status
  });
});

app.put("/unsubscribeProgram", async function(req,res) {
  // req.body = {"program_id": program, "user_id": u_id}
  var status = await dbunsubProgram(req.body['program_id'], req.body['user_id']);
  res.send({
    "status": status
  });
});

app.get("/getEventsDes", async function(req,res) {
  // req.body = {"event_id": event}
  var d = await dbgetEvent(req.body['event_id']);
  if(d.length == 0) {
    res.send({
      "status": "not found"
    });
  } else {
    res.send({
      "status": "success",
      "data": d[0]
    });
  }
});

app.get("/getEvents", async function(req,res) {
  var d = await dbgetEvents();
  var subs = await dbgetSubs(d[0].u_id);
  res.send({
    "status": "success",
    "events": d,
    "subscriptions": subs
  });
});

app.put("/subscribeEvent", async function(req,res) {

});

app.get("/getPosts", async function(req,res) {
  //req.query = {"user_id":u_id)
  var d = await dbposts(req.query['user_id']);
  var subs = await dbgetSubs(req.query['user_id']);
  res.send({
    "status": "success",
    "posts": d,
    "subscriptions": subs
  });
});

app.get("/getPrograms", async function(req,res) {
  //req.query = {"user_id":u_id)
  var d = await dbprograms();
  var subs = await dbgetSubs(req.query['user_id']);
  res.send({
    "status": "success",
    "programs": d,
    "subscriptions": subs
  });
});

app.post("/addProgram", async function(req,res) {

});

app.put("/addProgramManager", async function(req,res) {

});

app.post("/addEvent", async function(req,res) {

});

app.get("/", function(req, res) {
  console.log(req.query);
  res.send({
    "status": "success",
    "data": "Visit /q# for each of the 20 queries to execute"
  });
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Our app is running on port ${ PORT }`);
});
