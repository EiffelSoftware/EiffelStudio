note
	description: "Database access for login uses cases."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGIN_DATA_PROVIDER

inherit

	ESA_PARAMETER_NAME_HELPER

	REFACTORING_HELPER

create
	make

feature -- Initialization

	make
			-- Create a data provider
		do
			create {ESA_DATABASE_HANDLER_IMPL} db_handler.make_common
		end

	db_handler: ESA_DATABASE_HANDLER
		-- Db handler

feature -- Access

	countries: ESA_DATABASE_ITERATION_CURSOR [COUNTRY]
			-- Countries
		local
			l_parameters: STRING_TABLE[ANY]
		do
			create l_parameters.make (0)
			db_handler.set_query (create {ESA_DATABASE_QUERY}.data_reader (Select_countries, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_country)
		end



	token_from_email (a_email: READABLE_STRING_32): detachable STRING
			-- Activation token for user with email `a_email' if any
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put ( string_parameter(a_email,100), {ESA_DATA_PARAMETERS_NAMES}.email_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetRegistrationToken", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
			end
			disconnect
		end

	membership_creation_date (a_username: STRING): detachable DATE_TIME
			-- Creation date of membership of user with username `a_username'
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetMembershipCreationDate", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_date_time (1)
			end
			disconnect
		end


	role (a_username: STRING): detachable STRING
			-- Role associated with user with username `a_username'
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetRole", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
				to_implement ("handle error: User not found - Retrieval of user role")
			end
			disconnect
		end

	role_description (a_synopsis: STRING): detachable STRING
			-- Role description for role with synopsis `a_synopsis'
		require
			attached_synopsis: a_synopsis /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_synopsis, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetRoleDescription", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
				to_implement ("handle error: Role not found -  Retrieval of role description")
			end
			disconnect
		end

	security_questions: ESA_DATABASE_ITERATION_CURSOR [SECURITY_QUESTION]
			--	Security questions
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (0)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetSecurityQuestions", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_security_question)
		end

	question_from_email (a_email: STRING): detachable STRING
			-- Security question associated with account with email `a_email' if any
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 100), {ESA_DATA_PARAMETERS_NAMES}.username_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetQuestionFromEmail", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
				to_implement ("handle error: No results - Security question retrieval")
			end
			disconnect
		end

	user_creation_date (a_username: STRING): detachable DATE_TIME
			-- Last accounts admin page view date for user `a_username'
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUserCreationDate", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_date_time (1)
			end
			disconnect
		end

	user_from_email (a_email: STRING): detachable TUPLE [first_name:STRING; last_name:STRING; user_name:STRING]
			-- User with email `a_email' if any
		require
			attached_email: a_email /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 100), {ESA_DATA_PARAMETERS_NAMES}.username_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUserFromEmail", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := new_user
			end
			disconnect
		end

	user_from_username (a_username: STRING): detachable USER
			-- User with username `a_username' if any
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUser", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := new_user_username
			end
			disconnect
		end

	user_information (a_username: STRING): detachable USER
			-- Full user information from username
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.username_param )
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUserInformation", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				Result := new_user_information
			end
			disconnect
		end


feature -- Factories

	new_country (a_tuple: DB_TUPLE): COUNTRY
			-- Build a new country from a db_tuple,
			-- by default an empty county
		do
			create Result.make ("", "")
			if attached db_handler.read_string (1) as l_item_id and then
			   attached db_handler.read_string (2) as l_item_name then
					create Result.make (l_item_id, l_item_name)
			end
		end

	new_security_question (a_tuple: DB_TUPLE): SECURITY_QUESTION
			-- Build a new country from a db_tuple,
			-- by default an empty security question
		do
			create Result.make (0, "")
			if attached db_handler.read_integer_32 (1) as l_item_id and then
			   attached db_handler.read_string (2) as l_item_name then
					create Result.make (l_item_id, l_item_name)
			end
		end

	new_user: TUPLE [first_name:STRING; last_name:STRING; user_name:STRING]
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

	new_user_username: USER
			-- Build a new user from a db_tuple,
			-- by default an empty user
		do
			create Result.make ("")
			if attached db_handler.read_string (3) as l_item_name then
				create Result.make (l_item_name)
			end
		end

	new_user_information: USER
			-- Build a new user from a db_tuple,
			-- by default an empty user
		do
			create Result.make ("")
			if attached db_handler.read_string (3) as l_item_name then
				create Result.make (l_item_name)
			end
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

	tuple_user: detachable TUPLE [first_name:STRING; last_name:STRING; user_name:STRING]
end
