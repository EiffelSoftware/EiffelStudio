note
	description: "Database access for login uses cases."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGIN_DATA_PROVIDER

inherit

	ESA_PARAMETER_NAME_HELPER

	ESA_DATABASE_ERROR

	REFACTORING_HELPER

create
	make

feature -- Initialization

	make (a_connection: ESA_DATABASE_CONNECTION)
			-- Create a data provider
		do
			create {ESA_DATABASE_HANDLER_IMPL} db_handler.make (a_connection)
			post_execution
		end

	db_handler: ESA_DATABASE_HANDLER
			-- Db handler

feature -- Status Report

	is_successful: BOOLEAN
			-- Is the last execution sucessful?
		do
			Result := db_handler.successful
		end

feature -- Access

	countries: ESA_DATABASE_ITERATION_CURSOR [ESA_COUNTRY]
			-- Countries
		local
			l_parameters: STRING_TABLE [ANY]
		do
			create l_parameters.make (0)
			db_handler.set_query (create {ESA_DATABASE_QUERY}.data_reader (Select_countries, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_country)
			post_execution
		end

	token_from_email (a_email: READABLE_STRING_32): detachable STRING
			-- Activation token for user with email `a_email' if any
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 100), {ESA_DATA_PARAMETERS_NAMES}.email_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetRegistrationToken", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
			end
			disconnect
			post_execution
		end

	token_from_username (a_username: READABLE_STRING_32): detachable STRING
			-- Activation token for user with username `a_username', if any.
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.email_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetRegistrationTokenFromUsername", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
			end
			disconnect
			post_execution
		end

	membership_creation_date (a_username: STRING): detachable DATE_TIME
			-- Creation date of membership of user with username `a_username'
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetMembershipCreationDate", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_date_time (1)
			end
			disconnect
			post_execution
		end

	role (a_username: STRING): detachable STRING
			-- Role associated with user with username `a_username'
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetRole", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
				to_implement ("handle error: User not found - Retrieval of user role")
			end
			disconnect
			post_execution
		end

	role_description (a_synopsis: STRING): detachable STRING
			-- Role description for role with synopsis `a_synopsis'
		require
			attached_synopsis: a_synopsis /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_synopsis, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetRoleDescription", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
				to_implement ("handle error: Role not found -  Retrieval of role description")
			end
			disconnect
			post_execution
		end

	security_questions: ESA_DATABASE_ITERATION_CURSOR [ESA_SECURITY_QUESTION]
			--	Security questions
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			log.write_information (generator+".security_questions Execute store procedure GetSecurityQuestions.")
			create l_parameters.make (0)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetSecurityQuestions", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_security_question)
			post_execution
		end

	question_from_email (a_email: STRING): detachable STRING
			-- Security question associated with account with email `a_email' if any
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 100), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetQuestionFromEmail", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
			end
			disconnect
			post_execution
		end

	user_creation_date (a_username: STRING): detachable DATE_TIME
			-- Last accounts admin page view date for user `a_username'
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUserCreationDate", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_date_time (1)
			end
			disconnect
			post_execution
		end

	user_from_email (a_email: STRING): detachable TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]
			-- User with email `a_email' if any
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 100), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUserFromEmail", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := new_user
			end
			disconnect
			post_execution
		end

	user_from_username (a_username: STRING): detachable ESA_USER
			-- User with username `a_username' if any
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUser", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := new_user_username
			end
			disconnect
			post_execution
		end

	user_information (a_username: STRING): ESA_USER_INFORMATION
			-- Full user information from username
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUserInformation", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := new_user_account_information (a_username)
			else
				create Result.make (a_username)
			end
			disconnect
			post_execution
		end

feature -- Element Settings

	remove_user (a_username: STRING)
			-- Remove user with username `a_username' from database.
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_writer ("RemoveUser", l_parameters))
			db_handler.execute_writer
			disconnect
			post_execution
		end


	remove_token (a_token: STRING)
				-- Remove token  `a_token' from database.
		require
			attached_token: a_token /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_token, 7), {ESA_DATA_PARAMETERS_NAMES}.registrationtoken_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_writer ("RemoveRegistrationToken", l_parameters))
			db_handler.execute_writer
			disconnect
			post_execution
		end

	update_password (a_email: STRING; a_password: STRING)
			-- Update password of user with email `a_email'.
		require
			attached_email: a_email /= Void
			attached_password: a_password /= Void
		local
			l_security: ESA_SECURITY_PROVIDER
			l_password_salt, l_password_hash: STRING
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			create l_security
			l_password_salt := l_security.salt
			l_password_hash := l_security.password_hash (a_password, l_password_salt)

			connect
			create l_parameters.make (3)
			l_parameters.put (string_parameter (a_email, 100), {ESA_DATA_PARAMETERS_NAMES}.email_param)
			l_parameters.put (string_parameter (l_password_hash, 40), {ESA_DATA_PARAMETERS_NAMES}.passwordhash_param)
			l_parameters.put (string_parameter (l_password_salt, 24), {ESA_DATA_PARAMETERS_NAMES}.passwordsalt_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_writer ("UpdatePasswordFromEmail", l_parameters))
			db_handler.execute_writer
			disconnect
			post_execution
		end

	update_email_from_user_and_token (a_token: STRING; a_user: STRING)
			-- Update email of user with email `a_email'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_user, 50), {ESA_DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (string_parameter (a_token, 50), {ESA_DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_writer ("UpdateEmailFromUserAndToken", l_parameters))
			db_handler.execute_writer
			disconnect
			post_execution
		end


	update_personal_information (a_username: STRING; a_first_name, a_last_name, a_position, a_address, a_city, a_country, a_region, a_code, a_tel, a_fax: detachable STRING)
			-- Update personal information of user with username `a_username'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (11)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.Username_param)
			if attached a_first_name then
				l_parameters.put (string_parameter (a_first_name, 50), {ESA_DATA_PARAMETERS_NAMES}.Firstname_param)
			end
			if attached a_last_name then
				l_parameters.put (string_parameter (a_last_name, 50), {ESA_DATA_PARAMETERS_NAMES}.Lastname_param)
			end
			if attached a_position then
				l_parameters.put (string_parameter (a_position, 50), {ESA_DATA_PARAMETERS_NAMES}.Position_param)
			end
			if attached a_address then
				l_parameters.put (string_parameter (a_address, 500), {ESA_DATA_PARAMETERS_NAMES}.Address_param)
			end
			if attached a_city then
				l_parameters.put (string_parameter (a_city, 50), {ESA_DATA_PARAMETERS_NAMES}.City_param)
			end
			if attached a_country then
				l_parameters.put (string_parameter (a_country, 50), {ESA_DATA_PARAMETERS_NAMES}.Country_param)
			end
	   		if attached a_region then
	   			l_parameters.put (string_parameter (a_region, 100), {ESA_DATA_PARAMETERS_NAMES}.Region_param)
			end
	   		if attached a_code then
				l_parameters.put (string_parameter (a_code, 50), {ESA_DATA_PARAMETERS_NAMES}.Code_param)
			end
	   		if attached a_tel then
	   			l_parameters.put (string_parameter (a_tel, 50), {ESA_DATA_PARAMETERS_NAMES}.Tel_param)
 			end
	   		if attached a_fax then
				l_parameters.put (string_parameter (a_fax, 50), {ESA_DATA_PARAMETERS_NAMES}.Fax_param)
 			end

			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_writer ("UpdatePersonalInformation", l_parameters))
			db_handler.execute_writer
			disconnect
			post_execution
		end

	change_user_email (a_user: READABLE_STRING_32; a_new_email: READABLE_STRING_32; a_token: READABLE_STRING_32)
			-- Change User email.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (3)
			l_parameters.put (string_parameter (a_user, 50), {ESA_DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (string_parameter (a_new_email, 150), {ESA_DATA_PARAMETERS_NAMES}.Email_param)
			l_parameters.put (string_parameter (a_token, 24), {ESA_DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_writer ("ChangeUserEmail", l_parameters))
			db_handler.execute_writer
			disconnect
			post_execution
		end

feature -- Factories

	new_country (a_tuple: DB_TUPLE): ESA_COUNTRY
			-- Build a new country from a db_tuple,
			-- by default an empty county
		do
			create Result.make ("", "")
			if attached db_handler.read_string (1) as l_item_id and then attached db_handler.read_string (2) as l_item_name then
				create Result.make (l_item_id, l_item_name)
			end
		end

	new_security_question (a_tuple: DB_TUPLE): ESA_SECURITY_QUESTION
			-- Build a new country from a db_tuple,
			-- by default an empty security question
		do
			create Result.make (0, "")
			if attached db_handler.read_integer_32 (1) as l_item_id and then attached db_handler.read_string (2) as l_item_name then
				create Result.make (l_item_id, l_item_name)
			end
		end

	new_user: TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]
			-- Build a new user from a db_tuple,
			-- by default an empty user
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

	new_user_username: ESA_USER
			-- Build a new user from a db_tuple,
			-- by default an empty user
		do
			create Result.make ("")
			if attached db_handler.read_string (3) as l_item_name then
				create Result.make (l_item_name)
			end
		end

	new_user_information: ESA_USER
			-- Build a new user from a db_tuple,
			-- by default an empty user
		do
			create Result.make ("")
			if attached db_handler.read_string (3) as l_item_name then
				create Result.make (l_item_name)
			end
		end

	new_user_account_information (a_user_name: STRING): ESA_USER_INFORMATION
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

	is_active (a_username: STRING): BOOLEAN
			-- Is membership for user with username `a_username' active?
		require
				attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("IsMemberhipActive", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_boolean (1)
			end
			disconnect
		end

	validate_login (a_username: READABLE_STRING_32; a_password_salt: READABLE_STRING_32): BOOLEAN
			-- Does account with username `a_username' and password `a_password' exist?
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (2)
			l_parameters.put (a_username, {ESA_DATA_PARAMETERS_NAMES}.username_param)
			l_parameters.put (a_password_salt, {ESA_DATA_PARAMETERS_NAMES}.passwordhash_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("ValidateLogin", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {BOOLEAN_REF} l_item.item (1) as l_item_1 then
					Result := l_item_1.item
				end
			end
			disconnect
		end



	activation_valid (a_email, a_token: STRING): BOOLEAN
			-- Is activation for user with email `a_email' using token `a_token' valid?
		require
			attached_email: a_email /= Void
			attached_token: a_token /= Void
		local
			l_token: detachable STRING
		do
			l_token := token_from_email (a_email)
			if l_token = Void then
				if user_from_email(a_email) = Void then
					set_last_error ("Account not registered with that email address", "Activation validation")
				else
					-- Account already activated
				   	set_last_error ("Account with that email address has already been successfully activated", "Activation validation")
				   	Result := False
				end
			elseif a_token.same_string (l_token) then
				remove_token (l_token)
				set_successful
				Result := True
			else
				set_last_error ("Specified token does not match one sent.", "Activation validation")
				Result := False
			end
		end

	email_token_age (a_token: STRING; a_user: STRING): TUPLE[age:INTEGER; email: detachable STRING]
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create Result.default_create
			connect
			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_user, 50), {ESA_DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_token, {ESA_DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetEmailTokenAge", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if db_handler.read_integer_32 (1) /= -1 then
					Result.age := db_handler.read_integer_32 (1)
					Result.email :=	db_handler.read_string (2)
				else
					Result.age := -1
				end
			end
			disconnect
		end

feature -- Connection

	connect
			-- Connect to the database
		do
			if not db_handler.is_connected then
				db_handler.connect
			end
		end

	disconnect
			-- Disconnect to the database
		do
			if db_handler.is_connected then
				db_handler.disconnect
			end
		end

feature -- Queries

	Select_countries: STRING = "select CountryId, Country from Countries;"
		-- SQL Query to retrieve all countries

	tuple_user: detachable TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]


feature {NONE} -- Implementation

	post_execution
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
