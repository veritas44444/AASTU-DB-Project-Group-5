
USE GEBAR_COMMERCIAL_BANK;
GO
DROP TABLE IF EXISTS Account;
GO
DROP TABLE IF EXISTS Customer;
GO
DROP TABLE IF EXISTS Branch;
GO

DROP TABLE IF EXISTS Branch;
CREATE TABLE Branch(
Branch_id  VARCHAR(10) NOT NULL,
Branch_name VARCHAR(50) NOT NULL,
adress VARCHAR(200),
Phone_number VARCHAR(20),
Manager_id VARCHAR(10),
CONSTRAINT pk_Branch PRIMARY KEY (Branch_id)
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customer(
customer_id VARCHAR(15) PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
date_of_birth DATE,
gender VARCHAR(10),
address VARCHAR(200),
registration_date DATE,
phone_number varchar(100),
email varchar(100),
national_id VARCHAR(20) UNIQUE,
branch_id VARCHAR(10),
FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

DROP TABLE IF EXISTS account;
CREATE TABLE account(
account_no VARCHAR(20) PRIMARY KEY,
customer_id VARCHAR(15),
account_type VARCHAR(20),
balance decimal(15,2) default 0,
open_date DATE,
status VARCHAR(20),
branch_id VARCHAR(10),
 FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
 FOREIGN KEY(branch_id) REFERENCES Branch(branch_id)
 );
 GO 
 DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Employee;
GO
 CREATE TABLE Loan (
    LoanID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10),
    LoanType VARCHAR(50),
    Amount DECIMAL(10,2),
    ApplicationDate DATE,
    BranchID VARCHAR(10)
);
CREATE TABLE Transactions (
    TransactionID VARCHAR(10) PRIMARY KEY,
    AccountNo VARCHAR(10),
    BranchID VARCHAR(10),
    TransactionType VARCHAR(20),
    Amount DECIMAL(10,2),
    TransactionDate DATE
);

CREATE TABLE Employee (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Position VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Salary DECIMAL(10,2),
    BranchID VARCHAR(10)
);
 
