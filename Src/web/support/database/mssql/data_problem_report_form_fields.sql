USE [$(database_name)]
GO
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'attachments', N'List of files that will be stored together with the description of the problem.')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'category', N'The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'class', N'The class of a problem can be one of the following:
<UL>
<LI><B>Bug</B>: A general product problem.</LI>
<LI><B>Documentation</B>: A problem with documentation.</LI>
<LI><B>Change Request</B>: A request for a change in behavior, etc.</LI>
<LI><B>Support</B>: A support problem or question.</LI>
<LI><B>Installation</B>: A problem with installing the product.</LI>
</UL>')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'confidential', N'Is the report considers confidential? If not, the material provided with the bug report can be published. For example, sample code can be used when helping other customers.')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'description', N'Precise description of the problem.')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'environment', N'Description of the environment where the problem occured: machine architecture, operating system, host and target types, libraries, pathnames, etc. On Unix, in addition to other information, execute the command uname -a and copy the result here.')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'priority', N'How soon the solution is required. Accepted values include:
<UL>
<LI><B>High</B>: A solution is needed as soon as possible.</LI>
<LI><B>Medium</B>: The problem should be solved in the next release.</LI>
<LI><B>Low</B>: The problem should be solved in a future release.</LI>
</UL>')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'release', N'Release or version number of the Eiffel product. Please be as specific as possible. For example, 5.6.0919 is better than 5.6.')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'severity', N'The severity of the problem. Accepted values include:
<UL>
<LI><B>Critical</B>: The product, component or concept is completely non operational. No workaround is known.</LI>
<LI><B>Serious</B>: The product, component or concept is not working properly. Problems that would otherwise be considered critical are rated serious when a workaround is known.</LI>
<LI><B>Non-critical</B>: The product, component or concept is working in general, but lacks features, has irritating behavior, does something wrong, or doesn''t match its documentation.</LI>
</UL>')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'synopsis', N'One-line summary of the problem. This information will be used as the subject of the problem and it should be short, but still descriptive enough to be different from other problem report subjects.')
INSERT [dbo].[ProblemReportFormFields] ([Title], [Description]) VALUES (N'to_reproduce', N'Example code, input, or activities to reproduce the problem. Eiffel Software uses the example code both to reproduce the problem and to test whether the problem is fixed. Include all precondition, inputs, outputs, conditions after the problem, and symptoms. Any additional important information should be included. Include all the details that would be necessary for someone else to recreate the problem reported, however obvious. Sometimes seemingly arbitrary or obvious information can point the way toward a solution.')
