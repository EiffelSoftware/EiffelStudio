USE [$(database_name)]
GO
SET IDENTITY_INSERT [dbo].[ProblemReportCategoryGroups] ON 

INSERT [dbo].[ProblemReportCategoryGroups] ([CategoryGroupID], [CategoryGroupSynopsis]) VALUES (1, N'Libraries')
INSERT [dbo].[ProblemReportCategoryGroups] ([CategoryGroupID], [CategoryGroupSynopsis]) VALUES (2, N'Tools')
INSERT [dbo].[ProblemReportCategoryGroups] ([CategoryGroupID], [CategoryGroupSynopsis]) VALUES (3, N'Technologies')
INSERT [dbo].[ProblemReportCategoryGroups] ([CategoryGroupID], [CategoryGroupSynopsis]) VALUES (4, N'Other')
SET IDENTITY_INSERT [dbo].[ProblemReportCategoryGroups] OFF
