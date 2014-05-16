USE [$(database_name)]
GO
/****** Object:  Table [dbo].[AccountsPageViewDates]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_AccountsPageViewDates] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Answers]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Codes]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Consultings]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Contacts_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactsNoEmail]    Script Date: 08/04/2014 14:49:57 ******/
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
/****** Object:  Table [dbo].[Countries]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CountryMappingsTemp]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[eccountries]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ecregions]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailLists]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ForbiddenEmails]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Interactions]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InteractionType]    Script Date: 08/04/2014 14:49:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InteractionType](
	[InteractionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[InteractionTypeDescription] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Memberships]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Memberships] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notes]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payments]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PresetRoles]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportCategories]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_ProblemReportCategories] UNIQUE NONCLUSTERED 
(
	[CategorySynopsis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportCategoriesRoles]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProblemReportCategoriesSubscribers]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProblemReportCategoryGroups]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportClasses]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportDefaultCategoriesResponsibles]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProblemReportFormFields]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportInteractionAttachments]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportInteractions]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProblemReportPriorities]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportResponsibles]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProblemReportResponsiblesCategories]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProblemReports]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_ProblemReports] UNIQUE NONCLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportSeverities]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportStatus]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportsTemporary]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportTemporaryInteractionAttachments]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProblemReportTemporaryInteractions]    Script Date: 08/04/2014 14:49:57 ******/
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
 CONSTRAINT [PK_ProblemReportInteractionsTemp] PRIMARY KEY CLUSTERED 
(
	[InteractionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProblemReportTemporaryReportAttachments]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Products]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Regions]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Registrations]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SecurityQuestions]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Support]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SupportAdminPageViewDates]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_SupportAdminPageViewDates] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SupportPageViewDates]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_SupportPageViewDates] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TemporaryEmails]    Script Date: 08/04/2014 14:49:57 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Memberships] ADD  CONSTRAINT [DF_Memberships_RoleID]  DEFAULT (1) FOR [RoleID]
