USE [test]
GO
/****** Object:  View [dbo].[LastActivityDates]    Script Date: 21/05/2014 8:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[LastActivityDates] with SCHEMABINDING AS
SELECT	ReportID, MAX(InteractionDate) AS LastActivityDate
FROM	dbo.ProblemReportInteractions
GROUP BY ReportID

GO
