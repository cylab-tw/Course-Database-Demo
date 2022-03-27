/****** 練習2 - JOIN ******/
SELECT 客.客戶名稱, 客.聯絡人, 數量, 書名
FROM   客戶 AS 客 JOIN 出貨記錄 AS 出 ON 客.客戶名稱 = 出.客戶名稱

GO
-- JOIN ON - P9-12
SELECT 企劃書籍.編號, 名稱, 價錢
FROM   企劃書籍 JOIN 企劃書籍預定價  ON 企劃書籍.編號 = 企劃書籍預定價.編號 

GO

-- 等效JOIN 語法(WHERE做關聯) - P9-13
SELECT 企劃書籍.編號, 名稱, 價錢
FROM  企劃書籍, 企劃書籍預定價
WHERE 企劃書籍.編號 = 企劃書籍預定價.編號
GO

-- 使用別名 - P9-14a
SELECT * FROM   標標公司
SELECT * FROM   旗旗公司

SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 ,  -- 左邊 旗旗公司
		標.產品名稱 AS 標標公司產品名稱, 標.價格   -- 右邊 標標公司
FROM    旗旗公司 AS 旗  JOIN  標標公司 AS 標  ON  旗.產品名稱 = 標.產品名稱
GO

-- LEFT JOIN - P9-14b
SELECT * FROM   旗旗公司
GO

SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 ,		-- 左邊 旗旗公司
             標.產品名稱 AS 標標公司產品名稱, 標.價格	-- 右邊 標標公司
FROM   旗旗公司 AS 旗  LEFT JOIN  標標公司 AS 標 
             ON  旗.產品名稱 = 標.產品名稱
GO

-- RIGHT JOIN - P9-15a
SELECT * FROM   標標公司
GO

SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 ,		-- 左邊 旗旗公司
             標.產品名稱 AS 標標公司產品名稱, 標.價格	-- 右邊 標標公司
FROM    旗旗公司 AS 旗  RIGHT JOIN  標標公司 AS 標
            ON  旗.產品名稱 = 標.產品名稱

GO

-- FULL JOIN - P9-15b
SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 , 
             標.產品名稱 AS 標標公司產品名稱, 標.價格 
FROM   旗旗公司 AS 旗  FULL JOIN  標標公司 AS 標 
            ON 旗.產品名稱 = 標.產品名稱 

GO

--  CROSS JOIN  - P9-15c
SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 ,
             標.產品名稱 AS 標標公司產品名稱, 標.價格 
FROM   旗旗公司 AS 旗  CROSS JOIN  標標公司 AS 標 

GO

-- SELF JOIN  - P9-17a
SELECT 員工.姓名, 員工.職位, 長官.姓名 AS 主管
FROM    員工  LEFT JOIN  員工 AS 長官
             ON  員工.主管編號 = 長官.編號

GO

/****** 練習3 - JOIN綜合練習 ******/

DECLARE @BookName nvarchar(30)
DECLARE @SearchCond nvarchar(50)
SET @BookName='Windows'
SET @SearchCond='%' + @BookName + '%'
select @SearchCond

SELECT 訂單.訂單編號, 訂單.下單日期, 書籍.書籍名稱, 訂購項目.數量, 客戶.客戶名稱, 客戶.聯絡人, 客戶.地址, 客戶.電話
FROM 訂單 LEFT JOIN 客戶 ON 客戶.客戶編號=訂單.客戶編號 
          LEFT JOIN 訂購項目 ON 訂購項目.訂單編號=訂單.訂單編號
          LEFT JOIN 書籍 ON 書籍.書籍編號 = 訂購項目.書籍編號
--WHERE 書籍.書籍名稱='Windows Server 系統實務' --精準搜尋
--WHERE 書籍.書籍名稱 like '%W%' -- keyword搜尋
--WHERE 書籍.書籍名稱 IN('Windows Server 系統實務', 'Outlook 快學快用')
--WHERE 書籍.書籍名稱 like @SearchCond
--WHERE 書籍.書籍名稱 like '%Photoshop%'

/****** 練習4 - UNION綜合練習 ******/
--說明如何使用UNION合併2個查詢結果 
SELECT 書名, SUM(本數) AS 借閱數量  -- INTO ##LinuxTable
FROM   借閱清單
WHERE 書名 LIKE '%LINUX%'
GROUP BY 書名, 本數

SELECT 書名, SUM(本數) AS 借閱數量  -- INTO #WinTable
FROM   借閱清單
WHERE 書名 LIKE '%WINDOWS%'
GROUP BY 書名, 本數

drop table #LinuxTable
drop table #WinTable

--說明如何使用UNION合併2個查詢結果 - 等效操作 - 使用暫存資料表
SELECT 書名, SUM(本數) AS 借閱數量  INTO #Temp
FROM   借閱清單
WHERE 書名 LIKE '%WINDOWS%' OR 書名 LIKE '%LINUX%'
GROUP BY 書名, 本數

DECLARE @Linux char(5)
SET @Linux='Linux'
DECLARE @Win char(7)
SET @Win='Windows'

SELECT @Linux AS 類別, * into #LinuxTable
FROM #Temp
WHERE 書名 LIKE '%' + @Linux+ '%'
 
SELECT @Win AS 類別, * into #WinTable
FROM #Temp
WHERE 書名 LIKE '%' + @Win+ '%' --'%Windows%'

SELECT * FROM #LinuxTable
SELECT * FROM #WinTable

SELECT * into #Result
FROM #WinTable
UNION
SELECT * FROM #LinuxTable

--合併成一個SQL Statement
DECLARE @Linux char(5)
SET @Linux='Linux'
DECLARE @Win char(7)
SET @Win='Windows'

SELECT @Win, SUM(借閱數量) AS 總數
FROM #WinTable
UNION
SELECT @Linux, SUM(借閱數量) AS 總數 FROM #LinuxTable
GROUP BY 類別

-- 其他做法 -使用IIF
SELECT IIF(書名 LIKE '%LINUX%', 'Linux', 'Windows') 類別,  本數 into #Result2
FROM   借閱清單
WHERE 書名 LIKE '%LINUX%' OR 書名 LIKE '%Windows%'

SELECT 類別, SUM(本數) AS 借閱數量 
FROM #Result2
GROUP BY 類別