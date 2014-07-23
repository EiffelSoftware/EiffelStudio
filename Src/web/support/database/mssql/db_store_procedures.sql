USE [$(database_name)]
GO
/****** Object:  StoredProcedure [dbo].[AddDownloadInteraction]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddDownloadInteraction]

@Username			VARCHAR(50),
@Subject			TEXT,
@Notes				TEXT

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

INSERT INTO Interactions(ContactID, DateTime, InteractionType, Subject, Respondant, Notes) 
	VALUES (@ContactID, getdate(), 1, @Subject, 'Web Download', @Notes)
GO
/****** Object:  StoredProcedure [dbo].[AddProblemReportCategorySubscriber]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AddProblemReportCategorySubscriber]

@Username NVARCHAR(50),
@CategoryID INT

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

INSERT INTO ProblemReportCategoriesSubscribers  (ContactID, CategoryID)
VALUES (
	@ContactID,
	@CategoryID)


GO
/****** Object:  StoredProcedure [dbo].[AddProblemReportFromGnats]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddProblemReportFromGnats]

@Username			VARCHAR(100),
@FirstName			VARCHAR(50),
@LastName			VARCHAR(50),
@Email				VARCHAR(100),
@OrganizationName		VARCHAR(50),
@Priority			INT,
@Severity			INT,
@Category			INT,
@Class				INT,
@Confidential			BIT,
@Number			INT,
@Status			INT,
@Synopsis			VARCHAR(100),
@Release			VARCHAR(50),
@Environment			VARCHAR(200),
@Description			TEXT,
@ToReproduce			TEXT,
@SubmissionDate		DATETIME,
@InteractionDate		DATETIME,
@InteractionContent		TEXT,
@InteractionID			INT OUTPUT

AS

DECLARE @ContactID		INT
DECLARE @ProblemReportID	INT

/* 1. Add user if not added and get ContactID */
SELECT	@ContactID = ContactID
FROM		Contacts
WHERE	EMail = @EMail

IF @ContactID IS NULL
BEGIN
	INSERT INTO Contacts (
		FirstName, 
		LastName,
		EMail,
		OrganizationName,
		DateOfCreation
	)
	VALUES (
		@FirstName, 
		@LastName, 
		@EMail,
		@OrganizationName,
		getdate()
	)
	SELECT @ContactID = SCOPE_IDENTITY()
END

/* 4. Add problem report entry and get ProblemReportID */ INSERT INTO ProblemReports (
	ContactID,
	StatusID,
	PriorityID,
	CategoryID,
	SeverityID,
	ClassID,
	Number,
	SubmissionDate,
	Synopsis,
	Release,
	Confidential,
	Environment,
	Description,
	ToReproduce
)
VALUES (
	@ContactID,
	@Status,
	@Priority,
	@Category,
	@Severity,
	@Class,
	@Number,
	@SubmissionDate,
	@Synopsis,
	@Release,
	@Confidential,
	@Environment,
	@Description,
	@ToReproduce
)
SELECT @ProblemReportID = SCOPE_IDENTITY()

/* 6. Add interaction in interactions table */ INSERT INTO ProblemReportInteractions (
	ReportID,
	ContactID,
	InteractionDate,
	Content
)
VALUES (
	@ProblemReportID,
	@ContactID,
	@InteractionDate,
	@InteractionContent
)
SELECT @InteractionID = SCOPE_IDENTITY()

/* 7. Return ProblemReportID */
SELECT @ProblemReportID

GO
/****** Object:  StoredProcedure [dbo].[AddProblemReportInteractionAttachment]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddProblemReportInteractionAttachment]

@InteractionID			INT,
@FileName			VARCHAR(260),
@Length			INT,
@Content			IMAGE

AS

INSERT INTO dbo.ProblemReportInteractionAttachments(
	InteractionID,
	FileName,
	BytesCount,
	Blob
)
VALUES (
	@InteractionID,
	@FileName,
	@Length,
	@Content
)

GO
/****** Object:  StoredProcedure [dbo].[AddProblemReportResponsibleCategory]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AddProblemReportResponsibleCategory]

@Username NVARCHAR(50),
@CategoryID INT

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

INSERT INTO ProblemReportResponsiblesCategories  (ContactID, CategoryID)
VALUES (
	@ContactID,
	@CategoryID)

GO
/****** Object:  StoredProcedure [dbo].[AddTemporaryNewEmail]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddTemporaryNewEmail]

@Username VARCHAR(50),
@Email VARCHAR(100),
@RegistrationToken CHAR(7)

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

IF NOT @ContactID IS NULL
BEGIN

	BEGIN TRANSACTION AddTemporaryNewEmail

	DELETE FROM TemporaryEmails WHERE Email = @Email

	INSERT INTO TemporaryEmails (Email, ContactID, Token)
	VALUES (
		@Email,
		@ContactID,
		@RegistrationToken
	)
	
	COMMIT TRANSACTION AddTemporaryNewEmail

END


GO
/****** Object:  StoredProcedure [dbo].[AddTemporaryProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddTemporaryProblemReport]

@Username VARCHAR(50)

AS

DECLARE @ContactID INT
DECLARE @Res INT

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

INSERT INTO ProblemReportsTemporary(ContactID, CreationDate) VALUES (@ContactID,getdate())

SET @Res = SCOPE_IDENTITY()
SELECT @Res

GO
/****** Object:  StoredProcedure [dbo].[AddTemporaryProblemReportAttachment]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddTemporaryProblemReportAttachment]

@ReportID	INT,
@Length	INT,
@Content	IMAGE,
@FileName	VARCHAR(260)

AS

INSERT INTO ProblemReportTemporaryReportAttachments (
	ReportID,
	Length,
	Content,
	FileName
) VALUES (
	@ReportID,
	@Length,
	@Content,
	@FileName
)

GO
/****** Object:  StoredProcedure [dbo].[AddTemporaryProblemReportInteraction]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddTemporaryProblemReportInteraction]

@Username	VARCHAR(50),
@Number	INT

 AS

DECLARE @ContactID INT
DECLARE @ReportID INT
DECLARE @Res INT

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username
SELECT @ReportID = ReportID FROM ProblemReports WHERE Number = @Number

INSERT INTO ProblemReportTemporaryInteractions (ReportID, ContactID, CreationDate) VALUES (@ReportID, @ContactID, getdate())

SET @Res = SCOPE_IDENTITY()
SELECT @Res
GO
/****** Object:  StoredProcedure [dbo].[AddTemporaryProblemReportInteractionAttachment]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AddTemporaryProblemReportInteractionAttachment]

@InteractionID	INT,
@Length	INT,
@Content	IMAGE,
@FileName	VARCHAR(260)

AS

INSERT INTO ProblemReportTemporaryInteractionAttachments (
	InteractionID,
	Length,
	Content,
	FileName
) VALUES (
	@InteractionID,
	@Length,
	@Content,
	@FileName
)

GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AddUser]

@FirstName		VARCHAR(50),
@LastName		VARCHAR(50),
@EMail			VARCHAR(100),
@Username		VARCHAR(100),
@PasswordHash	CHAR(40),
@PasswordSalt		CHAR(24),
@AnswerHash		CHAR(40),
@AnswerSalt		CHAR(24),
@RegistrationToken	CHAR(7),
@QuestionID		INT,
@AlreadyExists		BIT OUT

AS

DECLARE @Count		INT
DECLARE @ContactID		INT
DECLARE  @MembershipID	INT
DECLARE @Now datetime
SET @Now = getdate()

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

	SELECT @ContactID

COMMIT TRANSACTION AddUserTransaction



GO
/****** Object:  StoredProcedure [dbo].[AddUser2]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[ChangeActiveStatus]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ChangeActiveStatus]

@Username NVARCHAR(50)

AS

DECLARE @IsActive BIT

SELECT @IsActive = IsActive
FROM Memberships
WHERE Username=@Username

IF @IsActive = 1
	UPDATE Memberships SET IsActive = 0 WHERE Username=@Username
ELSE
	UPDATE Memberships SET IsActive = 1 WHERE Username=@Username

GO
/****** Object:  StoredProcedure [dbo].[CleanupRegistrations]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[CleanupRegistrations] AS

DECLARE @CutOffDate DATETIME

SET @CutOffDate = DATEADD (dd, -1, getdate())

BEGIN TRAN

DELETE FROM Registrations
WHERE CreationDate < @CutOffDate

IF @@TRANCOUNT > 0
BEGIN
	COMMIT TRAN
	RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[CleanupTemporaryProblemReportInteractions]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[CleanupTemporaryProblemReportInteractions] AS

DECLARE @CutOffDate DATETIME

SET @CutOffDate = DATEADD (hh, -4, getdate())

BEGIN TRAN

DELETE FROM ProblemReportTemporaryInteractions
WHERE CreationDate < @CutOffDate

IF @@TRANCOUNT > 0
BEGIN
	COMMIT TRAN
	RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[CleanupTemporaryProblemReports]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[CleanupTemporaryProblemReports] AS

DECLARE @CutOffDate DATETIME

SET @CutOffDate = DATEADD (hh, -4, getdate())

BEGIN TRAN

DELETE FROM ProblemReportsTemporary
WHERE CreationDate < @CutOffDate

IF @@TRANCOUNT > 0
BEGIN
	COMMIT TRAN
	RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[CommitInteraction]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CommitInteraction]

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

/*
DELETE FROM ProblemReportTemporaryInteractions WHERE InteractionID = @InteractionID
*/
SELECT @NewInteractionID




GO
/****** Object:  StoredProcedure [dbo].[CommitProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CommitProblemReport]

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
/****** Object:  StoredProcedure [dbo].[DeleteProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[DeleteProblemReport]

@Number INT

AS

/* Start transaction to guarentee no two updates in parallel */
BEGIN TRANSACTION UpdateProblemReport

DELETE FROM ProblemReports

WHERE Number = @Number

COMMIT TRANSACTION UpdateProblemReport


