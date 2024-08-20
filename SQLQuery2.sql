CREATE TABLE items(
  code varchar(255) not null Primary key,
  [Desc] varchar(255),
  UnitPrice int,
  Available int,
  Saved int,
  Waiting int,
  Subscript int,
  Freq varchar(255),
  SuppDate Date,
  OrderPercnt decimal(5,2)
  );

INSERT INTO Items 
VALUES
    ('101', 'Office Chair', 100, 50, 10, 5, 20, 30, '2024-08-01', 10),
    ('102', 'Desk Lamp', 200, 30, 15, 10, 25, 40, '2024-08-05', 15),
    ('103', 'Monitor Stand', 150, 20, 5, 2, 10, 20, '2024-08-10', 20),
    ('104', 'Ergonomic Keyboard', 250, 40, 20, 8, 30, 25, '2024-08-15', 25),
    ('105', 'Wireless Mouse', 180, 60, 30, 12, 15, 35, '2024-08-20', 18);



CREATE TABLE ExOrders(
  OrderNo int not null Primary key,
  [Date] Date,
  CustID int FOREIGN KEY REFERENCES Customers(CustID),
  Code varchar(255) FOREIGN KEY REFERENCES items(code),
  Quant int,
  Delivery varchar(255) FOREIGN KEY REFERENCES DeliveryFees(Delivery),
  Address varchar(255),
  Status varchar(255),
  SuppDate Date,
  );

insert into exOrders (OrderNo, [date], CustID, Code, quant, delivery, [address], [status], suppDate)
values
(2001, '2024-08-01', 1, '101', 2, '1', '123 Main St Springfield', 'Open', '2024-08-01'),
    (2002, '2024-08-05', 2, '102', 1, '2', '456 Elm St Springfield', 'In Progress', '2024-08-05'),
    (2003, '2024-08-10', 3, '103', 5, '3', '789 Oak St Springfield', 'Closed', '2024-08-10'),
    (2004, '2024-08-15', 4, '104', 3, '1', '101 Pine St Springfield', 'Reserved In Progress', '2024-08-15'),
    (2005, '2024-08-20', 5, '105', 4, '3', '202 Cedar St Springfield', 'Not Shipped', '2024-08-20');



CREATE TABLE DeliveryFees(
  Delivery varchar(255) not null Primary key,
  [Desc] varchar(255),
  DelFee int
  );
  delete from DeliveryFees
  insert into DeliveryFees
values
('1','slow',20),
('3','fast',100),
('2','normal',50)


 CREATE TABLE Invoices(
  InvNo int not null Primary key,
  [Date] Date,
  OrderNo int,
  UnitDesc varchar(255),
  NoUnits int,
  UnitPrice int,
  TotAmount int,
  );
  INSERT INTO Invoices (InvNo, OrderNo, [Date], UnitDesc, NoUnits, UnitPrice, TotAmount)
VALUES
    (3001, 2001, '2024-08-02', 'Office Chair', 2, 100, 200),
    (3002, 2002, '2024-08-06', 'Desk Lamp', 1, 200, 200),
    (3003, 2003, '2024-08-11', 'Monitor Stand', 5, 150, 750),
    (3004, 2004, '2024-08-16', 'Ergonomic Keyboard', 3, 250, 750),
    (3005, 2005, '2024-08-21', 'Wireless Mouse', 4, 180, 720);


CREATE TABLE Profiles(
  [Profile] varchar(255) not null Primary key,
  Act varchar(255),
  );

INSERT INTO Profiles([Profile], [Act])
VALUES 
    ('Office', '10 times per day'),
    ('Sales', 'Full access'),
    ('Support', 'Read-only'),
    ('Management', 'Unlimited access')

CREATE TABLE Users(
  UserName varchar(255) not null Primary key,
  Profile varchar(255) FOREIGN KEY REFERENCES Profiles(Profile),
  );
  insert into Users
  values ('maor smueli' , 'Management'),
  ('aviel moshe', 'Sales')

CREATE TABLE Numbers(
  LastOrder int,
  LastSubsc int,
  LastStock int,
  LastReciept int,
  LastInvoice int,
  );
  insert into Numbers
