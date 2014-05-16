USE [$(database_name)]
GO
/****** Object:  User [$(schema)]    Script Date: 08/04/2014 15:08:58 ******/
CREATE USER [$(schema)] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[$(schema)]
GO
ALTER ROLE [db_owner] ADD MEMBER [$(schema)]
GO
