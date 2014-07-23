/**** Tables *****/
GO
/****** Object:  Table [dbo].[UpdateEmail]    Script Date: 03/06/2014 14:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UpdateEmail](
	[ContactID] [int] NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[OldEmail] [varchar](150) NOT NULL,
	[Token] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ChangeEmailIdD] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_UpdateEmail] PRIMARY KEY CLUSTERED 
(
	[ChangeEmailIdD] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[UpdateEmail]  WITH CHECK ADD  CONSTRAINT [FK_EmailUpdate_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[UpdateEmail] CHECK CONSTRAINT [FK_EmailUpdate_Contacts]

GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] ADD [NewCategoryID] [int] NULL
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportTemporaryInteractions_ProblemReportCategory] FOREIGN KEY([NewCategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO

GO

/************ Store Procedures *****/

/****** Object:  StoredProcedure [dbo].[AddUser2]    Script Date: 21/05/2014 8:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddUser2]
	@FirstName		VARCHAR(50),
	@LastName		VARCHAR(50),
	@EMail			VARCHAR(100),
	@Username		VARCHAR(100),
	@PasswordHash	CHAR(40),
	@PasswordSalt		CHAR(24),
	@AnswerHash		CHAR(40),
	@AnswerSalt		CHAR(24),
	@RegistrationToken	CHAR(7),
	@QuestionID		INT

AS

DECLARE @Count		INT
DECLARE @ContactID		INT
DECLARE  @MembershipID	INT
DECLARE @Now datetime
DECLARE @AlreadyExists	BIT
SET @Now = getdate()
SET NOCOUNT ON

BEGIN TRANSACTION AddUserTransaction

		/* 1. Check username isn't taken already */
	SELECT	@Count = COUNT(*)
	FROM	Memberships
	WHERE	Username = @Username

		/* 1.a Check username/email is not already trying to register */
	IF @Count = 0
	BEGIN
		SELECT	@Count = COUNT(*)
		FROM	Registrations
		WHERE	Username = @Username or Email = @Email
	END

		/* 1.b Check username/email is not already registered */
	IF @Count = 0
	BEGIN
		SELECT	@ContactID= ContactID
		FROM	Contacts
		WHERE	Email = @Email
		IF @ContactID IS NOT NULL
		BEGIN
			SELECT @Count = COUNT(*)
			FROM Memberships
			WHERE ContactID=@ContactID;
		END
	END

	IF @Count = 0
	BEGIN

		/* 2. Retrieve/create ContactID */
		SELECT	@ContactID = ContactID
		FROM		Contacts
		WHERE	EMail = @EMail

		IF @ContactID IS NULL
		BEGIN
			INSERT INTO Contacts (
				FirstName,
				LastName,
				EMail,
				DateOfLastModification,
				DateOfCreation
			)
			VALUES (
				@FirstName,
				@LastName,
				@EMail,
				@Now,
				@Now
			)
			SELECT @ContactID = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
			DELETE FROM Memberships
			WHERE ContactID = @ContactID
		END

		/* 3. Store membership information */		

		INSERT INTO Memberships (
			ContactID,
			QuestionID,
			Username,
			PasswordHash,
			PasswordSalt,
			AnswerHash,
			AnswerSalt,
			CreationDate,
			IsActive
			)
		VALUES (
			@ContactID,
			@QuestionID,
			@Username,
			@PasswordHash,
			@PasswordSalt,
			@AnswerHash,
			@AnswerSalt,
			@Now,
			1
		)
		SELECT @MembershipID = SCOPE_IDENTITY()

		/* 4. Create registration table entry */
		INSERT INTO Registrations(
			RegistrationToken,
			EMail,
			Username,
			CreationDate
		)
		VALUES(
			@RegistrationToken,
			@EMail,
			@Username,
			@Now
		)

		/* 5. Initialize Role from presets */
		EXEC SetPresetRole @EMail
	END
	ELSE
		SET @AlreadyExists = 1

	SELECT @ContactID, @AlreadyExists

COMMIT TRANSACTION AddUserTransaction

GO

