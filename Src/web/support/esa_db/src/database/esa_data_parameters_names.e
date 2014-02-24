note
	description: "Stored procedures paramters names"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATA_PARAMETERS_NAMES

feature -- Access

	Contactid_param: STRING = "ContactID"

	Username_param: STRING =  "Username"

	Submitter_username_param: STRING = "SubmitterUsername"

	Responsibleid_param: STRING =  "Responsible"

	Email_param: STRING = "Email"

	Synopsis_param: STRING = "Synopsis"

	Openonly_param: STRING = "OpenOnly"

	Number_param: STRING = "Number"

	Categoryid_param: STRING = "CategoryID"

	Category_synopsis_param: STRING = "CategorySynopsis"

	Statusid_param: STRING = "StatusID"

	Private_param: STRING = "Private"

	Priorityid_param: STRING = "PriorityID"

	Severityid_param: STRING = "SeverityID"

	Searchtext_param: STRING = "SearchText"

	Searchsynopsis_param: STRING = "SearchSynopsis"

	Searchdescription_param: STRING = "SearchDescription"

	Reportid_param: STRING = "ReportID"

	Interactionid_param: STRING = "InteractionID"

	Attachmentid_param: STRING = "AttachmentID"

	Fieldtitle_param: STRING = "FieldTitle"

	Passwordhash_param: STRING = "PasswordHash"

	Registrationtoken_param: STRING = "RegistrationToken"

	Answerhash_param: STRING = "AnswerHash"

	Classid_param: STRING = "Classid"

	Confidential_param: STRING = "Confidential"

	Release_param: STRING = "Release"

	Environment_param: STRING = "Environment"

	Description_param: STRING = "Description"

	Toreproduce_param: STRING = "ToReproduce"

	Content_param: STRING = "Content"

	Alreadyexists_param: STRING = "AlreadyExists"

	Firstname_param: STRING = "FirstName"

	Lastname_param: STRING = "LastName"

	Responsible_param: STRING = "Responsible"

	Responsible_firstname_param: STRING = "ResponsibleFirstName"

	Responsible_lastname_param: STRING = "ResponsibleLastName"

	Length_param: STRING = "Length"

	Filename_param: STRING = "Filename"

	Position_param: STRING = "Position"

	Address_param: STRING = "Address"

	City_param: STRING = "City"

	Country_param: STRING = "Country"

	Region_param: STRING = "Region"

	Code_param: STRING = "Code"

	Tel_param: STRING = "Tel"

	Fax_param: STRING = "Fax"

	Name_param: STRING = "Name"

	Url_param: STRING = "URL"

feature -- Login

--	Passwordhash_param: STRING = "PasswordHash"

--	Registrationtoken_param: STRING = "RegistrationToken"

--	Answerhash_param: STRING = "AnswerHash"

	Passwordsalt_param: STRING = "PasswordSalt"

	Answersalt_param: STRING = "AnswerSalt"

	Questionid_param: STRING = "QuestionID"


end
