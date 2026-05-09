USE GEBAR_COMMERCIAL_BANK;
INSERT INTO Branch
VALUES
('B001','Main Branch','Addis Ababa','0911000001','E001'),
('B002','Bole Branch','Addis Ababa','0911000002','E003'),
('B003','Hara Branch','Adama','0911000003','E006');
INSERT INTO Customer
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

('C010','Nati','Yared','M','0912000010','Adama','2026-01-20','B003','1985-06-22','nati.yared@example.com','4161137359341012');
INSERT INTO Account
VALUES
('A1001','C001','B001','Savings',5000,'Active','2026-01-11'),

('A1002','C002','B002','Current',12000,'Active','2026-02-05'),

('A1003','C003','B003','Savings',8000,'Active','2026-02-01'),

('A1004','C004','B001','Savings',3000,'Dormant','2026-01-15'),

('A1005','C005','B003','Current',15000,'Active','2026-01-20'),

('A1006','C006','B002','Savings',7000,'Active','2026-01-25'),

('A1007','C007','B003','Savings',4500,'Active','2026-01-18'),

('A1008','C008','B001','Current',20000,'Active','2026-01-22'),

('A1009','C009','B002','Savings',6000,'Closed','2026-01-30'),

('A1010','C010','B003','Current',10000,'Active','2026-02-10');