values(2005,1000,50,4005,3005)



CREATE TABLE Discounts(
  CustType varchar(255) not null Primary key,
  Discnt decimal(5,2),
  );


insert into Discounts
values ('1',10)
insert into Discounts
values ('2',25)

CREATE TABLE StockOrder(
  OrderNo int,
  StockDate date,
  Code varchar(255) FOREIGN KEY REFERENCES items(code),
  Descr varchar(255),
  Quant int,
  Delivery varchar(255) FOREIGN KEY REFERENCES DeliveryFees(Delivery),
  [Desc] varchar(255),
  DelFee int
  );

INSERT INTO StockOrder (OrderNo, StockDate, Code, [Descr], Quant)
VALUES
    (2001, '2024-08-01', '101', 'Initial stock order for new office chairs', 100),
    (2002, '2024-08-05', '102', 'Order of desk lamps for the new office', 50),
    (2003, '2024-08-10', '103', 'Replenishment of monitor stands', 30),
    (2004, '2024-08-15', '104', 'Order of ergonomic keyboards', 40),
    (2005, '2024-08-20', '105', 'Stock up on wireless mice', 60);

CREATE TABLE Accounting(
  [Date] date,
  Amount int,
  CrdtDebt varcher(255),
  InvNo int FOREIGN KEY REFERENCES Invoices(InvNo),
  OrderNo int FOREIGN KEY REFERENCES ExOrders(OrderNo),
  RecNo int FOREIGN KEY REFERENCES Receipt(RecNo)
  );

  alter table Accounting
  alter column CrdtDebt varchar(255)

INSERT INTO Accounting (RecNo, Amount, CrdtDebt, InvNo, OrderNo, [Date])
VALUES
    (5001, 200, 'Credit', 3001, 2001, '2024-08-03'),
    (5002, 200, 'Credit', 3002, 2002, '2024-08-07'),
    (5003, 750, 'Credit', 3003, 2003, '2024-08-12'),
    (5004, 750, 'Credit', 3004, 2004, '2024-08-17'),
    (5005, 720, 'Debit', 3005, 2005, '2024-08-22');

CREATE TABLE Receipt(
  RecNo int not null Primary key,
  PymtDate Date,
  InvNo int FOREIGN KEY REFERENCES Invoices(InvNo),
  OrderNo int FOREIGN KEY REFERENCES ExOrders(OrderNo),
  PaidAmt int
  );
INSERT INTO Receipt (RecNo, PymtDate, InvNo, OrderNo, PaidAmt)
VALUES
    (5001, '2024-08-02', 3001, 2001, 200),
    (5002, '2024-08-06', 3002, 2002, 200),
    (5003, '2024-08-11', 3003, 2003, 750),
    (5004, '2024-08-16', 3004, 2004, 750),
    (5005, '2024-08-21', 3005, 2005, 720);


CREATE TABLE Customers(
  CustID int not null Primary key,
  CustType varchar(255) FOREIGN KEY REFERENCES Discounts(CustType),
  CustStatus varchar(255),
  FreezCode varchar(255),
  OverCount int,
  CustName varchar(255),
  DelivAddrss varchar(255),
  MailAddrss varchar(255),
  CreditCard int,
  );


INSERT INTO Customers (CustID, CustType, CustStatus, FreezCode, OverCount, CustName, DelivAddrss, MailAddrss, CreditCard)
VALUES
    (1, '1', 'ACT', 'None', 0, 'John Doe', '123 Main St, Springfield', 'john.doe@example.com', 12347890),
    (2, '2', 'FRZ', '1', 2, 'Jane Smith', '456 Elm St, Springfield', 'jane.smith@example.com', 23458901),
    (3, '1', 'DEL', 'None', 0, 'Alice Johnson', '789 Oak St, Springfield', NULL, 34789012),
    (4, '2', 'ACT', '2', 1, 'Bob Brown', '101 Pine St, Springfield', 'bob.brown@example.com', 45789123),
    (5, '1', 'FRZ', '1', 0, 'Charlie White', '202 Cedar St, Springfield', 'charlie.white@example.com', 5681234);

