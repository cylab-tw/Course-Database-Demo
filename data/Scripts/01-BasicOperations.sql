CREATE DATABASE myBank
GO
--批次處理，區分CREATE DATABASE與USE myBank:要等CREATE DATABASE myBank結束後才會進行下一行避免錯誤
USE myBank

-- 個人帳號、姓氏、名字、生日、性別、通訊地址、城市、國籍、更新時間日期、異動人
CREATE TABLE 個人資料
(
    個人帳號 char(20),
    姓氏 char(20),
    名字 char(20),
    生日 date,
    -- 0: female, 1: male, 2: others
    性別 int,
    通訊地址 char(50),
    城市 char(10),
    國籍 char (10),
    更新時間日期 datetime,
    異動人 char(20)
)

--帳戶資訊
CREATE TABLE Account
(
    --銀行帳號
    AccID char(20),
    --銀行代號
    BankID char(20),
    --個人帳戶  
    UserID char(20),
    --餘額 
    Balance int,
    --分行帳號  
    Branch_ID char(20),
    --帳戶類型: 1:活存, 2: 定存 
    AccType int,
    -- 更新時間日期 
    UpDateTime datetime,
    -- 異動人
    UPDateID char(20)
)

--新增個人資料
INSERT INTO 個人資料
    (個人帳號, 姓氏, 名字, 性別, 通訊地址, 城市)
VALUES
    ('001', '連', '小岳', '1', '明德路365號', '台北市');
INSERT INTO 個人資料
    (個人帳號, 姓氏, 名字, 生日, 性別, 通訊地址, 城市)
VALUES
    ('002', '陳  ', '棉潔', '20020221', '1', '內湖區內湖路一段737巷', '台北市');

--新增銀行帳號資料
INSERT INTO Account
    (AccID, BankID, UserID, Balance, Branch_ID, AccType)
VALUES
    ('Acc001', '01  ', '001', 1000, '00', 1);
INSERT INTO Account
    (AccID, BankID, UserID, Balance, Branch_ID, AccType)
VALUES
    ('Acc003', '01  ', '002', 5000, '00', 1);

INSERT INTO Account
    (AccID, BankID, UserID, Balance, Branch_ID, AccType)
VALUES
    ('Acc002', '01  ', '001', 10000000, '00', 2);

SELECT *
FROM Account

SELECT *
FROM 個人資料

SELECT Account.*, 個人資料.姓氏, 個人資料.名字
FROM 個人資料, Account
WHERE 個人資料.個人帳號=Account.UserID

SELECT Account.AccID, Account.BankID, (個人資料.姓氏 + 個人資料.名字) AS 名字, Account.Balance, AccID
FROM 個人資料, Account
WHERE 個人資料.個人帳號=Account.UserID

DELETE FROM 個人資料
WHERE 個人帳號='002'

UPDATE 個人資料
SET 國籍='內湖國'
WHERE 個人帳號='002'

SELECT *
FROM 個人資料

use myDB
drop table 個人資料
