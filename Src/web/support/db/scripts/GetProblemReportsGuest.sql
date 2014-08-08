USE [EiffelDB]
GO

/****** Object:  StoredProcedure [dbo].[GetProblemReportsGuest]    Script Date: 19/02/2014 17:02:32 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

-- Batch submitted through debugger: SQLQuery16.sql|7|0|C:\Users\javier\AppData\Local\Temp\~vsCE.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProblemReportsGuest]

	@RowsPerPage INT , 
    @PageNumber INT
AS
SELECT Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID
 FROM (
    SELECT TOP (@RowsPerPage)
	   Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID, PAG.CategoryID
    FROM (
	SELECT TOP ((@PageNumber)*@RowsPerPage) 
	Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID, ProblemReports.CategoryID
	FROM ProblemReports
    INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID 
    WHERE Confidential = 0
	ORDER BY Number DESC
	) AS PAG
	INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = PAG.CategoryID 
	ORDER BY Number ASC
) AS PAG2
INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = PAG2.CategoryID 
ORDER BY Number DESC

GO

