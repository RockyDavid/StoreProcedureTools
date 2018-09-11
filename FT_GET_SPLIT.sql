-- =============================================
-- Author:		Kevin
-- Create date: 2018-06-15
-- Description:	字串分割，取得指定INDEX
-- =============================================
CREATE FUNCTION [dbo].[FT_GET_SPLIT]
(
	@RAW NVARCHAR(MAX),
	@COMMA NVARCHAR(20),
	@INDEX TINYINT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	
	/*
	USE SupervisionInformationManagementSystem
	GO
	 SELECT [dbo].[FT_GET_SPLIT]('adsfad.pdf[:]231312312364564560564065[:].pdf[:]23413434.pdf','[:]',3)
	*/

 DECLARE @VALUE NVARCHAR(MAX) = NULL
 DECLARE @pos INT = 1
 DECLARE @CURRENT_INDEX TINYINT = 0
 
 WHILE CHARINDEX(@COMMA, @RAW) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(@COMMA, @RAW)  
  SELECT @VALUE = SUBSTRING(@RAW, 1, @pos-1)
  
  IF @CURRENT_INDEX = @INDEX BEGIN RETURN @VALUE END
  
  SET @CURRENT_INDEX = @CURRENT_INDEX  + 1
  SELECT @RAW = SUBSTRING(@RAW, @pos+LEN(@COMMA), LEN(@RAW)-@pos)
 END
 SELECT @VALUE = SUBSTRING(@RAW, 1, LEN(@RAW))

 RETURN @VALUE

END