CREATE TABLE Subscription(
  OrderNo int FOREIGN KEY REFERENCES ExOrders(OrderNo),
  Status varchar(255),
  CustID int FOREIGN KEY REFERENCES Customers(CustID),
  Code varchar(255) FOREIGN KEY REFERENCES items(code),
  Quant int,
  Freq varchar(255),
  Delivery varchar(255),
  NextOrder date,
  Expiration date
  );

  INSERT INTO Subscription ( OrderNo, CustID, Code, [Status], quant, Freq, Delivery, NextOrder, Expiration)
VALUES
    (2001, 1, '101', 'Active', 2, 'Monthly', '1', '2024-09-01', '2025-08-01'),
    ( 2002, 2,'102', 'Active', 1, 'Quarterly', '2', '2024-11-05', '2025-11-05'),
    ( 2003, 3, '103', 'Expired', 5, 'Annually', '3', '2024-08-10', '2024-08-10'),
    ( 2004, 4, '104', 'Active', 3, 'Bi-Weekly', '1', '2024-08-16', '2025-08-16'),
    (2005, 5, '105', 'Pending', 4, 'Monthly', '2', '2024-09-20', '2025-09-20');

select *
from Items

select *
from ExOrders
select *
from Invoices
select *
from Subscription
select *
from Customers
select *
from Receipt
select *
from Accounting
select *
from StockOrder
select *
from DeliveryFees
select *
from Discounts
select *
from Numbers
select *
from Users
select *
from Profiles

--Q6(1)
CREATE PROCEDURE specificCode (@code1 varchar(255))
   as
      if @code1 is null
	   select *
	   from items
	   order by code
	  else
	   select *
	   from items
	   where code = @code1
	   order by code
   go


   exec specificCode @code1 = 102

--Q6(2)


create procedure getOrders(@status1 varchar(255), @date1 date, @date2 date, @orderNum int)
as
select e.[Date],e.Code,TotAmount, Quant,[Status]
from ExOrders e join Invoices n 
on n.OrderNo = e.OrderNo
where (Status = @status1 or (e.Date between @date1 and @date2) or (e.OrderNo = @ordernum))
order by e.Date
go


exec getOrders @status1 = 'close', @date1 = null, @date2= null , @orderNum = 2001 


--Q6(3)
create procedure getCustomerById (@custID int)
as
select c.CustID, CustName, Status, OrderNo, CustStatus, Code, Quant,Freq
from Customers c join Subscription s on c.CustID = s.CustID
where c.CustID = @custID
go



select *
from Customers
exec getCustomerById @custID = 4



--Q6(4)
CREATE procedure profit1 (@date1 date)  
 as
  SELECT a.OrderNo,RecNo,a.Date,amount,
  CASE WHEN a.CrdtDebt = 'credit' THEN a.Amount ELSE NULL END AS Income,
  CASE WHEN a.CrdtDebt = 'debit' THEN a.Amount ELSE NULL END AS Expense
  FROM Accounting a
  WHERE  a.Date > =@Date1
  ORDER BY a.Date;

  SELECT 
    SUM(CASE WHEN CrdtDebt = 'credit' THEN Amount ELSE 0 END) AS TotalIncome,
    SUM(CASE WHEN CrdtDebt = 'debit' THEN Amount ELSE 0 END) AS TotalExpense,
    SUM(CASE WHEN CrdtDebt = 'credit' THEN Amount ELSE 0 END) 
     - SUM(CASE WHEN CrdtDebt = 'debit' THEN Amount ELSE 0 END) AS Balance
  FROM Accounting
  WHERE Date >=@Date1;

  exec profit1 @date1 = '2002-01-01'

--Q6(5)
create procedure getOrdersnotrealized
as
select e.Date, e.SuppDate, TotAmount, Status
from ExOrders e join Invoices i on e.OrderNo = i.OrderNo
where e.Status in ('Not Shipped', 'not realized')
order by e.SuppDate
go

exec getOrdersnotrealized


select *
from ExOrders

   
	   