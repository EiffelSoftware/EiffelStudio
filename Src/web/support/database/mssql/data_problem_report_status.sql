USE [$(database_name)]
GO
SET IDENTITY_INSERT [dbo].[ProblemReportStatus] ON 

INSERT [dbo].[ProblemReportStatus] ([StatusID], [StatusSynopsis], [StatusDescription]) VALUES (1, N'Open', N'The initial state of a Problem Report. This means the PR has been filed and the responsible person(s) notified.')
INSERT [dbo].[ProblemReportStatus] ([StatusID], [StatusSynopsis], [StatusDescription]) VALUES (2, N'Analyzed', N'The responsible person has analyzed the problem. The analysis should contain a preliminary evaluation of the problem and an estimate of the amount of time and resources necessary to solve the problem. It should also suggest possible workarounds.')
INSERT [dbo].[ProblemReportStatus] ([StatusID], [StatusSynopsis], [StatusDescription]) VALUES (3, N'Closed', N'A Problem Report is closed only when any changes have been integrated, documented, and tested, and the submitter has confirmed the solution')
INSERT [dbo].[ProblemReportStatus] ([StatusID], [StatusSynopsis], [StatusDescription]) VALUES (4, N'Suspended', N'Work on the problem has been postponed. This happens if a timely solution is not possible or is not cost-effective at the present time. The PR continues to exist, though a solution is not being actively sought. If the problem cannot be solved at all, it should be closed rather than suspended.')
INSERT [dbo].[ProblemReportStatus] ([StatusID], [StatusSynopsis], [StatusDescription]) VALUES (5, N'Won''t fix', N'Won''t fix problem report.')
SET IDENTITY_INSERT [dbo].[ProblemReportStatus] OFF
