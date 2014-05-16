USE [$(database_name)]
GO
/****** Object:  View [dbo].[LastActivityDates]    Script Date: 08/04/2014 14:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[LastActivityDates] with SCHEMABINDING AS
SELECT	ReportID, MAX(InteractionDate) AS LastActivityDate
FROM	dbo.ProblemReportInteractions
GROUP BY ReportID

GO
