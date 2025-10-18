CREATE TABLE Branch (
    branch_name VARCHAR(50) ,
    branch_city VARCHAR(50),
    assets REAL,
    PRIMARY KEY(branch_name));
    
    desc Branch

CREATE TABLE BankAccount (
    account_number INT ,
    branch_name VARCHAR(50),
    balance REAL,
    PRIMARY KEY(account_number),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name));
    
    desc BankAccount

CREATE TABLE BankCustomer (
    customer_name VARCHAR(50) ,
    customer_street VARCHAR(50),
    customer_city VARCHAR(50),
    PRIMARY KEY(customer_name));

desc BankCustomer

CREATE TABLE Depositer (
    customer_name VARCHAR(50),
    account_number INT,
    PRIMARY KEY (customer_name, account_number),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (account_number) REFERENCES BankAccount(account_number));
    
    desc Depositer

CREATE TABLE Loan (
    loan_number INT ,
    branch_name VARCHAR(50),
    amount REAL,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name));
    
    desc Loan


INSERT INTO Branch VALUES
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Banglore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParliamentRoad', 'Delhi', 60000),
('SBI_Jantarmantar', 'Delhi', 20000);

select * from Branch;

INSERT INTO BankAccount VALUES
(1,'SBI_Chamrajpet',2000),
(2, 'SBI_ResidencyRoad', 5000),
(3,'SBI_ShivajiRoad',6000),
(4, 'SBI_ParliamentRoad', 9000),
(5,'SBI_Jantarmantar',8000),
(6,'SBI_ShivajiRoad',4000),
(8, 'SBI_ResidencyRoad', 4000),
(9,'SBI_ParliamentRoad',3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

select * from BankAccount;

INSERT INTO BankCustomer VALUES
('Avinash', 'Bull Temple Road', 'Bangalore'),
('Dinesh', 'Bannergatta Road', 'Bangalore'),
('Mohan', 'National College Road', 'Bangalore'),
('Nikhil', 'Akbar Road', 'Delhi'),
('Ravi', 'Prithviraj', 'Delhi');

select * from BankCustomer;

INSERT INTO Depositer VALUES
('Avinash', 1),
('Dinesh',2),
('Nikhil', 4),
('Ravi',5),
('Avinash',8),
('Nikhil',9),
('Dinesh', 10),
('Nikhil',11);

select * from Depositer;

INSERT INTO Loan VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_Parliamentroad', 4000),
(5, 'SBI_Jantarmantar', 5000);

select * from Loan;


SELECT branch_name, (assets / 100000) AS "assets in lakhs"
FROM Branch;

SELECT d.customer_name, b.branch_name, COUNT(*) AS num_accounts
FROM Depositer d
JOIN BankAccount b ON d.account_number = b.account_number
GROUP BY d.customer_name, b.branch_name
HAVING COUNT(*) >= 2;

CREATE VIEW BranchLoanSummary AS
SELECT branch_name, SUM(amount) AS total_loan_amount
FROM Loan
GROUP BY branch_name;

SELECT * FROM BranchLoanSummary;

SELECT d.customer_name
FROM Depositer d
JOIN BankAccount b ON d.account_number = b.account_number
WHERE b.branch_name = 'SBI_ResidencyRoad'
GROUP BY d.customer_name
HAVING COUNT(d.account_number) >= 2;

select branch_name, assets as assets_in_lakhs
from Branch;

select d.customer_name, a.branch_name, count(*)
from depositer d, BankAccount a
where d.account_number = a.account_number
group by d.customer_name, a.branch_name
having count(*)>=2;

create view TotalLoans as
select branch_name, sum(amount)
from loan
group by branch_name;

select * from TotalLoans;





