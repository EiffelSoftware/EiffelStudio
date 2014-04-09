/* SCRIPT: CREATE_DB.sql */
/* BUILD A DATABASE */

-- This is the main caller for each script
SET NOCOUNT ON
GO

PRINT 'CREATING DATABASE'
IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$(database_name)')
DROP DATABASE $(database_name)
GO
CREATE DATABASE $(database_name)
GO

:On Error exit

:r .\db_schemas.sql
:r .\db_user.sql
:r .\db_tables.sql
:r .\db_store_procedures.sql
:r .\db_views.sql
:r .\db_user_defined_functions.sql



PRINT 'DATABASE CREATE IS COMPLETE'
GO