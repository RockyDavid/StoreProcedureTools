-- =============================================
-- Author:		Kevin
-- Create date: 2018/05/03
-- Description:	¥é®Ä C# IsNullOrWhiteSpace
-- dbo.FT_IsNullOrWhiteSpace()
-- =============================================
CREATE FUNCTION [dbo].[FT_CINT]
( @TARGEGET NVARCHAR(MAX) )
RETURNS INT
AS
BEGIN
	-- SELECT dbo.FT_CINT(-1)
	DECLARE @RESULT INT = NULL

	IF @TARGEGET IS NOT NULL OR LEN(LTRIM(RTRIM(@TARGEGET))) <> 0 
	BEGIN 
		IF ISNUMERIC(@TARGEGET) > 0 BEGIN		
			SET @RESULT = CONVERT(INT, @TARGEGET)
			IF(@RESULT = -1)
				SET @RESULT = NULL
		END
	END
	RETURN @RESULT
END
