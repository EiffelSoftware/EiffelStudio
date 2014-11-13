note
	description: "Summary description for {USER_DATA_PROVIDER}."
	date: "$Date$"
	revision: "$Revision$"

class
	USER_DATA_PROVIDER

inherit

	PARAMETER_NAME_HELPER

	SHARED_ERROR

	REFACTORING_HELPER

create
	make

feature -- Initialization

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

	has_user: BOOLEAN
			-- Has any user?
		do
			Result := count > 0
		end

feature -- Basic Operations

	new_user (a_user_name: READABLE_STRING_32; a_password: READABLE_STRING_32; a_email: READABLE_STRING_32)
			-- Create a new node.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_password_salt, l_password_hash: STRING
			l_security: SECURITY_PROVIDER
		do
			create l_security
			l_password_salt := l_security.salt
			l_password_hash := l_security.password_hash (a_password, l_password_salt)

			log.write_information (generator + ".new_user")
			create l_parameters.make (4)
			l_parameters.put (a_user_name,"username")
			l_parameters.put (l_password_hash,"password")
			l_parameters.put (l_password_salt,"salt")
			l_parameters.put (a_email,"email")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_insert_user, l_parameters))
			db_handler.execute_change
			post_execution
		end

	user (a_id: INTEGER_64): detachable CMS_USER
			-- User for the given id `a_id', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".user")
			create l_parameters.make (1)
			l_parameters.put (a_id,"id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_user_by_id, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := fetch_user
			end
			post_execution
		end

	user_by_name (a_name: READABLE_STRING_32): detachable CMS_USER
			-- User for the given name `a_name', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".user_by_name")
			create l_parameters.make (1)
			l_parameters.put (a_name,"name")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_user_by_name, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := fetch_user
			end
			post_execution
		end


	user_by_email (a_email: detachable READABLE_STRING_32): detachable CMS_USER
			-- User for the given email `a_email', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			log.write_information (generator + ".user_by_email")
			create l_parameters.make (1)
			l_parameters.put (a_email,"email")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_user_by_email, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := fetch_user
			end
			post_execution
		end

	user_salt (a_username: READABLE_STRING_32): detachable READABLE_STRING_32
			-- User salt for the given user `a_username', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".user_salt")
			create l_parameters.make (1)
			l_parameters.put (a_username,"name")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_salt_by_username, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				if attached db_handler.read_string (1) as l_salt then
					Result := l_salt.as_string_32
				end
			end
			post_execution
		end

	count: INTEGER
			-- Number of items users.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".count")
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_count, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := db_handler.read_integer_32 (1)
			end
			post_execution
		end

feature -- New Object

	fetch_user: CMS_USER
		do
			create Result.make ("")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_u then
				Result.set_name (l_u)
			end
			if attached db_handler.read_string (3) as l_p then
				Result.set_password (l_p)
			end
			if attached db_handler.read_string (5) as l_e then
				Result.set_email (l_e)
			end
		end

feature -- Sql Queries

	Select_count: STRING = "select count(*) from Users;"
		-- Number of users.

	Select_user_by_id: STRING = "select * from Users where id =:id;"
		-- Retrieve user by id if exists.

	Select_user_by_name: STRING = "select * from Users where username =:name;"
		-- Retrieve user by name if exists.

	Select_user_by_email: STRING = "select * from Users where email =:email;"
		-- Retrieve user by email if exists.

	Select_salt_by_username: STRING = "select salt from Users where username =:name;"
		-- Retrieve salt by username if exists.

	SQL_Insert_user: STRING = "insert into users (username, password, salt, email) values (:username, :password, :salt, :email);"
		-- SQL Insert to add a new node.


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
