CREATE TABLE USERS (
	UserID INT,
    UserName CHAR(50) NOT NULL,
    UserEmail CHAR(50) NOT NULL,
	Primary Key (UserID)
)

CREATE TABLE Restaurants (
	RestaurantID INT,
    RestaurantName CHAR(50) NOT NULL,
    RestaurantLocation CHAR(50) NOT NULL,
	Primary Key (RestaurantID)
)

CREATE TABLE ZomatoGoldMemberships (
    MembershipID INT,
    UserID INT,
    StartDate TIMESTAMP,
    EndDate TIMESTAMP,
    PRIMARY KEY (MembershipID),
    FOREIGN KEY (UserID) REFERENCES USERS(UserID)
)

CREATE TABLE Visits (
    VisitID INT,
    UserID INT,
    RestaurantID INT,
    VisitDate TIMESTAMP,
    BillAmount INT,
	PRIMARY KEY (VisitID),
    FOREIGN KEY (UserID) REFERENCES USERS(UserID),
	FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
)

-- Insert data into Users table
INSERT INTO Users (UserID, UserName, UserEmail) 
VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com');

-- Insert data into Restaurants table
INSERT INTO Restaurants (RestaurantID, RestaurantName, RestaurantLocation) 
VALUES
(1, 'Italian Bistro', 'Downtown'),
(2, 'Sushi Place', 'Midtown'),
(3, 'Burger Joint', 'Uptown');

-- Insert data into ZomatoGoldMemberships table
INSERT INTO ZomatoGoldMemberships (MembershipID, UserID, StartDate, EndDate) 
VALUES
(1, 1, '2024-01-01', '2024-12-31'),
(2, 2, '2024-01-01', '2024-12-31');

-- Insert data into Visits table
INSERT INTO Visits (VisitID, UserID, RestaurantID, VisitDate, BillAmount) 
VALUES
(1, 1, 1, '2024-05-15', 50.00),
(2, 1, 2, '2024-06-20', 75.00),
(3, 2, 1, '2024-05-10', 60.00),
(4, 3, 3, '2024-04-25', 40.00);

/*Data Analysis Queries: */

/*Find the total amount spent by each user with Zomato Gold membership? */
SELECT u.UserName, SUM(v.BillAmount) AS TotalSpent
FROM Users u
JOIN ZomatoGoldMemberships z ON u.UserID = z.UserID
JOIN Visits v ON u.UserID = v.UserID
GROUP BY u.UserName;

/* List the users who visited the 'Italian Bistro' and their visit dates */
SELECT u.UserName, v.VisitDate
FROM Users u
JOIN Visits v ON u.UserID = v.UserID
JOIN Restaurants r ON v.RestaurantID = r.RestaurantID
WHERE r.RestaurantName = 'Italian Bistro';

/*Find the total number of visits to each restaurant by users with Zomato Gold membership */
SELECT r.RestaurantName, COUNT(v.VisitID) AS TotalVisits
FROM Restaurants r
JOIN Visits v ON r.RestaurantID = v.RestaurantID
JOIN ZomatoGoldMemberships z ON v.UserID = z.UserID
GROUP BY r.RestaurantName;

/* Get the details of users whose membership is valid as of a certain date (e.g., '2024-07-01') */
SELECT u.UserName, u.UserEmail, z.StartDate, z.EndDate
FROM Users u
JOIN ZomatoGoldMemberships z ON u.UserID = z.UserID
WHERE '2024-07-01' BETWEEN z.StartDate AND z.EndDate;

/*Find the average bill amount per visit for each restaurant */
SELECT r.RestaurantName, AVG(v.BillAmount) AS AverageBillAmount
FROM Restaurants r
JOIN Visits v ON r.RestaurantID = v.RestaurantID
GROUP BY r.RestaurantName;






