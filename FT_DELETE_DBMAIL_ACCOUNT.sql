-- =============================================
-- Author:		Kevin
-- Create date: 2018-06-12
-- Description:	刪除 DataBase Mail 帳戶資訊
-- =============================================
CREATE PROCEDURE [dbo].[FT_DELETE_DBMAIL_ACCOUNT]
AS
BEGIN
	-- EXEC dbo.FT_DELETE_DBMAIL_ACCOUNT
	SET NOCOUNT ON;
	
	DECLARE @_account_name SYSNAME = 'SIMS_Administrator'

	BEGIN TRY  
		EXECUTE msdb.dbo.sysmail_delete_profileaccount_sp    
		@profile_name    = 'SIMS_AdministratorProfile',  
		@account_name    = @_account_name

		EXECUTE msdb.dbo.sysmail_delete_profile_sp 
		@profile_name = 'SIMS_AdministratorProfile';

		EXECUTE msdb.dbo.sysmail_delete_account_sp 
		@account_name = @_account_name	
		
		SELECT 200 CODE, '刪除成功' ERROR_MESSAGE;
	END TRY  
	BEGIN CATCH  
			SELECT 500					[CODE]
				  ,ERROR_NUMBER()		AS [ERROR_NUMBER]
				  ,ERROR_SEVERITY()		AS [ERROR_SEVERITY]
				  ,ERROR_STATE()		AS [ERROR_STATE]
				  ,ERROR_PROCEDURE()	AS [ERROR_PROCEDURE]
				  ,ERROR_LINE()			AS [ERROR_LINE]
				  ,ERROR_MESSAGE()		AS [ERROR_MESSAGE]
	END CATCH
END
