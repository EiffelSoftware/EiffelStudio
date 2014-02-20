USE [EiffelDB]
GO

/****** Object:  StoredProcedure [dbo].[IsProblemReportVisibleGuest]    Script Date: 19/02/2014 17:12:57 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IsProblemReportVisibleGuest]
@Number INT

AS

DECLARE @Count INT

BEGIN
	SELECT @Count = COUNT(*)
	FROM ProblemReports
	WHERE (Number = @Number) AND (Confidential = 0)
	IF @Count > 0
		SELECT 1
	ELSE
		SELECT 0
END


GO

