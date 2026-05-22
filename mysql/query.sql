USE GEBAR_COMMERCIAL_BANK;
GO
INSERT INTO Branch(BranchID, BranchName, City, Phone, ManagerID)
VALUES
('B001','Main Branch','Addis Ababa','0911000001',NULL),
('B002','Bole Branch','Addis Ababa','0911000002',NULL),
('B003','Hara Branch','Adama','0911000003',NULL),
('B004','Arada Branch','Addis Ababa','0911000004',NULL);
INSERT INTO Customers(CustomerID, FirstName, LastName, gender, phone_number,address, RegistrationDate, Branch_ID, Date_Of_Birth, email, National_iD)
VALUES
('C001','Abebe','Bekele','M','0912000001','Addis Ababa','2026-01-05','B001','1965-11-20','abebe.bekele@example.com','7548658496973896'),

('C002','Hana','Tesfaye','F','0912000002','Addis Ababa','2026-01-06','B002','1988-09-07','hana.tesfaye@example.com','9604299709214572'),

('C003','Meron','Alemu','F','0912000003','Adama','2026-01-08','B003','1997-11-17','meron.alemu@example.com','6057079456919581'),

('C004','Dawit','Mekonnen','M','0912000004','Addis Ababa','2026-01-10','B001','1978-05-12','dawit.mekonnen@example.com','4026768435774065'),

('C005','Selamawit','Guta','F','0912000005','Adama','2026-01-12','B003','1995-03-25','selamawit.guta@example.com','8579317338025766'),

('C006','Kibrom','Tadesse','M','0912000006','Addis Ababa','2026-01-13','B002','1982-07-18','kibrom.tadesse@example.com','6794683898200034'),

('C007','Eyerusalem','Haile','F','0912000007','Adama','2026-01-15','B003','2000-12-05','eyerusalem.haile@example.com','5126049741877130'),

('C008','Samuel','Assefa','M','0912000008','Addis Ababa','2026-01-18','B001','1972-09-30','samuel.assefa@example.com','6587177196930252'),

('C009','Rahel','Solomon','F','0912000009','Addis Ababa','2026-01-19','B002','1990-04-15','rahel.solomon@example.com','7241739168082662'),

('C010','Nati','Yared','M','0912000010','Adama','2026-01-20','B003','1985-06-22','nati.yared@example.com','4161137359341012'),

('C011','selam','kebede','F','0912000011','Addis Ababa','2026-01-21','B004','1992-08-14','selam.kebede@example.com','198967890123456');
INSERT INTO Account(account_no, customer_id, branch_id,account_type, balance, status, open_date)
VALUES
('A1001','C001','B001','Savings',5000,'Active','2026-01-11'),

('A1002','C002','B002','Current',12000,'Active','2026-02-05'),

('A1003','C003','B003','Savings',8000,'Active','2026-02-01'),

('A1004','C004','B001','Savings',3000,'inactive','2026-01-15'),

('A1005','C005','B003','Current',15000,'Active','2026-01-20'),

('A1006','C006','B002','Savings',7000,'Active','2026-01-25'),

('A1007','C007','B003','Savings',4500,'Active','2026-01-18'),

('A1008','C008','B001','Current',20000,'Active','2026-01-22'),

('A1009','C009','B002','Savings',6000,'Closed','2026-01-30'),

('A1010','C010','B003','Current',10000,'Active','2026-02-10'),

('A1011','C011','B004','Savings',5000,'Active','2026-02-15');
INSERT INTO Employee 
(employee_id, first_name, last_name,position, email, phone_number, salary, branch_id)
VALUES
('E001', 'Tsegaye', 'Endale', 'Manager', 'tsegaye@gcb.com', '0913000001', 25000, 'B001'),

('E002', 'Helen', 'Fikadu', 'Cashier', 'helen@gcb.com', '0913000002', 12000, 'B001'),

('E003', 'Yonatan', 'Abay', 'Accountant', 'yonatan@gcb.com', '0913000003', 15000, 'B002'),

('E004', 'Mulugeta', 'Birhanu', 'Teller', 'mulugeta@gcb.com', '0913000004', 11000, 'B002'),

('E005', 'Eden', 'Shiferaw', 'Customer Service', 'eden@gcb.com', '0913000005', 10000, 'B003'),

('E006', 'Solomon', 'Wondimu', 'Manager', 'solomon@gcb.com', '0913000006', 25000, 'B003');

