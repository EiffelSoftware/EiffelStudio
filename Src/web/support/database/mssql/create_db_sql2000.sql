/* SCRIPT: CREATE_DB.sql */
/* BUILD A DATABASE */

-- This is the main caller for each script


SET NOCOUNT ON
GO

PRINT 'CREATING DATABASE'
IF EXISTS (SELECT 1 FROM  master.dbo.sysdatabases WHERE NAME = 'test')
DROP DATABASE test
GO
CREATE DATABASE test 
GO


:On Error exit


PRINT 'DATABASE CREATE IS COMPLETE'
GO