GO
/****** Object:  StoredProcedure [dbo].[GetAllProblemReports]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[GetAllProblemReports]

AS

SELECT ProblemReports.Number, ProblemReports.Synopsis, ProblemReports.SubmissionDate,
	 ProblemReports.Release, ProblemReports.PriorityID,
	 ProblemReportCategories.CategorySynopsis, ProblemReports.SeverityID,
	 ProblemReports.StatusID, Contacts.FirstName, Contacts.LastName, Contacts.Email,
	dbo.UserSynopsis(Contacts.ContactID) AS 'Username'

FROM ProblemReports
LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
LEFT JOIN Contacts ON ProblemReports.ContactID = Contacts.ContactID




GO
/****** Object:  StoredProcedure [dbo].[GetContactsForEdition]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetContactsForEdition]

AS

SELECT Username, FirstName, LastName, EMail, RoleSynopsis, CreationDate
FROM Memberships
INNER JOIN Contacts ON Contacts.ContactID = Memberships.ContactID
INNER JOIN Roles ON Roles.RoleID = Memberships.RoleID
GO
/****** Object:  StoredProcedure [dbo].[GetDefaultCategoriesResponsibles]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetDefaultCategoriesResponsibles]
AS
BEGIN
	SELECT ProblemReportDefaultCategoriesResponsibles.CategoryID, CategorySynopsis, Username
	FROM ProblemReportDefaultCategoriesResponsibles
	INNER JOIN Memberships ON Memberships.ContactID = ProblemReportDefaultCategoriesResponsibles.ResponsibleID
	INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReportDefaultCategoriesResponsibles.CategoryID
	ORDER BY CategorySynopsis
END



GO
/****** Object:  StoredProcedure [dbo].[GetDefaultCategoryResponsible]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDefaultCategoryResponsible]
	@CategoryID INT
AS
BEGIN
	SELECT Username 
	FROM ProblemReportDefaultCategoriesResponsibles
	INNER JOIN Memberships ON Memberships.ContactID = ProblemReportDefaultCategoriesResponsibles.ResponsibleID
	WHERE CategoryID = @CategoryID
END


GO
/****** Object:  StoredProcedure [dbo].[GetEmailFromContactID]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GetEmailFromContactID]

@ContactID INT

AS

SELECT Email FROM Contacts WHERE ContactID = @ContactID

GO
/****** Object:  StoredProcedure [dbo].[GetLastAccountsPageViewDate]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLastAccountsPageViewDate]

@Username VARCHAR(50)

AS

DECLARE @Res DATETIME

SELECT @Res = ViewDate
FROM AccountsPageViewDates
WHERE Username = @Username

IF @Res IS NULL
BEGIN
	SET @Res=getdate()
	INSERT INTO AccountsPageViewDates (Username, ViewDate)
	VALUES (@Username, @Res)
END
ELSE
BEGIN
	UPDATE AccountsPageViewDates
	SET ViewDate = getdate()
	WHERE Username = @Username
END

SELECT @Res

GO
/****** Object:  StoredProcedure [dbo].[GetLastSupportAdminPageViewDate]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLastSupportAdminPageViewDate]

@Username VARCHAR(50)

AS

DECLARE @Res DATETIME

SELECT @Res = ViewDate
FROM SupportAdminPageViewDates
WHERE Username = @Username

IF @Res IS NULL
BEGIN
	SET @Res=getdate()
	INSERT INTO SupportAdminPageViewDates (Username, ViewDate)
	VALUES (@Username, @Res)
END
ELSE
BEGIN
	UPDATE SupportAdminPageViewDates
	SET ViewDate = getdate()
	WHERE Username = @Username
END

SELECT @Res

GO
/****** Object:  StoredProcedure [dbo].[GetLastSupportPageViewDate]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLastSupportPageViewDate]

@Username VARCHAR(50)

AS

DECLARE @Res DATETIME

SELECT @Res = ViewDate
FROM SupportPageViewDates
WHERE Username = @Username

IF @Res IS NULL
BEGIN
	SET @Res=getdate()
	INSERT INTO SupportPageViewDates (Username, ViewDate)
	VALUES (@Username, @Res)
END
ELSE
BEGIN
	UPDATE SupportPageViewDates
	SET ViewDate = getdate()
	WHERE Username = @Username
END

SELECT @Res

GO
/****** Object:  StoredProcedure [dbo].[GetMembershipCreationDate]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GetMembershipCreationDate]

@Username NVARCHAR(50)

AS

SELECT CreationDate
FROM Memberships
WHERE Username = @Username


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE

[dbo].[GetProblemReport]

@Number INT

AS

SELECT ProblemReports.SubmissionDate, ProblemReports.Synopsis, ProblemReports.Release,
	 ProblemReports.Confidential, ProblemReports.Environment, ProblemReports.Description, ProblemReports.ToReproduce,
	 ProblemReportStatus.StatusSynopsis, ProblemReportPriorities.PrioritySynopsis, ProblemReportCategories.CategorySynopsis,
	 ProblemReportSeverities.SeveritySynopsis, ProblemReportClasses.ClassSynopsis, Username
FROM ProblemReports
INNER JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReports.StatusID
INNER JOIN ProblemReportPriorities ON ProblemReportPriorities.PriorityID = ProblemReports.PriorityID
INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID
INNER JOIN ProblemReportSeverities ON ProblemReportSeverities.SeverityID = ProblemReports.SeverityID
INNER JOIN ProblemReportClasses ON ProblemReportClasses.ClassID = ProblemReports.ClassID
LEFT JOIN Memberships ON Memberships.ContactID = ProblemReports.ContactID
WHERE Number = @Number

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReport2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE

[dbo].[GetProblemReport2]

@Number INT

AS

SELECT ProblemReports.SubmissionDate, ProblemReports.Synopsis, ProblemReports.Release,
	 ProblemReports.Confidential, ProblemReports.Environment, ProblemReports.Description, ProblemReports.ToReproduce,
	 ProblemReportStatus.StatusSynopsis, ProblemReportPriorities.PrioritySynopsis, ProblemReportCategories.CategorySynopsis,
	 ProblemReportSeverities.SeveritySynopsis, ProblemReportClasses.ClassSynopsis, Username,
	(SELECT Username AS Responsible FROM Memberships WHERE ContactID=ResponsibleID)

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
/****** Object:  StoredProcedure [dbo].[GetProblemReportCategories]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportCategories]

@Username VARCHAR(50)

AS

SELECT ProblemReportCategories.CategoryID, ProblemReportCategories.CategorySynopsis, ProblemReportCategoryGroups.CategoryGroupSynopsis

FROM ProblemReportCategories
INNER JOIN ProblemReportCategoryGroups ON ProblemReportCategoryGroups.CategoryGroupID = ProblemReportCategories.CategoryGroupID
INNER JOIN ProblemReportCategoriesRoles ON ProblemReportCategoriesRoles.CategoryID = ProblemReportCategories.CategoryID

WHERE IsActive = 1
AND ProblemReportCategoriesRoles.RoleID = (SELECT RoleID FROM Memberships WHERE Username=@Username)

ORDER BY CategorySynopsis

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportCategoryResponsibles]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProblemReportCategoryResponsibles]

@CategorySynopsis VARCHAR(50)

AS

SELECT FirstName, LastName, Email

FROM Contacts
INNER JOIN ProblemReportResponsiblesCategories ON Contacts.ContactID = ProblemReportResponsiblesCategories.ContactID
INNER JOIN ProblemReportCategories ON ProblemReportResponsiblesCategories.CategoryID = ProblemReportCategories.CategoryID

WHERE ProblemReportCategories.CategorySynopsis = @CategorySynopsis
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportCategorySubscribers]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetProblemReportCategorySubscribers]

@CategorySynopsis VARCHAR(50)

AS

SELECT FirstName, LastName, Email

FROM Contacts
INNER JOIN ProblemReportCategoriesSubscribers ON Contacts.ContactID = ProblemReportCategoriesSubscribers.ContactID
INNER JOIN ProblemReportCategories ON ProblemReportCategoriesSubscribers.CategoryID = ProblemReportCategories.CategoryID

WHERE ProblemReportCategories.CategorySynopsis = @CategorySynopsis


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportCategorySynopsis]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProblemReportCategorySynopsis]

@Number INT

AS

SELECT CategorySynopsis
FROM ProblemReports
INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID
WHERE Number = @Number
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportClasses]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportClasses] AS
SELECT * FROM ProblemReportClasses
ORDER BY ClassSynopsis

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportFormFieldDescription]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportFormFieldDescription]

@FieldTitle VARCHAR(50)

AS

SELECT [Description] 
FROM ProblemReportFormFields 
WHERE Title=@FieldTitle

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportForReview]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportForReview]

@Number INT

AS

SELECT PriorityID, CategoryID, SeverityID, ClassID, Synopsis, Release, Confidential, Environment, [Description], ToReproduce
FROM ProblemReports
WHERE Number = @Number

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteraction]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetProblemReportInteraction]

@InteractionID INT

AS

SELECT InteractionDate, Content, Username, FirstName, LastName, StatusSynopsis

FROM ProblemReportInteractions
INNER JOIN Contacts ON Contacts.ContactID = ProblemReportInteractions.ContactID
LEFT JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReportInteractions.NewStatusID
LEFT JOIN Memberships ON Memberships.ContactID = ProblemReportInteractions.ContactID

WHERE InteractionID = @InteractionID


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteraction2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetProblemReportInteraction2]

@InteractionID INT,
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


SELECT InteractionDate, Content, Username, FirstName, LastName, StatusSynopsis, Private 
FROM ProblemReportInteractions
INNER JOIN Contacts ON Contacts.ContactID = ProblemReportInteractions.ContactID
LEFT JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReportInteractions.NewStatusID
LEFT JOIN Memberships ON Memberships.ContactID = ProblemReportInteractions.ContactID

WHERE InteractionID = @InteractionID AND (@IsResponsible=1 OR Private=0)


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractionAttachmentContent]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportInteractionAttachmentContent]

@AttachmentID INT

AS

SELECT Blob, BytesCount, [FileName]
FROM ProblemReportInteractionAttachments
WHERE AttachmentID = @AttachmentID

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractionAttachmentsHeaders]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportInteractionAttachmentsHeaders]

@InteractionID INT

AS

SELECT AttachmentID, [FileName], BytesCount
FROM ProblemReportInteractionAttachments
WHERE InteractionID = @InteractionID

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractionAttachmentsHeadersGuest]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractions]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetProblemReportInteractions]

@Number INT

AS

SELECT InteractionID
FROM ProblemReportInteractions
WHERE ReportID = (SELECT ReportID FROM ProblemReports WHERE Number = @Number)

ORDER BY InteractionDate DESC


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractions2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetProblemReportInteractions2]

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

SELECT InteractionID
FROM ProblemReportInteractions
WHERE ReportID = (SELECT ReportID FROM ProblemReports WHERE Number = @Number)
AND (@IsResponsible=1 OR Private=0)

ORDER BY InteractionDate DESC


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractions3]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportPriorities]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetProblemReportPriorities]

AS

SELECT *
FROM ProblemReportPriorities






GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportResponsible]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProblemReportResponsible]
	@ReportID INT
AS
BEGIN
	SELECT ResponsibleID
	FROM ProblemReportsResponsibles
	WHERE ReportID=@ReportID
END

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportResponsibles]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetProblemReportResponsibles]
AS
BEGIN
	SELECT Contacts.ContactID, Memberships.Username, FirstName + ' ' + LastName AS [Name]
	FROM Memberships
	INNER JOIN Contacts ON Memberships.ContactID = Contacts.ContactID
	WHERE RoleID = 2 OR RoleID = 4
	ORDER BY FirstName
END





GO
/****** Object:  StoredProcedure [dbo].[GetProblemReports]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetProblemReports]

@Username VARCHAR(50),
@OpenOnly BIT,
@CategoryID INT,
@StatusID INT

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID
FROM Memberships
WHERE Username = @Username

IF NOT @ContactID IS NULL
BEGIN
	SELECT ProblemReports.Number, ProblemReports.Synopsis, ProblemReportCategories.CategorySynopsis, ProblemReports.SubmissionDate, ProblemReportStatus.StatusSynopsis

	FROM ProblemReports
	INNER JOIN ProblemReportStatus ON ProblemReports.StatusID = ProblemReportStatus.StatusID
	INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID

	WHERE ContactID = @ContactID
	AND ((ProblemReports.StatusID = 1 AND @OpenOnly = 1) OR @OpenOnly = 0)
	AND ((ProblemReports.CategoryID =  @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
	AND ((ProblemReports.StatusID =  @StatusID) OR (NOT EXISTS (SELECT StatusID FROM ProblemReportStatus WHERE StatusID = @StatusID)))
END



GO
/****** Object:  StoredProcedure [dbo].[GetProblemReports2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetProblemReports2]

@Username VARCHAR(50),
@OpenOnly BIT,
@CategoryID INT,
@StatusID INT

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID
FROM Memberships
WHERE Username = @Username

IF NOT @ContactID IS NULL
BEGIN
	SELECT Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID

	FROM ProblemReports
	INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID

	WHERE 
		ContactID = @ContactID 
		AND ((ProblemReports.CategoryID = @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
		AND
		(
			(
				@OpenOnly = 0
				AND ((ProblemReports.StatusID = @StatusID) OR (NOT EXISTS (SELECT StatusID FROM ProblemReportStatus WHERE (StatusID = @StatusID))))
			) OR (
				@OpenOnly = 1
				AND (((NOT ProblemReports.StatusID = 3) AND (NOT ProblemReports.StatusID = 5)) OR (NOT EXISTS (SELECT StatusID FROM ProblemReportStatus WHERE ((NOT StatusID = 3) AND (NOT StatusID = 5)))))
			)
		)
END
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportSeverities]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetProblemReportSeverities]

AS

SELECT *
FROM ProblemReportSeverities






GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForEdition]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetProblemReportsForEdition]

@Username VARCHAR(50),
@LastName VARCHAR(50),
@FirstName VARCHAR(50),
@CategoryID INT,
@StatusID INT,
@PriorityID INT,
@SeverityID INT

AS

DECLARE @StatusTable table(
	StatusID INT
)

INSERT INTO @StatusTable
SELECT StatusID
FROM ProblemReportStatus
WHERE ((POWER(2,StatusID - 1) & @StatusID) = POWER(2,StatusID - 1))

SELECT ProblemReports.Number, ProblemReports.Synopsis, ProblemReports.SubmissionDate,
	 ProblemReports.Release, ProblemReportPriorities.PrioritySynopsis,
	 ProblemReportCategories.CategorySynopsis, ProblemReportSeverities.SeveritySynopsis,
	 ProblemReportStatus.StatusSynopsis, Contacts.FirstName, Contacts.LastName, Contacts.Email,
	dbo.UserSynopsis(Contacts.ContactID) AS 'Username'

FROM ProblemReports
LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
INNER JOIN ProblemReportStatus ON ProblemReports.StatusID = ProblemReportStatus.StatusID
INNER JOIN ProblemReportPriorities ON ProblemReports.PriorityID = ProblemReportPriorities.PriorityID
INNER JOIN ProblemReportSeverities ON ProblemReports.SeverityID = ProblemReportSeverities.SeverityID
LEFT JOIN Contacts ON ProblemReports.ContactID = Contacts.ContactID

WHERE ((ProblemReports.CategoryID =  @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
AND (ProblemReports.StatusID IN (SELECT StatusID FROM @StatusTable))
AND ((ProblemReports.PriorityID =  @PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = @PriorityID)))
AND ((ProblemReports.SeverityID =  @SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = @SeverityID)))
AND ((Memberships.Username = @Username) OR (@Username = ''))
AND ((Contacts.FirstName = @FirstName) OR (@FirstName = ''))
AND ((Contacts.LastName = @LastName) OR (@LastName = ''))


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForEdition2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProblemReportsForEdition2]
@Username VARCHAR(50),
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Responsible VARCHAR(50),
@ResponsibleFirstName VARCHAR(50),
@ResponsibleLastName VARCHAR(50),
@CategoryID INT,
@StatusID INT,
@PriorityID INT,
@SeverityID INT

AS


DECLARE @StatusTable table(
	StatusID INT
)

/* If `SearchWithResponsibles' is set, then the list of responsibles is inserted in `ResponsiblesTable'. */
DECLARE @SearchWithResponsibles BIT
DECLARE @ResponsiblesTable table(
	ResponsibleID INT
)