GO
ALTER TABLE [dbo].[Memberships] ADD  CONSTRAINT [DF_Memberships_QuestionID]  DEFAULT (0) FOR [QuestionID]
GO
ALTER TABLE [dbo].[ProblemReportInteractions] ADD  CONSTRAINT [DF_ProblemReportInteractions_Private]  DEFAULT (0) FOR [Private]
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] ADD  CONSTRAINT [DF_ProblemReportTemporaryInteractions_Private]  DEFAULT (0) FOR [Private]
GO
ALTER TABLE [dbo].[AccountsPageViewDates]  WITH CHECK ADD  CONSTRAINT [FK_AccountsPageViewDates_Memberships] FOREIGN KEY([Username])
REFERENCES [dbo].[Memberships] ([Username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccountsPageViewDates] CHECK CONSTRAINT [FK_AccountsPageViewDates_Memberships]
GO
ALTER TABLE [dbo].[Answers]  WITH NOCHECK ADD  CONSTRAINT [FK_Answers_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Contacts]
GO
ALTER TABLE [dbo].[Answers]  WITH NOCHECK ADD  CONSTRAINT [FK_Answers_Questions] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Questions]
GO
ALTER TABLE [dbo].[Consultings]  WITH CHECK ADD  CONSTRAINT [FK_Consultings_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Consultings] CHECK CONSTRAINT [FK_Consultings_Contacts]
GO
ALTER TABLE [dbo].[Consultings]  WITH CHECK ADD  CONSTRAINT [FK_Consultings_Purchases] FOREIGN KEY([PurchaseID])
REFERENCES [dbo].[Purchases] ([PurchaseID])
GO
ALTER TABLE [dbo].[Consultings] CHECK CONSTRAINT [FK_Consultings_Purchases]
GO
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Countries]
GO
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Countries1] FOREIGN KEY([OrganizationCountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Countries1]
GO
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Regions] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Regions] ([RegionID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Regions]
GO
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Regions1] FOREIGN KEY([OrganizationRegionID])
REFERENCES [dbo].[Regions] ([RegionID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Regions1]
GO
ALTER TABLE [dbo].[Interactions]  WITH NOCHECK ADD  CONSTRAINT [FK_Interactions_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Interactions] CHECK CONSTRAINT [FK_Interactions_Contacts]
GO
ALTER TABLE [dbo].[Memberships]  WITH NOCHECK ADD  CONSTRAINT [FK_Memberships_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [FK_Memberships_Contacts]
GO
ALTER TABLE [dbo].[Memberships]  WITH NOCHECK ADD  CONSTRAINT [FK_Memberships_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [FK_Memberships_Roles]
GO
ALTER TABLE [dbo].[Memberships]  WITH NOCHECK ADD  CONSTRAINT [FK_Memberships_SecurityQuestions] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[SecurityQuestions] ([QuestionID])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [FK_Memberships_SecurityQuestions]
GO
ALTER TABLE [dbo].[Notes]  WITH NOCHECK ADD  CONSTRAINT [FK_Notes_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_Notes_Contacts]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Purchases] FOREIGN KEY([PurchaseID])
REFERENCES [dbo].[Purchases] ([PurchaseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Purchases]
GO
ALTER TABLE [dbo].[PresetRoles]  WITH CHECK ADD  CONSTRAINT [FK_PresetRoles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[PresetRoles] CHECK CONSTRAINT [FK_PresetRoles_Roles]
GO
ALTER TABLE [dbo].[ProblemReportCategories]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategories_ProblemReportCategoryGroups] FOREIGN KEY([CategoryGroupID])
REFERENCES [dbo].[ProblemReportCategoryGroups] ([CategoryGroupID])
GO
ALTER TABLE [dbo].[ProblemReportCategories] CHECK CONSTRAINT [FK_ProblemReportCategories_ProblemReportCategoryGroups]
GO
ALTER TABLE [dbo].[ProblemReportCategoriesRoles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategoriesroles_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportCategoriesRoles] CHECK CONSTRAINT [FK_ProblemReportCategoriesroles_ProblemReportCategories]
GO
ALTER TABLE [dbo].[ProblemReportCategoriesRoles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategoriesroles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[ProblemReportCategoriesRoles] CHECK CONSTRAINT [FK_ProblemReportCategoriesroles_Roles]
GO
ALTER TABLE [dbo].[ProblemReportCategoriesSubscribers]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportResponsiblesCategories_Contacts2] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportCategoriesSubscribers] CHECK CONSTRAINT [FK_ProblemReportResponsiblesCategories_Contacts2]
GO
ALTER TABLE [dbo].[ProblemReportCategoriesSubscribers]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportResponsiblesCategories_ProblemReportCategories2] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportCategoriesSubscribers] CHECK CONSTRAINT [FK_ProblemReportResponsiblesCategories_ProblemReportCategories2]
GO
ALTER TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategoriesResponsibles_Contacts] FOREIGN KEY([ResponsibleID])
REFERENCES [dbo].[Contacts] ([ContactID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles] CHECK CONSTRAINT [FK_ProblemReportCategoriesResponsibles_Contacts]
GO
ALTER TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportCategoriesResponsibles_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportDefaultCategoriesResponsibles] CHECK CONSTRAINT [FK_ProblemReportCategoriesResponsibles_ProblemReportCategories]
GO
ALTER TABLE [dbo].[ProblemReportInteractionAttachments]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportAttachments_ProblemReportInteractions] FOREIGN KEY([InteractionID])
REFERENCES [dbo].[ProblemReportInteractions] ([InteractionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportInteractionAttachments] CHECK CONSTRAINT [FK_ProblemReportAttachments_ProblemReportInteractions]
GO
ALTER TABLE [dbo].[ProblemReportInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractions_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractions_Contacts]
GO
ALTER TABLE [dbo].[ProblemReportInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractions_ProblemReports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[ProblemReports] ([ReportID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractions_ProblemReports]
GO
ALTER TABLE [dbo].[ProblemReportInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractions_ProblemReportStatus] FOREIGN KEY([NewStatusID])
REFERENCES [dbo].[ProblemReportStatus] ([StatusID])
GO
ALTER TABLE [dbo].[ProblemReportInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractions_ProblemReportStatus]
GO
ALTER TABLE [dbo].[ProblemReportResponsibles]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsResponsibles_Contacts] FOREIGN KEY([ResponsibleID])
REFERENCES [dbo].[Contacts] ([ContactID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportResponsibles] CHECK CONSTRAINT [FK_ProblemReportsResponsibles_Contacts]
GO
ALTER TABLE [dbo].[ProblemReportResponsibles]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportsResponsibles_ProblemReports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[ProblemReports] ([ReportID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportResponsibles] CHECK CONSTRAINT [FK_ProblemReportsResponsibles_ProblemReports]
GO
ALTER TABLE [dbo].[ProblemReportResponsiblesCategories]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportResponsiblesCategories_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportResponsiblesCategories] CHECK CONSTRAINT [FK_ProblemReportResponsiblesCategories_Contacts]
GO
ALTER TABLE [dbo].[ProblemReportResponsiblesCategories]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportResponsiblesCategories_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportResponsiblesCategories] CHECK CONSTRAINT [FK_ProblemReportResponsiblesCategories_ProblemReportCategories]
GO
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_Contacts]
GO
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportCategories]
GO
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportClasses] FOREIGN KEY([ClassID])
REFERENCES [dbo].[ProblemReportClasses] ([ClassID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportClasses]
GO
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportPriorities] FOREIGN KEY([PriorityID])
REFERENCES [dbo].[ProblemReportPriorities] ([PriorityID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportPriorities]
GO
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportSeverities] FOREIGN KEY([SeverityID])
REFERENCES [dbo].[ProblemReportSeverities] ([SeverityID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportSeverities]
GO
ALTER TABLE [dbo].[ProblemReports]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReports_ProblemReportStatus] FOREIGN KEY([StatusID])
REFERENCES [dbo].[ProblemReportStatus] ([StatusID])
GO
ALTER TABLE [dbo].[ProblemReports] CHECK CONSTRAINT [FK_ProblemReports_ProblemReportStatus]
GO
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_Contacts]
GO
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_ProblemReportCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProblemReportCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_ProblemReportCategories]
GO
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_ProblemReportClasses] FOREIGN KEY([ClassID])
REFERENCES [dbo].[ProblemReportClasses] ([ClassID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_ProblemReportClasses]
GO
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_ProblemReportPriorities] FOREIGN KEY([PriorityID])
REFERENCES [dbo].[ProblemReportPriorities] ([PriorityID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_ProblemReportPriorities]
GO
ALTER TABLE [dbo].[ProblemReportsTemporary]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportsTemp_ProblemReportSeverities] FOREIGN KEY([SeverityID])
REFERENCES [dbo].[ProblemReportSeverities] ([SeverityID])
GO
ALTER TABLE [dbo].[ProblemReportsTemporary] CHECK CONSTRAINT [FK_ProblemReportsTemp_ProblemReportSeverities]
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractionAttachments]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportTemporaryInteractionAttachments_ProblemReportInteractions] FOREIGN KEY([InteractionID])
REFERENCES [dbo].[ProblemReportTemporaryInteractions] ([InteractionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractionAttachments] CHECK CONSTRAINT [FK_ProblemReportTemporaryInteractionAttachments_ProblemReportInteractions]
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractionsTemp_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractionsTemp_Contacts]
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportInteractionsTemp_ProblemReports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[ProblemReports] ([ReportID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] CHECK CONSTRAINT [FK_ProblemReportInteractionsTemp_ProblemReports]
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemReportTemporaryInteractions_ProblemReportStatus] FOREIGN KEY([NewStatusID])
REFERENCES [dbo].[ProblemReportStatus] ([StatusID])
GO
ALTER TABLE [dbo].[ProblemReportTemporaryInteractions] CHECK CONSTRAINT [FK_ProblemReportTemporaryInteractions_ProblemReportStatus]
GO
ALTER TABLE [dbo].[ProblemReportTemporaryReportAttachments]  WITH CHECK ADD  CONSTRAINT [FK_ProblemReportTemporaryReportAttachments_ProblemReportsTemporary] FOREIGN KEY([ReportID])
REFERENCES [dbo].[ProblemReportsTemporary] ([ReportID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProblemReportTemporaryReportAttachments] CHECK CONSTRAINT [FK_ProblemReportTemporaryReportAttachments_ProblemReportsTemporary]
GO
ALTER TABLE [dbo].[Purchases]  WITH NOCHECK ADD  CONSTRAINT [FK_Purchases_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Purchases] CHECK CONSTRAINT [FK_Purchases_Contacts]
GO
ALTER TABLE [dbo].[Registrations]  WITH NOCHECK ADD  CONSTRAINT [FK_Registrations_Contacts] FOREIGN KEY([Email])
REFERENCES [dbo].[Contacts] ([Email])
GO
ALTER TABLE [dbo].[Registrations] CHECK CONSTRAINT [FK_Registrations_Contacts]
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD  CONSTRAINT [FK_Registrations_Memberships] FOREIGN KEY([Username])
REFERENCES [dbo].[Memberships] ([Username])
GO
ALTER TABLE [dbo].[Registrations] CHECK CONSTRAINT [FK_Registrations_Memberships]
GO
ALTER TABLE [dbo].[SupportAdminPageViewDates]  WITH CHECK ADD  CONSTRAINT [FK_SupportAdminPageViewDates_Memberships] FOREIGN KEY([Username])
REFERENCES [dbo].[Memberships] ([Username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SupportAdminPageViewDates] CHECK CONSTRAINT [FK_SupportAdminPageViewDates_Memberships]
GO
ALTER TABLE [dbo].[SupportPageViewDates]  WITH CHECK ADD  CONSTRAINT [FK_SupportPageViewDates_Memberships] FOREIGN KEY([Username])
REFERENCES [dbo].[Memberships] ([Username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SupportPageViewDates] CHECK CONSTRAINT [FK_SupportPageViewDates_Memberships]
GO
ALTER TABLE [dbo].[TemporaryEmails]  WITH CHECK ADD  CONSTRAINT [FK_TemporaryEmails_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TemporaryEmails] CHECK CONSTRAINT [FK_TemporaryEmails_Contacts]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InteractionType', @level2type=N'COLUMN',@level2name=N'InteractionTypeId'
GO
