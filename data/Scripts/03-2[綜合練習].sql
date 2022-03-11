-- 綜合練習
USE master

-- 檢查資料庫是否存在
IF DB_ID ( 'BANK' ) IS NOT NULL
  DROP DATABASE BANK;
GO

-- 新建資料庫與設定參數，包含: 檔案群組(filegroup)以及記錄檔(log)
CREATE DATABASE BANK
GO
-- 新建資料表
USE BANK;

-- 新增用戶資料Table: Customer 
CREATE TABLE Customer
(
  ID int,
  LName varchar(20),
  FName varchar(20),
  BDate date,
  Sex char(1),
  Address varchar(50),
  City varchar(20),
  Country varchar(50),
  UP_Date datetime,
  UP_User int,
  PRIMARY KEY (ID)
)
GO

DECLARE @CURRENT_TS datetimeoffset = GETDATE()
INSERT INTO Customer
  (ID,Lname,FName,BDate,Sex,Address,City,Country,UP_Date,UP_User)
VALUES('0', 'CY', 'Lien', '19120101', 'M', 'Neihu', 'Taipei', 'Taiwan', @CURRENT_TS, '0');
INSERT INTO Customer
  (ID,Lname,FName,BDate,Sex,Address,City,Country,UP_Date,UP_User)
VALUES('001', 'LJ', 'KUO', '19981002', 'F', 'Neihu', 'Taipei', 'Taiwan', @CURRENT_TS, '0');
INSERT INTO Customer
  (ID,Lname,FName,BDate,Sex,Address,City,Country,UP_Date,UP_User)
VALUES('002', 'CW', 'Lin', '19981002', 'F', 'Tianmu', 'Taipei', 'Taiwan', @CURRENT_TS, '0');
INSERT INTO Customer
  (ID,Lname,FName,BDate,Sex,Address,City,Country,UP_Date,UP_User)
VALUES('003', 'DW', 'Wang', '19981002', 'M', 'Beitou', 'Taipei', 'Taiwan', @CURRENT_TS, '0');
GO

-- 新增銀行帳戶Table: Account 
CREATE TABLE Account
(
  ID int,
  AccID varchar(10) PRIMARY KEY,
  Balance int,
  BranchID int,
  AccType varchar(3),
  UP_Date datetime,
  UP_User int,
) ON BANK_FG1;
GO

-- 插入測試資料
DECLARE @CURRENT_TS datetimeoffset = GETDATE()
INSERT INTO ACCOUNT
  (ID, AccID, Balance, BranchID, AccType, UP_Date, UP_User)
VALUES('001', '00000001', '5000', '010', 'B01', @CURRENT_TS, '0');
GO

-- 新增交易紀錄Table: Trans 
CREATE TABLE Trans
(
  AccID varchar(10),
  TranID int,
  TranTime datetime,
  AtmID varchar(3),
  TranType varchar(3),
  TranNote varchar(100),
  UP_DATETIME datetime,
  UP_USR int
) ON BANK_FG1;
GO

-- 插入測試資料
DECLARE @CURRENT_TS datetimeoffset = GETDATE()
INSERT INTO Trans
  (AccID, TranID, TranTime, AtmID, TranType, TranNote, UP_DATETIME, UP_USR)
VALUES('00000001', '001', @CURRENT_TS, 'A01', 'A00', 'I love writing SQL because it makes me happy', @CURRENT_TS, '001');
INSERT INTO Trans
  (AccID, TranID, TranTime, AtmID, TranType, TranNote, UP_DATETIME, UP_USR)
VALUES('00000001', '002', @CURRENT_TS, 'A01', 'B01', 'I love writing Java because it makes me AAAAAA', @CURRENT_TS, '001');
INSERT INTO Trans
  (AccID, TranID, TranTime, AtmID, TranType, TranNote, UP_DATETIME, UP_USR)
VALUES('00000001', '003', @CURRENT_TS, 'A01', 'C01', 'B: Good night, Wellcome to Restaurant DATABASE may I help your ?', @CURRENT_TS, '001');
INSERT INTO Trans
  (AccID, TranID, TranTime, AtmID, TranType, TranNote, UP_DATETIME, UP_USR)
VALUES('00000001', '004', @CURRENT_TS, 'A01', 'C02', 'C: Hi, we have 4 persons and wanna to CREATE a TABLE', @CURRENT_TS, '001');
INSERT INTO Trans
  (AccID, TranID, TranTime, AtmID, TranType, TranNote, UP_DATETIME, UP_USR)
VALUES('00000001', '005', @CURRENT_TS, 'A01', 'C02', 'B: Sorry, there is no table available now.', @CURRENT_TS, '001');
INSERT INTO Trans
  (AccID, TranID, TranTime, AtmID, TranType, TranNote, UP_DATETIME, UP_USR)
VALUES('00000001', '006', @CURRENT_TS, 'A01', 'D05', 'C: COW~ DROP a TABLE  (ノ° ロ °)ノ彡┻━┻!.', @CURRENT_TS, '001');
INSERT INTO Trans
  (AccID, TranID, TranTime, AtmID, TranType, TranNote, UP_DATETIME, UP_USR)
VALUES('00000001', '007', @CURRENT_TS, 'A01', 'D05', 'B: AAA~~Now there is one TABLE available  ┬─┬ノ( º _ ºノ)....', @CURRENT_TS, '001');

SELECT * FROM Customer
SELECT * FROM Account
SELECT * FROM Trans
