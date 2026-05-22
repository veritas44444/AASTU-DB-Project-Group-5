
USE GEBAR_COMMERCIAL_BANK;
GO
DROP TABLE IF EXISTS AuditLog;
DROP TABLE IF EXISTS loan_payments;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Branch;
GO
CREATE TABLE Branch(
branch_id  VARCHAR(10) NOT NULL,
branch_name VARCHAR(50) NOT NULL,
address VARCHAR(200),
phone_number VARCHAR(20),
manager_id VARCHAR(20),
CONSTRAINT pk_Branch PRIMARY KEY (branch_id)
);
GO

CREATE TABLE Customers(
customerID VARCHAR(15) PRIMARY KEY,
First_name VARCHAR(50) NOT NULL,
Last_name VARCHAR(50) NOT NULL,
gender VARCHAR(10),
phone_number varchar(20),
adress varchar(15),
registration_date DATE,
branch_id VARCHAR(10) NOT NULL,
date_of_birth DATE,
email varchar(100)
CHECK (email LIKE '%@%.%'),
national_id VARCHAR(20) UNIQUE,
FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
GO

DROP TABLE IF EXISTS account;
CREATE TABLE account(
account_no VARCHAR(20) PRIMARY KEY,
customer_id VARCHAR(15) NOT NULL,
branch_id VARCHAR(10) NOT NULL,
account_type VARCHAR(20) NOT NULL,
balance decimal(15,2) default 0
  CHECK (balance >= 0),
status VARCHAR(20)
  CHECK (status IN ('Active', 'Inactive', 'Closed')),
 open_date DATE DEFAULT GETDATE(),
 FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
 FOREIGN KEY(branch_id) REFERENCES Branch(branch_id)
 );

 GO 
  
CREATE TABLE Loan (
    loan_id VARCHAR(20) PRIMARY KEY,

    customer_id VARCHAR(15) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,

    loan_type VARCHAR(50) NOT NULL,
  
     loan_amount DECIMAL(15,2) NOT NULL
        CHECK (loan_amount > 0),
  
    interest_rate DECIMAL(5,2) NOT NULL
        CHECK (interest_rate >= 0),
  
    duration_months INT NOT NULL
        CHECK (duration_months > 0),

    application_date DATE NOT NULL,

    approval_date DATE,

    disbursement_date DATE,

    monthly_installment DECIMAL(15,2)
     CHECK (monthly_installment >= 0),
  
    total_payable DECIMAL(15,2)
  CHECK (total_payable >= 0),

    outstanding_balance DECIMAL(15,2)
    CHECK (outstanding_balance >= 0),

    next_due_date DATE,

    status VARCHAR(30) DEFAULT 'Pending',
  CHECK (status IN ('Pending', 'Approved', 'Rejected', 'Closed')),

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES Branch(branch_id)
);
GO

CREATE TABLE Transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,

    account_no VARCHAR(20) NOT NULL,

    branch_id VARCHAR(10) NOT NULL,

    transaction_type VARCHAR(50) NOT NULL,

    amount DECIMAL(15,2) NOT NULL
  CHECK (amount > 0),

    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    description VARCHAR(255),

    reference_number VARCHAR(50),

    FOREIGN KEY (account_no) REFERENCES Account(account_no),

    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
GO

CREATE TABLE Employee (
    employee_id VARCHAR(20) PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    position VARCHAR(50),

  email VARCHAR(100) UNIQUE
  CHECK (email LIKE '%@%.%'),

    phone_number VARCHAR(20),

    salary DECIMAL(15,2)
 CHECK (salary >= 0),

    hire_date DATE,

    branch_id VARCHAR(10) NOT NULL,

    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
GO
ALTER TABLE Branch
ADD CONSTRAINT fk_branch_manager
FOREIGN KEY (manager_id)
REFERENCES Employee(employee_id);

GO
CREATE TABLE loan_payments (
    payment_id VARCHAR(20) PRIMARY KEY,

    loan_id VARCHAR(20) NOT NULL,

    payment_date DATE NOT NULL,

    amount_paid DECIMAL(15,2) NOT NULL
  CHECK (amount_paid > 0),

    principal_paid DECIMAL(15,2)
 CHECK (principal_paid >= 0),

    interest_paid DECIMAL(15,2)
 CHECK (interest_paid >= 0),

    remaining_balance DECIMAL(15,2)
CHECK (remaining_balance >= 0),

    recorded_by VARCHAR(20),

    FOREIGN KEY (loan_id) REFERENCES Loan(loan_id),
    FOREIGN KEY (recorded_by) REFERENCES Employee(employee_id)
);
GO 
CREATE TABLE users (
    user_id VARCHAR(20) PRIMARY KEY,

    username VARCHAR(50) UNIQUE NOT NULL,

    password_hash VARCHAR(255) NOT NULL,

    employee_id VARCHAR(20),

    customer_id VARCHAR(15),

    role VARCHAR(20) NOT NULL
  CHECK (role IN ('manager', 'teller', 'customer')),

    status VARCHAR(20) DEFAULT 'Active'
  CHECK (status IN ('Active', 'Inactive')),

    last_login DATETIME,

    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    
);
GO

 
CREATE TABLE AuditLog (
    log_id VARCHAR(15) PRIMARY KEY,

     table_name VARCHAR(100),
 
    record_id VARCHAR(20),

    action_type VARCHAR(10)
    CHECK (action_type IN ('INSERT', 'UPDATE', 'DELETE')),

    changed_by VARCHAR(20) NOT NULL,

    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 
     old_values VARCHAR(MAX),
 
     new_values VARCHAR(MAX),

    FOREIGN KEY (changed_by)
  REFERENCES users(user_id)
);
GO

