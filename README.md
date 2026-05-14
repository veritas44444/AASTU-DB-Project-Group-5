## Project Title
Bank Management System for Gebar Commercial Bank

## Group Information
- Group Number: 6
- Course: Database Systems
- Department: Software Engineering
- University: Addis Ababa Science and Technology University

## Group Members      
- Elabem Medfer       ETS 0471/17   
- Elsabet Berhanu     ETS 0487/17
- Enjifeto Abdella    ETS 0497/17
- Ermias Berhane      ETS 0504/17
- Ewenetu Haile       ETS 0528/17
- Kasim Muhdin        ETS 0814/17

## Project Description
The Gebar Commercial Bank project is building a database to improve how the bank works. This bank is a medium sized bank in Ethiopia. The database will help with tasks like signing up customers managing types of accounts and giving loans to people and businesses. It will also help move money between branches. The database will keep track of what's happening at each branch what transactions have taken place and how customers are being helped.
The main goal of this database is to keep information safe and ensure transactions happen quickly. The Gebar Commercial Bank database can handle customers and multiple branches. It will automatically update accounts monitor loans check transactions and provide reports to branches. All the information will be stored in one place. By doing all these things the Gebar Commercial Bank database will make the bank work efficiently reduce mistakes and make it easier for the bank to do more digital banking, in the future. The Gebar Commercial Bank project is crucial for the bank to function well and assist its customers.

The implementation includes:
- Relational database design and implementation in MySQL
- NoSQL design and implementation in MongoDB
- Normalized schema up to BCNF for the relational part
- Example operational and analytical queries
- Diagramming Tool: Draw.io / Lucidchart
- Presentation: Microsoft PowerPoint

## Final Data Model

  Entities with Attribute
1. Branch:

     BranchID,
     BranchName, 
     Location, 
     Phone,

  2. Customer:

   CustomerID
     FullName 
     Gender 
     Phone 
     Address 
     Registration
     Date 
     BranchID
   
 3. Account:
     AccountNo 
     CustomerID 
     BranchID 
     AccountType 
     Balance
   
 4. Loan:
   
       LoanID 
       CustomerID 
       LoanType 
       Amount 
       Application Date 
       BranchID
   
 5. Transaction:
   
     TransactionID 
      AccountNo 
      BranchID 
      TransactionType 
      Amount 
      TransactionDate
   
 6. Employee:
    
      EmployeeID
      FullName 
      Position 
      Email 
      Phone 
      Salary 
      BranchID

### Relationships
- Branch -> Customer (1:M)
- Branch -> Employee (1:M)
- Branch ->Transaction (M:N)
- Branch ->Account (M:N)
- Branch ->Loan (1:M)
- Account -> Transaction (1:M)
- Customer  -> Loan (1:M)
- Customer -> Account (1:M)
## Repository Structure
The repository follows the required submission format:

...

/docs/

    final_report.pdf
    
    presentation.pptx
    
/mysql/

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
- MySQL 8+
- MongoDB 6+

## How To Run

### MySQL
1. Create a database:
    - "CREATE DATABASE inventory_db;"
    - "USE inventory_db;"
2. Run schema script from "mysql/schema.sql".
3. Run data and query script from "mysql/queries.sql".

### MongoDB
1. Open "mongosh".
2. Run:
    - "use inventory_db"
     - "load("mongodb/queries.js")"
3. Optional: import sample JSON from "mongodb/collections.json" if preferred.

