-- =============================================
-- Author:		Kevin
-- Create date: 2018-05-08
-- Description:	將Date轉成指定格式之字串
-- =============================================
CREATE FUNCTION [dbo].[FT_CONVERT_DATE]
(
	@DATE DATE,
	@TARGET_FORMAT NVARCHAR(40) = null
)
RETURNS NVARCHAR(50)
AS
BEGIN
	-- SELECT dbo.FT_CONVERT_DATE(GETDATE(),null)
	DECLARE @TARGET NVARCHAR(50) = ''
	
	IF @DATE IS NULL BEGIN
		RETURN @TARGET
	END

	IF(@TARGET_FORMAT IS NULL OR LEN(RTRIM(LTRIM(@TARGET_FORMAT))) = 0) BEGIN
		SET @TARGET_FORMAT = (SELECT [VAR_VALUE] FROM [dbo].[AR_DEFAULT_VAR] WHERE [VAR_KEY] = '日期格式')
	END
			 
	SET @TARGET = (SELECT FORMAT(@DATE, @TARGET_FORMAT))

	IF CONVERT(DATE, @TARGET) = '1970/01/01' BEGIN
		SET @TARGET = ''
	END
	RETURN @TARGET
END