/* If `SearchWithContacts' is set, the the list of contacts we are searching is inserted in `ContactsTable'. */
DECLARE @SearchWithContacts BIT
DECLARE @ContactsTable table (
	ContactID INT
)

DECLARE @ReportsTable table (
	Number INT,
	Synopsis VARCHAR(200),
	LastActivityDate DATETIME,
	Release VARCHAR(50),
	ReportContactID INT,
	PriorityID INT,
	ReportCategoryID INT,
	SeverityID INT,
	StatusID INT,
	ResponsibleID INT,
	Username VARCHAR(50)
)

/* First compute the set of status we are looking for. We are
   given a number and the position of the bits which are set in
   that number will give you the list of StatusID we are looking for. */
INSERT INTO @StatusTable
SELECT StatusID
FROM ProblemReportStatus
WHERE ((POWER(2,StatusID - 1) & @StatusID) = POWER(2,StatusID - 1))

/* Then compute the list of responsibles we are filtering. */
IF @Responsible<>'' OR @ResponsibleFirstName<>'' OR @ResponsibleLastName<>''
	BEGIN
			/* A user name was specified, we are looking for all responsibles matching the request. */
		SET @SearchWithResponsibles=1
		INSERT INTO @ResponsiblesTable
		SELECT Contacts.ContactID
		FROM Contacts
		INNER JOIN Memberships ON Memberships.ContactID = Contacts.ContactID
		WHERE
			((RoleID = 4) OR (RoleID = 2))
			AND ((Username = @Responsible) OR (@Responsible = ''))
			AND ((FirstName = @ResponsibleFirstName) OR (@ResponsibleFirstName = ''))
			AND ((LastName = @ResponsibleLastName) OR (@ResponsibleLastName = ''))
	END
ELSE
	BEGIN
			/* Nothing specified, we will look for all responsibles. */
		SET @SearchWithResponsibles=0
	END

/* Then compute the list of contacts we are filtering. */
If @Username<>'' OR @FirstName<>'' OR @LastName<>''
	BEGIN
			/* A user name was specified, we are looking for all contacts matching the request. */
		SET @SearchWithContacts=1
		INSERT INTO @ContactsTable
		SELECT Contacts.ContactID
		FROM Contacts
		INNER JOIN Memberships ON Memberships.ContactID = Contacts.ContactID
		WHERE
			((Username = @Username) OR (@Username = ''))
			AND ((FirstName = @FirstName) OR (@FirstName = ''))
			AND ((LastName = @LastName) OR (@LastName = ''))
	END
ELSE
	BEGIN
			/* Nothing specified, we will look for all contacts. */
		SET @SearchWithContacts=0
	END

/* Search from `ProblemReports' all matching reports. */
INSERT INTO @ReportsTable
SELECT
	Number, Synopsis, LastActivityDate, Release, ProblemReports.ContactID, PriorityID, ProblemReports.CategoryID, SeverityID, StatusID, ResponsibleID, Username

FROM ProblemReports
	/* Left joing because not all reports have a membership (case of old bug reports) or a responsible */
LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID

WHERE ((ProblemReports.CategoryID =  @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
AND (StatusID IN (SELECT StatusID FROM @StatusTable))
AND ((ProblemReports.PriorityID =  @PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = @PriorityID)))
AND ((ProblemReports.SeverityID =  @SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = @SeverityID)))
AND ((@SearchWithResponsibles = 0) OR (ProblemReportResponsibles.ResponsibleID IN (SELECT ResponsibleID FROM @ResponsiblesTable)))
AND ((@SearchWithContacts = 0) OR (ProblemReports.ContactID IN (SELECT ContactID FROM @ContactsTable)))

SELECT
	Number, Synopsis, SubmissionDate = LastActivityDate, Release, PriorityID, ProblemReportCategories.CategorySynopsis,
	SeverityID, StatusID, Contacts.FirstName, Contacts.LastName, Contacts.Email,
/* Those two are commented because it makes the query much much slower (10s vs just 1s) */
/*	dbo.UserSynopsis(ReportContactID) AS 'DisplayName',*/
/* 	dbo.UserSynopsisFast(Contacts.FirstName, Contacts.LastName, Username) AS 'DisplayName', */
	Username as 'DisplayName',
	ResponsibleID, Username
FROM @ReportsTable
	/* Left joing because not all reports have a membership (case of old bug reports) or a responsible */
LEFT JOIN Contacts ON ReportContactID = Contacts.ContactID
INNER JOIN ProblemReportCategories ON ReportCategoryID = ProblemReportCategories.CategoryID
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForEdition2_old]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[GetProblemReportsForEdition2_old]

@Username VARCHAR(50),
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Responsible VARCHAR(50),
@ResponsibleFirstName VARCHAR(50),
@ResponsibleLastName VARCHAR(50),
@CategoryID INT,
@StatusID INT,
@PriorityID INT,
@SeverityID INT

AS
DECLARE @StatusTable table(
	StatusID INT
)

DECLARE @ResponsiblesTable table(
	ResponsibleID INT
)

INSERT INTO @StatusTable
SELECT StatusID
FROM ProblemReportStatus
WHERE ((POWER(2,StatusID - 1) & @StatusID) = POWER(2,StatusID - 1))

DECLARE @SearchWithResponsible BIT
IF @Responsible<>'' OR @ResponsibleFirstName<>'' OR @ResponsibleLastName<>''
BEGIN
	SET @SearchWithResponsible=1
	INSERT INTO @ResponsiblesTable
	SELECT Contacts.ContactID
	FROM Contacts
	INNER JOIN Memberships ON Memberships.ContactID = Contacts.ContactID
	WHERE ((RoleID = 4) OR (RoleID = 2))
	AND ((Username = @Responsible) OR (@Responsible = ''))
	AND ((FirstName = @ResponsibleFirstName) OR (@ResponsibleFirstName = ''))
	AND ((LastName = @ResponsibleLastName) OR (@ResponsibleLastName = ''))
END
ELSE
BEGIN
	SET @SearchWithResponsible=0
END

SELECT
	ProblemReports.Number, ProblemReports.Synopsis, SubmissionDate = ProblemReports.LastActivityDate,
	ProblemReports.Release, ProblemReports.PriorityID,
	ProblemReportCategories.CategorySynopsis, ProblemReports.SeverityID,
	ProblemReports.StatusID, Contacts.FirstName, Contacts.LastName, Contacts.Email,
