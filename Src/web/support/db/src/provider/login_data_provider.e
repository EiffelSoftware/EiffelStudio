note
	description: "Database access for login uses cases."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_DATA_PROVIDER

inherit

	PARAMETER_NAME_HELPER

	SHARED_ERROR

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- Create a data provider.
		do
			create {DATABASE_HANDLER_IMPL} db_handler.make (a_connection)
			post_execution
		end

	db_handler: DATABASE_HANDLER
			-- Db handler.

feature -- Status Report

	is_successful: BOOLEAN
			-- Is the last execution sucessful?
		do
			Result := db_handler.successful
		end

feature -- Access: Auth Session

	user_by_session_token (a_token: READABLE_STRING_8): detachable USER
			-- Retrieve user by token `a_token', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_debug (generator + ".user_by_session_token for a_token:" + a_token )
			create l_parameters.make (1)
			l_parameters.put (a_token, "Token")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_user_by_session_token, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				create Result.make ("")
				if attached db_handler.read_string (1) as l_item_name then
					create Result.make (l_item_name)
				end
			end
			post_execution
		end

	has_user_token (a_user: USER): BOOLEAN
			-- Has the user `a_user' and associated session token?
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_debug (generator + ".has_user_token for a_user:" + a_user.name.to_string_8 )
			create l_parameters.make (1)
			l_parameters.put (a_user.id, "uid")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_has_user_token, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				if attached db_handler.read_integer_32 (1) as l_count and then
				   l_count > 0
				then
					Result := True
				end
			end
			post_execution
		end

feature -- Change Auth Session

	new_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: USER; a_maxage: INTEGER)
			-- New user session for user `a_user' with token `a_token' and max_age `a_maxage'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_debug (generator + ".new_user_session_auth for a_user:" + a_user.name.to_string_8 )
			create l_parameters.make (3)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "date")
			l_parameters.put (a_maxage, "max_age")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (SQL_insert_session_auth, l_parameters))
			db_handler.execute_query
			post_execution
		end

	update_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: USER; a_maxage: INTEGER)
			-- Update user session for user `a_user' with token `a_token'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_debug (generator + ".update_user_session_auth for a_user:" + a_user.name.to_string_8 )
			create l_parameters.make (3)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "date")
			l_parameters.put (a_maxage, "max_age")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (SQL_update_session_auth, l_parameters))
			db_handler.execute_query
			post_execution
		end

