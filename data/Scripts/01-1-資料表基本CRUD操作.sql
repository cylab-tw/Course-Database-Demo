-- 1. 新增資料庫-檢查是否存在
IF DB_ID ( 'NTUNHS_IM' ) IS NOT NULL
  DROP DATABASE NTUNHS_IM;
GO
CREATE DATABASE NTUNHS_IM;  
GO

USE NTUNHS_IM;
--2. 新增Table
CREATE TABLE Customer
(
    FName char(50),
    LName char(50),
    Address char(50),
    City char(50),
    Country char(25),
    BDate datetime
);

--3. 插入5筆資料至Table
-- 第一筆
INSERT INTO Customer
    (FName, LName, Address, City, Country, BDate)
VALUES
    ('CY', 'Lien', 'NTUNHS', 'Taiepi', 'Taiwan', '19800101');
-- 第二筆
INSERT INTO Customer
    (FName, LName, Address, City, Country, BDate)
VALUES
    ('AAA', 'Fu', 'NTU', 'Taipei', 'Taiwan', '20010301');
-- 第三筆
INSERT INTO Customer
    (FName, LName, Address, City, Country, BDate)
VALUES
    ('GY', 'Chen', 'FJU', 'New Taipei City', 'Taiwan', '20010801');
-- 第四筆
INSERT INTO Customer
    (FName, LName, Address, City, Country, BDate)
VALUES
    ('KK', 'Wang', 'NCKU', 'Tainan', 'Taiwan', '19950630');
-- 第五筆
INSERT INTO Customer
    (FName, LName, Address, City, Country, BDate)
VALUES
    ('NC', 'Lin', 'NUTC', 'Taichung', 'Taiwan', '19970515');

--4. 查詢在台北市的所有資料
SELECT *
FROM Customer
WHERE City ='Taipei'

--6. 查詢在台北市且生日大於1997年的所有資料
SELECT *
FROM Customer
WHERE City ='Taipei' AND BDate >'19970101'

--7. 更新一筆資料
UPDATE Customer
SET BDate='19980515'
WHERE City ='NC' AND LName='Lin'

--8. 刪除一筆資料
DELETE FROM Customer
WHERE City ='NC' AND LName='Lin'

--9. 增加欄位&設定預設值
ALTER TABLE Customer ADD Sex CHAR(1) DEFAULT 'U'

--10. 刪除欄位
ALTER TABLE Products DROP COLUMN ProductName

--11. 修改
--11.1 欄位大小型態
USE NTUHNS_IM;
IF DB_ID ( N'NTUHNS_IM' ) IS NOT NULL
ALTER TABLE Customer ALTER COLUMN FName char(30);
GO

--11.2 修改欄位名稱 -使用Stoured Procedure方式
USE NTUHNS_IM;
IF DB_ID ( N'NTUHNS_IM' ) IS NOT NULL
EXEC sp_RENAME 'Customer.FName', 'FirstName', 'COLUMN'
GO

--11.3. 修改欄位預設值
--12.3.1 檢查有無重複的限制(Constraint): 
--NULL ([允許空值)、NOT NULL  (非空值)
--UNIQUE  (唯一值)
--CHECK (例如: 只能大於0):  CHECK (ID > 0),  ( MySQL沒有CHECK)
--其他: 
  --Primary key
  --Foreign key
  --DEFAULT
--查詢物件(通常為Table)中的限制條件
EXEC sp_helpconstraint @objname = 'Customer'

--11.3.2  有重複限制需要先刪除(如果新增CONSTRAINT時無指定名稱，則系統會自動產生CONSTRAINT編號)
ALTER TABLE Customer DROP CONSTRAINT Sex
ALTER TABLE Customer DROP CONSTRAINT DF__Customer__Sex__49C3F6B7

--12.3.3 重新建立Constraint
ALTER TABLE Customer ADD CONSTRAINT Sex DEFAULT 'F' FOR Sex

--13. 清除資料表裡面所有的資料
TRUNCATE TABLE Customer

--14. UPDATE資料(指定條件)
UPDATE Customer SET BDate='19980515' WHERE ID ='001'

--15. DELETE資料(指定條件)
DELETE FROM Customer
WHERE  ID ='001'

--16. 查詢兩個表格並輸出程一個結果
SELECT A.ID, B.BDate
FROM IDTable AS A, Customer AS B
WHERE A.ID=B.ID