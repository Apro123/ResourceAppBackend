-- Inserting data into Users
INSERT INTO Users (u_firstname, u_lastname, u_username, u_pictureURL, u_schoolEmail, u_schoolID, u_password, u_genderTitle, u_professionalTitle, u_affiliatedProgramID, u_adminPriv, u_programPriv, u_lastLoggedIn, u_currentlyLoggedIPAddress, u_addedBy)
VALUES
    ('Victoria', 'Preece', 'admin user #1', "https://loremflickr.com/640/360", 'vPreece@ucmerced.edu', '802789240', 'password1', "She/Her", "IT Administrator", NULL, 0, 0, NULL, NULL, NULL),
    ('Payton', 'Greaves', 'user #2', "https://loremflickr.com/640/360", 'pGreaves@ucmerced.edu', '378502872', 'password2', "She/Her", "Student", NULL, 0, 0, NULL, NULL, NULL),
    ('Roisin', 'Tierney', 'user #3', "https://loremflickr.com/640/360", 'rTierney@ucmerced.edu', '024567491', 'password3', "He/His/Him", "Student", NULL, 0, 0, NULL, NULL, NULL),
    ('Keiren', 'Robin', 'user #4', "https://loremflickr.com/640/360", 'kRobin@ucmerced.edu', '456872035', 'password4', "He/His/Him", "Student", NULL, 0, 0, NULL, NULL, NULL),
    ('Rose', 'Handley', 'program user #5', "https://loremflickr.com/640/360", 'rHandley@ucmerced.edu', '867542098', 'password5', "She/Her", "Program Intern", NULL, 0, 0, NULL, NULL, 1),
    (NULL, NULL, NULL, NULL, 'rHandley@ucmerced.edu', NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL, 1),
    (NULL, NULL, NULL, NULL, 'rHandley@ucmerced.edu', NULL, NULL, NULL, NULL, 2, 0, 1, NULL, NULL, 1),
    (NULL, NULL, NULL, NULL, 'rHandley@ucmerced.edu', NULL, NULL, NULL, NULL, 3, 0, 1, NULL, NULL, 1),
    ('Phoebe', 'Legge', 'user #6', "https://loremflickr.com/640/360", 'pLegge@ucmerced.edu', '324587601', 'password6', "She/Her", "Student", NULL, 0, 0, NULL, NULL, NULL),
    ('Asha', 'Bolton', 'program user #7', "https://loremflickr.com/640/360", 'aBolton@ucmerced.edu', '457822146', 'password7', "She/Her", "Program Intern", NULL, 0, 0, NULL, NULL, 1),
    (NULL, NULL, NULL, NULL, 'aBolton@ucmerced.edu', NULL, NULL, NULL, NULL, 3, 0, 1, NULL, NULL, 1),
    (NULL, NULL, NULL, NULL, 'aBolton@ucmerced.edu', NULL, NULL, NULL, NULL, 4, 0, 1, NULL, NULL, 1),
    ('Abubakr', 'Buxton', 'user #8', "https://loremflickr.com/640/360", 'aBuxton@ucmerced.edu', '145687923', 'password8', "She/Her", "Student", NULL, 0, 0, NULL, NULL, NULL),
    ('William', 'Hayes', 'program user #9', "https://loremflickr.com/640/360", 'wHayes@ucmerced.edu', '612358497', 'password9', "He/His/Him", "Program Intern", NULL, 0, 0, NULL, NULL, 1),
    (NULL, NULL, NULL, NULL, 'wHayes@ucmerced.edu', NULL, NULL, NULL, NULL, 5, 0, 1, NULL, NULL, 1),
    ('Bjorn', 'Villarreal', 'user #10', "https://loremflickr.com/640/360", 'bVillarreal@ucmerced.edu', '542031782', 'password10', "He/His/Him", "Student", NULL, 0, 0, NULL, NULL, 1);

-- Inserting data into Programs
INSERT INTO Programs (pr_name, pr_shortName, pr_description, pr_logoLocation, pr_physicalLocation, pr_addedByAdminUserID, pr_eventID, pr_programManagerUserID, pr_tags)
VALUES
    ('program #1', "pr1", "des1", "https://loremflickr.com/640/360", "COB 1 RM 251", 1, NULL, 5, "IT, entertainment"),
    ('program #2', "pr2", "des2", "https://loremflickr.com/640/360", "COB 1 RM 252", 1, NULL, 5, "food, fun"),
    ('program #3', "pr3", "des3", "https://loremflickr.com/640/360", "COB 1 RM 253", 1, NULL, 5, "thrilling, exciting"),
    ('program #3', NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL),
    ('program #4', "pr4", "des4", "https://loremflickr.com/640/360", "COB 1 RM 254", 1, NULL, 10, "food, entertainment"),
    ('program #4', NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL),
    ('program #5', "pr5", "des5", "https://loremflickr.com/640/360", "COB 1 RM 255", 1, NULL, 14, "fun, exciting"),
    ('program #5', NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL);