feature -- Access

	countries: DATABASE_ITERATION_CURSOR [COUNTRY]
			-- Countries.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			debug
				log.write_information (generator + ".countries")
			end
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_countries, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_country)
			post_execution
		end

	token_from_email (a_email: READABLE_STRING_8): detachable STRING
			-- Activation token for user with email `a_email' if any.
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".token_from_email")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 100), {DATA_PARAMETERS_NAMES}.email_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetRegistrationToken", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
			end
			post_execution
		end

	token_from_username (a_username: READABLE_STRING_32): detachable STRING
			-- Activation token for user with username `a_username', if any.
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".token_from_username")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.email_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetRegistrationTokenFromUsername", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
			end

			post_execution
		end

	membership_creation_date (a_username: READABLE_STRING_32): detachable DATE_TIME
			-- Creation date of membership of user with username `a_username'.
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".membership_creation_date")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetMembershipCreationDate", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_date_time (1)
			end
			post_execution
		end

	role (a_username: READABLE_STRING_32): detachable STRING_32
			-- Role associated with user with username `a_username'.
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".role")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetRole", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string_32 (1)
				to_implement ("handle error: User not found - Retrieval of user role")
			end
			post_execution
		end

	role_description (a_synopsis: READABLE_STRING_32): detachable STRING_32
			-- Role description for role with synopsis `a_synopsis'.
		require
			attached_synopsis: a_synopsis /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".role_description")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_synopsis, 50), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetRoleDescription", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string_32 (1)
				to_implement ("handle error: Role not found -  Retrieval of role description")
			end
			post_execution
		end

	security_questions: DATABASE_ITERATION_CURSOR [SECURITY_QUESTION]
			--	Security questions.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator+".security_questions")
			end
			create l_parameters.make (0)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetSecurityQuestions", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_security_question)
			post_execution
		end

	question_from_email (a_email: READABLE_STRING_8): detachable STRING_8
			-- Security question associated with account with email `a_email' if any.
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".question_from_email")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email.to_string_32, 100), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetQuestionFromEmail", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
			end
			post_execution
		end

	user_creation_date (a_username: STRING): detachable DATE_TIME
			-- Last accounts admin page view date for user `a_username'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".user_creation_date")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetUserCreationDate", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_date_time (1)
			end
			post_execution
		end

	contact_from_email (a_email: STRING): detachable TUPLE [first_name: STRING; last_name: STRING]
			-- Contact with email `a_email' if any.
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".contact_from_email")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 100), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetContactFromEmail", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := new_contact
			end
			post_execution
		end

	user_from_email (a_email: READABLE_STRING_8): detachable TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]
			-- User with email `a_email' if any.
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".user_from_email")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 100), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetUserFromEmail", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := new_user
			end
			post_execution
		end

	user_from_username (a_username: READABLE_STRING_32): detachable USER
			-- User with username `a_username' if any.
		require
			attached_username: a_username /= Void
		local
			l_parameters: STRING_TABLE[ANY]
		do
			debug
				log.write_information (generator + ".user_from_username")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_user_from_username, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				if attached db_handler.read_integer_32 (1) as l_contactid then
					create Result.make (a_username)
					Result.set_id (l_contactid)
				end
			end
			post_execution
		end

	user_information (a_username: READABLE_STRING_32): USER_INFORMATION
			-- Full user information from username.
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".user_information")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetUserInformation", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := new_user_account_information (a_username)
			else
				create Result.make (a_username)
			end
			post_execution
		end

