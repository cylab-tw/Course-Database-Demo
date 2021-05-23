
USE master
-- 檢查資料庫是否存在
IF DB_ID ( 'BANK' ) IS NOT NULL
  DROP DATABASE BANK;
GO
-- 新建資料庫
CREATE DATABASE BANK
GO

-- 新建資料表
USE BANK;

-- 新增用戶資料Table: Customer 
CREATE TABLE Customer
(
  ID int,
  PWD varbinary(max),
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
  (ID, PWD, Lname,FName,BDate,Sex,Address,City,Country,UP_Date,UP_User)
VALUES('0', HASHBYTES('SHA2_512',N'123'),'CY', 'Lien', '19120101', 'M', 'Neihu', 'Taipei', 'Taiwan', @CURRENT_TS, '0');
INSERT INTO Customer
  (ID, PWD,Lname,FName,BDate,Sex,Address,City,Country,UP_Date,UP_User)
VALUES('001', HASHBYTES('SHA2_512',N'123'),'LJ', 'KUO', '19981002', 'F', 'Neihu', 'Taipei', 'Taiwan', @CURRENT_TS, '0');
INSERT INTO Customer
  (ID, PWD, Lname,FName,BDate,Sex,Address,City,Country,UP_Date,UP_User)
VALUES('002', HASHBYTES('SHA2_512',N'123'), 'CW', 'Lin', '19981002', 'F', 'Tianmu', 'Taipei', 'Taiwan', @CURRENT_TS, '0');
INSERT INTO Customer
  (ID, PWD, Lname,FName,BDate,Sex,Address,City,Country,UP_Date,UP_User)
VALUES('003', HASHBYTES('SHA2_512',N'123'), 'DW', 'Wang', '19981002', 'M', 'Beitou', 'Taipei', 'Taiwan', @CURRENT_TS, '0');
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
)
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
  TranID varchar(15),
  TranTime datetime,
  AtmID varchar(3),
  TranType varchar(3),
  TranNote varchar(100),
  UP_DATETIME datetime,
  UP_USR int
)
GO

-- Create Table LOG_SEQ
 CREATE TABLE LOG_SEQ(
  SDATE varchar(8) NOT NULL PRIMARY KEY, -- 當天的log紀錄
  LOG_COUNT varchar(6) NOT NULL --當天一共有多少筆log
)
GO

SELECT * FROM LOG_SEQ
SELECT * FROM Customer
SELECT * FROM Account
SELECT * FROM Trans
