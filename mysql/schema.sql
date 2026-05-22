
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
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS loan_payments;
DROP TABLE IF EXISTS AuditLog;

GO

CREATE TABLE Loan (
    loan_id VARCHAR(20) PRIMARY KEY,

    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(20) NOT NULL,

    loan_type VARCHAR(50) NOT NULL,

    loan_amount DECIMAL(15,2) NOT NULL,

    interest_rate DECIMAL(5,2) NOT NULL,

    duration_months INT NOT NULL,

    application_date DATE NOT NULL,

    approval_date DATE,

    disbursement_date DATE,

    monthly_installment DECIMAL(15,2),

    total_payable DECIMAL(15,2),

    outstanding_balance DECIMAL(15,2),

    next_due_date DATE,

    status VARCHAR(30) DEFAULT 'Pending',

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES Branch(branch_id)
);

CREATE TABLE Transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,

    account_no VARCHAR(20) NOT NULL,

    branch_id VARCHAR(20) NOT NULL,

    transaction_type VARCHAR(50) NOT NULL,

    amount DECIMAL(15,2) NOT NULL,

    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    description VARCHAR(255),

    reference_number VARCHAR(50),

    FOREIGN KEY (account_no)
        REFERENCES Account(account_no),

    FOREIGN KEY (branch_id)
        REFERENCES Branch(branch_id)
);

CREATE TABLE Employee (
    employee_id VARCHAR(20) PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    phone_number VARCHAR(20),

    email VARCHAR(100) UNIQUE,

    position VARCHAR(50),

    salary DECIMAL(15,2),

    hire_date DATE,

    branch_id VARCHAR(20),

    FOREIGN KEY (branch_id)
        REFERENCES Branch(branch_id)
);

CREATE TABLE loan_payments (
    payment_id VARCHAR(20) PRIMARY KEY,

    loan_id VARCHAR(20) NOT NULL,

    payment_date DATE NOT NULL,

    amount_paid DECIMAL(15,2) NOT NULL,

    principal_paid DECIMAL(15,2),

    interest_paid DECIMAL(15,2),

    remaining_balance DECIMAL(15,2),

    recorded_by VARCHAR(20),

    FOREIGN KEY (loan_id)
        REFERENCES Loan(loan_id),

    FOREIGN KEY (recorded_by)
        REFERENCES Employee(employee_id)
);
CREATE TABLE users (
    user_id VARCHAR(20) PRIMARY KEY,

    username VARCHAR(50) UNIQUE NOT NULL,

    password_hash VARCHAR(255) NOT NULL,

    employee_id VARCHAR(20),

    customer_id VARCHAR(20),

    role VARCHAR(20) NOT NULL,

    status VARCHAR(20) DEFAULT 'Active',

    last_login DATETIME,

    
    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id),

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),

    CHECK (role IN ('manager', 'teller', 'customer'))
);
CREATE TABLE AuditLog (
    LogID VARCHAR(15) PRIMARY KEY,

    TableName VARCHAR(100),
    RecordID VARCHAR(20),

    Action VARCHAR(10)
    CHECK (Action IN ('INSERT', 'UPDATE', 'DELETE')),

    ChangedBy VARCHAR(10),

    ChangedAt DATETIME DEFAULT CURRENT_TIMESTAMP,

    OldValues TEXT,
    NewValues TEXT,

    FOREIGN KEY (ChangedBy)
    REFERENCES EMPLOYEE(EmployeeID)