/*	dbo.UserSynopsis(Contacts.ContactID) AS 'DisplayName',*/
	Memberships.Username AS 'DisplayName',
	ProblemReportResponsibles.ResponsibleID, Memberships.Username AS 'Username'

FROM ProblemReports
LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
LEFT JOIN Contacts ON ProblemReports.ContactID = Contacts.ContactID
LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID
LEFT JOIN LastActivityDates ON LastActivityDates.ReportID = ProblemReports.ReportID


WHERE ((ProblemReports.CategoryID =  @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
AND (ProblemReports.StatusID IN (SELECT StatusID FROM @StatusTable))
AND ((ProblemReports.PriorityID =  @PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = @PriorityID)))
AND ((ProblemReports.SeverityID =  @SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = @SeverityID)))
AND ((Memberships.Username = @Username) OR (@Username = ''))
AND ((Contacts.FirstName = @FirstName) OR (@FirstName = ''))
AND ((Contacts.LastName = @LastName) OR (@LastName = ''))
AND ((@SearchWithResponsible = 0) OR (ProblemReportResponsibles.ResponsibleID IN (SELECT ResponsibleID FROM @ResponsiblesTable)))
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForEdition3]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProblemReportsForEdition3]
@Username VARCHAR(50),
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Responsible VARCHAR(50),
@ResponsibleFirstName VARCHAR(50),
@ResponsibleLastName VARCHAR(50),
@CategoryID INT,
@StatusID INT,
@PriorityID INT,
@SeverityID INT

AS


DECLARE @StatusTable table(
	StatusID INT
)

/* If `SearchWithResponsibles' is set, then the list of responsibles is inserted in `ResponsiblesTable'. */
DECLARE @SearchWithResponsibles BIT
DECLARE @ResponsiblesTable table(
	ResponsibleID INT
)

/* If `SearchWithContacts' is set, the the list of contacts we are searching is inserted in `ContactsTable'. */
DECLARE @SearchWithContacts BIT
DECLARE @ContactsTable table (
	ContactID INT
)

DECLARE @ReportsTable table (
	Number INT,
	Synopsis VARCHAR(200),
	LastActivityDate DATETIME,
	Release VARCHAR(50),
	ReportContactID INT,
	PriorityID INT,
	ReportCategoryID INT,
	SeverityID INT,
	StatusID INT,
	ResponsibleID INT,
	Username VARCHAR(50)
)

/* First compute the set of status we are looking for. We are
   given a number and the position of the bits which are set in
   that number will give you the list of StatusID we are looking for. */
INSERT INTO @StatusTable
SELECT StatusID
FROM ProblemReportStatus
WHERE ((POWER(2,StatusID - 1) & @StatusID) = POWER(2,StatusID - 1))

/* Then compute the list of responsibles we are filtering. */
IF @Responsible<>'' OR @ResponsibleFirstName<>'' OR @ResponsibleLastName<>''
	BEGIN
			/* A user name was specified, we are looking for all responsibles matching the request. */
		SET @SearchWithResponsibles=1
		INSERT INTO @ResponsiblesTable
		SELECT Contacts.ContactID
		FROM Contacts
		INNER JOIN Memberships ON Memberships.ContactID = Contacts.ContactID
		WHERE
			((RoleID = 4) OR (RoleID = 2))
			AND ((Username = @Responsible) OR (@Responsible = ''))
			AND ((FirstName = @ResponsibleFirstName) OR (@ResponsibleFirstName = ''))
			AND ((LastName = @ResponsibleLastName) OR (@ResponsibleLastName = ''))
	END
ELSE
	BEGIN
			/* Nothing specified, we will look for all responsibles. */
		SET @SearchWithResponsibles=0
	END

/* Then compute the list of contacts we are filtering. */
If @Username<>'' OR @FirstName<>'' OR @LastName<>''
	BEGIN
			/* A user name was specified, we are looking for all contacts matching the request. */
		SET @SearchWithContacts=1
		INSERT INTO @ContactsTable
		SELECT Contacts.ContactID
		FROM Contacts
		INNER JOIN Memberships ON Memberships.ContactID = Contacts.ContactID
		WHERE
			((Username = @Username) OR (@Username = ''))
			AND ((FirstName = @FirstName) OR (@FirstName = ''))
			AND ((LastName = @LastName) OR (@LastName = ''))
	END
ELSE
	BEGIN
			/* Nothing specified, we will look for all contacts. */
		SET @SearchWithContacts=0
	END

/* Search from `ProblemReports' all matching reports. */
INSERT INTO @ReportsTable
SELECT
	Number, Synopsis, LastActivityDate, Release, ProblemReports.ContactID, PriorityID, ProblemReports.CategoryID, SeverityID, StatusID, ResponsibleID, Username

FROM ProblemReports
	/* Left joing because not all reports have a membership (case of old bug reports) or a responsible */
LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID

WHERE ((ProblemReports.CategoryID =  @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
AND (StatusID IN (SELECT StatusID FROM @StatusTable))
AND ((ProblemReports.PriorityID =  @PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = @PriorityID)))
AND ((ProblemReports.SeverityID =  @SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = @SeverityID)))
AND ((@SearchWithResponsibles = 0) OR (ProblemReportResponsibles.ResponsibleID IN (SELECT ResponsibleID FROM @ResponsiblesTable)))
AND ((@SearchWithContacts = 0) OR (ProblemReports.ContactID IN (SELECT ContactID FROM @ContactsTable)))

SELECT
	Number, Synopsis, SubmissionDate = LastActivityDate, Release, PriorityID, ProblemReportCategories.CategorySynopsis,
	SeverityID, StatusID, Contacts.FirstName, Contacts.LastName, Contacts.Email,
/*	dbo.UserSynopsis(ReportContactID) AS 'DisplayName',*/
	dbo.UserSynopsisFast(Contacts.FirstName, Contacts.LastName, Username) AS 'DisplayName',
/*	Username as 'DisplayName',*/
	ResponsibleID, Username
FROM @ReportsTable
	/* Left joing because not all reports have a membership (case of old bug reports) or a responsible */
LEFT JOIN Contacts ON ReportContactID = Contacts.ContactID
INNER JOIN ProblemReportCategories ON ReportCategoryID = ProblemReportCategories.CategoryID
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForSearch]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetProblemReportsForSearch]

@Username NVARCHAR(50),
@LastName NVARCHAR(50),
@FirstName NVARCHAR(50),
@SearchText NVARCHAR(250),
@SearchSynopsis BIT,
@SearchDescription BIT,
@CategoryID INT,
@StatusID INT,
@PriorityID INT,
@SeverityID INT

AS

DECLARE @StatusTable table(
	StatusID INT
)

DECLARE @Temp table(
	Number INT,
	Synopsis VARCHAR(200),
	SubmissionDate DATETIME,
	Release VARCHAR(50),
	PrioritySynopsis VARCHAR(50),
	CategorySynopsis VARCHAR(50),
	SeveritySynopsis VARCHAR(50),
	StatusSynopsis VARCHAR(50),
	Username VARCHAR(50)
)

DECLARE @Temp2 table(
	Number INT,
	Synopsis VARCHAR(200),
	SubmissionDate DATETIME,
	Release VARCHAR(50),
	PrioritySynopsis VARCHAR(50),
	CategorySynopsis VARCHAR(50),
	SeveritySynopsis VARCHAR(50),
	StatusSynopsis VARCHAR(50),
	Username VARCHAR(50)
)

DECLARE @Temp3 table(
	Number INT,
	Synopsis VARCHAR(200),
	SubmissionDate DATETIME,
	Release VARCHAR(50),
	PrioritySynopsis VARCHAR(50),
	CategorySynopsis VARCHAR(50),
	SeveritySynopsis VARCHAR(50),
	StatusSynopsis VARCHAR(50),
	Description NTEXT,
	Username VARCHAR(50)
)

INSERT INTO @StatusTable
SELECT StatusID
FROM ProblemReportStatus
WHERE (@StatusID = 0) OR ((POWER(2,StatusID - 1) & @StatusID) = POWER(2,StatusID - 1))

INSERT INTO @Temp3
SELECT ProblemReports.Number, ProblemReports.Synopsis, ProblemReports.SubmissionDate,
	 ProblemReports.Release, ProblemReportPriorities.PrioritySynopsis,
	 ProblemReportCategories.CategorySynopsis, ProblemReportSeverities.SeveritySynopsis,
	 ProblemReportStatus.StatusSynopsis, ProblemReports.Description, dbo.UserSynopsis(Contacts.ContactID) AS 'Username'

FROM ProblemReports
LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
INNER JOIN ProblemReportStatus ON ProblemReports.StatusID = ProblemReportStatus.StatusID
INNER JOIN ProblemReportPriorities ON ProblemReports.PriorityID = ProblemReportPriorities.PriorityID
INNER JOIN ProblemReportSeverities ON ProblemReports.SeverityID = ProblemReportSeverities.SeverityID
LEFT JOIN Contacts ON Contacts.ContactID = ProblemReports.ContactID

WHERE ((Username = @Username) OR (@Username = ''))
AND ((ProblemReports.CategoryID =  @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
AND (ProblemReports.StatusID IN (SELECT StatusID FROM @StatusTable))
AND ((ProblemReports.PriorityID =  @PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = @PriorityID)))
AND ((ProblemReports.SeverityID =  @SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = @SeverityID)))
AND ((Contacts.FirstName = @FirstName) OR (@FirstName = ''))
AND ((Contacts.LastName = @LastName) OR (@LastName = ''))

IF @SearchSynopsis = 1
BEGIN
	INSERT INTO @Temp
	SELECT Number, Synopsis, SubmissionDate, Release, PrioritySynopsis,
		 CategorySynopsis, SeveritySynopsis, StatusSynopsis, Username
	FROM @Temp3
	WHERE Synopsis LIKE @SearchText
END

IF @SearchDescription = 1
BEGIN
	INSERT INTO @Temp2
	SELECT Number, Synopsis, SubmissionDate, Release, PrioritySynopsis,
		 CategorySynopsis, SeveritySynopsis, StatusSynopsis, Username
	FROM @Temp3
	WHERE Description LIKE @SearchText
END

SELECT * FROM @Temp
UNION 
SELECT * FROM @Temp2



GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForSearch2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetProblemReportsForSearch2]

@Username NVARCHAR(50),
@FirstName NVARCHAR(50),
@LastName NVARCHAR(50),
@Responsible NVARCHAR(50),
@ResponsibleFirstName NVARCHAR(50),
@ResponsibleLastName NVARCHAR(50),
@SearchText NVARCHAR(250),
@SearchSynopsis BIT,
@SearchDescription BIT,
@CategoryID INT,
@StatusID INT,
@PriorityID INT,
@SeverityID INT

AS
DECLARE @StatusTable table(
	StatusID INT
)

DECLARE @ResponsiblesTable table(
	ResponsibleID INT
)

DECLARE @Temp table(
	Number INT,
	Synopsis VARCHAR(200),
	SubmissionDate DATETIME,
	Release VARCHAR(50),
	PriorityID INT,
	CategorySynopsis VARCHAR(50),
	SeverityID INT,
	StatusID INT,
	DisplayName VARCHAR(50),
	ResponsibleID INT,
	Username VARCHAR(50)
)

