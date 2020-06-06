USE EiffelDB GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[IsProblemReportInteractionVisibleGuest]
@InteractionID INT

AS

DECLARE @ReportId INT
DECLARE @ReportNumber INT
BEGIN
		-- Check if the report interaction is visible
		-- Private = 0
	SELECT @ReportID = ProblemReportInteractions.ReportID
	FROM ProblemReportInteractions
	WHERE (InteractionID = @InteractionID) AND (Private = 0)
	
	SELECT @ReportNumber = ProblemReports.Number 
	FROM ProblemReports
	WHERE ReportID = @ReportID
END

EXEC IsProblemReportVisibleGuest @ReportNumber



 GO
USE master GO
