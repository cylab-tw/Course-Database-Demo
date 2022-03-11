--參考文件
--https://www.tutorialspoint.com/sql/sql-primary-key.htm
CREATE DATABASE BANK;
GO
-- Primary Key建立方式
-- 1. CREATE TABLE時，放在欄位後面
CREATE TABLE 個人資料
(
    個人帳號 int PRIMARY KEY,
    姓氏 char(20),
    名字 char(20),
    生日 date,
    性別 int,
    通訊地址 char(50),
    城市 char(10),
    國籍 char (10),
    更新時間日期 datetime,
    異動人 char(20),
)

-- 2. CREATE TABLE時，放在最後面指定欄位名稱
CREATE TABLE 個人資料
(
    個人帳號 int,
    姓氏 char(20),
    名字 char(20),
    生日 date,
    性別 int,
    通訊地址 char(50),
    城市 char(10),
    國籍 char (10),
    更新時間日期 datetime,
    異動人 char(20),
    PRIMARY KEY (個人帳號)
)

-- 3. 使用ALTER TABLE建立(前提要先建立好資料表)
ALTER TABLE 個人資料 ADD PRIMARY KEY (個人帳號);

-- 4. 使用ALTER TABLE建立-以新增CONSTRAINT方式 (前提要先建立好資料表)
ALTER TABLE 個人資料 
   ADD CONSTRAINT PK_CUSTID PRIMARY KEY (個人帳號);

--測試新增個人資料
INSERT INTO 個人資料
    (個人帳號, 姓氏, 名字, 性別, 通訊地址, 城市)
VALUES
    ('003', '連', '大岳', '1', '明德路365號', '台北市');
INSERT INTO 個人資料
    (個人帳號, 姓氏, 名字, 生日, 性別, 通訊地址, 城市)
VALUES
    ('002', '陳  ', '棉潔', '20020221', '1', '內湖區內湖路一段737巷', '台北市');