DECLARE @Temp2 table(
	Number INT,
	Synopsis VARCHAR(200),
	SubmissionDate DATETIME,
	Release VARCHAR(50),
	PriorityID INT,
	CategorySynopsis VARCHAR(50),
	SeverityID INT,
	StatusID INT,
	DisplayName VARCHAR(50),
	ResponsibleID INT,
	Username VARCHAR(50)
)

DECLARE @Temp3 table(
	Number INT,
	Synopsis VARCHAR(200),
	SubmissionDate DATETIME,
	Release VARCHAR(50),
	PriorityID INT,
	CategorySynopsis VARCHAR(50),
	SeverityID INT,
	StatusID INT,
	Description NTEXT,
	DisplayName VARCHAR(50),
	ResponsibleID INT,
	Username VARCHAR(50)
)

INSERT INTO @StatusTable
SELECT StatusID
FROM ProblemReportStatus
WHERE (@StatusID = 0) OR ((POWER(2,StatusID - 1) & @StatusID) = POWER(2,StatusID - 1))

DECLARE @SearchWithResponsible BIT
IF @Responsible<>'' OR @ResponsibleFirstName<>'' OR @ResponsibleLastName<>''
BEGIN
	SET @SearchWithResponsible=1
	INSERT INTO @ResponsiblesTable
	SELECT Contacts.ContactID
	FROM Contacts
	INNER JOIN Memberships ON Memberships.ContactID = Contacts.ContactID
	WHERE ((RoleID = 4) OR (RoleID = 2))
	AND ((Username = @Responsible) OR (@Responsible = ''))
	AND ((FirstName = @ResponsibleFirstName) OR (@ResponsibleFirstName = ''))
	AND ((LastName = @ResponsibleLastName) OR (@ResponsibleLastName = ''))
END
ELSE
BEGIN
	SET @SearchWithResponsible=0
END

INSERT INTO @Temp3
SELECT ProblemReports.Number, ProblemReports.Synopsis, SubmissionDate = ProblemReports.LastActivityDate,
	 ProblemReports.Release, ProblemReports.PriorityID,
	 ProblemReportCategories.CategorySynopsis, ProblemReports.SeverityID,
	 ProblemReports.StatusID, ProblemReports.Description,
/* This query is way too slow, we are just displaying the username. */
/*	dbo.UserSynopsis(Contacts.ContactID) AS 'DisplayName',*/
	Memberships.Username as 'DisplayName',
	 ProblemReportResponsibles.ResponsibleID, Memberships.Username

FROM ProblemReports
INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
LEFT JOIN Contacts ON Contacts.ContactID = ProblemReports.ContactID
LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID
LEFT JOIN LastActivityDates ON LastActivityDates.ReportID = ProblemReports.ReportID

WHERE ((Username = @Username) OR (@Username = ''))
AND ((ProblemReports.CategoryID =  @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
AND (ProblemReports.StatusID IN (SELECT StatusID FROM @StatusTable))
AND ((ProblemReports.PriorityID =  @PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = @PriorityID)))
AND ((ProblemReports.SeverityID =  @SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = @SeverityID)))
AND ((Contacts.FirstName = @FirstName) OR (@FirstName = ''))
AND ((Contacts.LastName = @LastName) OR (@LastName = ''))
AND ((@SearchWithResponsible = 0) OR (ProblemReportResponsibles.ResponsibleID IN (SELECT ResponsibleID FROM @ResponsiblesTable)))

IF @SearchSynopsis = 1
BEGIN
	INSERT INTO @Temp
	SELECT Number, Synopsis, SubmissionDate, Release, PriorityID, CategorySynopsis,
		   SeverityID, StatusID, DisplayName, ResponsibleID, Username
	FROM @Temp3
	WHERE Synopsis LIKE @SearchText
END

IF @SearchDescription = 1
BEGIN
	INSERT INTO @Temp2
	SELECT Number, Synopsis, SubmissionDate, Release, PriorityID, CategorySynopsis,
		   SeverityID, StatusID, DisplayName, ResponsibleID, Username
	FROM @Temp3
	WHERE Description LIKE @SearchText
END

SELECT * FROM @Temp
UNION 
SELECT * FROM @Temp2
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsGuest]    Script Date: 08/04/2014 15:02:37 ******/
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
    @PageNumber INT,
	@CategoryID INT,
	@StatusID INT
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
    WHERE Confidential = 0 AND ((ProblemReports.CategoryID = @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
		AND ((ProblemReports.StatusID = @StatusID) OR (NOT EXISTS (SELECT StatusID FROM ProblemReportStatus WHERE (StatusID = @StatusID))))
	ORDER BY Number DESC
	) AS PAG
	INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = PAG.CategoryID 
	ORDER BY Number ASC
) AS PAG2
INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = PAG2.CategoryID 
ORDER BY Number DESC

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsGuest2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProblemReportsGuest2]
	@RowsPerPage INT , 
    @PageNumber INT,
	@CategoryID INT,
	@StatusID INT,
	@Column VARCHAR (30),
	@Order INT
AS
IF @Order = 1
BEGIN
	SELECT Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID
	 FROM (
		SELECT TOP (@RowsPerPage)
		   Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate , StatusID, PAG.CategoryID
		FROM (
		SELECT TOP ((@PageNumber)*@RowsPerPage) 
		Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID, ProblemReports.CategoryID
		FROM ProblemReports
		INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID 
		WHERE Confidential = 0 AND ((ProblemReports.CategoryID = @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
			AND ((ProblemReports.StatusID = @StatusID) OR (NOT EXISTS (SELECT StatusID FROM ProblemReportStatus WHERE (StatusID = @StatusID))))
		ORDER BY  
		   CASE
				WHEN @Column='number' THEN Number 
				wHEN @Column='synopsis' THEN ProblemReports.Synopsis
				WHEN @Column='category' THEN ProblemReportCategories.CategorySynopsis 
				WHEN @Column='date' THEN SubmissionDate 
				WHEN @Column='status' THEN StatusID
				ELSE Number 
		   END 	
		DESC
		) AS PAG
		INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = PAG.CategoryID 
		ORDER BY 
		   CASE
				WHEN @Column='number' THEN Number 
				wHEN @Column='synopsis' THEN PAG.Synopsis
				WHEN @Column='category' THEN ProblemReportCategories.CategorySynopsis 
				WHEN @Column='date' THEN SubmissionDate 
				WHEN @Column='status' THEN StatusID
				ELSE Number 
		   END
		 ASC
	) AS PAG2
	INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = PAG2.CategoryID 
	ORDER BY 
		   CASE
				WHEN @Column='number' THEN Number 
				wHEN @Column='synopsis' THEN pag2.Synopsis
				WHEN @Column='category' THEN ProblemReportCategories.CategorySynopsis 
				WHEN @Column='date' THEN SubmissionDate 
				WHEN @Column='status' THEN StatusID
				ELSE Number 
		   END	
		  DESC
END
ELSE
BEGIN
	SELECT Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID
	 FROM (
		SELECT TOP (@RowsPerPage)
		   Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID, PAG.CategoryID
		FROM (
		SELECT TOP ((@PageNumber)*@RowsPerPage) 
		Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID, ProblemReports.CategoryID
		FROM ProblemReports
		INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID 
		WHERE Confidential = 0 AND ((ProblemReports.CategoryID = @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
			AND ((ProblemReports.StatusID = @StatusID) OR (NOT EXISTS (SELECT StatusID FROM ProblemReportStatus WHERE (StatusID = @StatusID))))
		ORDER BY   
			CASE
				WHEN @Column='number' THEN Number 
				wHEN @Column='synopsis' THEN Synopsis
				WHEN @Column='category' THEN ProblemReportCategories.CategorySynopsis 
				WHEN @Column='date' THEN SubmissionDate 
				WHEN @Column='status' THEN StatusID
				ELSE Number 
		   END
		ASC
		) AS PAG
		INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = PAG.CategoryID 
		ORDER BY  
		    CASE
				WHEN @Column='number' THEN Number 
				wHEN @Column='synopsis' THEN Synopsis
				WHEN @Column='category' THEN ProblemReportCategories.CategorySynopsis 
				WHEN @Column='date' THEN SubmissionDate 
				WHEN @Column='status' THEN StatusID
				ELSE Number 
		   END 	
		DESC
	) AS PAG2
	INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = PAG2.CategoryID 
	ORDER BY  
		  CASE
				WHEN @Column='number' THEN Number 
				wHEN @Column='synopsis' THEN Synopsis
				WHEN @Column='category' THEN ProblemReportCategories.CategorySynopsis 
				WHEN @Column='date' THEN SubmissionDate 
				WHEN @Column='status' THEN StatusID
				ELSE Number 
		   END
	ASC
END
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsHistory]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[GetProblemReportsHistory]
	@Username VARCHAR(50),
	@SubmitterUsername VARCHAR(50),
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@Responsible VARCHAR(50),
	@ResponsibleFirstName VARCHAR(50),
	@ResponsibleLastName VARCHAR(50),
	@CategoryID INT,
	@StatusID INT,
	@PriorityID INT,
	@SeverityID INT
AS
BEGIN
	DECLARE @StatusTable TABLE(
		StatusID INT
	)

	DECLARE @ResponsiblesTable table(
		ResponsibleID INT
	)

	DECLARE @ProblemReports TABLE(
		ReportID INT,
		SubmissionDate DATETIME
	)

	INSERT INTO @StatusTable
	SELECT StatusID
	FROM ProblemReportStatus
	WHERE ((POWER(2,StatusID - 1) & @StatusID) = POWER(2,StatusID - 1))

	DECLARE @SearchWithResponsible BIT
	IF @Responsible<>'' OR @ResponsibleFirstName<>'' OR @ResponsibleLastName<>''
	BEGIN
		SET @SearchWithResponsible=1
		INSERT INTO @ResponsiblesTable
		SELECT Contacts.ContactID
		FROM Contacts
		INNER JOIN Memberships ON Memberships.ContactID = Contacts.ContactID
		WHERE ((RoleID = 4) OR (RoleID = 2))
		AND ((Username = @Responsible) OR (@Responsible = ''))
		AND ((FirstName = @ResponsibleFirstName) OR (@ResponsibleFirstName = ''))
		AND ((LastName = @ResponsibleLastName) OR (@ResponsibleLastName = ''))
	END
	ELSE
	BEGIN
		SET @SearchWithResponsible=0
	END

	INSERT INTO @ProblemReports
	SELECT ProblemReportInteractions.ReportID, SubmissionDate = MAX(ProblemReportInteractions.InteractionDate)
	FROM ProblemReportInteractions
	INNER JOIN ProblemReports ON ProblemReportInteractions.ReportID = ProblemReports.ReportID
	LEFT JOIN Contacts ON ProblemReports.ContactID = Contacts.ContactID
	LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID
	LEFT JOIN Memberships AS SubmitterMemberships ON ProblemReports.ContactID = SubmitterMemberships.ContactID
	LEFT JOIN Memberships ON ProblemReportInteractions.ContactID = Memberships.ContactID
	WHERE ((ProblemReports.CategoryID =  @CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = @CategoryID)))
	AND (ProblemReports.StatusID IN (SELECT StatusID FROM @StatusTable))
	AND ((ProblemReports.PriorityID =  @PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = @PriorityID)))
	AND ((ProblemReports.SeverityID =  @SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = @SeverityID)))
	AND (Memberships.Username = @Username)
	AND ((SubmitterMemberships.Username = @SubmitterUsername) OR (@SubmitterUsername = ''))
	AND ((Contacts.FirstName = @FirstName) OR (@FirstName = ''))
	AND ((Contacts.LastName = @LastName) OR (@LastName = ''))
	AND ((@SearchWithResponsible = 0) OR (ProblemReportResponsibles.ResponsibleID IN (SELECT ResponsibleID FROM @ResponsiblesTable)))
	GROUP BY ProblemReportInteractions.ReportID

	SELECT ProblemReports.Number, ProblemReports.Synopsis, FilteredProblemReports.SubmissionDate,
		 ProblemReports.Release, ProblemReports.PriorityID,
		 ProblemReportCategories.CategorySynopsis, ProblemReports.SeverityID,
		 ProblemReports.StatusID, Contacts.FirstName, Contacts.LastName, Contacts.Email,
		 dbo.UserSynopsis(Contacts.ContactID) AS 'DisplayName',
		 ProblemReportResponsibles.ResponsibleID, Memberships.Username
	FROM @ProblemReports AS FilteredProblemReports
	INNER JOIN ProblemReports ON FilteredProblemReports.ReportID = ProblemReports.ReportID
	INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
	INNER JOIN Contacts ON Contacts.ContactID = ProblemReports.ContactID
	LEFT JOIN Memberships ON Memberships.ContactID = ProblemReports.ContactID
	LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID

	ORDER BY Number

	END




GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsRowCountGuest]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportStatus]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportStatus]

AS

SELECT * 
FROM ProblemReportStatus

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportSubscribedCategories]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportSubscribedCategories]

@Username NVARCHAR(50)

AS

DECLARE @Categories TABLE(
	CategoryID INT
)

INSERT INTO @Categories

SELECT ProblemReportResponsiblesCategories.CategoryID

FROM ProblemReportResponsiblesCategories
INNER JOIN ProblemReportCategories ON ProblemReportResponsiblesCategories.CategoryID = ProblemReportCategories.CategoryID
INNER JOIN Memberships ON Memberships.ContactID = ProblemReportResponsiblesCategories.ContactID
INNER JOIN ProblemReportCategoriesRoles ON ProblemReportCategoriesRoles.CategoryID = ProblemReportCategories.CategoryID

WHERE Username = @Username
AND ProblemReportCategoriesRoles.RoleID = (SELECT RoleID FROM Memberships WHERE Username=@Username)

SELECT ProblemReportCategories.CategoryID, CategorySynopsis, ISNULL ((SELECT COUNT(*) FROM @Categories AS A WHERE A.CategoryID = ProblemReportCategories.CategoryID), 0) AS Subscribed

FROM ProblemReportCategories
INNER JOIN ProblemReportCategoriesRoles ON ProblemReportCategoriesRoles.CategoryID = ProblemReportCategories.CategoryID

WHERE IsActive = 1
AND ProblemReportCategoriesRoles.RoleID = (SELECT RoleID FROM Memberships WHERE Username=@Username)

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportSubscribedCategories2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetProblemReportSubscribedCategories2]

@Username NVARCHAR(50)

AS

DECLARE @Categories TABLE(
	CategoryID INT
)

INSERT INTO @Categories

SELECT ProblemReportCategoriesSubscribers.CategoryID

FROM ProblemReportCategoriesSubscribers
INNER JOIN ProblemReportCategories ON ProblemReportCategoriesSubscribers.CategoryID = ProblemReportCategories.CategoryID
INNER JOIN Memberships ON Memberships.ContactID = ProblemReportCategoriesSubscribers.ContactID
INNER JOIN ProblemReportCategoriesRoles ON ProblemReportCategoriesRoles.CategoryID = ProblemReportCategories.CategoryID

WHERE Username = @Username
AND ProblemReportCategoriesRoles.RoleID = (SELECT RoleID FROM Memberships WHERE Username=@Username)

SELECT ProblemReportCategories.CategoryID, CategorySynopsis, ISNULL ((SELECT COUNT(*) FROM @Categories AS A WHERE A.CategoryID = ProblemReportCategories.CategoryID), 0) AS Subscribed

FROM ProblemReportCategories
INNER JOIN ProblemReportCategoriesRoles ON ProblemReportCategoriesRoles.CategoryID = ProblemReportCategories.CategoryID

WHERE IsActive = 1
AND ProblemReportCategoriesRoles.RoleID = (SELECT RoleID FROM Memberships WHERE Username=@Username)


GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporary]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GetProblemReportTemporary]

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
		Username

FROM ProblemReportsTemporary
INNER JOIN ProblemReportPriorities ON ProblemReportPriorities.PriorityID = ProblemReportsTemporary.PriorityID
INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReportsTemporary.CategoryID
INNER JOIN ProblemReportSeverities ON ProblemReportSeverities.SeverityID = ProblemReportsTemporary.SeverityID
INNER JOIN ProblemReportClasses ON ProblemReportClasses.ClassID = ProblemReportsTemporary.ClassID
INNER JOIN Memberships ON Memberships.ContactID = ProblemReportsTemporary.ContactID

WHERE ReportID = @ReportID

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporary2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetProblemReportTemporary2]

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
-- INNER JOIN ProblemReportDefaultCategoriesResponsibles ON ProblemReportDefaultCategoriesResponsibles.CategoryID = ProblemReportsTemporary.CategoryID
LEFT JOIN ProblemReportDefaultCategoriesResponsibles ON ProblemReportDefaultCategoriesResponsibles.CategoryID = ProblemReportsTemporary.CategoryID
WHERE ProblemReportsTemporary.ReportID = @ReportID





GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryInteraction]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportTemporaryInteraction]

@InteractionID INT

AS
SELECT Content, (SELECT Username FROM Memberships WHERE Memberships.ContactID = ProblemReportTemporaryInteractions.ContactID), (SELECT StatusSynopsis FROM ProblemReportStatus WHERE ProblemReportStatus.StatusID = ProblemReportTemporaryInteractions.NewStatusID), Private

FROM ProblemReportTemporaryInteractions

WHERE InteractionID = @InteractionID

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryInteractionAttachmentsHeaders]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GetProblemReportTemporaryInteractionAttachmentsHeaders]

@InteractionID INT

AS

SELECT AttachmentID, [FileName], Length
FROM ProblemReportTemporaryInteractionAttachments
WHERE InteractionID = @InteractionID

GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryReportAttachments]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProblemReportTemporaryReportAttachments]

@ReportID INT

AS

SELECT AttachmentID, Length, [FileName]
FROM ProblemReportTemporaryReportAttachments
WHERE ReportID = @ReportID

