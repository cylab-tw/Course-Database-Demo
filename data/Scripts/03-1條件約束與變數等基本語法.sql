--練習1 - CHECK資料表條件約束(CREATE語法)
CREATE TABLE Account2
(
  ID int,
  AccID int PRIMARY KEY,
  -- 使用CHECK用來設定條件
  Balance int CHECK(Balance >=0 AND Balance <=1000000),
  BranchID int,
  AccType varchar(3),
  UP_Date datetime,
  UP_User int,
  FOREIGN KEY (AccID) REFERENCES CUSTOMER (ID)
)
-- 練習2 - 資料表條件約束(ALTER語法)
-- 練習找語法 (CHECK)

-- 練習3 - 資料表欄位定義
-- 3.1 NULL, NOT NULL
-- 3.2 DEFAULT
-- 3.3 IDENTITY
-- 3.4 COLLATE
-- 3.5 ROWGUIDCOL
CREATE TABLE #Account4
(
  ID int UNIQUE, 
  AccID int PRIMARY KEY,
  Balance int NOT NULL,
  BranchID int,
  AccType varchar(3),
  UP_Date datetime,
  UP_User int,
  GID uniqueidentifier DEFAULT NEWID() ROWGUIDCOL
)

INSERT #Account4
VALUES('123','01','500','300','ACC',GETDATE(),'001',NEWID())

SELECT * FROM #Account4

-- 練習4 - 建立資料庫圖表

-- 練習5 - 暫存資料表
CREATE TABLE #Account3
(
  ID int,
  AccID int PRIMARY KEY,
  Balance int,
  BranchID int,
  AccType varchar(3),
  UP_Date datetime,
  UP_User int  
)

INSERT #Account3
VALUES('123','01','500','300','ACC',GETDATE(),'001')

SELECT * FROM #Account3

-- 練習6 - 使用變數
-- 插入測試資料
DECLARE @CURRENT_TS datetimeoffset = GETDATE()
INSERT INTO ACCOUNT
  (ID, AccID, Balance, BranchID, AccType, UP_Date, UP_User)
VALUES('001', '00000001', '5000', '010', 'B01', @CURRENT_TS, '0');
GO

--### 練習5 - 查詢資料(SELECT語法)
5.1 顯示結果(AS)
5.2 指定查詢數量上限 (TOP  n, TOP n PERCENT)
5.3 是否顯示重複資料(ALL, DISTINCT)
5.4 排序(ORDER BY DESC, ASC)