/****** Object:  StoredProcedure [dbo].[ChangeUserEmail]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ChangeUserEmail]
	-- Add the parameters for the stored procedure here
	@Username			VARCHAR(50),
	@Email	            VARCHAR(150), 
	@Token              VARCHAR(50)
	
AS
DECLARE @ContactID INT
DECLARE @OldEmail	            VARCHAR(150) 

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

SELECT @OldEmail = EmaIL  FROM Contacts WHERE ContactID = @ContactID

BEGIN TRANSACTION ChangeEmail

INSERT INTO UpdateEmail(ContactID, Email, OldEmail, Token, CreatedDate) 
	VALUES (@ContactID, @Email, @OldEmail, @Token, getdate())

COMMIT TRANSACTION ChangeEmail

GO


/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryInteraction3]    Script Date: 23/06/2014 9:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProblemReportTemporaryInteraction3]

@InteractionID INT

AS
SELECT NewStatusID, NewCategoryID

FROM ProblemReportTemporaryInteractions

WHERE InteractionID = @InteractionID

GO
/****** Object:  StoredProcedure [dbo].[InitializeInteraction3]    Script Date: 23/06/2014 9:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InitializeInteraction3]
@InteractionID	INT,
@Content	TEXT,
@StatusID	INT,
@Private	BIT,
@CategoryID	INT

AS
DECLARE @NewStatusID INT
DECLARE @NewCategoryID INT

IF @StatusID > 0
BEGIN
	SET @NewStatusID = @StatusID
END
ELSE
BEGIN
	SET @NewStatusID = NULL
END

IF @CategoryID > 0
BEGIN
	SET @NewCategoryID = @CategoryID
END
ELSE
BEGIN
	SET @NewCategoryID = NULL
END

UPDATE ProblemReportTemporaryInteractions
SET Content = @Content, NewStatusID = @NewStatusID, Private = @Private, NewCategoryID = @CategoryID
WHERE InteractionID = @InteractionID

GO

/****** Object:  StoredProcedure [dbo].[GetEmailTokenAge]    Script Date: 23/06/2014 10:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmailTokenAge]
	-- Add the parameters for the stored procedure here
    @Username			VARCHAR(50),
	@Token              VARCHAR(50)
AS
  DECLARE @ContactID INT
  DECLARE @Exist INT


  SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username;

  select @Exist=COUNT(*)  from UpdateEmail where Token = @Token and ContactID = @ContactID

  if @Exist = 1
  BEGIN
       select DATEDIFF(HOUR,CreatedDate,getdate()), Email from UpdateEmail where Token = @Token and ContactID = @ContactID
  END
  IF @Exist = 0
  begin
	   Select -1  
  end 
GO

/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractionAttachmentsHeadersGuest]    Script Date: 21/05/2014 8:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[GetProblemReportInteractionAttachmentsHeadersGuest]

@InteractionID INT

AS
select AttachmentID, [FileName], BytesCount
FROM ProblemReportInteractionAttachments
JOIN ProblemReportInteractions  pri ON pri.InteractionID = ProblemReportInteractionAttachments.InteractionID
where ProblemReportInteractionAttachments.InteractionID =@InteractionID  and pri.Private = 0

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractions3]    Script Date: 21/05/2014 8:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProblemReportInteractions3]

@Number INT,
@Username VARCHAR(50)

AS
DECLARE @IsResponsible BIT
DECLARE @RoleID INT

SELECT @RoleID=RoleID FROM Memberships WHERE Username=@Username
IF @RoleID = 2 OR @RoleID = 4 
BEGIN
	SET @IsResponsible=1
END
ELSE
BEGIN
	SET @IsResponsible=0
END

SELECT InteractionDate, Content, Username, FirstName, LastName, StatusSynopsis, Private, InteractionID
FROM ProblemReportInteractions
INNER JOIN Contacts ON Contacts.ContactID = ProblemReportInteractions.ContactID
LEFT JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReportInteractions.NewStatusID
LEFT JOIN Memberships ON Memberships.ContactID = ProblemReportInteractions.ContactID
WHERE ReportID = (SELECT ReportID FROM ProblemReports WHERE Number = @Number)
AND (@IsResponsible=1 OR Private=0)

ORDER BY InteractionDate DESC

GO


/****** Object:  StoredProcedure [dbo].[GetProblemReportsGuest3]    Script Date: 21/05/2014 8:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery8.sql|7|0|C:\Users\javier\AppData\Local\Temp\~vsF81E.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[GetProblemReportsGuest3]
	@RowsPerPage INT , 
    @PageNumber INT,
	@CategoryID INT,
	@StatusID INT
AS

BEGIN TRANSACTION GetProblemReportsGuest3
DECLARE  @StartRow INT
DECLARE  @EndRow INT
SET    @StartRow = (@RowsPerPage*@PageNumber)
SET    @EndRow = (@StartRow + @RowsPerPage)

CREATE TABLE dbo.TEMP (RowNumber INT IDENTITY(1,1), Number int,Synopsis VARCHAR (200), CategorySynopsis VARCHAR(50), SubmissionDate datetime, StatusID int)

INSERT INTO dbo.TEMP (Number, Synopsis, CategorySynopsis, SubmissionDate, StatusID)
    (SELECT Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID
	FROM ProblemReports
    INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID 
    WHERE Confidential = 0 AND ((ProblemReports.CategoryID = @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
		AND ((ProblemReports.StatusID = @StatusID) OR (NOT EXISTS (SELECT StatusID FROM ProblemReportStatus WHERE (StatusID = @StatusID))))
    )
	 		
SELECT Number, Synopsis, CategorySynopsis, SubmissionDate, StatusID
    FROM  dbo.TEMP
    WHERE RowNumber > @StartRow
        AND RowNumber < (@EndRow)
DROP TABLE dbo.TEMP

COMMIT TRANSACTION GetProblemReportsGuest3

GO

/****** Object:  StoredProcedure [dbo].[GetProblemReportsRowCountGuest]    Script Date: 21/05/2014 8:42:18 ******/
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
@CategoryID INT,
@StatusID INT,
@UserName Varchar(50)
AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID
FROM Memberships
WHERE Username = @Username

