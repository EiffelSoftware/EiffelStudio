USE [$(database_name)]
GO
SET IDENTITY_INSERT [dbo].[ProblemReportClasses] ON 

INSERT [dbo].[ProblemReportClasses] ([ClassID], [ClassSynopsis], [ClassDescription]) VALUES (1, N'Bug', N'A general product problem.')
INSERT [dbo].[ProblemReportClasses] ([ClassID], [ClassSynopsis], [ClassDescription]) VALUES (2, N'Installation', N'A problem with the installation of a product.')
INSERT [dbo].[ProblemReportClasses] ([ClassID], [ClassSynopsis], [ClassDescription]) VALUES (3, N'Documentation', N'A problem with documentation.')
INSERT [dbo].[ProblemReportClasses] ([ClassID], [ClassSynopsis], [ClassDescription]) VALUES (4, N'Feature Request', N'A request for a new feature, a change in behavior, etc.')
INSERT [dbo].[ProblemReportClasses] ([ClassID], [ClassSynopsis], [ClassDescription]) VALUES (5, N'Support', N' A support problem or question.')
SET IDENTITY_INSERT [dbo].[ProblemReportClasses] OFF
