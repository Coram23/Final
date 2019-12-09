CREATE SCHEMA Final_Project7;
USE Final_Project7;


CREATE TABLE Parents (
FamilyID varchar(6) NOT NULL,
Email varchar(30),
FirstName varchar(30),
LastName varchar(30) NOT NULL,
Address varchar(50),
PhoneNumber varchar(15),
PRIMARY KEY (FamilyID)
);


CREATE TABLE Students (
StudentID varchar(6) NOT NULL,
FirstName varchar (255),
LastName varchar (255) NOT NULL,
Grade int NOT NULL,
StatusID int NOT NULL,
FamilyID varchar(6) NOT NULL,
PRIMARY KEY (StudentID),
FOREIGN KEY (FamilyID) REFERENCES Parents(FamilyID)
);


CREATE TABLE Meals (
MealID varchar(5) NOT NULL,
MealDescription varchar (255),
PRIMARY KEY (MealID)
);


CREATE TABLE FinancialStatus (
StatusID integer auto_increment primary key,
StatusDetails varchar(10) not null,
ChargePerMeal varchar(4)
);
    
    
CREATE TABLE MealTransactions (
TransactionID varchar(7) NOT NULL,
TransactionDate Date,
TransactionTime varchar(5),
StatusID integer auto_increment,
MealsOrdered int,
StudentID VARCHAR(6) NOT NULL,
MealID varchar(5) NOT NULL,
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (MealID) REFERENCES Meals(MealID),
FOREIGN KEY (StatusID) REFERENCES FinancialStatus(StatusID)
); 
    
    
CREATE TABLE Payments (
PaymentID int NOT NULL,
Method varchar(30),   
Amount int,
PaymentDate date,
Processor varchar(30),
Notes varchar(280),
StudentID varchar(6) NOT NULL,
PRIMARY KEY (PaymentID),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
    

INSERT INTO Parents (FamilyID,email, FirstName, LastName, Address, PhoneNumber)
VALUES
('100000', 'ahaas@gmail.com', 		'Aman', 		'Haas', 		'14 Ridgeway Ct.', 		'(286)146-9786'),
('200000', 'ccastolo@hotmail.com', 	'Cristobal', 	'Castolo', 	'6456 Murdoch Ave', 	'(300)412-8886'),
('300000', 'khought@gmail.com', 	'Karen', 		'Hought', 	'304 Kingslanding Rd.', '(286)003-7462'),
('400000', 'mstarr@gmail.com', 		'Marcine', 		'Starr', 	'2 Westward Dr.', 		'(286)994-1630'),
('500000', 'tbaida@hotmail.com', 	'Tony', 		'Baida', 	'7804 Kylian Pkwy.', 	'(300)845-7544');


INSERT INTO Students (StudentID,FirstName,LastName,Grade,StatusID,FamilyID)
VALUES  
('000001','Safiyah',	'Haas',		3,3,'100000'),
('000002','Mattew',		'Castolo',	5,2,'200000'),
('000003','Kaycee',		'Hought',	7,2,'300000'),
('000004','Christopher','Starr',	4,1,'400000'),
('000005','Jamil',		'Baida',	6,1,'500000');


INSERT INTO Meals (MealID, MealDescription)
Values 
('11100','Chicken Nuggets, Glazed Sweet Potato, Chilled Mixed Fruit, Choice of milk'),
('11200','Bean Nachos, Corn Whole Kernel, Apple Slices w/ Cinnamon, Choice of Milk'),
('11300','PBJ w/ Cheesestick, Fresh Mango, Fresh Cucumber w/ Dip, Choice of Milk'),
('11400','Chili Beef With Beans, Cornbread, Chilled Pears, Choice of Milk'),
('11500','Deli Sandwich w/ Lettuce & Tomato, Mini Carrots, Fresh Grapes, Choice of Milk');


INSERT INTO FinancialStatus (StatusDetails, ChargePerMeal)
VALUES 
('Paid',	 '3.00'),
('Reduced',  '0.40'),
('Free', 	 '0.00');



INSERT INTO MealTransactions (TransactionID, TransactionDate, TransactionTime, StatusID, MealsOrdered, StudentID, MealID)
Values 
('1000111','2019-01-16', '12:30','1', 2, '000005', '11100'),
('1000222','2019-01-16', '12:30','3', 1, '000001', '11200'),
('1000333','2019-01-16', '12:30','2', 2, '000003', '11400'),
('1000444','2019-01-20', '12:30','2', 2, '000002', '11300'),
('1000555','2019-01-20', '12:30','1', 1, '000004', '11500'),
('1000666','2019-01-20', '12:30','2', 1, '000002', '11200'),
('1000777','2019-01-20', '12:30','1', 1, '000004', '11300');


INSERT INTO Payments (PaymentID, Method, Amount, PaymentDate, Processor, Notes, StudentID )
VALUES 
('010000', 'Cash', 			'6.00',	'2019-01-16',	'',				'', '000001'),
('020000', 'Credit Card', 	'10.00',	'2019-01-16',	'Visa',			'', '000002'),
('030000', 'Credit Card',	'5.00',	'2019-01-16',	'Mastercard',	'', '000003'),
('040000', 'Credit Card',	'15.00',	'2019-01-30',	'PostePay',		'', '000004'),
('050000', 'Cash',			'12.00',	'2019-01-23',	'',				'', '000005');


SELECT * FROM Meals;
SELECT * FROM Parents;
SELECT * FROM Payments;
SELECT * FROM FinancialStatus;
SELECT * FROM MealTransactions;
SELECT * FROM Students;

--- RQ1 ---

SELECT
FirstName,
LastName,
Grade
FROM Students
ORDER BY Grade;

SELECT
FirstName,
LastName,
Grade
FROM Students
ORDER BY LastName;

SELECT
FirstName,
LastName,
Grade
FROM Students
ORDER BY FirstName;

--- RQ2 ---

SELECT
FirstName,
LastName,
StatusDetails
FROM Students S
Left JOIN FinancialStatus F
ON F.StatusID = S.StatusID
ORDER BY StatusDetails;

SELECT
FirstName,
LastName,
StatusDetails
FROM Students S
Left JOIN FinancialStatus F
ON F.StatusID = S.StatusID
ORDER BY LastName;

SELECT
FirstName,
LastName,
StatusDetails
FROM Students S
Left JOIN FinancialStatus F
ON F.StatusID = S.StatusID
ORDER BY FirstName;

--- RQ3 Part1 ---

SELECT 
sum(MealsOrdered) AS 'Total Meals Ordered'
FROM MealTransactions
WHERE TransactionDate = '2019-01-16';

SELECT 
sum(MealsOrdered) AS 'Total Meals Ordered'
FROM MealTransactions
WHERE TransactionDate = '2019-01-20';


--- RQ3 Part2 ---


SELECT 
sum(MealsOrdered * ChargePerMeal) AS 'Total Meal Cost'
FROM MealTransactions M
Left JOIN FinancialStatus F
ON F.StatusID = M.StatusID
WHERE TransactionDate = '2019-01-16';

SELECT 
sum(MealsOrdered * ChargePerMeal) AS 'Total Meal Cost'
FROM MealTransactions M
Left JOIN FinancialStatus F
ON F.StatusID = M.StatusID
WHERE TransactionDate = '2019-01-20';


--- RQ4 ---

SELECT 
Sum(MealsOrdered),
(sum(MealsOrdered)*3.00) AS 'Total Free Meal Cost'
FROM MealTransactions M
Left JOIN FinancialStatus F
ON F.StatusID = M.StatusID
WHERE F.StatusID = 3;


--- RQ5 ---

SELECT 
Sum(MealsOrdered),
(sum(MealsOrdered)*3.00) AS 'Total Reduced Meal Cost'
FROM MealTransactions M
Left JOIN FinancialStatus F
ON F.StatusID = M.StatusID
WHERE F.StatusID = 2;


--- RQ6 ---

SELECT 
PaymentID,
Amount,
FirstName,
LastName
FROM Payments P
Left JOIN Students S
ON S.StudentID = P.StudentID
GROUP BY LastName;


--- RQ7 ---

create view StudentPayments as
select s.StudentID,
       concat(s.FirstName,' ',s.LastName) as FullName,
       p.Amount
from Students s
left join Payments p
on s.StudentID = p.StudentID;


create view TotalMealOrdered as
select TransactionID,
       StatusID,
       sum(MealsOrdered) as TotalMealOrdered,
       StudentID
from MealTransactions
group by StudentID;

select sp.StudentID,
       sp.FullName,
	   sp.Amount AS "Amount Paid",
       round((tm.TotalMealOrdered*sts.ChargePerMeal),2) as Charge
from TotalMealOrdered tm
left join StudentPayments sp
on tm.StudentID = sp.StudentID
left join FinancialStatus sts
on tm.StatusID = sts.StatusID
group by sp.StudentID;






--- TABLEDROPS ---
DROP TABLE FinancialStatus;
DROP TABLE MealTransactions;
DROP TABLE Payments;
DROP TABLE Students;
DROP TABLE Meals;
DROP TABLE Parents;