IF @ContactID IS NULL
BEGIN
	SET @ContactID = 0
END
BEGIN
	SELECT COUNT(*) FROM dbo.ProblemReports
	where (Confidential = 0 or (Confidential = 1 and ContactID = @ContactID ) )
	and ((ProblemReports.CategoryID = @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
	AND ((ProblemReports.StatusID = @StatusID) OR (NOT EXISTS (SELECT StatusID FROM ProblemReportStatus WHERE (StatusID = @StatusID))))
END


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportStatus]    Script Date: 21/05/2014 8:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportStatus]

AS

SELECT * 
FROM ProblemReportStatus

GO

/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryInteraction2]    Script Date: 23/06/2014 9:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProblemReportTemporaryInteraction2]

@InteractionID INT

AS
SELECT Content, (SELECT Username FROM Memberships WHERE Memberships.ContactID = ProblemReportTemporaryInteractions.ContactID), (SELECT StatusSynopsis FROM ProblemReportStatus WHERE ProblemReportStatus.StatusID = ProblemReportTemporaryInteractions.NewStatusID), Private, (SELECT CategorySynopsis FROM ProblemReportCategories WHERE ProblemReportCategories.CategoryID = ProblemReportTemporaryInteractions.NewCategoryID) 

FROM ProblemReportTemporaryInteractions

WHERE InteractionID = @InteractionID

GO

/****** Object:  StoredProcedure [dbo].[GetReportProblemInteractionsGuest]    Script Date: 21/05/2014 8:42:18 ******/
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
WHERE ReportID = (SELECT ReportID FROM ProblemReports WHERE Number = @Number and Private = 0)
END


GO

