--資料庫建立檔案群組設定參數
--1. 卸離資料庫
EXEC sp_detach_db BANK

--2. 附加資料庫
CREATE DATABASE BANK
ON PRIMARY
  ( NAME='BANK_Primary',
    FILENAME=
       'D:\MSSQL_DB\Bank_Prm.mdf',
    SIZE=24MB,
    MAXSIZE=64MB,
    FILEGROWTH=1MB)
FOR ATTACH;

--3. 附加資料庫(使用Stored Procedure: sp_attach_db)
EXEC sp_attach_db @dbname = N'BANK', @filename1 = N'D:\MSSQL_DB\Bank_Prm.mdf'

--4. 備份資料庫
BACKUP DATABASE BANK TO DISK = 'D:\backups\BANK.bak';

--5. 還原資料庫
RESTORE DATABASE BANK FROM DISK = 'D:\backups\BANK.bak'

--6.卸離資料庫
EXEC sp_detach_db BANK

--7.附加資料庫(FOR ATTACH)，包含:指定DB檔與LOG檔
CREATE DATABASE BANK
ON PRIMARY
( NAME='BANK_Primary',
  FILENAME=
   'D:\DB\BANK.mdf'
)
LOG ON
  ( NAME='BANK_log',
    FILENAME =
        'D:\DB\BANK_log.ldf'
)
FOR ATTACH;

--8. 新建資料庫與設定參數，包含: 檔案群組(FILEGROUP)以及記錄檔(LOG)
CREATE DATABASE BANK
ON PRIMARY
  ( NAME='BANK_Primary',
    FILENAME=
       'D:\MSSQL_DB\Bank_Prm.mdf',
    SIZE=24MB,
    MAXSIZE=64MB,
    FILEGROWTH=1MB),
FILEGROUP Bank_FG1
  ( NAME = 'Bank_FG1_Dat1',
    FILENAME =
       'D:\MSSQL_DB\MyDB_FG1_1.ndf',
    SIZE=24MB,
    MAXSIZE=64MB,
    FILEGROWTH=1MB),
  ( NAME = 'Bank_FG1_Dat2',
    FILENAME =
        'D:\MSSQL_DB\MyDB_FG1_2.ndf',
    SIZE=24MB,
    MAXSIZE=64MB,
    FILEGROWTH=1MB)
LOG ON
  ( NAME='BANK_log',
    FILENAME =
        'D:\MSSQL_DB\BANK.ldf',
    SIZE=24MB,
    MAXSIZE=64MB,
    FILEGROWTH=1MB);
GO
