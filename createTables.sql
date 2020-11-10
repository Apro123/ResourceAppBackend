CREATE TABLE IF NOT EXISTS Users (
    u_id INT PRIMARY KEY, 
    u_firstname VARCHAR(255) NOT NULL, 
    u_lastname VARCHAR(255) NOT NULL, 
    u_username VARCHAR(255) NOT NULL, 
    u_pictureURL VARCHAR(255) NULL, 
    u_schoolEmail VARCHAR(255) NOT NULL, 
    u_schoolID VARCHAR(255) NOT NULL, 
    u_password VARCHAR(255) NOT NULL, 
    u_genderTitle VARCHAR(31) NULL, 
    u_professionalTitle VARCHAR(31) NULL, 
    u_affiliatedProgramID INT NULL REFERENCES Programs(pr_id), 
    u_adminPriv INT NOT NULL, 
    u_programPriv INT NOT NULL, 
    u_lastLoggedIn DATE NULL, 
    u_currentlyLoggedIPAddress VARCHAR(255) NULL,
    u_addedBy INT NOT NULL REFERENCES User(u_id)
);

CREATE TABLE IF NOT EXISTS Programs (
    pr_id INT PRIMARY KEY, 
    pr_name VARCHAR(255) NOT NULL, 
    pr_shortName VARCHAR(255) NULL, 
    pr_description VARCHAR(255) NULL, 
    pr_logoLocation VARCHAR(255) NULL, 
    pr_physicalLocation VARCHAR(255) NULL, 
    pr_addedByAdminUserID INT NOT NULL REFERENCES Users(u_id), 
    pr_eventID INT NOT NULL REFERENCES Events(e_id), 
    pr_programManagerUserID INT NOT NULL REFERENCES Users(u_id)
);

CREATE TABLE IF NOT EXISTS Events (
    e_id INT PRIMARY KEY, 
    e_name VARCHAR(255) NOT NULL, 
    e_description VARCHAR(255) NULL, 
    e_pictureLocation VARCHAR(255) NULL, 
    e_programID INT NOT NULL REFERENCES Programs(u_id), 
    e_repeated BOOLEAN NOT NULL, 
    e_date DATE NOT NULL, 
    e_tags VARCHAR(255) NULL, 
    e_addedBy INT NOT NULL REFERENCES Users(u_id)
);

CREATE TABLE IF NOT EXISTS Posts (
    ps_id INT PRIMARY KEY, 
    ps_addedByUserID INT NOT NULL REFERENCES Users(u_id), 
    ps_name VARCHAR(255) NOT NULL, 
    ps_description VARCHAR(255) NULL, 
    ps_pictureLocation VARCHAR(255) NULL, 
    ps_eventID INT NOT NULL REFERENCES Events(e_id), 
    ps_pointOpportunity INT NULL REFERENCES PointOpp(po_id), 
    ps_tags VARCHAR(255) NULL, 
    ps_dateAdded DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Subscriptions (
    s_id INT PRIMARY KEY, 
    s_dateAdded DATE NOT NULL, 
    s_userID INT NOT NULL REFERENCES Users(u_id), 
    s_programID INT NOT NULL REFERENCES Programs(pr_id), 
    s_eventID INT NOT NULL REFERENCES Events(e_id), 
    s_sendPushNotification BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS Items (
    i_id INT PRIMARY KEY, 
    i_addedBy INT NOT NULL REFERENCES Users(u_id), 
    i_name VARCHAR(255) NOT NULL, 
    i_description VARCHAR(255) NULL, 
    i_picture VARCHAR(255) NULL, 
    i_pointsWorth INT NULL, 
    i_quantitiy INT NULL, 
    i_programID INT NOT NULL REFERENCES Programs(pr_id)
);

CREATE TABLE IF NOT EXISTS PointOpp (
    po_id INT PRIMARY KEY, 
    po_name VARCHAR(255) NOT NULL, 
    po_description VARCHAR(255) NULL, 
    po_type VARCHAR(255) NULL, 
    po_externalLink VARCHAR(255) NULL, 
    po_postUniqieID INT NOT NULL REFERENCES Posts(ps_id)
);

CREATE TABLE IF NOT EXISTS PointHistory (
    ph_id INT PRIMARY KEY, 
    ph_userID INT NOT NULL REFERENCES Users(u_id), 
    ph_pointOppID INT NOT NULL REFERENCES PointOpp(po_id), 
    ph_actualPointsEarned INT NOT NULL
);

CREATE TABLE IF NOT EXISTS ItemsBought (
    ib_id INT PRIMARY KEY, 
    ib_userID INT NOT NULL REFERENCES Users(u_id), 
    ib_itemID INT NOT NULL REFERENCES Items(i_id), 
    ib_dateOrdered VARCHAR(255) NOT NULL, 
    ib_dateReceived VARCHAR(255)
); 

CREATE TABLE IF NOT EXISTS Points (
    p_id INT PRIMARY KEY, 
    p_userID INT NOT NULL REFERENCES Users(u_id), 
    p_currentPoints INT NOT NULL, 
    p_totalPoints INT NOT NULL
);

-- Remove all content from database
-- DELETE FROM Users;
-- DELETE FROM Programs;
-- DELETE FROM Events;
-- DELETE FROM Posts;
-- DELETE FROM Subscriptions;
-- DELETE FROM Items;
-- DELETE FROM PointOpp;
-- DELETE FROM PointHistory;
-- DELETE FROM ItemsBought;
-- DELETE FROM Points;