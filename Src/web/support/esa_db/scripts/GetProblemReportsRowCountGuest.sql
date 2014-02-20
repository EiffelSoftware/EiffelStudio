USE [EiffelDB]
GO

/****** Object:  StoredProcedure [dbo].[GetProblemReportsRowCountGuest]    Script Date: 19/02/2014 17:14:44 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProblemReportsRowCountGuest] 
AS
BEGIN
	SELECT COUNT(*) FROM dbo.ProblemReports
	where Confidential = 0
END

GO

