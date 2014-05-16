USE [$(database_name)]
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleSynopsis], [RoleDescription]) VALUES (1, N'User', N'Eiffel Software web site user.')
INSERT [dbo].[Roles] ([RoleID], [RoleSynopsis], [RoleDescription]) VALUES (2, N'Admin', N'Eiffel Software web site administrator.')
INSERT [dbo].[Roles] ([RoleID], [RoleSynopsis], [RoleDescription]) VALUES (3, N'InternalUser', N'Internal user, has access to special pr categories but cannot edit web site.')
INSERT [dbo].[Roles] ([RoleID], [RoleSynopsis], [RoleDescription]) VALUES (4, N'Responsible', N'Eiffel Software developer, responsible for fixing reported problems.')
SET IDENTITY_INSERT [dbo].[Roles] OFF
