USE [master]
GO
/****** Object:  Database [EiffelDB]    Script Date: 12/14/2016 08:11:32 ******/
CREATE DATABASE [EiffelDB] ON  PRIMARY 
( NAME = N'EiffelDB_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL\data\EiffelDB_Data.MDF' , SIZE = 737792KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'EiffelDB_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL\data\EiffelDB_Log.LDF' , SIZE = 1280KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [EiffelDB] SET COMPATIBILITY_LEVEL = 80
GO
ALTER DATABASE [EiffelDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [EiffelDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [EiffelDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [EiffelDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [EiffelDB] SET ARITHABORT OFF
GO
ALTER DATABASE [EiffelDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [EiffelDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [EiffelDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [EiffelDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [EiffelDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [EiffelDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [EiffelDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [EiffelDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [EiffelDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [EiffelDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [EiffelDB] SET  READ_WRITE
GO
ALTER DATABASE [EiffelDB] SET RECOVERY FULL
GO
ALTER DATABASE [EiffelDB] SET  MULTI_USER
GO
ALTER DATABASE [EiffelDB] SET PAGE_VERIFY TORN_PAGE_DETECTION
GO
ALTER DATABASE [EiffelDB] SET DB_CHAINING OFF
GO
USE [EiffelDB]
GO
/****** Object:  User [eiffel2]    Script Date: 12/14/2016 08:11:32 ******/
EXEC dbo.sp_grantdbaccess @loginame = N'eiffel2', @name_in_db = N'eiffel2'
GO
/****** Object:  User [eiffel]    Script Date: 12/14/2016 08:11:32 ******/
EXEC dbo.sp_grantdbaccess @loginame = N'eiffel', @name_in_db = N'eiffel'
GO
/****** Object:  Table [dbo].[ContactsTemporary]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactsTemporary](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](240) NULL,
	[LastName] [varchar](240) NULL,
	[Email] [varchar](150) NOT NULL,
	[Newsletter] [int] NULL,
 CONSTRAINT [PK_ContactsTemporary] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UniqueEmail] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportCategoryGroups]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportCategoryGroups](
	[CategoryGroupID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryGroupSynopsis] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ProblemReportCategoryGroups] PRIMARY KEY CLUSTERED 
(
	[CategoryGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportClasses]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportClasses](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[ClassSynopsis] [varchar](50) NOT NULL,
	[ClassDescription] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ProblemReportClasses] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportFormFields]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportFormFields](
	[Title] [varchar](50) NOT NULL,
	[Description] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_ProblemReportFormFields] PRIMARY KEY CLUSTERED 
(
	[Title] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ecregions]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ecregions](
	[contactid] [int] NOT NULL,
	[region] [varchar](50) NULL,
 CONSTRAINT [PK_ecregions] PRIMARY KEY CLUSTERED 
(
	[contactid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportPriorities]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportPriorities](
	[PriorityID] [int] IDENTITY(1,1) NOT NULL,
	[PrioritySynopsis] [varchar](50) NOT NULL,
	[PriorityDescription] [varchar](200) NOT NULL,
 CONSTRAINT [PK_ProblemReportPriorities] PRIMARY KEY CLUSTERED 
(
	[PriorityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[eccountries]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[eccountries](
	[contactid] [int] NOT NULL,
	[countryid] [varchar](250) NULL,
 CONSTRAINT [PK_eccountries] PRIMARY KEY CLUSTERED 
(
	[contactid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AddProblemReportFromGnats]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  Table [dbo].[ProblemReportSeverities]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportSeverities](
	[SeverityID] [int] IDENTITY(1,1) NOT NULL,
	[SeveritySynopsis] [varchar](50) NOT NULL,
	[SeverityDescription] [varchar](200) NOT NULL,
 CONSTRAINT [PK_ProblemReportSeverities] PRIMARY KEY CLUSTERED 
(
	[SeverityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[RemoveDownloadExpiration]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RemoveDownloadExpiration]
	-- Add the parameters for the stored procedure here
	@Email	            VARCHAR(150), 
	@Token              VARCHAR(50)
	
AS

DELETE FROM DownloadExpiration WHERE Email = @Email and Token = @Token;
GO
/****** Object:  StoredProcedure [dbo].[AddProblemReportInteractionAttachment]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[AddProblemReportResponsibleCategory]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[AddTemporaryProblemReport]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  Table [dbo].[DownloadExpiration]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DownloadExpiration](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[Token] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Platform] [varchar](50) NOT NULL,
	[Company] [varchar](100) NULL,
	[FirstName] [varchar](240) NULL,
	[LastName] [varchar](240) NULL,
 CONSTRAINT [PK_DownloadExpiration] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AddTemporaryProblemReportAttachment]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[update_answers]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_answers] (@N_Answerid integer,@N_Contactid integer,@N_Questionid integer,@N_Text varchar (500),@N_Notes varchar (500),@N_Datetime  datetime) as update Answers set Contactid = @N_Contactid, Questionid = @N_Questionid, Text = @N_Text, Notes = @N_Notes, Datetime = @N_Datetime where Answerid = @N_Answerid
GO
/****** Object:  StoredProcedure [dbo].[AddTemporaryProblemReportInteractionAttachment]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[ChangeActiveStatus]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  Table [dbo].[Auth_Session]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Auth_Session](
	[ContactID] [int] NOT NULL,
	[Access_token] [varchar](64) NOT NULL,
	[Created] [datetime] NOT NULL,
	[MaxAge] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportResponsible]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  Table [dbo].[Questions]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[QuestionID] [int] NOT NULL,
	[Text] [text] NOT NULL,
	[Type] [float] NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL,
	[ProductName] [text] NOT NULL,
	[Type] [int] NOT NULL,
	[Price] [varchar](120) NOT NULL,
	[IsObsolete] [bit] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Regions]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Regions](
	[RegionID] [int] IDENTITY(1,1) NOT NULL,
	[Region] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Regions] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportSubscribedCategories]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporary]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryInteractionAttachmentsHeaders]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryReportAttachments]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuestionFromEmail]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetRegistrationToken]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetRegistrationTokenFromEmail]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetRegistrationTokenFromUsername]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetRole]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetRoleDescription]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserAnswerSalt]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserFromEmail]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserInformation]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserPasswordSalt]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveProblemReport]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  Table [dbo].[Codes]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Codes](
	[CodeID] [int] NOT NULL,
	[CodeInteger] [int] NOT NULL,
	[CodeString] [varchar](50) NOT NULL,
	[TableCode] [int] NOT NULL,
	[AttributeCode] [int] NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[FieldName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Codes] PRIMARY KEY CLUSTERED 
(
	[CodeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportAttachment]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[InitializeProblemReport]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[IsMemberhipActive]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionAttachmentVisible]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionVisible]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[IsProblemReportInteractionVisible]

@Username VARCHAR(50),
@InteractionID INT

AS

DECLARE @Number INT
DECLARE @RoleID INT

SELECT @RoleID = RoleID
FROM Memberships
WHERE Username = @Username

IF @RoleID = 2 or @RoleID = 4
BEGIN
	SELECT 1
END
ELSE
BEGIN
		-- if the ROLEID is not 2 or 4 we check for Private = 0 
		-- Reports Interactions with Private = 1 are only visible for users with roleID 2 or 4.
	SELECT @Number = Number
	FROM ProblemReports
	WHERE ProblemReports.ReportID = (SELECT ReportID FROM ProblemReportInteractions WHERE InteractionID = @InteractionID and Private = 0)

		-- And then we check if the report is visible for the current user.
	EXEC IsProblemReportVisible @Username, @Number
END
GO
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportInteractionAttachment]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportResponsibleCategory]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportTemporaryInteractionAttachments]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportTemporaryReportAttachments]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveRegistrationToken]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[GetRolesForEdition]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetRolesForEdition]

AS

SELECT RoleID, RoleSynopsis

FROM Roles
GO
/****** Object:  StoredProcedure [dbo].[GetSecurityQuestions]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetSecurityQuestions]

AS

SELECT *
FROM SecurityQuestions
GO
/****** Object:  StoredProcedure [dbo].[RemoveTemporaryProblemReport]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[RemoveTemporaryProblemReport]

@ReportID INT

AS

DELETE FROM ProblemReportsTemporary WHERE ReportID = @ReportID
GO
/****** Object:  StoredProcedure [dbo].[SetPresetRole]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateOrganizationInformation]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdatePasswordFromEmail]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateProblemReport]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateProblemReportCategory]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateProblemReportStatus]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateSecurityQuestion]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidateAnswer]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[CleanupTemporaryProblemReportInteractions]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidateLogin]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  Table [dbo].[ProblemReportStatus]    Script Date: 12/14/2016 08:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportStatus](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusSynopsis] [varchar](50) NOT NULL,
	[StatusDescription] [varchar](300) NOT NULL,
 CONSTRAINT [PK_ProblemReportStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SetUserRole]    Script Date: 12/14/2016 08:11:34 ******/
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
/****** Object:  UserDefinedFunction [dbo].[UserSynopsisFast]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[UserSynopsisFast] (

@FirstName VARCHAR(240),
@LastName VARCHAR(240),
@UserName VARCHAR(150)

)  

RETURNS VARCHAR (500) AS  

BEGIN 

	IF (@FirstName IS NULL) OR (DataLength (@FirstName) < 2)
	BEGIN
		IF (@LastName IS NULL) OR (DataLength (@LastName) < 2)
		BEGIN
			RETURN @UserName
		END
		ELSE
		BEGIN
			RETURN @LastName + ' (' + @Username + ')'
		END
	END
	ELSE
	BEGIN
		IF (@LastName IS NULL) OR (@LastName = '')
		BEGIN
			RETURN @FirstName + ' (' + @Username + ')'
		END
		ELSE
		BEGIN
			RETURN @FirstName + ' ' +  @LastName
		END
	END

	RETURN @UserName

END
GO
/****** Object:  Table [dbo].[InteractionType]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InteractionType](
	[InteractionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[InteractionTypeDescription] [nvarchar](50) NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InteractionType', @level2type=N'COLUMN',@level2name=N'InteractionTypeId'
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsGuest3]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  Table [dbo].[ContactsNoEmail]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactsNoEmail](
	[ContactID] [int] NOT NULL,
	[ContactTypeID] [varchar](140) NULL,
	[CountryID] [int] NULL,
	[OrganizationCountryID] [int] NULL,
	[RegionID] [int] NULL,
	[OrganizationRegionID] [int] NULL,
	[FirstName] [varchar](240) NULL,
	[LastName] [varchar](240) NULL,
	[Email] [varchar](150) NULL,
	[Address] [text] NULL,
	[City] [varchar](240) NULL,
	[PostalCode] [varchar](110) NULL,
	[Phone] [varchar](130) NULL,
	[Fax] [varchar](130) NULL,
	[Position] [varchar](130) NULL,
	[OrganizationName] [text] NULL,
	[OrganizationEmail] [varchar](100) NULL,
	[OrganizationURL] [varchar](150) NULL,
	[OrganizationAddress] [text] NULL,
	[OrganizationCity] [varchar](100) NULL,
	[OrganizationPostalCode] [varchar](50) NULL,
	[OrganizationPhone] [varchar](130) NULL,
	[OrganizationExtension] [varchar](110) NULL,
	[OrganizationFax] [varchar](130) NULL,
	[DateOfCreation] [datetime] NULL,
	[DateOfLastModification] [datetime] NULL,
	[Happyness] [varchar](130) NULL,
	[Notes] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CountryMappingsTemp]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CountryMappingsTemp](
	[ContactID] [int] NOT NULL,
	[Country] [varchar](150) NULL,
 CONSTRAINT [PK_CountryMappingsTemp] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailLists]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailLists](
	[EmailListID] [int] NOT NULL,
	[Code] [varchar](5) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[UnsubscriptionAddress] [varchar](50) NOT NULL,
	[TaskType] [int] NOT NULL,
	[DefaultStatus] [int] NOT NULL,
 CONSTRAINT [PK_EmailLists] PRIMARY KEY CLUSTERED 
(
	[EmailListID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ForbiddenEmails]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ForbiddenEmails](
	[ForbiddenEmailID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ForbiddenEmails] PRIMARY KEY CLUSTERED 
(
	[ForbiddenEmailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryID] [char](3) NOT NULL,
	[Country] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[UpdateProblemReport2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  Table [dbo].[SecurityQuestions]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecurityQuestions](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[Question] [varchar](200) NOT NULL,
 CONSTRAINT [PK_SecurityQuestions] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GetEmailFromContactID]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetEmailFromContactID]

@ContactID INT

AS

SELECT Email FROM Contacts WHERE ContactID = @ContactID
GO
/****** Object:  StoredProcedure [dbo].[GetDefaultCategoriesResponsibles]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  Table [dbo].[Support]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Support](
	[SupportID] [int] NOT NULL,
	[SupportTypeID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [text] NOT NULL,
 CONSTRAINT [PK_Support] PRIMARY KEY CLUSTERED 
(
	[SupportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GetMembershipCreationDate]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetDefaultCategoryResponsible]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  Table [dbo].[Tasks]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tasks](
	[TaskID] [int] NOT NULL,
	[TaskName] [varchar](150) NOT NULL,
	[Description] [text] NULL,
	[Query] [text] NOT NULL,
	[ResultType] [int] NOT NULL,
	[StdColumnResult] [text] NOT NULL,
	[Deadline] [datetime] NOT NULL,
	[Duration] [float] NULL,
	[FileName] [varchar](150) NOT NULL,
	[TaskType] [int] NULL,
 CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReport]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleSynopsis] [varchar](50) NOT NULL,
	[RoleDescription] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[DeleteProblemReport]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportCategories]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportClasses]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProblemReportClasses] AS
SELECT * FROM ProblemReportClasses
ORDER BY ClassSynopsis
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportForReview]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportFormFieldDescription]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractionAttachmentContent]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractionAttachmentsHeaders]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportPriorities]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProblemReportPriorities]

AS

SELECT *
FROM ProblemReportPriorities
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportSeverities]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProblemReportSeverities]

AS

SELECT *
FROM ProblemReportSeverities
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportStatus]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProblemReportStatus]

AS

SELECT * 
FROM ProblemReportStatus
GO
/****** Object:  Table [dbo].[ProblemReportDefaultCategoriesResponsibles]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles](
	[CategoryResponsibleID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ResponsibleID] [int] NOT NULL,
 CONSTRAINT [PK_ProblemReportDefaultCategoriesResponsibles] PRIMARY KEY CLUSTERED 
(
	[CategoryResponsibleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProblemReportResponsibles]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemReportResponsibles](
	[ReportResponsibleID] [int] IDENTITY(1,1) NOT NULL,
	[ReportID] [int] NOT NULL,
	[ResponsibleID] [int] NOT NULL,
 CONSTRAINT [PK_ProblemReportResponsibles] PRIMARY KEY CLUSTERED 
(
	[ReportResponsibleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notes]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notes](
	[NoteID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[DateTime] [datetime] NULL,
	[Text] [text] NULL,
 CONSTRAINT [PK_Notes] PRIMARY KEY CLUSTERED 
(
	[NoteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registrations]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Registrations](
	[RegistrationToken] [varchar](7) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Registrations] PRIMARY KEY CLUSTERED 
(
	[RegistrationToken] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Memberships]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Memberships](
	[MembershipID] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[QuestionID] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[PasswordHash] [varchar](40) NOT NULL,
	[PasswordSalt] [varchar](24) NOT NULL,
	[AnswerHash] [char](40) NOT NULL,
	[AnswerSalt] [char](24) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Memberships] PRIMARY KEY CLUSTERED 
(
	[MembershipID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Memberships] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Consultings]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Consultings](
	[ConsultingID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[PurchaseID] [int] NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Location] [text] NULL,
	[Consultant] [text] NULL,
	[Subject] [text] NULL,
	[Notes] [text] NULL,
 CONSTRAINT [PK_Consultings] PRIMARY KEY CLUSTERED 
(
	[ConsultingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Answers]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Answers](
	[AnswerID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[QuestionID] [int] NOT NULL,
	[Text] [varchar](50) NULL,
	[Notes] [text] NULL,
	[DateTime] [datetime] NULL,
 CONSTRAINT [PK_Answers] PRIMARY KEY CLUSTERED 
(
	[AnswerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportInteractions]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemReportInteractions](
	[InteractionID] [int] IDENTITY(1,1) NOT NULL,
	[ReportID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[NewStatusID] [int] NULL,
	[InteractionDate] [datetime] NOT NULL,
	[Content] [text] NOT NULL,
	[Private] [bit] NOT NULL,
 CONSTRAINT [PK_ProblemReportInteractions] PRIMARY KEY CLUSTERED 
(
	[InteractionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UpdateEmail]    Script Date: 12/14/2016 08:11:35 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportTemporaryInteractions]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemReportTemporaryInteractions](
	[InteractionID] [int] IDENTITY(1,1) NOT NULL,
	[ReportID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[NewStatusID] [int] NULL,
	[Content] [text] NULL,
	[CreationDate] [datetime] NOT NULL,
	[Private] [bit] NOT NULL,
	[NewCategoryID] [int] NULL,
 CONSTRAINT [PK_ProblemReportInteractionsTemp] PRIMARY KEY CLUSTERED 
(
	[InteractionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interactions]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Interactions](
	[InteractionID] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NOT NULL,
	[DateTime] [datetime] NULL,
	[InteractionType] [int] NULL,
	[Subject] [text] NULL,
	[Respondant] [varchar](130) NULL,
	[Notes] [text] NULL,
 CONSTRAINT [PK_Interactions] PRIMARY KEY CLUSTERED 
(
	[InteractionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TemporaryEmails]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TemporaryEmails](
	[Email] [varchar](100) NOT NULL,
	[ContactID] [int] NOT NULL,
	[Token] [char](7) NOT NULL,
 CONSTRAINT [PK_TemporaryEmails] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Purchases](
	[PurchaseID] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NOT NULL,
	[DateTime] [datetime] NULL,
	[Deadline] [datetime] NULL,
	[Total] [varchar](120) NOT NULL,
	[Premium] [varchar](120) NULL,
	[Discount] [varchar](120) NULL,
	[InvoiceNumber] [varchar](130) NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_Purchases] PRIMARY KEY CLUSTERED 
(
	[PurchaseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReports]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReports](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[PriorityID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[SeverityID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[SubmissionDate] [datetime] NOT NULL,
	[Synopsis] [varchar](200) NOT NULL,
	[Release] [varchar](50) NOT NULL,
	[Confidential] [bit] NOT NULL,
	[Environment] [varchar](200) NOT NULL,
	[Description] [text] NOT NULL,
	[ToReproduce] [text] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProblemReports] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_ProblemReports] UNIQUE NONCLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportCategoriesSubscribers]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemReportCategoriesSubscribers](
	[ResponsibleCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_ProblemReportCategoriesSubscribers] PRIMARY KEY CLUSTERED 
(
	[ResponsibleCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProblemReportsTemporary]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportsTemporary](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NOT NULL,
	[PriorityID] [int] NULL,
	[CategoryID] [int] NULL,
	[SeverityID] [int] NULL,
	[ClassID] [int] NULL,
	[Synopsis] [varchar](200) NULL,
	[Release] [varchar](50) NULL,
	[Confidential] [bit] NULL,
	[Environment] [varchar](200) NULL,
	[Description] [text] NULL,
	[ToReproduce] [text] NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProblemReportsTemp] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportResponsiblesCategories]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemReportResponsiblesCategories](
	[ResponsibleCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_ProblemReportResponsiblesCategories] PRIMARY KEY CLUSTERED 
(
	[ResponsibleCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProblemReportInteractionAttachments]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportInteractionAttachments](
	[AttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[InteractionID] [int] NOT NULL,
	[Blob] [image] NOT NULL,
	[FileName] [varchar](260) NOT NULL,
	[BytesCount] [int] NOT NULL,
 CONSTRAINT [PK_ProblemReportAttachments] PRIMARY KEY CLUSTERED 
(
	[AttachmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportTemporaryInteractionAttachments]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportTemporaryInteractionAttachments](
	[AttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[InteractionID] [int] NOT NULL,
	[Length] [int] NOT NULL,
	[Content] [image] NOT NULL,
	[FileName] [varchar](260) NOT NULL,
 CONSTRAINT [PK_ProblemReportTemporaryInteractionAttachments] PRIMARY KEY CLUSTERED 
(
	[AttachmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [char](3) NULL,
	[OrganizationCountryID] [char](3) NULL,
	[RegionID] [int] NULL,
	[OrganizationRegionID] [int] NULL,
	[FirstName] [varchar](240) NULL,
	[LastName] [varchar](240) NULL,
	[Email] [varchar](150) NOT NULL,
	[Address] [text] NULL,
	[City] [varchar](240) NULL,
	[PostalCode] [varchar](110) NULL,
	[Phone] [varchar](130) NULL,
	[Fax] [varchar](130) NULL,
	[Position] [varchar](130) NULL,
	[OrganizationName] [text] NULL,
	[OrganizationEmail] [varchar](100) NULL,
	[OrganizationURL] [varchar](150) NULL,
	[OrganizationAddress] [text] NULL,
	[OrganizationCity] [varchar](100) NULL,
	[OrganizationPostalCode] [varchar](50) NULL,
	[OrganizationPhone] [varchar](130) NULL,
	[OrganizationExtension] [varchar](110) NULL,
	[OrganizationFax] [varchar](130) NULL,
	[DateOfCreation] [datetime] NULL,
	[DateOfLastModification] [datetime] NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Contacts_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SupportAdminPageViewDates]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SupportAdminPageViewDates](
	[ViewID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[ViewDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SupportAdminPageViewDates] PRIMARY KEY CLUSTERED 
(
	[ViewID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_SupportAdminPageViewDates] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountsPageViewDates]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountsPageViewDates](
	[ViewID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[ViewDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AccountsPageViewDates] PRIMARY KEY CLUSTERED 
(
	[ViewID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_AccountsPageViewDates] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SupportPageViewDates]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SupportPageViewDates](
	[ViewID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[ViewDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SupportPageViewDates] PRIMARY KEY CLUSTERED 
(
	[ViewID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_SupportPageViewDates] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportCategoriesRoles]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemReportCategoriesRoles](
	[CategoryRoleID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_ProblemReportCategoriesroles] PRIMARY KEY CLUSTERED 
(
	[CategoryRoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProblemReportCategories]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryGroupID] [int] NOT NULL,
	[CategorySynopsis] [varchar](50) NOT NULL,
	[CategoryDescription] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ProblemReportCategories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_ProblemReportCategories] UNIQUE NONCLUSTERED 
(
	[CategorySynopsis] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportTemporaryReportAttachments]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProblemReportTemporaryReportAttachments](
	[AttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[ReportID] [int] NOT NULL,
	[Length] [int] NOT NULL,
	[Content] [image] NOT NULL,
	[FileName] [varchar](260) NOT NULL,
 CONSTRAINT [PK_ProblemReportTemporaryReportAttachments] PRIMARY KEY CLUSTERED 
(
	[AttachmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] NOT NULL,
	[PurchaseID] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Amount] [varchar](220) NOT NULL,
	[PaymentType] [varchar](180) NULL,
	[Notes] [text] NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PresetRoles]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PresetRoles](
	[PresetRoleID] [int] IDENTITY(1,1) NOT NULL,
	[EMail] [varchar](100) NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_PresetRoles] PRIMARY KEY CLUSTERED 
(
	[PresetRoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportCategorySubscribers]    Script Date: 12/14/2016 08:11:35 ******/
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

GROUP BY FirstName, LastName, Email
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportSubscribedCategories2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  UserDefinedFunction [dbo].[UserSynopsis]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[UserSynopsis] (

@ContactID AS INT

)  

RETURNS VARCHAR (500) AS  

BEGIN 

	DECLARE @FirstName VARCHAR(240)
	DECLARE @LastName VARCHAR(240)
	DECLARE @Email VARCHAR(150)
	DECLARE @OrganizationName VARCHAR(500)
	DECLARE @UserSynopsis VARCHAR(500)

	SELECT @FirstName = FirstName, @LastName = LastName, @Email = Email, @OrganizationName = OrganizationName FROM Contacts WHERE ContactID = @ContactID

	IF (@FirstName IS NULL) OR (DataLength (@FirstName) < 2)
	BEGIN
		IF (@LastName IS NULL) OR (DataLength (@LastName) < 2)
		BEGIN
			SELECT @UserSynopsis = @Email
		END
		ELSE
		BEGIN
			SELECT @UserSynopsis = @LastName + ' (' + @Email + ')'
		END
	END
	ELSE
	BEGIN
		IF (@LastName IS NULL) OR (@LastName = '')
		BEGIN
			SELECT @UserSynopsis = @FirstName + ' (' + @Email + ')'
		END
		ELSE
		BEGIN
			SELECT @UserSynopsis = @FirstName + ' ' +  @LastName
		END
	END

	RETURN @UserSynopsis

END
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteraction2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForSearch]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForEdition]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[AddDownloadInteractionContact]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddDownloadInteractionContact]
@Email			VARCHAR(150),
@Subject			TEXT,
@Notes				TEXT

AS

DECLARE @ContactID INT

SELECT @ContactID = ContactID FROM Contacts WHERE Email = @Email

INSERT INTO Interactions(ContactID, DateTime, InteractionType, Subject, Respondant, Notes) 
	VALUES (@ContactID, getdate(), 1, @Subject, 'Web Download', @Notes)
GO
/****** Object:  StoredProcedure [dbo].[GetContactFromEmail]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetContactFromEmail]
	@EMail VARCHAR(100)

AS

SELECT Contacts.FirstName, Contacts.LastName
FROM Contacts
WHERE EMail = @EMail
GO
/****** Object:  StoredProcedure [dbo].[CommitContact]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CommitContact]
	@Email				VARCHAR(150)
AS
  DECLARE @Exist INT, @FirstName varchar(50), @LastName varchar (50), @Newsletter INT, @ContactID INT

		-- Check temporary contact
  select @Exist=COUNT(*), @FirstName=FirstName, @LastName=LastName, @Newsletter=Newsletter from ContactsTemporary where Email = @Email Group by FirstName, LastName, Newsletter

  if @Exist = 1
  BEGIN
		-- Is not a contact
	select @Exist=COUNT(*) from Contacts where Email = @Email 
	if @Exist = 0
	begin
			-- Add Contacts
        Begin Transaction  ADD_CONTACT
			INSERT INTO Contacts(FirstName, LastName, Email) Values (@FirstName, @LastName, @Email)
		Commit Transaction ADD_CONTACT
			-- If register newsletter, add it to answer
		if @Newsletter = 1
		begin
			DECLARE @AnswerID INT
			select @AnswerID =isnull (max(AnswerID + 1), 1) from Answers
			select @ContactID=ContactID from Contacts where Email = @Email
			INSERT INTO Answers(AnswerID, ContactID, QuestionID, Notes, DateTime) Values ( @AnswerID, @ContactID, 11, 'Register Newsletter', getDate())
		end

		DELETE FROM ContactsTemporary WHERE Email = @Email
    end 
		
  END
GO
/****** Object:  StoredProcedure [dbo].[RegisterNewsletter]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RegisterNewsletter]
    @Email				VARCHAR(150)

AS
  DECLARE @ContactID INT
  DECLARE @QuestionID INT 
  DECLARE @Exist INT

  SET @ContactID = 0
  SET @QuestionID = 11 

  select @ContactID = ContactID from Contacts where Email = @Email 

  if @ContactID > 0
  BEGIN transaction register_newsletter
	select @Exist= Count(*) from Answers where ContactID = @ContactID
	if @Exist = 0
	  begin
	    DECLARE @AnswerID INT
		select @AnswerID=isnull (max(AnswerID + 1), 1) from Answers
	    INSERT INTO Answers(AnswerID, ContactID, QuestionID, Notes, DateTime) Values (@AnswerID, @ContactID, 11, 'Register Newsletter', getDate())
	  end
  commit transaction register_newsletter
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
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
/****** Object:  StoredProcedure [dbo].[GetAllProblemReports]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportResponsibles]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdatePersonalInformation2]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdatePersonalInformation2]
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
/****** Object:  StoredProcedure [dbo].[GetContactsForEdition]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateEmailFromUserAndToken]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[update_contacts]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_contacts] (@N_Contactid integer,@N_Countryid varchar (500),@N_Organizationcountryid varchar (500),@N_Regionid integer,@N_Organizationregionid integer,@N_Firstname varchar (500),@N_Lastname varchar (500),@N_Email varchar (500),@N_Address varchar (500),@N_City varchar (500),@N_Postalcode varchar (500),@N_Phone varchar (500),@N_Fax varchar (500),@N_Position varchar (500),@N_Organizationname varchar (500),@N_Organizationemail varchar (500),@N_Organizationurl varchar (500),@N_Organizationaddress varchar (500),@N_Organizationcity varchar (500),@N_Organizationpostalcode varchar (500),@N_Organizationphone varchar (500),@N_Organizationextension varchar (500),@N_Organizationfax varchar (500),@N_Dateofcreation  datetime,@N_Dateoflastmodification  datetime) as update Contacts set Countryid = @N_Countryid, Organizationcountryid = @N_Organizationcountryid, Regionid = @N_Regionid, Organizationregionid = @N_Organizationregionid, Firstname = @N_Firstname, Lastname = @N_Lastname, Email = @N_Email, Address = @N_Address, City = @N_City, Postalcode = @N_Postalcode, Phone = @N_Phone, Fax = @N_Fax, Position = @N_Position, Organizationname = @N_Organizationname, Organizationemail = @N_Organizationemail, Organizationurl = @N_Organizationurl, Organizationaddress = @N_Organizationaddress, Organizationcity = @N_Organizationcity, Organizationpostalcode = @N_Organizationpostalcode, Organizationphone = @N_Organizationphone, Organizationextension = @N_Organizationextension, Organizationfax = @N_Organizationfax, Dateofcreation = @N_Dateofcreation, Dateoflastmodification = @N_Dateoflastmodification where Contactid = @N_Contactid
GO
/****** Object:  StoredProcedure [dbo].[GetReportProblemInteractionsGuest]    Script Date: 12/14/2016 08:11:35 ******/
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
ORDER BY InteractionDate DESC
END
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractions3]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[update_contacts2]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_contacts2] (@N_Contactid integer,@N_Countryid varchar (500),@N_Organizationcountryid varchar (500),@N_Regionid integer,@N_Organizationregionid integer,@N_Firstname varchar (500),@N_Lastname varchar (500),@N_Email varchar (500),@N_Address varchar (500),@N_City varchar (500),@N_Postalcode varchar (500),@N_Phone varchar (500),@N_Fax varchar (500),@N_Position varchar (500),@N_Organizationname varchar (500),@N_Organizationemail varchar (500),@N_Organizationurl varchar (500),@N_Organizationaddress varchar (500),@N_Organizationcity varchar (500),@N_Organizationpostalcode varchar (500),@N_Organizationphone varchar (500),@N_Organizationextension varchar (500),@N_Organizationfax varchar (500),@N_Dateofcreation  datetime,@N_Dateoflastmodification  datetime) as update Contacts set Countryid = @N_Countryid, Organizationcountryid = @N_Organizationcountryid, Regionid = @N_Regionid, Organizationregionid = @N_Organizationregionid, Firstname = @N_Firstname, Lastname = @N_Lastname, Email = @N_Email, Address = @N_Address, City = @N_City, Postalcode = @N_Postalcode, Phone = @N_Phone, Fax = @N_Fax, Position = @N_Position, Organizationname = @N_Organizationname, Organizationemail = @N_Organizationemail, Organizationurl = @N_Organizationurl, Organizationaddress = @N_Organizationaddress, Organizationcity = @N_Organizationcity, Organizationpostalcode = @N_Organizationpostalcode, Organizationphone = @N_Organizationphone, Organizationextension = @N_Organizationextension, Organizationfax = @N_Organizationfax, Dateofcreation = @N_Dateofcreation, Dateoflastmodification = @N_Dateoflastmodification where Contactid = @N_Contactid
GO
/****** Object:  StoredProcedure [dbo].[ChangeUserEmail]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[AddUser2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForEdition2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForEdition3]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveUser]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdatePersonalInformation]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidateNewEmail]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteraction]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportsHistory]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportCategoryResponsibles]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReports2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractions]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportsRowCountGuest]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[SetProblemReportResponsible]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[IsProblemReportVisibleGuest]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[CommitInteraction2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[CommitProblemReport]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[CommitInteraction]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CommitInteraction]

@InteractionID INT

AS
DECLARE @ReportID INT
DECLARE @NewInteractionID INT
DECLARE @InteractionDate DATETIME

SELECT @ReportID = ReportID FROM ProblemReportTemporaryInteractions WHERE InteractionID = @InteractionID
SET @InteractionDate=getdate()

UPDATE ProblemReports SET LastActivityDate = @InteractionDate WHERE ReportID = @ReportID

INSERT INTO ProblemReportInteractions (ReportID, ContactID, InteractionDate, Content, NewStatusID, Private)
SELECT ReportID = @ReportID, ContactID, InteractionDate = @InteractionDate, Content, NewStatusID, Private
FROM ProblemReportTemporaryInteractions
WHERE InteractionID = @InteractionID

SET @NewInteractionID = SCOPE_IDENTITY()

IF EXISTS(SELECT* FROM ProblemReportTemporaryInteractionAttachments WHERE InteractionID = @InteractionID)
BEGIN
	INSERT  INTO ProblemReportInteractionAttachments (InteractionID, Blob, [FileName], BytesCount)
	SELECT InteractionID = @NewInteractionID, Blob = Content, [FileName], BytesCount = Length
	FROM ProblemReportTemporaryInteractionAttachments
	WHERE InteractionID = @InteractionID
END

DELETE FROM ProblemReportTemporaryInteractions WHERE InteractionID = @InteractionID
SELECT @NewInteractionID
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractions2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReport2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[AddTemporaryNewEmail]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[AddDownloadInteraction]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetLastAccountsPageViewDate]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryInteraction2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetLastSupportPageViewDate]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetLastSupportAdminPageViewDate]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  View [dbo].[LastActivityDates]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LastActivityDates] with SCHEMABINDING AS
SELECT	ReportID, MAX(InteractionDate) AS LastActivityDate
FROM	dbo.ProblemReportInteractions
GROUP BY ReportID
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportInteractionAttachmentsHeadersGuest]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionVisibleGuest]  ]    Script Date: 14/12/2016 9:37:27******/
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

DECLARE @ReportID INT 
BEGIN
		-- Check if the report interaction is visible
		-- Private = 0
	SELECT @ReportID = ProblemReportInteractions.ReportID 
	FROM ProblemReportInteractions
	WHERE (InteractionID = @InteractionID) AND (Private = 0)
END
	-- Check if the report is visible for Guest Users.
EXEC IsProblemReportVisibleGuest @ReportID
GO
GO
/****** Object:  StoredProcedure [dbo].[GetEmailTokenAge]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryInteraction3]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[InitializeInteraction3]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[InitializeInteraction2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[InitializeInteraction]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporaryInteraction]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[AddTemporaryProblemReportInteraction]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReports]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportTemporary2]    Script Date: 12/14/2016 08:11:35 ******/
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
LEFT JOIN ProblemReportDefaultCategoriesResponsibles ON ProblemReportDefaultCategoriesResponsibles.CategoryID = ProblemReportsTemporary.CategoryID

WHERE ProblemReportsTemporary.ReportID = @ReportID
GO
/****** Object:  StoredProcedure [dbo].[IsProblemReportVisible]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[AddProblemReportCategorySubscriber]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[SetDefaultCategoryResponsible]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserCreationDate]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[IsMembershipActive]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveProblemReportCategorySubscriber]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[update_notes]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_notes] (@N_Noteid integer,@N_Contactid integer,@N_Datetime  datetime,@N_Text Text) as
update Notes set Contactid = @N_Contactid, Datetime = @N_Datetime, Text = @N_Text where Noteid = @N_Noteid
GO
/****** Object:  StoredProcedure [dbo].[update_notes_manus]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_notes_manus] (@N_Noteid integer,@N_Contactid integer,@N_Datetime  datetime,@N_Text varchar (100)) as update Notes set Contactid = @N_Contactid, Datetime = @N_Datetime, Text = @N_Text where Noteid = @N_Noteid
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportCategorySynopsis]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[AddContactsTemporary]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddContactsTemporary]
    @FirstName			VARCHAR(50),
	@LastName			VARCHAR(50),
	@Email				VARCHAR(150),
	@Newsletter			INT
AS
  DECLARE @Exist INT

  select @Exist=COUNT(*) from ContactsTemporary where Email = @Email 

  if @Exist = 0
  BEGIN
    INSERT INTO ContactsTemporary(FirstName, LastName, Email, Newsletter) Values (@FirstName, @LastName, @Email, @Newsletter)
  END
GO
/****** Object:  StoredProcedure [dbo].[IsProblemReportInteractionAttachmentVisibleGuest]    Script Date: 14/12/2016 9:47:07 ******/
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

@AttachmentID INT

AS

DECLARE @InteractionID INT

SELECT @InteractionID = InteractionID
FROM ProblemReportInteractionAttachments
WHERE AttachmentID = @AttachmentID

EXEC [dbo].[IsProblemReportInteractionVisibleGuest] @InteractionID
GO


/****** Object:  StoredProcedure [dbo].[GetDownloadExpirationTokenAge]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDownloadExpirationTokenAge]
 	@Token              VARCHAR(50)
AS
  DECLARE @Exist INT

  SET NOCOUNT ON;

  select @Exist=COUNT(*) from DownloadExpiration where Token = @Token 

  if @Exist = 1
  BEGIN
       select DATEDIFF(day,CreatedDate,getutcdate()) from DownloadExpiration where Token = @Token 
  END
  ELSE
	   Select -1
GO
/****** Object:  StoredProcedure [dbo].[InitializeDownload]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[InitializeDownload]
	-- Add the parameters for the stored procedure here
	@Email	            VARCHAR(150), 
	@Token              VARCHAR(50),
	@Platform	        VARCHAR(50),
	@Company			VARCHAR(100),
	@FirstName			VARCHAR(240),
	@LastName			VARCHAR(240)

	
AS
BEGIN TRANSACTION DownloadExpiration
INSERT INTO DownloadExpiration(Email, Token, Platform, Company, FirstName, LastName, CreatedDate) 
	VALUES (@Email,  @Token, @Platform, @Company, @FirstName, @LastName, GETUTCDATE())
COMMIT TRANSACTION DownloadExpiration
GO
/****** Object:  StoredProcedure [dbo].[UpdateTemporaryProblemReport]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[CleanupTemporaryProblemReports]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[update_questions]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_questions] (@N_Questionid integer,@N_Text varchar (500),@N_Type float) as update Questions set Text = @N_Text, Type = @N_Type where Questionid = @N_Questionid
GO
/****** Object:  StoredProcedure [dbo].[CleanupRegistrations]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[update_tasks]    Script Date: 12/14/2016 08:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_tasks] (@N_Taskid integer,@N_Taskname varchar (500),@N_Description varchar (500),@N_Query varchar (500),@N_Resulttype integer,@N_Stdcolumnresult varchar (500),@N_Deadline  datetime,@N_Duration float,@N_Filename varchar (500),@N_Tasktype integer) as update Tasks set Taskname = @N_Taskname, Description = @N_Description, Query = @N_Query, Resulttype = @N_Resulttype, Stdcolumnresult = @N_Stdcolumnresult, Deadline = @N_Deadline, Duration = @N_Duration, Filename = @N_Filename, Tasktype = @N_Tasktype where Taskid = @N_Taskid
GO
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForSearch2]    Script Date: 12/14/2016 08:11:35 ******/
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
/****** Object:  StoredProcedure [dbo].[GetProblemReportsForEdition2_old]    Script Date: 12/14/2016 08:11:35 ******/
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

/****** Object:  Default [DF_Memberships_RoleID]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Memberships] ADD  CONSTRAINT [DF_Memberships_RoleID]  DEFAULT (1) FOR [RoleID]
GO
/****** Object:  Default [DF_Memberships_QuestionID]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Memberships] ADD  CONSTRAINT [DF_Memberships_QuestionID]  DEFAULT (0) FOR [QuestionID]
GO
/****** Object:  Default [DF_ProblemReportInteractions_Private]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportInteractions] ADD  CONSTRAINT [DF_ProblemReportInteractions_Private]  DEFAULT (0) FOR [Private]
GO
/****** Object:  Default [DF_ProblemReportTemporaryInteractions_Private]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] ADD  CONSTRAINT [DF_ProblemReportTemporaryInteractions_Private]  DEFAULT (0) FOR [Private]
GO
/****** Object:  ForeignKey [FK_ProblemReportCategoriesResponsibles_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategoriesResponsibles_Contacts] FOREIGN KEY([ResponsibleID])
REFERENCES [dbo].[Contacts] ([ContactID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles] CHECK CONSTRAINT [FK_ProblemReportCategoriesResponsibles_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReportCategoriesResponsibles_ProblemReportCategories]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategoriesResponsibles_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles] CHECK CONSTRAINT [FK_ProblemReportCategoriesResponsibles_ProblemReportCategories]
GO
/****** Object:  ForeignKey [FK_ProblemReportsResponsibles_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportResponsibles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsResponsibles_Contacts] FOREIGN KEY([ResponsibleID])
REFERENCES [dbo].[Contacts] ([ContactID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportResponsibles] CHECK CONSTRAINT [FK_ProblemReportsResponsibles_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReportsResponsibles_ProblemReports]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportResponsibles]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportsResponsibles_ProblemReports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[ProblemReports] ([ReportID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportResponsibles] CHECK CONSTRAINT [FK_ProblemReportsResponsibles_ProblemReports]
GO
/****** Object:  ForeignKey [FK_Notes_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Notes]  WITH NOCHECK ADD  CONSTRAINT [FK_Notes_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_Notes_Contacts]
GO
/****** Object:  ForeignKey [FK_Registrations_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Registrations]  WITH NOCHECK ADD  CONSTRAINT [FK_Registrations_Contacts] FOREIGN KEY([Email])
REFERENCES [dbo].[Contacts] ([Email])
GO
ALTER TABLE [dbo].[Registrations] CHECK CONSTRAINT [FK_Registrations_Contacts]
GO
/****** Object:  ForeignKey [FK_Registrations_Memberships]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD  CONSTRAINT [FK_Registrations_Memberships] FOREIGN KEY([Username])
REFERENCES [dbo].[Memberships] ([Username])
GO
ALTER TABLE [dbo].[Registrations] CHECK CONSTRAINT [FK_Registrations_Memberships]
GO
/****** Object:  ForeignKey [FK_Memberships_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Memberships]  WITH NOCHECK ADD  CONSTRAINT [FK_Memberships_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [FK_Memberships_Contacts]
GO
/****** Object:  ForeignKey [FK_Memberships_Roles]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Memberships]  WITH NOCHECK ADD  CONSTRAINT [FK_Memberships_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [FK_Memberships_Roles]
GO
/****** Object:  ForeignKey [FK_Memberships_SecurityQuestions]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Memberships]  WITH NOCHECK ADD  CONSTRAINT [FK_Memberships_SecurityQuestions] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[SecurityQuestions] ([QuestionID])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [FK_Memberships_SecurityQuestions]
GO
/****** Object:  ForeignKey [FK_Consultings_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Consultings]  WITH CHECK ADD  CONSTRAINT [FK_Consultings_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Consultings] CHECK CONSTRAINT [FK_Consultings_Contacts]
GO
/****** Object:  ForeignKey [FK_Consultings_Purchases]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Consultings]  WITH CHECK ADD  CONSTRAINT [FK_Consultings_Purchases] FOREIGN KEY([PurchaseID])
REFERENCES [dbo].[Purchases] ([PurchaseID])
GO
ALTER TABLE [dbo].[Consultings] CHECK CONSTRAINT [FK_Consultings_Purchases]
GO
/****** Object:  ForeignKey [FK_Answers_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Answers]  WITH NOCHECK ADD  CONSTRAINT [FK_Answers_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Contacts]
GO
/****** Object:  ForeignKey [FK_Answers_Questions]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Answers]  WITH NOCHECK ADD  CONSTRAINT [FK_Answers_Questions] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Questions]
GO
/****** Object:  ForeignKey [FK_ProblemReportInteractions_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractions_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractions_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReportInteractions_ProblemReports]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractions_ProblemReports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[ProblemReports] ([ReportID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractions_ProblemReports]
GO
/****** Object:  ForeignKey [FK_ProblemReportInteractions_ProblemReportStatus]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractions_ProblemReportStatus] FOREIGN KEY([NewStatusID])
REFERENCES [dbo].[ProblemReportStatus] ([StatusID])
GO
ALTER TABLE [dbo].[ProblemReportInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractions_ProblemReportStatus]
GO
/****** Object:  ForeignKey [FK_EmailUpdate_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[UpdateEmail]  WITH CHECK ADD  CONSTRAINT [FK_EmailUpdate_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[UpdateEmail] CHECK CONSTRAINT [FK_EmailUpdate_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReportInteractionsTemp_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractionsTemp_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractionsTemp_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReportInteractionsTemp_ProblemReports]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractionsTemp_ProblemReports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[ProblemReports] ([ReportID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractionsTemp_ProblemReports]
GO
/****** Object:  ForeignKey [FK_ProblemReportTemporaryInteractions_ProblemReportCategory]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportTemporaryInteractions_ProblemReportCategory] FOREIGN KEY([NewCategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] CHECK CONSTRAINT [FK_ProblemReportTemporaryInteractions_ProblemReportCategory]
GO
/****** Object:  ForeignKey [FK_ProblemReportTemporaryInteractions_ProblemReportStatus]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportTemporaryInteractions_ProblemReportStatus] FOREIGN KEY([NewStatusID])
REFERENCES [dbo].[ProblemReportStatus] ([StatusID])
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] CHECK CONSTRAINT [FK_ProblemReportTemporaryInteractions_ProblemReportStatus]
GO
/****** Object:  ForeignKey [FK_Interactions_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Interactions]  WITH NOCHECK ADD  CONSTRAINT [FK_Interactions_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Interactions] CHECK CONSTRAINT [FK_Interactions_Contacts]
GO
/****** Object:  ForeignKey [FK_TemporaryEmails_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[TemporaryEmails]  WITH CHECK ADD  CONSTRAINT [FK_TemporaryEmails_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TemporaryEmails] CHECK CONSTRAINT [FK_TemporaryEmails_Contacts]
GO
/****** Object:  ForeignKey [FK_Purchases_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Purchases]  WITH NOCHECK ADD  CONSTRAINT [FK_Purchases_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Purchases] CHECK CONSTRAINT [FK_Purchases_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReports_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReports_ProblemReportCategories]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportCategories]
GO
/****** Object:  ForeignKey [FK_ProblemReports_ProblemReportClasses]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportClasses] FOREIGN KEY([ClassID])
REFERENCES [dbo].[ProblemReportClasses] ([ClassID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportClasses]
GO
/****** Object:  ForeignKey [FK_ProblemReports_ProblemReportPriorities]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportPriorities] FOREIGN KEY([PriorityID])
REFERENCES [dbo].[ProblemReportPriorities] ([PriorityID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportPriorities]
GO
/****** Object:  ForeignKey [FK_ProblemReports_ProblemReportSeverities]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportSeverities] FOREIGN KEY([SeverityID])
REFERENCES [dbo].[ProblemReportSeverities] ([SeverityID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportSeverities]
GO
/****** Object:  ForeignKey [FK_ProblemReports_ProblemReportStatus]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportStatus] FOREIGN KEY([StatusID])
REFERENCES [dbo].[ProblemReportStatus] ([StatusID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportStatus]
GO
/****** Object:  ForeignKey [FK_ProblemReportResponsiblesCategories_Contacts2]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportCategoriesSubscribers]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportResponsiblesCategories_Contacts2] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportCategoriesSubscribers] CHECK CONSTRAINT [FK_ProblemReportResponsiblesCategories_Contacts2]
GO
/****** Object:  ForeignKey [FK_ProblemReportResponsiblesCategories_ProblemReportCategories2]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportCategoriesSubscribers]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportResponsiblesCategories_ProblemReportCategories2] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportCategoriesSubscribers] CHECK CONSTRAINT [FK_ProblemReportResponsiblesCategories_ProblemReportCategories2]
GO
/****** Object:  ForeignKey [FK_ProblemReportsTemp_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReportsTemp_ProblemReportCategories]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_ProblemReportCategories]
GO
/****** Object:  ForeignKey [FK_ProblemReportsTemp_ProblemReportClasses]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_ProblemReportClasses] FOREIGN KEY([ClassID])
REFERENCES [dbo].[ProblemReportClasses] ([ClassID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_ProblemReportClasses]
GO
/****** Object:  ForeignKey [FK_ProblemReportsTemp_ProblemReportPriorities]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_ProblemReportPriorities] FOREIGN KEY([PriorityID])
REFERENCES [dbo].[ProblemReportPriorities] ([PriorityID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_ProblemReportPriorities]
GO
/****** Object:  ForeignKey [FK_ProblemReportsTemp_ProblemReportSeverities]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_ProblemReportSeverities] FOREIGN KEY([SeverityID])
REFERENCES [dbo].[ProblemReportSeverities] ([SeverityID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_ProblemReportSeverities]
GO
/****** Object:  ForeignKey [FK_ProblemReportResponsiblesCategories_Contacts]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportResponsiblesCategories]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportResponsiblesCategories_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportResponsiblesCategories] CHECK CONSTRAINT [FK_ProblemReportResponsiblesCategories_Contacts]
GO
/****** Object:  ForeignKey [FK_ProblemReportResponsiblesCategories_ProblemReportCategories]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportResponsiblesCategories]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportResponsiblesCategories_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportResponsiblesCategories] CHECK CONSTRAINT [FK_ProblemReportResponsiblesCategories_ProblemReportCategories]
GO
/****** Object:  ForeignKey [FK_ProblemReportAttachments_ProblemReportInteractions]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportInteractionAttachments]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportAttachments_ProblemReportInteractions] FOREIGN KEY([InteractionID])
REFERENCES [dbo].[ProblemReportInteractions] ([InteractionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportInteractionAttachments] CHECK CONSTRAINT [FK_ProblemReportAttachments_ProblemReportInteractions]
GO
/****** Object:  ForeignKey [FK_ProblemReportTemporaryInteractionAttachments_ProblemReportInteractions]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportTemporaryInteractionAttachments]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportTemporaryInteractionAttachments_ProblemReportInteractions] FOREIGN KEY([InteractionID])
REFERENCES [dbo].[ProblemReportTemporaryInteractions] ([InteractionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractionAttachments] CHECK CONSTRAINT [FK_ProblemReportTemporaryInteractionAttachments_ProblemReportInteractions]
GO
/****** Object:  ForeignKey [FK_Contacts_Countries]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Countries]
GO
/****** Object:  ForeignKey [FK_Contacts_Countries1]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Countries1] FOREIGN KEY([OrganizationCountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Countries1]
GO
/****** Object:  ForeignKey [FK_Contacts_Regions]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Regions] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Regions] ([RegionID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Regions]
GO
/****** Object:  ForeignKey [FK_Contacts_Regions1]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Regions1] FOREIGN KEY([OrganizationRegionID])
REFERENCES [dbo].[Regions] ([RegionID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Regions1]
GO
/****** Object:  ForeignKey [FK_SupportAdminPageViewDates_Memberships]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[SupportAdminPageViewDates]  WITH CHECK ADD  CONSTRAINT [FK_SupportAdminPageViewDates_Memberships] FOREIGN KEY([Username])
REFERENCES [dbo].[Memberships] ([Username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SupportAdminPageViewDates] CHECK CONSTRAINT [FK_SupportAdminPageViewDates_Memberships]
GO
/****** Object:  ForeignKey [FK_AccountsPageViewDates_Memberships]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[AccountsPageViewDates]  WITH CHECK ADD  CONSTRAINT [FK_AccountsPageViewDates_Memberships] FOREIGN KEY([Username])
REFERENCES [dbo].[Memberships] ([Username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccountsPageViewDates] CHECK CONSTRAINT [FK_AccountsPageViewDates_Memberships]
GO
/****** Object:  ForeignKey [FK_SupportPageViewDates_Memberships]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[SupportPageViewDates]  WITH CHECK ADD  CONSTRAINT [FK_SupportPageViewDates_Memberships] FOREIGN KEY([Username])
REFERENCES [dbo].[Memberships] ([Username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SupportPageViewDates] CHECK CONSTRAINT [FK_SupportPageViewDates_Memberships]
GO
/****** Object:  ForeignKey [FK_ProblemReportCategoriesroles_ProblemReportCategories]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportCategoriesRoles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategoriesroles_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportCategoriesRoles] CHECK CONSTRAINT [FK_ProblemReportCategoriesroles_ProblemReportCategories]
GO
/****** Object:  ForeignKey [FK_ProblemReportCategoriesroles_Roles]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportCategoriesRoles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategoriesroles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[ProblemReportCategoriesRoles] CHECK CONSTRAINT [FK_ProblemReportCategoriesroles_Roles]
GO
/****** Object:  ForeignKey [FK_ProblemReportCategories_ProblemReportCategoryGroups]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportCategories]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategories_ProblemReportCategoryGroups] FOREIGN KEY([CategoryGroupID])
REFERENCES [dbo].[ProblemReportCategoryGroups] ([CategoryGroupID])
GO
ALTER TABLE [dbo].[ProblemReportCategories] CHECK CONSTRAINT [FK_ProblemReportCategories_ProblemReportCategoryGroups]
GO
/****** Object:  ForeignKey [FK_ProblemReportTemporaryReportAttachments_ProblemReportsTemporary]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[ProblemReportTemporaryReportAttachments]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportTemporaryReportAttachments_ProblemReportsTemporary] FOREIGN KEY([ReportID])
REFERENCES [dbo].[ProblemReportsTemporary] ([ReportID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportTemporaryReportAttachments] CHECK CONSTRAINT [FK_ProblemReportTemporaryReportAttachments_ProblemReportsTemporary]
GO
/****** Object:  ForeignKey [FK_Payments_Purchases]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Purchases] FOREIGN KEY([PurchaseID])
REFERENCES [dbo].[Purchases] ([PurchaseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Purchases]
GO
/****** Object:  ForeignKey [FK_PresetRoles_Roles]    Script Date: 12/14/2016 08:11:35 ******/
ALTER TABLE [dbo].[PresetRoles]  WITH CHECK ADD  CONSTRAINT [FK_PresetRoles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[PresetRoles] CHECK CONSTRAINT [FK_PresetRoles_Roles]
GO
