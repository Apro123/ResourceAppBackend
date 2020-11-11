DROP TABLE IF EXISTS Users;
CREATE TABLE IF NOT EXISTS Users (
    u_id INTEGER PRIMARY KEY AUTOINCREMENT,
    u_firstname VARCHAR(255) NULL,
    u_lastname VARCHAR(255) NULL,
    u_username VARCHAR(255) NULL,
    u_pictureURL VARCHAR(255) NULL,
    u_email VARCHAR(255) NULL UNIQUE,
    u_schoolID VARCHAR(255) NULL,
    u_password VARCHAR(255) NULL,
    u_genderTitle VARCHAR(31) NULL,
    u_professionalTitle VARCHAR(31) NULL,
    u_affiliatedProgramID INT NULL REFERENCES Programs(pr_id),
    u_adminPriv INT NULL,
    u_programPriv INT NULL,
    u_lastLoggedIn DATE NULL,
    u_currentlyLoggedIPAddress VARCHAR(255) NULL,
    u_addedBy INT NULL REFERENCES User(u_id)
);

DROP TABLE IF EXISTS Programs;
CREATE TABLE IF NOT EXISTS Programs (
    pr_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pr_name VARCHAR(255) NOT NULL,
    pr_shortName VARCHAR(255) NULL,
    pr_description VARCHAR(255) NULL,
    pr_logoLocation VARCHAR(255) NULL,
    pr_physicalLocation VARCHAR(255) NULL,
    pr_addedByAdminUserID INT NULL REFERENCES Users(u_id),
    pr_eventID INT NULL REFERENCES Events(e_id),
    pr_programManagerUserID INT NULL REFERENCES Users(u_id)
);

DROP TABLE IF EXISTS Events;
CREATE TABLE IF NOT EXISTS Events (
    e_id INTEGER PRIMARY KEY AUTOINCREMENT,
    e_name VARCHAR(255) NOT NULL,
    e_description VARCHAR(255) NULL,
    e_pictureLocation VARCHAR(255) NULL,
    e_programID INT NOT NULL REFERENCES Programs(u_id),
    e_repeated INT NOT NULL,
    e_date DATE NOT NULL,
    e_tags VARCHAR(255) NULL,
    e_addedBy INT NOT NULL REFERENCES Users(u_id)
);

DROP TABLE IF EXISTS Posts;
CREATE TABLE IF NOT EXISTS Posts (
    ps_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ps_addedByUserID INT NOT NULL REFERENCES Users(u_id),
    ps_name VARCHAR(255) NOT NULL,
    ps_description VARCHAR(255) NOT NULL,
    ps_pictureLocation VARCHAR(255) NULL,
    ps_eventID INT NOT NULL REFERENCES Events(e_id),
    ps_pointOpportunity INT NULL REFERENCES PointOpp(po_id),
    ps_tags VARCHAR(255) NULL,
    ps_dateAdded DATE NOT NULL
);

DROP TABLE IF EXISTS Subscriptions;
CREATE TABLE IF NOT EXISTS Subscriptions (
    s_id INTEGER PRIMARY KEY AUTOINCREMENT,
    s_dateAdded DATE NOT NULL,
    s_userID INT NOT NULL REFERENCES Users(u_id),
    s_programID INT NULL REFERENCES Programs(pr_id),
    s_eventID INT NULL REFERENCES Events(e_id),
    s_sendPushNotification INT NOT NULL
);

DROP TABLE IF EXISTS Items;
CREATE TABLE IF NOT EXISTS Items (
    i_id INTEGER PRIMARY KEY AUTOINCREMENT,
    i_addedBy INT NOT NULL REFERENCES Users(u_id),
    i_name VARCHAR(255) NOT NULL,
    i_description VARCHAR(255) NULL,
    i_picture VARCHAR(255) NULL,
    i_pointsWorth INT NOT NULL,
    i_quantitiy INT NOT NULL,
    i_programID INT NOT NULL REFERENCES Programs(pr_id)
);

DROP TABLE IF EXISTS PointOpp;
CREATE TABLE IF NOT EXISTS PointOpp (
    po_id INTEGER PRIMARY KEY AUTOINCREMENT,
    po_name VARCHAR(255) NOT NULL,
    po_description VARCHAR(255) NULL,
    po_type VARCHAR(255) NULL,
    po_externalLink VARCHAR(255) NULL,
    po_postUniqueID INT NOT NULL REFERENCES Posts(ps_id)
);

DROP TABLE IF EXISTS PointHistory;
CREATE TABLE IF NOT EXISTS PointHistory (
    ph_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ph_userID INT NOT NULL REFERENCES Users(u_id),
    ph_pointOppID INT NOT NULL REFERENCES PointOpp(po_id),
    ph_actualPointsEarned INT NOT NULL
);

DROP TABLE IF EXISTS ItemsBought;
CREATE TABLE IF NOT EXISTS ItemsBought (
    ib_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ib_userID INT NOT NULL REFERENCES Users(u_id),
    ib_itemID INT NOT NULL REFERENCES Items(i_id),
    ib_dateOrdered VARCHAR(255) NOT NULL,
    ib_dateReceived VARCHAR(255) NULL
);

DROP TABLE IF EXISTS Points;
CREATE TABLE IF NOT EXISTS Points (
    p_id INTEGER PRIMARY KEY AUTOINCREMENT,
    p_userID INT NOT NULL REFERENCES Users(u_id),
    p_currentPoints INT NOT NULL,
    p_totalPoints INT NOT NULL
);