feature -- Element Settings

	remove_user (a_username: READABLE_STRING_32)
			-- Remove user with username `a_username' from database.
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".remove_user")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("RemoveUser", l_parameters))
			db_handler.execute_writer
			post_execution
		end


	remove_token (a_token: STRING)
				-- Remove token  `a_token' from database.
		require
			attached_token: a_token /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".remove_token")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_token, 7), {DATA_PARAMETERS_NAMES}.registrationtoken_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("RemoveRegistrationToken", l_parameters))
			db_handler.execute_writer
			post_execution
		end

	update_password (a_email: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL)
			-- Update password of user with email `a_email'.
		require
			attached_email: a_email /= Void
			attached_password: a_password /= Void
		local
			l_security: SECURITY_PROVIDER
			l_password_salt, l_password_hash: STRING
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".update_password")
			end
			create l_security
			l_password_salt := l_security.salt
			l_password_hash := l_security.password_hash (a_password.to_string_8, l_password_salt)

			create l_parameters.make (3)
			l_parameters.put (string_parameter (a_email, 100), {DATA_PARAMETERS_NAMES}.email_param)
			l_parameters.put (string_parameter (l_password_hash, 40), {DATA_PARAMETERS_NAMES}.passwordhash_param)
			l_parameters.put (string_parameter (l_password_salt, 24), {DATA_PARAMETERS_NAMES}.passwordsalt_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("UpdatePasswordFromEmail", l_parameters))
			db_handler.execute_writer
			post_execution
		end

	update_email_from_user_and_token (a_token: READABLE_STRING_32; a_user: READABLE_STRING_32)
			-- Update email of user with email `a_email'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".update_email_from_user_and_token")
			end
			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_user, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (string_parameter (a_token, 50), {DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("UpdateEmailFromUserAndToken", l_parameters))
			db_handler.execute_writer
			post_execution
		end


	update_personal_information (a_username: READABLE_STRING_GENERAL; a_first_name, a_last_name, a_position, a_address, a_city, a_country, a_region, a_code, a_tel, a_fax: detachable READABLE_STRING_GENERAL)
			-- Update personal information of user with username `a_username'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".update_personal_information")
			end
			create l_parameters.make (11)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			if attached a_first_name then
				l_parameters.put (string_parameter (a_first_name, 50), {DATA_PARAMETERS_NAMES}.Firstname_param)
			end
			if attached a_last_name then
				l_parameters.put (string_parameter (a_last_name, 50), {DATA_PARAMETERS_NAMES}.Lastname_param)
			end
			if attached a_position then
				l_parameters.put (string_parameter (a_position, 50), {DATA_PARAMETERS_NAMES}.Position_param)
			end
			if attached a_address then
				l_parameters.put (string_parameter (a_address, 500), {DATA_PARAMETERS_NAMES}.Address_param)
			end
			if attached a_city then
				l_parameters.put (string_parameter (a_city, 50), {DATA_PARAMETERS_NAMES}.City_param)
			end
			if attached a_country then
				l_parameters.put (string_parameter (a_country, 50), {DATA_PARAMETERS_NAMES}.Country_param)
			end
	   		if attached a_region then
	   			l_parameters.put (string_parameter (a_region, 100), {DATA_PARAMETERS_NAMES}.Region_param)
			end
	   		if attached a_code then
				l_parameters.put (string_parameter (a_code, 50), {DATA_PARAMETERS_NAMES}.Code_param)
			end
	   		if attached a_tel then
	   			l_parameters.put (string_parameter (a_tel, 50), {DATA_PARAMETERS_NAMES}.Tel_param)
 			end
	   		if attached a_fax then
				l_parameters.put (string_parameter (a_fax, 50), {DATA_PARAMETERS_NAMES}.Fax_param)
 			end

			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("UpdatePersonalInformation2", l_parameters))
			db_handler.execute_writer
			post_execution
		end

	change_user_email (a_user: READABLE_STRING_32; a_new_email: READABLE_STRING_32; a_token: READABLE_STRING_32)
			-- Change User email.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".change_user_email")
			end
			create l_parameters.make (3)
			l_parameters.put (string_parameter (a_user, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (string_parameter (a_new_email, 150), {DATA_PARAMETERS_NAMES}.Email_param)
			l_parameters.put (string_parameter (a_token, 24), {DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("ChangeUserEmail", l_parameters))
			db_handler.execute_writer
			post_execution
		end

	change_password (a_user: READABLE_STRING_32; a_email: READABLE_STRING_32; a_token: READABLE_STRING_32)
			-- Change User Password.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".change_password")
			end
			create l_parameters.make (3)
			l_parameters.put (string_parameter (a_user, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (string_parameter (a_email, 150), {DATA_PARAMETERS_NAMES}.Email_param)
			l_parameters.put (string_parameter (a_token, 24), {DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("ChangePassword", l_parameters))
			db_handler.execute_writer
			post_execution
		end

feature -- Factories

	new_country (a_tuple: DB_TUPLE): COUNTRY
			-- Build a new country from a db_tuple,
			-- by default an empty county.
		do
			create Result.make ("", "")
			if attached db_handler.read_string (1) as l_item_id and then attached db_handler.read_string (2) as l_item_name then
				create Result.make (l_item_id, l_item_name)
			end
		end

	new_security_question (a_tuple: DB_TUPLE): SECURITY_QUESTION
			-- Build a new country from a db_tuple,
			-- by default an empty security question.
		do
			create Result.make (0, "")
			if attached db_handler.read_integer_32 (1) as l_item_id and then attached db_handler.read_string (2) as l_item_name then
				create Result.make (l_item_id, l_item_name)
			end
		end

	new_user: TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]
			-- Build a new user from a db_tuple,
			-- by default an empty user.
		do
			create Result.default_create
			if attached db_handler.read_string (1) as l_item_fname then
				Result.first_name := l_item_fname
			end
			if attached db_handler.read_string (2) as l_item_lname then
				Result.last_name := l_item_lname
			end
			if attached db_handler.read_string (3) as l_item_name then
				Result.user_name := l_item_name
			end
		end

	new_contact: TUPLE [first_name: STRING; last_name: STRING]
			-- Build a new user from a db_tuple,
			-- by default an empty user.
		do
			create Result.default_create
			if attached db_handler.read_string (1) as l_item_fname then
				Result.first_name := l_item_fname
			end
			if attached db_handler.read_string (2) as l_item_lname then
				Result.last_name := l_item_lname
			end
		end

	new_user_username: USER
			-- Build a new user from a db_tuple,
			-- by default an empty user.
		do
			create Result.make ("")
			if attached db_handler.read_string (3) as l_item_name then
				create Result.make (l_item_name)
			end
		end

	new_user_information: USER
			-- Build a new user from a db_tuple,
			-- by default an empty user.
		do
			create Result.make ("")
			if attached db_handler.read_string (3) as l_item_name then
				create Result.make (l_item_name)
			end
		end

	new_user_account_information (a_user_name: READABLE_STRING_32): USER_INFORMATION
			-- Build a new user account information from.
		do
			create Result.make (a_user_name)
			if attached db_handler.read_string (1) as l_first_name then
				Result.set_first_name (l_first_name)
			end
			if attached db_handler.read_string (2) as l_last_name then
				Result.set_last_name (l_last_name)
			end
			if attached db_handler.read_string (3) as l_email then
				Result.set_email (l_email)
			end
			if attached db_handler.read_string (4) as l_address then
				Result.set_address (l_address)
			end
			if attached db_handler.read_string (5) as l_city then
				Result.set_city (l_city)
			end
			if attached db_handler.read_string (6) as l_region then
				Result.set_region (l_region)
			end
			if attached db_handler.read_string (7) as l_postal_code then
				Result.set_postal_code (l_postal_code)
			end
			if attached db_handler.read_string (8) as l_country then
				Result.set_country (l_country)
			end
			if attached db_handler.read_string (9) as l_phone then
				Result.set_telephone (l_phone)
			end
			if attached db_handler.read_string (10) as l_fax then
				Result.set_fax (l_fax)
			end
			if attached db_handler.read_string (11) as l_position then
				Result.set_position (l_position)
			end
			if attached db_handler.read_string (12) as l_organization_name then
				Result.set_organization_name (l_organization_name)
			end
			if attached db_handler.read_string (13) as l_organization_email then
				Result.set_organization_email (l_organization_email)
			end
			if attached db_handler.read_string (14) as l_organization_url then
				Result.set_organization_url (l_organization_url)
			end
			if attached db_handler.read_string (15) as l_organization_address then
				Result.set_organization_address (l_organization_address)
			end
			if attached db_handler.read_string (16) as l_organization_city then
				Result.set_organization_city (l_organization_city)
			end
			if attached db_handler.read_string (17) as l_organization_region then
				Result.set_organization_region (l_organization_region)
			end
			if attached db_handler.read_string (18) as l_organization_postal_code then
				Result.set_organization_postal_code (l_organization_postal_code)
			end
			if attached db_handler.read_string (19) as l_organization_country then
				Result.set_organization_country (l_organization_country)
			end
			if attached db_handler.read_string (20) as l_organization_phone then
				Result.set_organization_telephone (l_organization_phone)
			end
			if attached db_handler.read_string (21) as l_organization_fax then
				Result.set_organization_country (l_organization_fax)
			end

		end

feature -- Status Report

	is_active (a_username: READABLE_STRING_32): BOOLEAN
			-- Is membership for user with username `a_username' active?
		require
				attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".is_active")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("IsMemberhipActive", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_boolean (1)
			end
			post_execution
		end

	validate_login (a_username: READABLE_STRING_32; a_password_salt: READABLE_STRING_32): BOOLEAN
			-- Does account with username `a_username' and password `a_password' exist?
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			debug
				log.write_information (generator + ".validate_login")
			end

			create l_parameters.make (2)
			l_parameters.put (a_username, {DATA_PARAMETERS_NAMES}.username_param)
			l_parameters.put (a_password_salt, {DATA_PARAMETERS_NAMES}.passwordhash_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("ValidateLogin", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {BOOLEAN_REF} l_item.item (1) as l_item_1 then
					Result := l_item_1.item
				end
			end
			post_execution
		end

	activation_valid (a_email: READABLE_STRING_8; a_token: READABLE_STRING_32): BOOLEAN
			-- Is activation for user with email `a_email' using token `a_token' valid?
		require
			attached_email: a_email /= Void
			attached_token: a_token /= Void
		local
			l_token: detachable STRING
		do
			debug
				log.write_information (generator + ".activation_valid")
			end
			l_token := token_from_email (a_email)
			if l_token = Void then
				if user_from_email(a_email) = Void then
					set_last_error ("Account not registered with that email address", "Activation validation")
					log.write_error (generator + ".activation_valid Account not registered with that email address :" + a_email )
				else
					-- Account already activated
				   	set_last_error ("Account with that email address has already been successfully activated", "Activation validation")
				   	log.write_error (generator + ".activation_valid Account with that email address has already been successfully activated :" + a_email )
				   	Result := False
				end
			elseif a_token.same_string (l_token) then
				remove_token (l_token)
				set_successful
				Result := True
			else
				set_last_error ("Specified token does not match one sent.", "Activation validation")
				log.write_error (generator + ".activation_valid Specified token does not match one sent to email :" + a_email )
				Result := False
			end
		end

	email_token_age (a_token: READABLE_STRING_32; a_user: READABLE_STRING_32): TUPLE [age:INTEGER; email: detachable STRING_32]
		local
			l_parameters: HASH_TABLE [ANY,STRING_32]
		do
			debug
				log.write_information (generator + ".email_token_age")
			end
			create Result.default_create
			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_user, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_token, {DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetEmailTokenAge", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if db_handler.read_integer_32 (1) /= -1 then
					Result.age := db_handler.read_integer_32 (1)
					Result.email :=	db_handler.read_string_32 (2)
				else
					Result.age := -1
				end
			end
			post_execution
		end

	email_from_reset_password (a_token: READABLE_STRING_32): detachable STRING_32
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_debug (generator + ".email_from_reset_password token:" + a_token.to_string_8 )
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_email_reset_password, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				if
					attached db_handler.read_string (1) as l_email
				then
					Result := l_email
				end
			end
			post_execution
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Delete_token_password, l_parameters))
			db_handler.execute_query
			post_execution
		end

feature -- Connection

	connect
			-- Connect to the database.
		do
			if not db_handler.is_connected then
				db_handler.connect
			end
		end

	disconnect
			--  Disconnect to the database.
		do
			if db_handler.is_connected then
				db_handler.disconnect
			end
		end

feature -- Queries

	Select_email_reset_password:  STRING = "SELECT email FROM UpdatePassword WHERE Token = :token;"

	Select_countries: STRING = "select CountryId, Country from Countries;"
		-- SQL Query to retrieve all countries.

	tuple_user: detachable TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]
		-- User row with first name, last name and user name.

	Select_user_by_session_token: STRING = "[
		SELECT Memberships.Username
		FROM Auth_Session
		INNER JOIN Memberships ON Auth_Session.ContactID = Memberships.ContactID
		WHERE Access_token = :Token;
		]"

	Select_has_user_token: STRING = "SELECT Count(*) FROM Auth_Session WHERE ContactID = :uid;"

	SQL_insert_session_auth: STRING = "INSERT INTO Auth_Session (ContactId, access_token, created, maxage) VALUES (:uid, :token, :date, :max_age);"

	SQL_update_session_auth: STRING = "UPDATE Auth_Session SET access_token = :token, created = :date, maxage = :max_age WHERE ContactId =:uid;"


	Select_user_from_username: STRING = "[
		SELECT ContactID FROM Memberships WHERE Username = :Username;
		]"

	Delete_token_password: STRING ="DELETE from UpdatePassword WHERE Token = :token;"


feature {NONE} -- Implementation

	post_execution
			-- Post database execution.
		do
			if db_handler.successful then
				set_successful
			else
				if attached db_handler.last_error then
					set_last_error_from_handler (db_handler.last_error)
				end
			end
		end

end
