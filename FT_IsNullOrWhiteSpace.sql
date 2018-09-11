-- =============================================
-- Author:		Kevin
-- Create date: 2018/05/03
-- Description:	¥é®Ä C# IsNullOrWhiteSpace
-- =============================================
CREATE FUNCTION dbo.FT_IsNullOrWhiteSpace
( @TARGEGET NVARCHAR(MAX) )
RETURNS INT
AS
BEGIN
	DECLARE @RESULT INT = 0

	IF @TARGEGET IS NULL OR LEN(LTRIM(RTRIM(@TARGEGET))) = 0 
		SET @RESULT = 1

	RETURN @RESULT
END