UPDATE Branch
SET manager_id = 'E001'
WHERE branch_id = 'B001';

UPDATE Branch
SET manager_id = 'E003'
WHERE branch_id = 'B002';

UPDATE Branch
SET manager_id = 'E006'
WHERE branch_id = 'B003';

UPDATE Branch
SET manager_id = 'E004'
WHERE branch_id = 'B004';

INSERT INTO transactions VALUES
('T001','A1001','B001','Deposit',1000,'2026-03-01','Salary Deposit','TXN-001',NULL),

('T002','A1001','B001','Loan Disbursement',500000,'2026-02-15','Home Loan Disbursed','LN-DIS-001','L001'),

('T003','A1001','B001','Loan Repayment',18500,'2026-03-15','Monthly payment for Home Loan','LN-PAY-001','L001'),

('T004','A1003','B003','Withdrawal',700,'2026-03-04','Cash Withdrawal','TXN-002',NULL);

INSERT INTO loan
VALUES

('L001','C001','B001','Home Loan',500000,18.50,36,'2026-02-01','2026-02-10','2026-02-15',18500.00,666000,480000,'2026-11-15','Active'),

('L002','C003','B003','Business Loan',300000,16.00,24,'2026-02-04','2026-02-12','2026-02-18',15833.33,380000,250000,'2026-12-18','Active'),

('L003','C005','B003','Education Loan',120000,15.00,18,'2026-02-06','2026-02-14','2026-02-20',7666.67,138000,105000,'2026-11-20','Active'),

('L004','C007','B003','Car Loan',250000,17.00,30,'2026-02-08','2026-02-16','2026-02-22',10833.33,325000,220000,'2026-12-22','Active'),

('L005','C009','B002','Personal Loan',80000,19.00,12,'2026-02-10','2026-02-15','2026-02-25',7333.33,88000,65000,'2026-11-25','Active');
INSERT INTO loan_payments
VALUES
  
('P001','L001','2026-03-15',18500.00,12000.00,6500.00,468000.00,'E001'),
  
('P002','L001','2026-04-15',18500.00,12500.00,6000.00,455500.00,'E001'),
  
('P003','L002','2026-03-18',15833.33,11000.00,4833.33,239000.00,'E006'),
  
('P004','L003','2026-03-20',7666.67,5500.00,2166.67,99500.00,'E006'),
  
('P005','L004','2026-03-22',10833.33,7500.00,3333.33,212500.00,'E003');

INSERT INTO users 
VALUES
  
('U001','admin','(hashed)','E001',NULL,'manager','active','2026-05-20 10:30'),
  
('U002','teller_b001','(hashed)','E002',NULL,'teller','active','2026-05-20 09:15'),
  
('U003','accountant_b002','(hashed)','E003',NULL,'manager','active','2026-05-19 14:45'),
  
('U004','teller_b003','(hashed)','E005',NULL,'teller','active','2026-05-20 08:50'),
  
('U005','abebe_bekele','(hashed)',NULL,'C001','customer','active','2026-05-18 16:20'),
  
('U006','hana_tesfaye','(hashed)',NULL,'C002','customer','active','2026-05-19 11:10'),
  
('U007','meron_alemu','(hashed)',NULL,'C003','customer','active',NULL);

INSERT INTO AuditLog VALUES
('AL001','customer','C001','INSERT','E001','2026-01-05 09:15','New customer C001 (Abebe Bekele) created'),

('AL002','account','A1001','INSERT','E002','2026-01-11 10:30','Savings account A1001 created for customer C001'),

('AL003','loan','L001','INSERT','E003','2026-02-10 14:45','Home Loan L001 approved and created'),

('AL004','loan','L001','UPDATE','E001','2026-02-15 11:20','Loan L001 disbursed - status updated'),

('AL005','transaction','T001','INSERT','E002','2026-03-01 09:05','Deposit transaction T001 recorded'),

('AL006','loan_payments','P001','INSERT','E001','2026-03-15 10:30','First monthly payment for loan L001 recorded'),

('AL007','account','A1001','UPDATE','E002','2026-03-15 10:31','Account balance updated after loan payment'),

('AL008','customer','C003','UPDATE','E004','2026-04-02 14:10','Customer C003 phone number updated'),

('AL009','loan','L002','UPDATE','E003','2026-04-05 08:55','Loan L002 outstanding balance updated'),

('AL010','transaction','T003','INSERT','E002','2026-05-10 16:40','Loan disbursement recorded as transaction');