GO
/****** Object:  StoredProcedure [dbo].[GetQuestionFromEmail]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetQuestionFromEmail]

@EMail VARCHAR(100)

AS

SELECT Question
FROM Contacts
INNER JOIN Memberships ON Contacts.ContactID = Memberships.ContactID
INNER JOIN SecurityQuestions ON Memberships.QuestionID = SecurityQuestions.QuestionID
WHERE EMail = @EMail






GO
/****** Object:  StoredProcedure [dbo].[GetRegistrationToken]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE
[dbo].[GetRegistrationToken]

@EMail VARCHAR(100)

AS

SELECT RegistrationToken
FROM Registrations
WHERE EMail = @EMail






GO
/****** Object:  StoredProcedure [dbo].[GetRegistrationTokenFromEmail]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetRegistrationTokenFromEmail]

@EMail VARCHAR(100)

AS

SELECT RegistrationToken
FROM Registrations
WHERE EMail = @Email






GO
/****** Object:  StoredProcedure [dbo].[GetRegistrationTokenFromUsername]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetRegistrationTokenFromUsername]

@Username VARCHAR(50)

AS

SELECT RegistrationToken
FROM Registrations
WHERE Username = @Username






GO
/****** Object:  StoredProcedure [dbo].[GetReportProblemInteractionsGuest]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[GetRole]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[GetRole]

@Username VARCHAR(50)

AS

SELECT RoleSynopsis
FROM Roles
WHERE RoleID = (SELECT RoleID FROM Memberships WHERE Username=@Username)





GO
/****** Object:  StoredProcedure [dbo].[GetRoleDescription]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[GetRoleDescription]

@Synopsis VARCHAR(50)

AS

SELECT RoleDescription
FROM Roles
WHERE RoleSynopsis = @Synopsis





GO
/****** Object:  StoredProcedure [dbo].[GetRolesForEdition]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[GetRolesForEdition]

AS

SELECT RoleID, RoleSynopsis

FROM Roles





GO
/****** Object:  StoredProcedure [dbo].[GetSecurityQuestions]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[GetSecurityQuestions]

AS

SELECT *
FROM SecurityQuestions






GO
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[GetUser]

@Username VARCHAR(50)

 AS

DECLARE @ContactID int

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username
IF @ContactID <> NULL
	SELECT FirstName, LastName, EMail FROM Contacts WHERE ContactID = @ContactID






GO
/****** Object:  StoredProcedure [dbo].[GetUserAnswerSalt]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[GetUserAnswerSalt]

@EMail VARCHAR(100)

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID
FROM Contacts
WHERE Email = @EMail

SELECT AnswerSalt
FROM Memberships
WHERE ContactID = @ContactID






GO
/****** Object:  StoredProcedure [dbo].[GetUserCreationDate]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserCreationDate]

@Username VARCHAR(50)

AS

SELECT CreationDate
FROM Memberships
WHERE Username = @Username

GO
/****** Object:  StoredProcedure [dbo].[GetUserFromEmail]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetUserFromEmail]

@EMail VARCHAR(100)

AS

SELECT Contacts.FirstName, Contacts.LastName, Memberships.Username
FROM Contacts
INNER JOIN Memberships ON Contacts.ContactID = Memberships.ContactID
WHERE EMail = @EMail






GO
/****** Object:  StoredProcedure [dbo].[GetUserInformation]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserInformation]

@Username VARCHAR(50)

AS

DECLARE @ContactID INT
DECLARE @Region VARCHAR(100)
DECLARE @Country VARCHAR(100)
DECLARE @OrganizationRegion VARCHAR(100)
DECLARE @OrganizationCountry VARCHAR(100)

SELECT @ContactID = ContactID
FROM Memberships
WHERE Username = @Username

SELECT @Region = Region
FROM Regions
WHERE RegionID = (SELECT RegionID FROM Contacts WHERE ContactID = @ContactID)

SELECT @Country = Country
FROM Countries
WHERE CountryID = (SELECT CountryID FROM Contacts WHERE ContactID = @ContactID)

SELECT @OrganizationRegion = Region
FROM Regions
WHERE RegionID = (SELECT OrganizationRegionID FROM Contacts WHERE ContactID = @ContactID)

SELECT @OrganizationCountry = Country
FROM Countries
WHERE CountryID = (SELECT OrganizationCountryID FROM Contacts WHERE ContactID = @ContactID)

SELECT FirstName, LastName, EMail, Address, City, @Region AS Region,
               PostalCode, @Country AS Country, Phone, Fax, Position, OrganizationName,
               OrganizationEmail, OrganizationURL, OrganizationAddress, OrganizationCity,
               @OrganizationRegion As OrganizationRegion, OrganizationPostalCode, @OrganizationCountry AS OrganizationCountry,
	 OrganizationPhone, OrganizationFax
FROM Contacts
WHERE ContactID = @ContactID

GO
/****** Object:  StoredProcedure [dbo].[GetUserPasswordSalt]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[GetUserPasswordSalt]

@Username VARCHAR(50)

AS

SELECT PasswordSalt
FROM Memberships
WHERE Username = @Username






GO
/****** Object:  StoredProcedure [dbo].[InitializeInteraction]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InitializeInteraction]

@InteractionID	INT,
@Content	TEXT,
@StatusID	INT

AS
DECLARE @NewStatusID INT

IF @StatusID > 0
BEGIN
	SET @NewStatusID = @StatusID
END
ELSE
BEGIN
	SET @NewStatusID = NULL
END

UPDATE ProblemReportTemporaryInteractions
SET Content = @Content, NewStatusID = @NewStatusID
WHERE InteractionID = @InteractionID


GO
/****** Object:  StoredProcedure [dbo].[InitializeInteraction2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InitializeInteraction2]

@InteractionID	INT,
@Content	TEXT,
@StatusID	INT,
@Private	BIT

AS
DECLARE @NewStatusID INT

IF @StatusID > 0
BEGIN
	SET @NewStatusID = @StatusID
END
ELSE
BEGIN
	SET @NewStatusID = NULL
END

UPDATE ProblemReportTemporaryInteractions
SET Content = @Content, NewStatusID = @NewStatusID, Private = @Private
WHERE InteractionID = @InteractionID


GO
/****** Object:  StoredProcedure [dbo].[InitializeProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InitializeProblemReport]

@ReportID	INT,
@PriorityID	INT,
@SeverityID	INT,
@CategoryID	INT,
@ClassID	INT,
@Confidential	BIT,
@Synopsis	VARCHAR(100),
@Release	VARCHAR(50),
@Environment	VARCHAR(200),
@Description	TEXT,
@ToReproduce	TEXT

 AS

UPDATE ProblemReportsTemporary SET
	PriorityID = @PriorityID,
	SeverityID = @SeverityID,
	CategoryID = @CategoryID,
	ClassID = @ClassID,
	Confidential = @Confidential,
	Synopsis = @Synopsis,
	Release = @Release,
	Environment = @Environment,
	[Description] = @Description,
	ToReproduce = @ToReproduce

WHERE ReportID = @ReportID

GO
/****** Object:  StoredProcedure [dbo].[IsMemberhipActive]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[IsMemberhipActive]

@Username NVARCHAR(50)

AS

SELECT IsActive
FROM Memberships
WHERE Username = @Username





GO
/****** Object:  StoredProcedure [dbo].[IsMembershipActive]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsMembershipActive]
	@Username VARCHAR(50)
AS
BEGIN
	SELECT IsActive
	FROM Memberships
	WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionAttachmentVisible]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[IsProblemReportInteractionAttachmentVisible]

@Username VARCHAR(50),
@AttachmentID INT

AS

DECLARE @InteractionID INT

SELECT @InteractionID = InteractionID
FROM ProblemReportInteractionAttachments
WHERE AttachmentID = @AttachmentID

EXEC IsProblemReportInteractionVisible @Username, @InteractionID

GO
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionAttachmentVisibleGuest]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionVisible]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[IsProblemReportInteractionVisible]

@Username VARCHAR(50),
@InteractionID INT

AS

DECLARE @Number INT

SELECT @Number = Number
FROM ProblemReports
WHERE ProblemReports.ReportID = (SELECT ReportID FROM ProblemReportInteractions WHERE InteractionID = @InteractionID)

EXEC IsProblemReportVisible @Username, @Number

GO
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionVisibleGuest]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[IsProblemReportVisible]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsProblemReportVisible]

@Username VARCHAR(50),
@Number INT

AS

DECLARE @ContactID INT
DECLARE @RoleID INT
DECLARE @Count INT

SELECT @RoleID = RoleID
FROM Memberships
WHERE Username = @Username

IF @RoleID = 2 or @RoleID = 4
BEGIN
	SELECT 1
END
ELSE
BEGIN
	SELECT @ContactID = ContactID
	FROM Memberships
	WHERE Username = @Username
	
	IF @ContactID <> NULL
	BEGIN
		SELECT @Count = COUNT(*)
		FROM ProblemReports
		WHERE (Number = @Number) AND ((ContactID = @ContactID) OR (Confidential = 0))
	END
	
	IF @Count > 0
		SELECT 1
	ELSE
		SELECT 0
END
GO
/****** Object:  StoredProcedure [dbo].[IsProblemReportVisibleGuest]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[RemoveProblemReport]

@Number INT

AS

/* Start transaction to guarentee no two updates in parallel */
BEGIN TRANSACTION UpdateProblemReport

DELETE FROM ProblemReports

WHERE Number = @Number

COMMIT TRANSACTION UpdateProblemReport




GO
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportAttachment]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[RemoveProblemReportAttachment]

@ReportID	INT,
@FileName	VARCHAR(260)

AS

DELETE FROM ProblemReportTemporaryReportAttachments
WHERE ([FileName] = @FileName) AND (ReportID = @ReportID)

GO
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportCategorySubscriber]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[RemoveProblemReportCategorySubscriber]

@Username NVARCHAR(50),
@CategoryID INT

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

DELETE
FROM ProblemReportCategoriesSubscribers
WHERE (ContactID = @ContactID)  AND (CategoryID = @CategoryID)






GO
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportInteractionAttachment]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[RemoveProblemReportInteractionAttachment]

@InteractionID	INT,
@FileName	VARCHAR(260)

AS

DELETE FROM ProblemReportTemporaryInteractionAttachments
WHERE ([FileName] = @FileName) AND (InteractionID = @InteractionID)

GO
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportResponsibleCategory]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[RemoveProblemReportResponsibleCategory]

@Username NVARCHAR(50),
@CategoryID INT

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

DELETE
FROM ProblemReportResponsiblesCategories
WHERE (ContactID = @ContactID)  AND (CategoryID = @CategoryID)





GO
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportTemporaryInteractionAttachments]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[RemoveProblemReportTemporaryInteractionAttachments]

@InteractionID INT

AS

DELETE FROM ProblemReportTemporaryInteractionAttachments
WHERE InteractionID = @InteractionID

GO
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportTemporaryReportAttachments]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[RemoveProblemReportTemporaryReportAttachments]

@ReportID INT

AS

DELETE FROM ProblemReportTemporaryReportAttachments
WHERE ReportID = @ReportID

