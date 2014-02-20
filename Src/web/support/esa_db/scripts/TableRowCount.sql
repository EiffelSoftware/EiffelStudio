USE [EiffelDB]
GO

/****** Object:  StoredProcedure [dbo].[TableRowCount]    Script Date: 19/02/2014 17:10:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TableRowCount] 
	@TableName VARCHAR(100)
AS
SELECT SUM(pa.rows) RowCnt
FROM sys.tables ta
INNER JOIN sys.partitions pa
ON pa.OBJECT_ID = ta.OBJECT_ID
INNER JOIN sys.schemas sc
ON ta.schema_id = sc.schema_id
WHERE ta.is_ms_shipped = 0 AND pa.index_id IN (1,0)
and ta.name = @TableName


GO

