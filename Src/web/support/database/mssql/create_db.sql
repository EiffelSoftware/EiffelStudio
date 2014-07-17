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

:r $(curr)db_schemas.sql
:r $(curr)db_user.sql
:r $(curr)db_tables.sql
:r $(curr)db_store_procedures.sql
:r $(curr)db_views.sql
:r $(curr)db_user_defined_functions.sql
:r $(curr)data_countries.sql
:r $(curr)data_problem_report_category_groups.sql
:r $(curr)data_problem_report_categories.sql
:r $(curr)data_problem_report_classes.sql
:r $(curr)data_problem_report_form_fields.sql
:r $(curr)data_problem_report_severities.sql
:r $(curr)db_problem_report_priorities.sql
:r $(curr)data_problem_report_status.sql
:r $(curr)data_questions.sql
:r $(curr)data_roles.sql
:r $(curr)data_security_questions.sql



PRINT 'DATABASE CREATE IS COMPLETE'
GO