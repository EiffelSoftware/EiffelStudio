USE [$(database_name)]
GO
SET IDENTITY_INSERT [dbo].[ProblemReportSeverities] ON 

INSERT [dbo].[ProblemReportSeverities] ([SeverityID], [SeveritySynopsis], [SeverityDescription]) VALUES (1, N'Critical', N'The product, component or concept is completely non operational. No workaround is known.')
INSERT [dbo].[ProblemReportSeverities] ([SeverityID], [SeveritySynopsis], [SeverityDescription]) VALUES (2, N'Serious', N'The product, component or concept is not working properly. Problems that would otherwise be considered critical are rated serious when a workaround is known.')
INSERT [dbo].[ProblemReportSeverities] ([SeverityID], [SeveritySynopsis], [SeverityDescription]) VALUES (3, N'Non-critical', N'The product, component or concept is working in general, but lacks features, has irritating behavior, does something wrong, or does not match its documentation.')
SET IDENTITY_INSERT [dbo].[ProblemReportSeverities] OFF
