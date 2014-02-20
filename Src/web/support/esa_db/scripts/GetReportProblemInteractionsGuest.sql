USE [EiffelDB]
GO

/****** Object:  StoredProcedure [dbo].[GetReportProblemInteractionsGuest]    Script Date: 19/02/2014 17:16:46 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetReportProblemInteractionsGuest]
	@Number INT
AS
BEGIN
	SELECT InteractionDate, Content, Username, FirstName, LastName, StatusSynopsis, Private, InteractionID
FROM ProblemReportInteractions
INNER JOIN Contacts ON Contacts.ContactID = ProblemReportInteractions.ContactID
LEFT JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReportInteractions.NewStatusID
LEFT JOIN Memberships ON Memberships.ContactID = ProblemReportInteractions.ContactID
WHERE ReportID = (SELECT ReportID FROM ProblemReports WHERE Number = @Number and Confidential = 0)
END

GO