GO
/****** Object:  StoredProcedure [dbo].[RemoveRegistrationToken]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[RemoveRegistrationToken]

@RegistrationToken CHAR(7)

AS

DELETE
FROM Registrations
WHERE RegistrationToken = @RegistrationToken






GO
/****** Object:  StoredProcedure [dbo].[RemoveTemporaryProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[RemoveTemporaryProblemReport]

@ReportID INT

AS

DELETE FROM ProblemReportsTemporary WHERE ReportID = @ReportID



GO
/****** Object:  StoredProcedure [dbo].[RemoveUser]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveUser]

@Username VARCHAR(50)

AS

DECLARE @Email VARCHAR(100)
DECLARE @ContactID INT

SELECT @ContactID = ContactID
FROM Memberships
WHERE Username = @Username

SELECT @EMail = EMail
FROM Contacts
WHERE ContactID = @ContactID

BEGIN TRAN

	DELETE
	FROM ProblemReportInteractions
	WHERE ContactID = @ContactID

	DELETE
	FROM ProblemReports
	WHERE ContactID = @ContactID

	DELETE
	FROM Registrations
	WHERE EMail = @EMail

	DELETE
	FROM Memberships
	WHERE ContactID = @ContactID

	DELETE
	FROM Contacts
	WHERE ContactID = @ContactID

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[SetDefaultCategoryResponsible]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SetDefaultCategoryResponsible]
	@CategoryID INT,
	@Username VARCHAR(50)
AS
BEGIN
	DECLARE @ContactID INT
	SELECT @ContactID=ContactID FROM Memberships WHERE Username=@Username

	DELETE FROM ProblemReportDefaultCategoriesResponsibles
	WHERE CategoryID=@CategoryID

	INSERT INTO ProblemReportDefaultCategoriesResponsibles(
		CategoryID,
		ResponsibleID)
	VALUES(
		@CategoryID,
		@ContactID)
END



GO
/****** Object:  StoredProcedure [dbo].[SetPresetRole]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SetPresetRole]

@Email NVARCHAR(100)

AS

DECLARE @RoleID INT

SELECT @RoleID = RoleID FROM PresetRoles WHERE EMail = @EMail

IF NOT @RoleID IS NULL
	UPDATE Memberships SET RoleID=@RoleID WHERE ContactID = (SELECT ContactID FROM Contacts WHERE EMail = @EMail)





GO
/****** Object:  StoredProcedure [dbo].[SetProblemReportResponsible]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetProblemReportResponsible]
	@Number INT,
	@ContactID INT
AS
BEGIN
	DECLARE @ReportID INT
	SELECT @ReportID=ReportID
	FROM ProblemReports 
	WHERE Number=@Number

	DELETE FROM ProblemReportResponsibles 
	WHERE ReportID=@ReportID

	IF @ContactID > 0
	BEGIN
		INSERT INTO ProblemReportResponsibles(
			ReportID,
			ResponsibleID)
		VALUES (
			@ReportID,
			@ContactID)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SetUserRole]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[SetUserRole]

@Username NVARCHAR(50),
@RoleID INT

AS

UPDATE Memberships
SET RoleID = @RoleID
WHERE Username = @Username





GO
/****** Object:  StoredProcedure [dbo].[TableRowCount]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[update_answers]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_answers] (@N_Answerid integer,@N_Contactid integer,@N_Questionid integer,@N_Text varchar (500),@N_Notes varchar (500),@N_Datetime  datetime) as update Answers set Contactid = @N_Contactid, Questionid = @N_Questionid, Text = @N_Text, Notes = @N_Notes, Datetime = @N_Datetime where Answerid = @N_Answerid
GO
/****** Object:  StoredProcedure [dbo].[update_contacts]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_contacts] (@N_Contactid integer,@N_Countryid varchar (500),@N_Organizationcountryid varchar (500),@N_Regionid integer,@N_Organizationregionid integer,@N_Firstname varchar (500),@N_Lastname varchar (500),@N_Email varchar (500),@N_Address varchar (500),@N_City varchar (500),@N_Postalcode varchar (500),@N_Phone varchar (500),@N_Fax varchar (500),@N_Position varchar (500),@N_Organizationname varchar (500),@N_Organizationemail varchar (500),@N_Organizationurl varchar (500),@N_Organizationaddress varchar (500),@N_Organizationcity varchar (500),@N_Organizationpostalcode varchar (500),@N_Organizationphone varchar (500),@N_Organizationextension varchar (500),@N_Organizationfax varchar (500),@N_Dateofcreation  datetime,@N_Dateoflastmodification  datetime) as update Contacts set Countryid = @N_Countryid, Organizationcountryid = @N_Organizationcountryid, Regionid = @N_Regionid, Organizationregionid = @N_Organizationregionid, Firstname = @N_Firstname, Lastname = @N_Lastname, Email = @N_Email, Address = @N_Address, City = @N_City, Postalcode = @N_Postalcode, Phone = @N_Phone, Fax = @N_Fax, Position = @N_Position, Organizationname = @N_Organizationname, Organizationemail = @N_Organizationemail, Organizationurl = @N_Organizationurl, Organizationaddress = @N_Organizationaddress, Organizationcity = @N_Organizationcity, Organizationpostalcode = @N_Organizationpostalcode, Organizationphone = @N_Organizationphone, Organizationextension = @N_Organizationextension, Organizationfax = @N_Organizationfax, Dateofcreation = @N_Dateofcreation, Dateoflastmodification = @N_Dateoflastmodification where Contactid = @N_Contactid
GO
/****** Object:  StoredProcedure [dbo].[update_contacts2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_contacts2] (@N_Contactid integer,@N_Countryid varchar (500),@N_Organizationcountryid varchar (500),@N_Regionid integer,@N_Organizationregionid integer,@N_Firstname varchar (500),@N_Lastname varchar (500),@N_Email varchar (500),@N_Address varchar (500),@N_City varchar (500),@N_Postalcode varchar (500),@N_Phone varchar (500),@N_Fax varchar (500),@N_Position varchar (500),@N_Organizationname varchar (500),@N_Organizationemail varchar (500),@N_Organizationurl varchar (500),@N_Organizationaddress varchar (500),@N_Organizationcity varchar (500),@N_Organizationpostalcode varchar (500),@N_Organizationphone varchar (500),@N_Organizationextension varchar (500),@N_Organizationfax varchar (500),@N_Dateofcreation  datetime,@N_Dateoflastmodification  datetime) as update Contacts set Countryid = @N_Countryid, Organizationcountryid = @N_Organizationcountryid, Regionid = @N_Regionid, Organizationregionid = @N_Organizationregionid, Firstname = @N_Firstname, Lastname = @N_Lastname, Email = @N_Email, Address = @N_Address, City = @N_City, Postalcode = @N_Postalcode, Phone = @N_Phone, Fax = @N_Fax, Position = @N_Position, Organizationname = @N_Organizationname, Organizationemail = @N_Organizationemail, Organizationurl = @N_Organizationurl, Organizationaddress = @N_Organizationaddress, Organizationcity = @N_Organizationcity, Organizationpostalcode = @N_Organizationpostalcode, Organizationphone = @N_Organizationphone, Organizationextension = @N_Organizationextension, Organizationfax = @N_Organizationfax, Dateofcreation = @N_Dateofcreation, Dateoflastmodification = @N_Dateoflastmodification where Contactid = @N_Contactid
GO
/****** Object:  StoredProcedure [dbo].[update_notes]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[update_notes] (@N_Noteid integer,@N_Contactid integer,@N_Datetime  datetime,@N_Text Text) as
update Notes set Contactid = @N_Contactid, Datetime = @N_Datetime, Text = @N_Text where Noteid = @N_Noteid


GO
/****** Object:  StoredProcedure [dbo].[update_notes_manus]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_notes_manus] (@N_Noteid integer,@N_Contactid integer,@N_Datetime  datetime,@N_Text varchar (100)) as update Notes set Contactid = @N_Contactid, Datetime = @N_Datetime, Text = @N_Text where Noteid = @N_Noteid
GO
/****** Object:  StoredProcedure [dbo].[update_tasks]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_tasks] (@N_Taskid integer,@N_Taskname varchar (500),@N_Description varchar (500),@N_Query varchar (500),@N_Resulttype integer,@N_Stdcolumnresult varchar (500),@N_Deadline  datetime,@N_Duration float,@N_Filename varchar (500),@N_Tasktype integer) as update Tasks set Taskname = @N_Taskname, Description = @N_Description, Query = @N_Query, Resulttype = @N_Resulttype, Stdcolumnresult = @N_Stdcolumnresult, Deadline = @N_Deadline, Duration = @N_Duration, Filename = @N_Filename, Tasktype = @N_Tasktype where Taskid = @N_Taskid
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrganizationInformation]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[UpdateOrganizationInformation]

@Username	VARCHAR(50),
@Name		VARCHAR(50),
@EMail		VARCHAR(100),
@URL		VARCHAR(150),
@Address	VARCHAR(500),
@City		VARCHAR(100),
@Country	VARCHAR(50),
@Region	VARCHAR(100),
@Code		VARCHAR(50),
@Tel		VARCHAR(50),
@Fax		VARCHAR(50)

AS

DECLARE @RegionID INT

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

SET OrganizationEmail = @EMail,
        OrganizationName = @Name,
        OrganizationURL = @URL,
        OrganizationAddress = @Address,
        OrganizationCity = @City,
        OrganizationCountryID = (SELECT CountryID FROM Countries WHERE Country = @Country),
        OrganizationRegionID = @RegionID,
        OrganizationPostalCode = @Code,
        OrganizationPhone = @Tel,
        OrganizationFax = @Fax

WHERE ContactID = (SELECT ContactID FROM Memberships WHERE Username = @Username)

GO
/****** Object:  StoredProcedure [dbo].[UpdatePasswordFromEmail]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[UpdatePasswordFromEmail]

@Email VARCHAR(100),
@PasswordHash CHAR(40),
@PasswordSalt CHAR(24)

AS

UPDATE Memberships
SET PasswordHash = @PasswordHash, PasswordSalt = @PasswordSalt
WHERE ContactID = (SELECT ContactID FROM Contacts WHERE Email = @Email)






GO
/****** Object:  StoredProcedure [dbo].[UpdatePersonalInformation]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdatePersonalInformation]

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
        CountryID = (SELECT CountryID FROM Countries WHERE Country = @Country),
        RegionID = @RegionID,
        PostalCode = @Code,
        Phone = @Tel,
        Fax = @Fax
	
WHERE ContactID = (SELECT ContactID FROM Memberships WHERE Username = @Username)
GO
/****** Object:  StoredProcedure [dbo].[UpdateProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[UpdateProblemReport]

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
BEGIN TRANSACTION UpdateProblemReport

UPDATE ProblemReports SET
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
WHERE Number = @Number

COMMIT TRANSACTION UpdateProblemReport

GO
/****** Object:  StoredProcedure [dbo].[UpdateProblemReport2]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UpdateProblemReport2]

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
BEGIN TRANSACTION UpdateProblemReport2

UPDATE ProblemReports SET
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
WHERE Number = @Number

DECLARE @ReportID INT
DECLARE @ResponsibleID INT

SELECT @ReportID=ReportID FROM ProblemReports WHERE Number=@Number
SELECT @ResponsibleID=ResponsibleID FROM ProblemReportDefaultCategoriesResponsibles WHERE CategoryID=@CategoryID

INSERT INTO ProblemReportResponsibles (ReportID, ResponsibleID)
VALUES (@ReportID, @ResponsibleID)

COMMIT TRANSACTION UpdateProblemReport2


GO
/****** Object:  StoredProcedure [dbo].[UpdateProblemReportCategory]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[UpdateProblemReportCategory]

@Number INT,
@CategoryID INT

AS

UPDATE ProblemReports
SET CategoryID = @CategoryID
WHERE Number = @Number






GO
/****** Object:  StoredProcedure [dbo].[UpdateProblemReportStatus]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[UpdateProblemReportStatus]

@Number INT,
@StatusID INT

AS

UPDATE ProblemReports
SET StatusID = @StatusID
WHERE Number = @Number






GO
/****** Object:  StoredProcedure [dbo].[UpdateSecurityQuestion]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[UpdateSecurityQuestion]

@Username VARCHAR(50),
@QuestionID INT,
@AnswerHash CHAR(40),
@AnswerSalt CHAR(24)


AS

UPDATE Memberships
SET QuestionID = @QuestionID, AnswerHash = @AnswerHash, AnswerSalt = @AnswerSalt
WHERE Username = @Username






GO
/****** Object:  StoredProcedure [dbo].[UpdateTemporaryProblemReport]    Script Date: 08/04/2014 15:02:37 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidateAnswer]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[ValidateAnswer]

@EMail VARCHAR(100),
@AnswerHash CHAR(40)

AS

DECLARE @Res BIT
DECLARE @Count INT
DECLARE @ContactID INT

SELECT @ContactID = ContactID
FROM Contacts
WHERE EMail = @Email

SELECT @Count = COUNT(*) FROM Memberships WHERE ContactID=@ContactID AND AnswerHash=@AnswerHash
IF @Count > 0
	SET @Res = 1
ELSE
	SET @Res = 0
SELECT @Res;






GO
/****** Object:  StoredProcedure [dbo].[ValidateLogin]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[ValidateLogin]

@Username VARCHAR(50),
@PasswordHash CHAR(40)

AS

DECLARE @Res BIT
DECLARE @Count INT
SELECT @Count = COUNT(*) FROM Memberships WHERE Username=@Username AND PasswordHash=@PasswordHash
IF @Count > 0
	SET @Res = 1
ELSE
	SET @Res = 0
SELECT @Res;






GO
/****** Object:  StoredProcedure [dbo].[ValidateNewEmail]    Script Date: 08/04/2014 15:02:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidateNewEmail]

@Username VARCHAR(50),
@Email VARCHAR(100),
@RegistrationToken CHAR(7)

AS

DECLARE @ContactID INT
DECLARE @Res BIT

SET @Res = 0
SELECT @ContactID = ContactID FROM Memberships WHERE Username = @Username

IF NOT @ContactID IS NULL
BEGIN
	IF EXISTS (
		SELECT Email
		FROM TemporaryEmails
		WHERE ((ContactID = @ContactID)
		AND (Email = @Email)
		AND (Token = @RegistrationToken))
	) BEGIN
		SET @Res = 1
		UPDATE Contacts SET Email = @Email WHERE ContactID = @ContactID
		DELETE FROM TemporaryEmails WHERE Email = @Email
	END
END

SELECT @Res

GO
