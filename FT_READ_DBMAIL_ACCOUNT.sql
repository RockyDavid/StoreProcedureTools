-- =============================================
-- Author:		Kevin
-- Create date: 2018-06-12
-- Description:	Åª¨ú DataBase Mail ±b¤á¸ê°T
-- =============================================
CREATE PROCEDURE [dbo].[FT_READ_DBMAIL_ACCOUNT]
	@IsCheckAPIv1 TINYINT = 0
AS
BEGIN
	-- EXEC dbo.FT_READ_DBMAIL_ACCOUNT  
	SET NOCOUNT ON;
	DECLARE @_account_name SYSNAME = 'SIMS_Administrator'
	
	DECLARE @TEMP TABLE (
		[account_id] int,
		[name] sysname,
		[description] NVARCHAR(256),
		[email_address] NVARCHAR(128),
		[display_name] NVARCHAR(256),
		[replyto_address] NVARCHAR(128),
		[servertype] sysname,
		[servername] sysname,
		[port] INT,
		[username] NVARCHAR(128),
		[user_default_credentials] TINYINT,
		[enable_ssl] TINYINT
	)
	BEGIN TRY  
		INSERT INTO @TEMP
		EXEC msdb.dbo.sysmail_help_account_sp @account_name = @_account_name	

		IF @IsCheckAPIv1 = 1 BEGIN SELECT 200 CODE, NULL ERROR_MESSAGE END
		SELECT [account_id],
			   [name],
			   [description],
			   [email_address],
			   [display_name],
			   [replyto_address],
			   [servertype],
			   [servername],
			   [port],
			   [username],
			   '' [password],
			   [user_default_credentials],
			   [enable_ssl]
		  FROM @TEMP
	END TRY  
	BEGIN CATCH  
		IF @IsCheckAPIv1 = 1 BEGIN
			SELECT 500					[CODE]
				  ,ERROR_NUMBER()		AS [ERROR_NUMBER]
				  ,ERROR_SEVERITY()		AS [ERROR_SEVERITY]
				  ,ERROR_STATE()		AS [ERROR_STATE]
				  ,ERROR_PROCEDURE()	AS [ERROR_PROCEDURE]
				  ,ERROR_LINE()			AS [ERROR_LINE]
				  ,ERROR_MESSAGE()		AS [ERROR_MESSAGE]
		END
		SELECT [account_id],
			   [name],
			   [description],
			   [email_address],
			   [display_name],
			   [replyto_address],
			   [servertype],
			   [servername],
			   [port],
			   [username],
			   '' [password],
			   [user_default_credentials],
			   [enable_ssl]
		  FROM @TEMP
	END CATCH
END