-- Inserting data into Events
INSERT INTO Events (e_name, e_description, e_pictureLocation, e_programID, e_repeated, e_date, e_tags, e_addedBy)
VALUES
    ('event #1', "des1", "https://loremflickr.com/640/360", 1, "Weekly", '2020-11-18', NULL, 1),
    ('event #2', "des2", "https://loremflickr.com/640/360", 2, NULL, '2020-12-05', NULL, 1),
    ('event #3', "des3", "https://loremflickr.com/640/360", 3, NULL, '2020-11-21', NULL, 5),
    ('event #4', "des4", "https://loremflickr.com/640/360", 3, "Monthly", '2020-8-21', NULL, 10),
    ('event #5', "des5", "https://loremflickr.com/640/360", 7, NULL, '2020-10-21', NULL, 10),
    ('event #6', "des6", "https://loremflickr.com/640/360", 5, "Biweekly", '2020-9-21', NULL, 14);

-- Inserting data into Posts
INSERT INTO Posts (ps_addedByUserID, ps_name, ps_description, ps_pictureLocation, ps_eventID, ps_pointOpportunity, ps_tags, ps_dateAdded)
VALUES
    (1, 'post #1', "des1", "https://loremflickr.com/640/360", 1, 1, "student, food", '2020-11-15'),
    (1, 'post #2', "des2", "https://loremflickr.com/640/360", 5, 2, "faculty, entertainment", '2020-11-16'),
    (1, 'post #3', "des3", "https://loremflickr.com/640/360", 6, 3, "student, fun", '2020-11-16'),
    (1, 'post #4', "des4", "https://loremflickr.com/640/360", 3, 4, "student, food", '2020-11-17'),
    (10, 'post #5', "des5", "https://loremflickr.com/640/360", 3, 5, "student, entertainment", '2020-11-18'),
    (5, 'post #6', "des6", "https://loremflickr.com/640/360", 1, 6, "student, food", '2020-11-19'),
    (5, 'post #7', "des7", "https://loremflickr.com/640/360", 2, 1, "faculty, entertainment", '2020-11-20'),
    (10, 'post #8', "des8", "https://loremflickr.com/640/360", 4, 2, "student, fun", '2020-11-22'),
    (14, 'post #9', "des9", "https://loremflickr.com/640/360", 5, 3, "faculty, food", '2020-11-24'),
    (10, 'post #10', "des10", "https://loremflickr.com/640/360", 6, 4, "student, entertainment", '2020-11-25'),
    (5, 'post #11', "des11", "https://loremflickr.com/640/360", 3, 5, "faculty, fun", '2020-11-28'),
    (5, 'post #12', "des12", "https://loremflickr.com/640/360", 4, 6, "student, food", '2020-10-10');

-- Inserting data into Subscriptions
INSERT INTO Subscriptions (s_dateAdded, s_userID, s_programID, s_eventID, s_sendPushNotification)
VALUES
    ('2020-11-15', 2, 1, NULL, 0),
    ('2020-11-16', 3, 2, NULL, 1),
    ('2020-11-17', 4, 3, NULL, 1),
    ('2020-11-19', 5, 5, NULL, 0),
    ('2020-11-20', 9, 7, NULL, 1),
    ('2020-11-20', 16, 3, NULL, 0);
    ('2020-11-20', 16, NULL, 4, 1);

-- Inserting data into Items
INSERT INTO Items (i_addedBy, i_name, i_description, i_picture, i_pointsWorth, i_quantitiy, i_programID)
VALUES
    (1, 'item #1', "des1", "https://loremflickr.com/640/360", 15, 10, 1),
    (5, 'item #2', "des2", "https://loremflickr.com/640/360", 250, 3, 3),
    (10, 'item #3', "des3", "https://loremflickr.com/640/360", 100, 5, 5),
    (14, 'item #4', "des4", "https://loremflickr.com/640/360", 50, 10, 7),
    (1, 'item #5', "des5", "https://loremflickr.com/640/360", 30, 15, 3),
    (5, 'item #6', "des6", "https://loremflickr.com/640/360", 75, 8, 2);

-- Inserting data into PointOpp
INSERT INTO PointOpp (po_name, po_description, po_type, po_externalLink, po_pointsPossible)
VALUES
    ('survey #1', "des1", "survey", "forms.google.com", 30),
    ('survey #2', "des2", "survey", "forms.google.com", 25),
    ('survey #3', "des3", "survey", "forms.google.com", 25),
    ('survey #4', "des4", "survey", "forms.google.com", 50),
    ('survey #5', "des5", "survey", "forms.google.com", 25),
    ('survey #6', "des6", "survey", "forms.google.com", 40);

-- Inserting data into PointHistory
INSERT INTO PointHistory (ph_userID, ph_pointOppID, ph_actualPointsEarned)
VALUES
    (2, 1, NULL),
    (3, 2, 20),
    (4, 3, NULL),
    (4, 4, 50),
    (5, 4, 20),
    (9, 5, NULL),
    (16, 6, 35);

-- Inserting data into ItemsBought
INSERT INTO ItemsBought (ib_userID, ib_itemID, ib_dateOrdered, ib_dateReceived)
VALUES
    (4, 4, '2020-12-1', '2020-12-3'),
    (16, 1, '2020-12-3', '2020-12-4'),
    (16, 1, '2020-12-5', NULL);

-- Inserting data into Points
INSERT INTO Points (p_userID, p_currentPoints, p_totalPoints)
VALUES
    (2, 0, 0),
    (3, 0, 20),
    (4, 0, 50),
    (5, 0, 20),
    (9, 0, 0),
    (16, 5, 30);
