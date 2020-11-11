-- Inserting data into Users
INSERT INTO Users (u_firstname, u_lastname, u_username, u_pictureURL, u_schoolEmail, u_schoolID, u_password, u_genderTitle, u_professionalTitle, u_affiliatedProgramID, u_adminPriv, u_programPriv, u_lastLoggedIn, u_currentlyLoggedIPAddress, u_addedBy)
VALUES 
    ('Victoria', 'Preece', 'user #1', NULL, 'vPreece@ucmerced.edu', '802789240', 'password1', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL),
    ('Payton', 'Greaves', 'user #2', NULL, 'pGreaves@ucmerced.edu', '378502872', 'password2', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL),
    ('Roisin', 'Tierney', 'user #3', NULL, 'rTierney@ucmerced.edu', '024567491', 'password3', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL),
    ('Keiren', 'Robin', 'user #4', NULL, 'kRobin@ucmerced.edu', '456872035', 'password4', NULL, NULL, NULL, 0, 1, NULL, NULL, 1),
    ('Rose', 'Handley', 'user #5', NULL, 'rHandley@ucmerced.edu', '867542098', 'password5', NULL, NULL, NULL, 0, 1, NULL, NULL, 2),
    ('Phoebe', 'Legge', 'user #6', NULL, 'pLegge@ucmerced.edu', '324587601', 'password6', NULL, NULL, NULL, 0, 1, NULL, NULL, 3),
    ('Asha', 'Bolton', 'user #7', NULL, 'aBolton@ucmerced.edu', '457822146', 'password7', NULL, NULL, NULL, 0, 0, NULL, NULL, NULL),
    ('Abubakr', 'Buxton', 'user #8', NULL, 'aBuxton@ucmerced.edu', '145687923', 'password8', NULL, NULL, NULL, 0, 0, NULL, NULL, NULL),
    ('William', 'Hayes', 'user #9', NULL, 'wHayes@ucmerced.edu', '612358497', 'password9', NULL, NULL, NULL, 0, 0, NULL, NULL, NULL),
    ('Bjorn', 'Villarreal', 'user #10', NULL, 'bVillarreal@ucmerced.edu', '542031782', 'password10', NULL, NULL, NULL, 0, 0, NULL, NULL, NULL);

-- Inserting data into Programs
INSERT INTO Programs (pr_name, pr_shortName, pr_description, pr_logoLocation, pr_physicalLocation, pr_addedByAdminUserID, pr_eventID, pr_programManagerUserID)
VALUES
    ('program #1', NULL, NULL, NULL, NULL, 1, 2, 1),
    ('program #2', NULL, NULL, NULL, NULL, 2, 1, 5),
    ('program #3', NULL, NULL, NULL, NULL, 3, 3, 4),
    ('program #4', NULL, NULL, NULL, NULL, 1, 6, 4),
    ('program #5', NULL, NULL, NULL, NULL, 2, 4, 1),
    ('program #6', NULL, NULL, NULL, NULL, 3, 5, 2);

-- Inserting data into Events
INSERT INTO Events (e_name, e_description, e_pictureLocation, e_programID, e_repeated, e_date, e_tags, e_addedBy)
VALUES
    ('event #1', NULL, NULL, 2, 0, '2020-11-18', NULL, 2),
    ('event #2', NULL, NULL, 1, 0, '2020-12-05', NULL, 1),
    ('event #3', NULL, NULL, 3, 0, '2020-11-21', NULL, 3),
    ('event #4', NULL, NULL, 5, 0, '2020-11-21', NULL, 2),
    ('event #5', NULL, NULL, 6, 0, '2020-11-21', NULL, 3),
    ('event #6', NULL, NULL, 4, 0, '2020-11-21', NULL, 1);

-- Inserting data into Posts
INSERT INTO Posts (ps_addedByUserID, ps_name, ps_description, ps_pictureLocation, ps_eventID, ps_pointOpportunity, ps_tags, ps_dateAdded)
VALUES
    (1, 'post #1', NULL, NULL, 2, 30, NULL, '2020-11-15'),
    (2, 'post #2', NULL, NULL, 1, 30, NULL, '2020-11-16'),
    (3, 'post #3', NULL, NULL, 3, 30, NULL, '2020-11-16'),
    (2, 'post #4', NULL, NULL, 4, 30, NULL, '2020-11-17'),
    (3, 'post #5', NULL, NULL, 6, 30, NULL, '2020-11-19'),
    (1, 'post #6', NULL, NULL, 5, 30, NULL, '2020-11-20');

-- Inserting data into Subscriptions
INSERT INTO Subscriptions (s_dateAdded, s_userID, s_programID, s_eventID, s_sendPushNotification)
VALUES
    ('2020-11-15', 3, 2, 1, 0),
    ('2020-11-16', 2, 1, 2, 0),
    ('2020-11-17', 2, 3, 3, 0),
    ('2020-11-19', 1, 5, 4, 0),
    ('2020-11-20', 4, 6, 5, 0),
    ('2020-11-20', 1, 4, 6, 0);

-- Inserting data into Items
INSERT INTO Items (i_addedBy, i_name, i_description, i_picture, i_pointsWorth, i_quantitiy, i_programID)
VALUES
    (1, 'item #1', NULL, NULL, 15, 10, 2),
    (3, 'item #2', NULL, NULL, 250, 3, 1),
    (4, 'item #3', NULL, NULL, 100, 5, 4),
    (2, 'item #4', NULL, NULL, 50, 10, 1),
    (5, 'item #5', NULL, NULL, 30, 15, 5),
    (2, 'item #6', NULL, NULL, 75, 8, 3);

-- Inserting data into PointOpp
INSERT INTO PointOpp (po_name, po_description, po_type, po_externalLink, po_postUniqueID)
VALUES
    ('survey #1', NULL, NULL, NULL, 1),
    ('survey #2', NULL, NULL, NULL, 2),
    ('survey #3', NULL, NULL, NULL, 3),
    ('survey #4', NULL, NULL, NULL, 4),
    ('survey #5', NULL, NULL, NULL, 5),
    ('survey #6', NULL, NULL, NULL, 6);

-- Inserting data into PointHistory
INSERT INTO PointHistory (ph_userID, ph_pointOppID, ph_actualPointsEarned)
VALUES
    (4, 1, 30),
    (5, 2, 20),
    (6, 3, 30),
    (7, 4, 18),
    (8, 5, 25),
    (9, 6, 30);

-- Inserting data into ItemsBought
INSERT INTO ItemsBought (ib_userID, ib_itemID, ib_dateOrdered, ib_dateReceived)
VALUES
    (7, 5, '2020-12-1', NULL),
    (6, 5, '2020-12-3', NULL),
    (5, 1, '2020-12-3', NULL),
    (8, 1, '2020-12-4', NULL),
    (9, 1, '2020-12-6', NULL),
    (4, 5, '2020-12-9', NULL);

-- Inserting data into Points
INSERT INTO Points (p_userID, p_currentPoints, p_totalPoints)
VALUES
    (1, 0, 0),
    (2, 0, 0),
    (3, 0, 0),
    (4, 0, 30),
    (5, 15, 30),
    (6, 0, 30),
    (7, 0, 30),
    (8, 15, 30),
    (9, 15, 30);