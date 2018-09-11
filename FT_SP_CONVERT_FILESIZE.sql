-- =============================================
-- Author:		Kevin
-- Create date: 2018-08-30
-- Description:	將檔案長度轉換成KB,MB,GB,TB
-- =============================================
CREATE FUNCTION [dbo].[FT_SP_CONVERT_FILESIZE]
(
	@FILESIZE BIGINT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @RESULT NVARCHAR(MAX) = 'N/A'
		
	DECLARE @KB FLOAT = POWER(1024.0,1)
	DECLARE @MB FLOAT = POWER(1024.0,2)
	DECLARE @GB FLOAT = POWER(1024.0,3)
	DECLARE @TB FLOAT = POWER(1024.0,4)

	SELECT @RESULT = 
		   (CASE WHEN @FILESIZE IS NULL OR @FILESIZE = 0 THEN 'N/A'
	             WHEN CONVERT(BIGINT, (CEILING(ISNULL(@FILESIZE, 0))/@GB)) > POWER(1024.0,1) 
				 THEN CAST(ROUND(@FILESIZE /@TB, 2) AS varchar(MAX)) + ' TB'      
				    
	             WHEN CONVERT(BIGINT, (CEILING(ISNULL(@FILESIZE, 0))/@MB)) > POWER(1024.0,1) 
				 THEN CAST(ROUND(@FILESIZE /@GB, 2) AS varchar(MAX)) + ' GB'   
				      
	             WHEN CONVERT(BIGINT, (CEILING(ISNULL(@FILESIZE, 0))/@KB)) > POWER(1024.0,1) 
				 THEN CAST(ROUND(@FILESIZE /@MB, 2) AS varchar(MAX)) + ' MB'  

				 WHEN CONVERT(BIGINT, ISNULL(@FILESIZE, 0)) > POWER(1024.0,1) 
				 THEN CAST(ROUND(@FILESIZE /@KB, 2) AS varchar(MAX)) + ' KB'
     
		     ELSE 'TOO LARGE' END)

	RETURN @RESULT

END
