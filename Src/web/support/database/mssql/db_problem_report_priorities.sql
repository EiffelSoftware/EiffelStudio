USE [$(database_name)]
GO
SET IDENTITY_INSERT [dbo].[ProblemReportPriorities] ON 

INSERT [dbo].[ProblemReportPriorities] ([PriorityID], [PrioritySynopsis], [PriorityDescription]) VALUES (1, N'High', N'A solution is needed as soon as possible.')
INSERT [dbo].[ProblemReportPriorities] ([PriorityID], [PrioritySynopsis], [PriorityDescription]) VALUES (2, N'Medium', N'The problem should be solved in the next release.')
INSERT [dbo].[ProblemReportPriorities] ([PriorityID], [PrioritySynopsis], [PriorityDescription]) VALUES (3, N'Low', N'The problem should be solved in a future release.')
SET IDENTITY_INSERT [dbo].[ProblemReportPriorities] OFF