/****** Object:  StoredProcedure [dbo].[InitializeInteraction3]    Script Date: 23/06/2014 9:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InitializeInteraction3]
@InteractionID	INT,
@Content	TEXT,
@StatusID	INT,
@Private	BIT,
@CategoryID	INT

AS
DECLARE @NewStatusID INT
DECLARE @NewCategoryID INT

IF @StatusID > 0
BEGIN
	SET @NewStatusID = @StatusID
END
ELSE
BEGIN
	SET @NewStatusID = NULL
END

IF @CategoryID > 0
BEGIN
	SET @NewCategoryID = @CategoryID
END
ELSE
BEGIN
	SET @NewCategoryID = NULL
END

UPDATE ProblemReportTemporaryInteractions
SET Content = @Content, NewStatusID = @NewStatusID, Private = @Private, NewCategoryID = @CategoryID
WHERE InteractionID = @InteractionID

GO
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionAttachmentVisibleGuest]    Script Date: 21/05/2014 8:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IsProblemReportInteractionAttachmentVisibleGuest]

@Username VARCHAR(50),
@AttachmentID INT

AS

DECLARE @InteractionID INT

SELECT @InteractionID = InteractionID
FROM ProblemReportInteractionAttachments
WHERE AttachmentID = @AttachmentID

EXEC IsProblemReportInteractionVisibleGuest @InteractionID


GO
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionVisibleGuest]    Script Date: 21/05/2014 8:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IsProblemReportInteractionVisibleGuest]
@InteractionID INT

AS

DECLARE @Count INT

BEGIN
	SELECT @Count = COUNT(*)
	FROM ProblemReportInteractions
	WHERE (InteractionID = @InteractionID) AND (Private = 0)
	IF @Count > 0
		SELECT 1
	ELSE
		SELECT 0
END

GO

/****** Object:  StoredProcedure [dbo].[IsProblemReportVisibleGuest]    Script Date: 21/05/2014 8:42:18 ******/
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

/****** Object:  StoredProcedure [dbo].[UpdateEmailFromUserAndToken]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEmailFromUserAndToken]

  @Username VARCHAR(50),
  @Token VARCHAR(50)

AS

 
  DECLARE @Email VARCHAR(150)
  DECLARE @ContactID INT
  DECLARE @Exist INT

  BEGIN TRANSACTION UpdateEmail

  SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username;

  select @Email=Email from UpdateEmail where Token = @Token and ContactID = @ContactID


  UPDATE Contacts
  SET Email = @EMAIL
  WHERE ContactID = @ContactID

  COMMIT TRANSACTION UpdateEmail


GO

/****** Object:  StoredProcedure [dbo].[UpdatePersonalInformation2]   ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.UpdatePersonalInformation2
@Username	VARCHAR(50),
@FirstName	VARCHAR(50),
@LastName	VARCHAR(50),
@Position	VARCHAR(50),
@Address	VARCHAR(500),
@City		VARCHAR(100),
@Country	VARCHAR(50),
@Region	VARCHAR(100),
@Code		VARCHAR(50),
@Tel		VARCHAR(50),
@Fax		VARCHAR(50)

AS

DECLARE @RegionID INT


BEGIN TRANSACTION UpdateInformation
if @Position = N'' 
begin
	SET @Position = NULL
end
IF @Address = N''
begin
	SET @Address = NULL
end 
if @City    = N''
begin
   SET @City = NULL
end	
if @Country	= N''
begin
	SET @Country = NULL
end
if @Region	= N''
begin
	SET @Region = NULL
end
if @Code	= N''
begin
	SET @Code = NULL
end
if @Tel		= N''
begin
	SET @Tel = NULL
end
if @Fax		= N''
begin
	SET @Fax = NULL
end
SELECT @RegionID = RegionID
FROM Regions
WHERE Region = @Region

IF @RegionID IS NULL
BEGIN
	INSERT INTO Regions
	VALUES (
		@Region
	)
	SELECT @RegionID = SCOPE_IDENTITY()
END
	
UPDATE Contacts

SET FirstName = @FirstName,
        LastName = @LastName,
        Position = @Position,
        Address = @Address,
        City = @City,
        CountryID = @Country,
        RegionID = @RegionID,
        PostalCode = @Code,
        Phone = @Tel,
        Fax = @Fax
WHERE ContactID = (SELECT ContactID FROM Memberships WHERE Username = @Username)
Commit TRANSACTION UpdateInformation
GO

/****** Object:  StoredProcedure [dbo].[UpdateTemporaryProblemReport]    Script Date: 21/05/2014 8:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateTemporaryProblemReport] 
	@Number				INT,	
	@PriorityID				INT,
	@SeverityID				INT,
	@CategoryID				INT,
	@ClassID				INT,
	@Confidential				BIT,
	@Synopsis				VARCHAR(100),
	@Release				VARCHAR(50),
	@Environment				VARCHAR(200),
	@Description				TEXT,
	@ToReproduce				TEXT
AS

/* Start transaction to guarentee no two updates in parallel */
BEGIN TRANSACTION UpdateTemporaryProblemReport

