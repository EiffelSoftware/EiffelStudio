note
	description: "Summary description for {USER_DATA_PROVIDER}."
	date: "$Date$"
	revision: "$Revision$"

class
	USER_DATA_PROVIDER

inherit

	PARAMETER_NAME_HELPER

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- Create a data provider.
		do
			create {DATABASE_HANDLER_IMPL} db_handler.make (a_connection)
			create error_handler.make
			post_execution
		end

	db_handler: DATABASE_HANDLER
			-- Db handler.

feature -- Error Handler

	error_handler: ERROR_HANDLER


feature -- Status Report

	is_successful: BOOLEAN
			-- Is the last execution sucessful?
		do
			Result := not error_handler.has_error
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
			error_handler.reset
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
			error_handler.reset
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
			error_handler.reset
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
			error_handler.reset
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
			error_handler.reset
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
			error_handler.reset
			log.write_information (generator + ".count")
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_count, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := db_handler.read_integer_32 (1)
			end
			post_execution
		end

feature -- Basic operations: User Roles

	add_role (a_user_id: INTEGER; a_role_id: INTEGER)
			-- Add Role `a_role_id' to user `a_user_id'
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			log.write_information (generator + ".add_role")
			create l_parameters.make (2)
			l_parameters.put (a_user_id,"users_id")
			l_parameters.put (a_role_id,"roles_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (slq_insert_users_roles, l_parameters))
			db_handler.execute_change
			post_execution
		end

	user_roles (a_id:INTEGER_64): DATABASE_ITERATION_CURSOR [INTEGER]
			-- List of Roles id for the given user `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".user_roles")
			create l_parameters.make (1)
			l_parameters.put (a_id, "user_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_user_roles, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent fetch_role_id)
			post_execution
		end


feature -- Basic operations: User Profiles

	save_profile_item (a_user_id: INTEGER_64; a_key: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Save a profile item with (a_key and a_value) to the given user `user_id'.
		local
				l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".save_profile_item")
			create l_parameters.make (3)
			l_parameters.put (a_key, "key")
			l_parameters.put (a_value, "value")
			l_parameters.put (a_user_id, "users_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_instert_profile_item, l_parameters))
			db_handler.execute_change
			post_execution
		end

	save_profile (a_user_id: INTEGER_64; a_user_profile: CMS_USER_PROFILE)
			-- Save a profile item with (a_key and a_value) to the given user `user_id'.
		local
			l_cursor: TABLE_ITERATION_CURSOR [READABLE_STRING_8, READABLE_STRING_GENERAL]
		do
			error_handler.reset
			log.write_information (generator + ".save_profile")
			from
				l_cursor := a_user_profile.new_cursor
			until
				l_cursor.after
			loop
				save_profile_item (a_user_id, l_cursor.key.as_string_32, l_cursor.item)
				l_cursor.forth
			end

			post_execution
		end

	user_profile (a_user_id: INTEGER_64): CMS_USER_PROFILE
			-- User profile for a user with id `a_user_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".user_profile")
			create l_parameters.make (1)
			l_parameters.put (a_user_id, "users_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_user_profile, l_parameters))
			db_handler.execute_query
			create Result.make
			if not db_handler.after then
				from
					db_handler.start
				until
					db_handler.after
				loop
					if
						attached db_handler.read_string (1) as l_key and then
						attached db_handler.read_string (2) as l_value
					then
						Result.force (l_value, l_key)
					end
					db_handler.forth
				end
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

	fetch_role_id: INTEGER
		do
			if attached db_handler.read_integer_32 (1) as l_id then
				Result := l_id
			end
		end

feature {NONE} -- Sql Queries: USER

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


feature {NONE} -- Sql Queries: USER_ROLES

	Slq_insert_users_roles: STRING = "insert into users_roles (users_id, roles_id) values (:users_id, :roles_id);"

	Select_user_roles:  STRING = "Select roles_id from users_roles where users_id = :user_id"

feature {NONE} -- SQL Queries: Profile

	Select_instert_profile_item: STRING = "insert into profiles (profiles.key, value, users_id) values (:key, :value, :users_id);"

	Select_user_profile: STRING = "Select profiles.key, value from profiles where users_id = :users_id;"



feature {NONE} -- Implementation

	post_execution
			-- Post database execution.
		do
			error_handler.add_synchronization (db_handler.database_error_handler)
			if error_handler.has_error then
				log.write_critical (generator + ".post_execution " +  error_handler.as_string_representation)
			end
		end

end
