-- =============================================
-- Author:		Kevin
-- Create date: 2018-05-22
-- Description:	預設日期
-- =============================================
CREATE FUNCTION dbo.FT_DEFAULT_DATE
(
)
RETURNS NVARCHAR(10)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @DEFAULT_DATE NVARCHAR(10) = '1970-01-01'
	SET @DEFAULT_DATE = (SELECT [VAR_VALUE] FROM [dbo].[AR_DEFAULT_VAR] WHERE [VAR_KEY] = '預設日期')
	-- Return the result of the function
	RETURN @DEFAULT_DATE

END
