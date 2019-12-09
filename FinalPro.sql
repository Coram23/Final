CREATE SCHEMA Final_Project6;
USE Final_Project6;


CREATE TABLE Parent (
FamilyID varchar(6) NOT NULL,
Email varchar(30) ,
FirstName varchar(30) ,
LastName varchar(30) ,
Address varchar(50) ,
PhoneNumber varchar(15) ,
PRIMARY KEY (FamilyID)
);


CREATE TABLE Student (
StudentID varchar(6) NOT NULL,
FirstName varchar (255),
LastName varchar (255) NOT NULL,
Grade int NOT NULL,
StatusID int NOT NULL,
FamilyID varchar(6) NOT NULL,
PRIMARY KEY (StudentID),
FOREIGN KEY (FamilyID) REFERENCES Parent(FamilyID)
);


CREATE TABLE Meal(
MealID varchar(5) NOT NULL,
Description varchar (255),
PRIMARY KEY (MealID)
);


CREATE TABLE Status (
	StatusID	integer auto_increment primary key,
    Descr	varchar(10) not null,
    ChargePerMeal 	varchar(4)
    );
    
    
CREATE TABLE Transaction (
    TransactionID varchar(7) NOT NULL,
    Date_ Date,
    Time_ varchar(5),
    StatusID integer auto_increment ,
    MealsOrdered int,
    StudentID VARCHAR(6) NOT NULL,
    MealID varchar(5) NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (MealID) REFERENCES Meal(MealID),
    FOREIGN KEY (StatusID) REFERENCES Status(StatusID)
    
);    
drop table Transaction;
    
CREATE TABLE Payment (
	PaymentID	  int not null,
    Method        varchar (30),   
    Amount	      int ,
    PaymentDate   date,
    Processor     varchar (30),
    Notes         varchar (280),
    StudentID     varchar(6) NOT NULL,
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
    );
    
    



INSERT INTO Parent (FamilyID,email, FirstName, LastName, Address, PhoneNumber)
VALUES
('100000', 'ahaas@gmail.com', 'Aman', 'Haas', '14 Ridgeway Ct.', '(286)146-9786'),
('200000', 'ccastolo@hotmail.com', 'Cristobal', 'Castolo', '6456 Murdoch Ave', '(300)412-8886'),
('300000', 'khought@gmail.com', 'Karen', 'Hought', '304 Kingslanding Rd.', '(286)003-7462'),
('400000', 'mstarr@gmail.com', 'Marcine', 'Starr', '2 Westward Dr.', '(286)994-1630'),
('500000', 'tbaida@hotmail.com', 'Tony', 'Baida', '7804 Kylian Pkwy.', '(300)845-7544') ;


INSERT INTO Student (StudentID,FirstName,LastName,Grade,StatusID,FamilyID)
VALUES  
('000001','Safiyah','Haas',3,3,'100000'),
('000002','Mattew','Castolo',5,2,'200000'),
('000003','Kaycee','Hought',7,2,'300000'),
('000004','Christopher','Starr',4,1,'400000'),
('000005','Jamil','Baida',6,1,'500000');


INSERT INTO Meal (MealID, Description)
Values 
('11100','Chicken Nuggets, Glazed Sweet Potato, Chilled Mixed Fruit, Choice of milk'),
('11200','Bean Nachos, Corn Whole Kernel, Apple Slices w/ Cinnamon, Choice of Milk'),
('11300','PBJ w/ Cheesestick, Fresh Mango, Fresh Cucumber w/ Dip, Choice of Milk'),
('11400','Chili Beef With Beans, Cornbread, Chilled Pears, Choice of Milk'),
('11500','Deli Sandwich w/ Lettuce & Tomato, Mini Carrots, Fresh Grapes, Choice of Milk');


INSERT INTO Status (Descr, ChargePerMeal)
VALUES 
('Paid', '3.00'),
('Reduced ', '0.40'),
('Free', '0.00');



INSERT INTO Transaction (TransactionID, Date_, Time_,StatusID, MealsOrdered, StudentID, MealID)
Values 
('1000111','2019-01-16', '12:30','1', 2, '000005', '11100'),
('1000222','2019-02-17', '12:30','3', 1, '000001', '11200'),
('1000333','2019-02-18', '12:30','2', 2, '000003', '11400'),
('1000444','2019-02-19', '12:30', '2',2, '000002', '11300'),
('1000555','2019-02-20', '12:30', '1',1, '000004', '11500'),
('1000666','2019-02-20', '12:30', '2', 1, '000002', '11200'),
('1000777','2019-02-20', '12:30','1', 1, '000004', '11300');



                   
		
SET SQL_SAFE_UPDATES = 1;



INSERT INTO Payment (PaymentID, Method, Amount, PaymentDate, Processor, Notes, StudentID )
VALUES 
('010000', 'Cash', '6','2019-01-16','','','000001'),
('020000', 'Credit Card', '10','2019-01-16','Visa','','000002'),
('030000','Credit Card','5','2019-01-16','Mastercard','','000003'),
('040000','Credit Card','15','2019-01-30','PostePay','','000004'),
('050000','Cash','12','2019-01-23','','','000005');


SELECT * FROM Meal;
SELECT * FROM Parent;
SELECT * FROM Payment;
SELECT * FROM Status;
SELECT * FROM Student;
SELECT * FROM Transaction;


select 
       sum(t.MealsOrdered) as TotalMeals,
       (sum(t.MealsOrdered) * 3) as TotalAmount
       
from Transaction t
inner join Student s
on t.StudentID = s.StudentID
inner join Status st
on s.StatusID = st.StatusID
where st.StatusID = 2;


select *
from Transaction;

select *
from Payment;

select *
from Status;


select *
from Status;

create view StudentPayments as
select s.StudentID,
       concat(s.FirstName,' ',s.LastName) as FullName,
       p.Amount
from Student s
left join Payment p
on s.StudentID = p.StudentID;



create view TotalMealOrdered as
select TransactionID,
       StatusID,
       sum(MealsOrdered) as TotalMealOrdered,
       StudentID
       
from Transaction
group by StudentID;


select sp.StudentID,
       sp.FullName,
	   sp.Amount,
       round((tm.TotalMealOrdered*sts.ChargePerMeal),2) as Charge
from TotalMealOrdered tm
left join StudentPayments sp
on tm.StudentID = sp.StudentID
left join Status sts
on tm.StatusID = sts.StatusID
group by sp.StudentID;





select *
from Meal;

select *
from Parent;

select *
from Payment;

select *
from Status;

select *
from Student;

select *
from Transaction;






























