-- =============================================
-- Author:		Kevin
-- Create date: 2018-09-11
-- Description:	匯出資料庫所有Function與StoreProcedure
-- =============================================
CREATE PROCEDURE dbo.ExportAllFunctionAndStoreProcedure
	@ROOT_PATH NVARCHAR(50) = 'E:\StoreProcedure\'
AS
BEGIN
-- EXEC  dbo.ExportAllFunctionAndStoreProcedure
SET NOCOUNT ON;
EXEC sp_configure 'show advanced options', 1;  
RECONFIGURE;  
EXEC sp_configure 'Ole Automation Procedures', 1;  
RECONFIGURE;  

DECLARE @FOLDER_PATH NVARCHAR(100) = @ROOT_PATH + REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR,SYSUTCDATETIME()), ' ', ''), '-', ''), ':', ''),'.','') + '\'

DECLARE @OLE_FOLDER        INT 
DECLARE @FOLDER_ID         INT 
EXECUTE sp_OACreate 'Scripting.FileSystemObject', @OLE_FOLDER OUT 
EXECUTE sp_OAMethod @OLE_FOLDER, 'CreateFolder', @FOLDER_ID OUT, @FOLDER_PATH
EXECUTE sp_OADestroy @FOLDER_ID 
EXECUTE sp_OADestroy @OLE_FOLDER 	


DECLARE @SP_ROWS TABLE(
	SP_ID  INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	SP_NAME NVARCHAR(200) NOT NULL,
	SP_CONTENT NTEXT NOT NULL
)

INSERT INTO @SP_ROWS
  SELECT OBJECT_NAME(id) [SP_NAME], [TEXT]
    FROM sys.syscomments 
   WHERE OBJECT_NAME(id) LIKE 'AR_%'
      OR OBJECT_NAME(id) LIKE 'FT_%'
  	  OR OBJECT_NAME(id) LIKE 'CDMS_%'
	  OR OBJECT_NAME(id) IN ('ExportAllFunctionAndStoreProcedure', 'CheckAccount_ForAPIv1')
ORDER BY [SP_NAME] ASC

DECLARE @SP_NAMES TABLE(
	SP_NAME NVARCHAR(200) NOT NULL
)
INSERT INTO @SP_NAMES
SELECT DISTINCT [SP_NAME] FROM @SP_ROWS

DECLARE @SP_ID INT = NULL
DECLARE @SP_NAME NVARCHAR(MAX) = NULL
DECLARE @SP_CONTENT NVARCHAR(MAX) = NULL
DECLARE @FILE_PATH NVARCHAR(MAX) = NULL
WHILE EXISTS(SELECT * FROM @SP_NAMES)
BEGIN
	SELECT TOP 1 @SP_NAME = [SP_NAME] FROM @SP_NAMES
	SET @FILE_PATH = @FOLDER_PATH + @SP_NAME + '.sql'
	
	DECLARE @OLE            INT 
	DECLARE @FileID         INT 
	EXECUTE sp_OACreate 'Scripting.FileSystemObject', @OLE OUT 
	EXECUTE sp_OAMethod @OLE, 'OpenTextFile', @FileID OUT, @FILE_PATH, 8, 1 

	WHILE EXISTS(SELECT * FROM @SP_ROWS WHERE [SP_NAME] = @SP_NAME)
	BEGIN
		SELECT TOP 1 @SP_ID = [SP_ID], @SP_CONTENT = [SP_CONTENT]  FROM @SP_ROWS WHERE [SP_NAME] = @SP_NAME
		EXECUTE sp_OAMethod @FileID, 'Write', Null, @SP_CONTENT		
		DELETE @SP_ROWS WHERE [SP_ID] = @SP_ID
	END

	EXECUTE sp_OADestroy @FileID 
	EXECUTE sp_OADestroy @OLE 	
	DELETE @SP_NAMES WHERE [SP_NAME] = @SP_NAME
END

EXEC sp_configure 'Ole Automation Procedures', 0;  
RECONFIGURE;  
EXEC sp_configure 'show advanced options', 0;  
RECONFIGURE;  


END