UPDATE ProblemReportsTemporary SET
	PriorityID = @PriorityID,
	CategoryID = @CategoryID,
	SeverityID = @SeverityID,
	ClassID = @ClassID,
	Synopsis = @Synopsis,
	Release = @Release,
	Confidential = @Confidential,
	Environment = @Environment,
	Description = @Description,
	ToReproduce = @ToReproduce
  WHERE ReportID = @Number


COMMIT TRANSACTION UpdateTemporaryProblemReport


GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CommitInteraction2]

@InteractionID INT

AS

/* Start transaction to guarentee no two updates in parallel */

DECLARE @ReportID INT
DECLARE @NewInteractionID INT
DECLARE @InteractionDate DATETIME

SET NOCOUNT ON

SELECT @ReportID = ReportID FROM ProblemReportTemporaryInteractions WHERE InteractionID = @InteractionID
SET @InteractionDate=getdate()

UPDATE ProblemReports SET LastActivityDate = @InteractionDate WHERE ReportID = @ReportID

BEGIN TRANSACTION CommitInteraction

INSERT INTO ProblemReportInteractions (ReportID, ContactID, InteractionDate, Content, NewStatusID, Private)
SELECT ReportID = @ReportID, ContactID, InteractionDate = @InteractionDate, Content, NewStatusID, Private
FROM ProblemReportTemporaryInteractions
WHERE InteractionID = @InteractionID

COMMIT TRANSACTION CommitInteraction

SET @NewInteractionID = SCOPE_IDENTITY()

IF EXISTS(SELECT* FROM ProblemReportTemporaryInteractionAttachments WHERE InteractionID = @InteractionID)
BEGIN
	INSERT  INTO ProblemReportInteractionAttachments (InteractionID, Blob, [FileName], BytesCount)
	SELECT InteractionID = @NewInteractionID, Blob = Content, [FileName], BytesCount = Length
	FROM ProblemReportTemporaryInteractionAttachments
	WHERE InteractionID = @InteractionID
END

SELECT @NewInteractionID


/********* Update Store Procedures */


GO
/****** Object:  StoredProcedure [dbo].[CommitProblemReport]    Script Date: 25/06/2014 11:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[CommitProblemReport]

@ReportID INT

AS

DECLARE @Number		INT
DECLARE @ContactID		INT
DECLARE @InteractionID	INT
DECLARE @NewReportID	INT

SET NOCOUNT ON

/* 0. Set ContactID */
SELECT @ContactID = ContactID FROM ProblemReportsTemporary WHERE ReportID = @ReportID

/* 1. Start transaction to guarentee correct value for 'Number' */
BEGIN TRANSACTION AddProblemReport

/* 2. Retrieve new number */
SELECT @Number = MAX(Number) FROM ProblemReports
IF @Number IS NULL SET @Number = 0
SET @Number = @Number + 1

/* 3. Add problem report entry and get ID */
INSERT INTO ProblemReports (ContactID, StatusID, PriorityID, CategoryID, SeverityID, ClassID, Number, SubmissionDate, Synopsis, Release, Confidential, Environment, [Description], ToReproduce, LastActivityDate)
SELECT ContactID, 1, PriorityID, CategoryID, SeverityID, ClassID, Number = @Number, SubmissionDate = getdate(), Synopsis, Release, Confidential, Environment, [Description], ToReproduce, getdate()
FROM ProblemReportsTemporary
WHERE ReportID = @ReportID

