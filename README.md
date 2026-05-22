## Project Title
Bank Management System for Gebar Commercial Bank

## Group Information
- Group Number: 5
- Course: Database Systems
- Department: Software Engineering
- University: Addis Ababa Science and Technology University

## Group Members      
- Elabem Medfer.................ETS 0471/17   
- Elsabet Berhanu.............. ETS 0487/17
- Enjifeto Abdella..............ETS 0497/17
- Ermias Berhane................ETS 0504/17
- Ewenetu Haile.................ETS 0528/17
- Kasim Muhdin..................ETS 0814/17

## Project Description
The Gebar Commercial Bank project is building a database to improve how the bank works. This bank is a medium sized bank in Ethiopia. The database will help with tasks like signing up customers managing types of accounts and giving loans to people and businesses. The database will keep track of what's happening at each branch what transactions have taken place and how customers are being helped.
The main goal of this database is to keep information safe and ensure transactions happen quickly. The Gebar Commercial Bank database can handle customers and multiple branches. It will automatically update accounts monitor loans check transactions and provide reports to branches. All the information will be stored in one place. By doing all these things the Gebar Commercial Bank database will make the bank work efficiently reduce mistakes and make it easier for the bank to do more digital banking, in the future. The Gebar Commercial Bank project is crucial for the bank to function well and assist its customers.

## The implementation includes:
 
Relational Database: Microsoft SQL

NoSQL Database: MongoDB

Schema Normalization: Up to BCNF

Queries: Operational & Analytical examples

Diagramming Tools: Draw.io / Lucidchart

Presentation: Microsoft PowerPoint

## Final Data Model

  Entities with Attribute
1. Branch:

     BranchID(PK), BranchName, Address, Phone_number, manager_id(FK)

  2. Customer:

   CustomerID(PK), FullName, date_of_birth, Gender,  Phone, Address, email, National_id,  Registration_Date, branch_id(FK)
 
 3. Account:
     AccountNo(PK), 
     CustomerID, 
     BranchID(FK), 
     AccountType, 
     Balance, open_date, status
   
 4. Loan:
   
       LoanID,    CustomerID(FK),    LoanType,   Amount,   Application Date,   BranchID(FK),   loan_amount,    Interest_rate,    duration_months,   approval_date,   disbursement_date,   monthly_installment,    total_payable,    outstanding_balance,    next_due_date,   status
   
 5. Transaction:
   
     TransactionID(PK), 
      AccountNo(FK), 
      BranchID(FK), 
      TransactionType, 
      Amount, description, reference_number, 
      TransactionDate
     
   
 6. Employee:
    
      EmployeeID(PK),  FullName, 
      Position, 
          Email, 
                  Phone,
      Salary,      hire_date, 
      BranchID(FK)

 7. loan_payments:
    
payment_id (PK),
loan_id (FK),
payment_date,
amount_paid,
principal_paid,
interest_paid,
remaining_balance,
recorded_by (FK)
 
 8.  users:
   
user_id (PK),
username,
password_hash,
employee_id (FK), customer_id (FK),
role ( manager, teller, customer),
status,
last_login
 

 9. audit_log:
    
log_id (PK),
table_name,
record_id,
action (INSERT, UPDATE, DELETE),
changed_by (employee_id)(FK),
changed_at,
old_values,
new_values 


## Relationships
#### Branch Relationships
- Branch -> Customer (1:M)
- Branch -> Employee (1:M)
- Branch ->Transaction (1:1)
- Branch ->Account (1:1)
- Branch ->Loan (1:M)
#### Customer Relationships
- Customer  -> Loan (1:M)
- Customer -> Account (1:M)
#### Account Relationships
- Account -> Transaction (1:M)
## Repository Structure

...

/docs/

    final_report.pdf
    
    presentation.pptx
    
/microsoft sql/

    schema.sql
    
    queries.sql
    
/mongodb/

    collections.json
    
    queries.js
    
/diagrams/

    erd.png
    
    normalization.pdf
    
/annex/

    survey_questions.pdf
    
    sample_forms.pdf
    
CONTRIBUTION.md

README.md

...

## Technologies Used
- Microsoft SQL 8+
- MongoDB 6+

## How To Run

### Microsoft SQL
1. Create a database:

    - CREATE DATABASE inventory_db;
    
    - USE inventory_db;
    
3. Run schema script:  microsoft sql/schema.sql

4.  Run queries:  microsoft sql/queries.sql

### MongoDB
1. Open "mongosh".
2. Run:

   - use inventory_db

    - load("mongodb/queries.js")
   
4. (Optional) import sample JSON: mongodb/collections.json 

