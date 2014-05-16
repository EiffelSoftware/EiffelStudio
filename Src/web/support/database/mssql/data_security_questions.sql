USE [$(database_name)]
GO
SET IDENTITY_INSERT [dbo].[SecurityQuestions] ON 

INSERT [dbo].[SecurityQuestions] ([QuestionID], [Question]) VALUES (1, N'What is your city of birth?')
INSERT [dbo].[SecurityQuestions] ([QuestionID], [Question]) VALUES (2, N'What is your father''s middle name?')
INSERT [dbo].[SecurityQuestions] ([QuestionID], [Question]) VALUES (3, N'What street did you grow up on?')
INSERT [dbo].[SecurityQuestions] ([QuestionID], [Question]) VALUES (4, N'What is your mother''s maiden name?')
INSERT [dbo].[SecurityQuestions] ([QuestionID], [Question]) VALUES (5, N'What is your favorite movie?')
INSERT [dbo].[SecurityQuestions] ([QuestionID], [Question]) VALUES (6, N'Who is your favorite cartoon character?')
SET IDENTITY_INSERT [dbo].[SecurityQuestions] OFF
