note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	test: "type/manual"
	testing:"execution/serial"



class
	ESA_REGISTER_USER_TEST

inherit

	ESA_ABSTRACT_DATABASE_TEST


feature -- Test routines

	test_register_new_user
			-- Register a new user successfuly
		local
			l_token: STRING
			l_parameters_memberships: STRING_TABLE[STRING]
			l_parameters_register: STRING_TABLE[STRING]
			l_parameters_contact: STRING_TABLE[STRING]
		do
--			new_user ("esa", "api", "esapirest@gmail.com", "esapi", "pwd123", "testing", security.token, 1)

				--Not exist the user name
			create l_parameters_memberships.make (1)
			l_parameters_memberships.put ("esapi",{ESA_DATA_PARAMETERS_NAMES}.Username_param)
			assert ("Expect: Username not a membership", not exist (sql_exist_memberships, l_parameters_memberships))

				--Not is trying to register
			create l_parameters_register.make (2)
			l_parameters_register.put ("esapi",{ESA_DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters_register.put ("esapirest@gmail.com",{ESA_DATA_PARAMETERS_NAMES}.Email_param)
			assert ("Expect: Username/Email not registered", not exist (sql_exist_registration, l_parameters_register))

				-- Email is not registered
			create l_parameters_contact.make (1)
			l_parameters_contact.put ("esapirest@gmail.com",{ESA_DATA_PARAMETERS_NAMES}.Email_param)
			assert ("Expect: Email is not a contact", not exist (sql_exist_contact, l_parameters_contact))

				-- Add user
			database_provider.add_user ("esa", "api", "esapirest@gmail.com", "esapi", "pwd123", "testing", security.token, 1)

				-- Check the user exist
			assert ("Expect: Username a membership", exist (sql_exist_memberships, l_parameters_memberships))

				-- Check exit registration
			assert ("Expect: Username/Email not registered", exist (sql_exist_registration, l_parameters_register))

				-- Check exit contact
			assert ("Expect: Email is a contact", exist (sql_exist_contact, l_parameters_contact))
		end

	test_register_new_user_email_already_exist
			-- Trying to register a new user, but the email, already exist!!!.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				new_user ("esa", "api", "esapirest@gmail.com", "esapi", "pwd123", "testing", security.token, 1)
				new_user ("new_esa", "new_api", "esapirest@gmail.com", "new_esapi", "new_pwd123", "new_testing", security.token, 2)
				assert ("Not expected execute this assert, the e_mail already exist", False)
			else
				assert ("Expected Failed, email already exist",  True)
			end
		rescue
			l_retried := True
			retry
		end



feature -- Factories

	new_user (a_first_name, a_last_name, a_email, a_username, a_password, a_answer, a_token: STRING; a_question_id: INTEGER)
		local
			l_token: STRING
			l_parameters_memberships: STRING_TABLE[STRING]
			l_parameters_register: STRING_TABLE[STRING]
			l_parameters_contact: STRING_TABLE[STRING]
		do
				--Not exist the user name
			create l_parameters_memberships.make (1)
			l_parameters_memberships.put (a_username,{ESA_DATA_PARAMETERS_NAMES}.Username_param)
			assert ("Expect: Username not a membership", not exist (sql_exist_memberships, l_parameters_memberships))

				--Not is trying to register
			create l_parameters_register.make (2)
			l_parameters_register.put (a_username,{ESA_DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters_register.put (a_email,{ESA_DATA_PARAMETERS_NAMES}.Email_param)
			assert ("Expect: Username/Email not registered", not exist (sql_exist_registration, l_parameters_register))

				-- Email is not registered
			create l_parameters_contact.make (1)
			l_parameters_contact.put (a_email,{ESA_DATA_PARAMETERS_NAMES}.Email_param)
			assert ("Expect: Email is not a contact", not exist (sql_exist_contact, l_parameters_contact))

				-- Add user
			database_provider.add_user (a_first_name, a_last_name, a_email, a_username, a_password, a_answer, a_token, a_question_id)

				-- Check the user exist
			assert ("Expect: Username a membership", exist (sql_exist_memberships, l_parameters_memberships))

				-- Check exit registration
			assert ("Expect: Username/Email not registered", exist (sql_exist_registration, l_parameters_register))

				-- Check exit contact
			assert ("Expect: Email is a contact", exist (sql_exist_contact, l_parameters_contact))

		end

feature -- SQL Queries.

		sql_exist_memberships: STRING = "SELECT COUNT(*) FROM Memberships WHERE Username = :Username"
			-- Exist the username?

		sql_exist_registration: STRING = "SELECT COUNT(*) FROM Registrations WHERE Username = :Username or Email = :Email"
			-- is username/email trying to register?

		sql_exist_contact: STRING =  "SELECT COUNT(*) FROM Contacts	WHERE Email = :Email"
			-- is the email alreadt registered?

end


