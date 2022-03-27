USE  練習09
GO
--
/****** 練習1 - SELECT使用函數 ******/
-- CAST - 型態轉換 (P9-4b)
SELECT 書籍名稱, CAST(價格 * 0.8 AS numeric(4, 0) )  AS  折扣價
FROM 書籍 
GO

-- LOWER - 轉小寫  - P9-5
SELECT '大家好' , 3+5 , LOWER('ABC')
GO

-- GROUP BY
-- SUM - P9-19a
 
SELECT  客戶名稱, SUM(數量) AS 出貨數量 
FROM     出貨記錄
GROUP BY  客戶名稱 

GO

-- GROUP BY多個欄位 - 搭配ORDER BY
-- DATEPART - 處理日期 - P9-19b
SELECT 客戶名稱, DATEPART(MONTH, 日期) AS 月份, SUM(數量) AS 出貨數量
FROM   出貨記錄
GROUP BY 客戶名稱, DATEPART(MONTH, 日期)
ORDER BY 客戶名稱, DATEPART(MONTH, 日期)

GO

-- GROUP BY CUBE - P9-20
SELECT  客戶名稱, 書名, SUM(數量) AS 總數量 
FROM     出貨記錄 
GROUP BY  CUBE (書名, 客戶名稱)

GO
-- GROUP BY CUBE  -  P9-21a
SELECT 客戶名稱, 書名, SUM(數量) AS 總數量 
FROM  出貨記錄
GROUP BY ROLLUP(客戶名稱, 書名)
GO

SELECT  客戶名稱, 書名, SUM(數量) AS 總數量 
FROM    出貨記錄
GROUP BY ROLLUP(書名, 客戶名稱) 

GO
-- HAVING SUM- P9-23a
SELECT   客戶名稱, 書名, SUM(數量) AS 總數量 
FROM      出貨記錄
GROUP BY  客戶名稱, 書名 
HAVING SUM(數量) >= 6 

GO

-- HAVING COUNT- P9-23b
SELECT  客戶名稱, 書名, COUNT(*) AS 次數 
FROM     出貨記錄
GROUP BY  客戶名稱, 書名 
HAVING COUNT(*) > 1 

GO

-- OFFSET (略過前3筆資料)- P9-25b
SELECT *
FROM 出貨記錄
ORDER BY 客戶名稱 DESC, 數量 ASC
OFFSET 3 ROWS

GO

-- OFFSET (略過前3筆資料，只傳4筆)- P9-26
SELECT *
FROM 出貨記錄
ORDER BY 客戶名稱 DESC, 數量 ASC
OFFSET 3 ROWS FETCH NEXT 4 ROWS ONLY