SELECT @NewReportID = SCOPE_IDENTITY()

/* 4. Commit transaction */
COMMIT TRANSACTION AddProblemReport

/* 5. Commit attachments if any */
DECLARE @HasAttachments	BIT	
SET @HasAttachments = (SELECT 1 WHERE EXISTS (SELECT * FROM ProblemReportTemporaryReportAttachments WHERE ReportID = @ReportID))
IF @HasAttachments = 1
BEGIN
	INSERT INTO ProblemReportInteractions (ReportID, ContactID, InteractionDate, Content) VALUES (@NewReportID, @ContactID, getdate(), 'Attachments for problem report #' + CAST (@Number AS VARCHAR(10)))
	SELECT @InteractionID = SCOPE_IDENTITY()
	INSERT INTO ProblemReportInteractionAttachments (InteractionID, Blob, [FileName], BytesCount) (SELECT InteractionID = @InteractionID, Content, [FileName], Length FROM ProblemReportTemporaryReportAttachments WHERE ReportID = @ReportID)
END

/* 6. Delete temporary entry */
DELETE FROM ProblemReportsTemporary WHERE ReportID = @ReportID

/* 7. Return new PR Number */
SELECT @Number


GO


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReport2]    Script Date: 25/06/2014 11:13:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE

[dbo].[GetProblemReport2]

@Number INT

AS

SELECT ProblemReports.SubmissionDate, ProblemReports.Synopsis, ProblemReports.Release,
	 ProblemReports.Confidential, ProblemReports.Environment, ProblemReports.Description, ProblemReports.ToReproduce,
	 ProblemReportStatus.StatusSynopsis, ProblemReportPriorities.PrioritySynopsis, ProblemReportCategories.CategorySynopsis,
	 ProblemReportSeverities.SeveritySynopsis, ProblemReportClasses.ClassSynopsis, Username,
	(SELECT Username AS Responsible FROM Memberships WHERE ContactID=ResponsibleID), ResponsibleID

FROM ProblemReports
INNER JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReports.StatusID
INNER JOIN ProblemReportPriorities ON ProblemReportPriorities.PriorityID = ProblemReports.PriorityID
INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID
INNER JOIN ProblemReportSeverities ON ProblemReportSeverities.SeverityID = ProblemReports.SeverityID
INNER JOIN ProblemReportClasses ON ProblemReportClasses.ClassID = ProblemReports.ClassID
LEFT JOIN Memberships ON Memberships.ContactID = ProblemReports.ContactID
LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID

WHERE Number = @Number

GO

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporary2]    Script Date: 25/06/2014 11:16:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





ALTER PROCEDURE [dbo].[GetProblemReportTemporary2]

@ReportID INT

AS

SELECT	Synopsis, 
		Release, 
		Confidential, 
		Environment, 
		[Description],
		ToReproduce, 
		PrioritySynopsis,
		CategorySynopsis,
		SeveritySynopsis,
		ClassSynopsis,
		Username,
		(SELECT Username AS Responsible FROM Memberships WHERE ContactID=ResponsibleID)

FROM ProblemReportsTemporary
INNER JOIN ProblemReportPriorities ON ProblemReportPriorities.PriorityID = ProblemReportsTemporary.PriorityID
INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReportsTemporary.CategoryID
INNER JOIN ProblemReportSeverities ON ProblemReportSeverities.SeverityID = ProblemReportsTemporary.SeverityID
INNER JOIN ProblemReportClasses ON ProblemReportClasses.ClassID = ProblemReportsTemporary.ClassID
INNER JOIN Memberships ON Memberships.ContactID = ProblemReportsTemporary.ContactID
LEFT JOIN ProblemReportDefaultCategoriesResponsibles ON ProblemReportDefaultCategoriesResponsibles.CategoryID = ProblemReportsTemporary.CategoryID

WHERE ProblemReportsTemporary.ReportID = @ReportID

GO

