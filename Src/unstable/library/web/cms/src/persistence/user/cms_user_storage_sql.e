note
	description: "Summary description for {CMS_USER_STORAGE_SQL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_USER_STORAGE_SQL

inherit
	CMS_USER_STORAGE

	CMS_STORAGE_SQL

	REFACTORING_HELPER

	SHARED_LOGGER

feature -- Access: user

	has_user: BOOLEAN
			-- Has any user?
		do
			Result := user_count > 0
		end

	user_count: INTEGER
			-- Number of items users.
		do
			error_handler.reset
			log.write_information (generator + ".user_count")

			sql_query (select_users_count, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_32 (1)
			end
		end

	users: LIST [CMS_USER]
		do
			create {ARRAYED_LIST [CMS_USER]} Result.make (0)

			error_handler.reset
			log.write_information (generator + ".all_users")

			from
				sql_query (select_users, Void)
				sql_start
			until
				sql_after
			loop
				if attached fetch_user as l_user then
					Result.force (l_user)
				end
				sql_forth
			end
		end

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
			-- User for the given id `a_id', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			log.write_information (generator + ".user")
			create l_parameters.make (1)
			l_parameters.put (a_id, "uid")
			sql_query (select_user_by_id, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_user
			else
				check no_more_than_one: sql_rows_count = 0 end
			end
		end

	user_by_name (a_name: like {CMS_USER}.name): detachable CMS_USER
			-- User for the given name `a_name', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			log.write_information (generator + ".user_by_name")
			create l_parameters.make (1)
			l_parameters.put (a_name, "name")
			sql_query (select_user_by_name, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_user
			else
				check no_more_than_one: sql_rows_count = 0 end
			end
		end

	user_by_email (a_email: like {CMS_USER}.email): detachable CMS_USER
			-- User for the given email `a_email', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			log.write_information (generator + ".user_by_email")
			create l_parameters.make (1)
			l_parameters.put (a_email, "email")
			sql_query (select_user_by_email, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_user
			else
				check no_more_than_one: sql_rows_count = 0 end
			end
		end

	is_valid_credential (l_auth_login, l_auth_password: READABLE_STRING_32): BOOLEAN
		local
			l_security: SECURITY_PROVIDER
		do
			if attached user_salt (l_auth_login) as l_hash then
				if attached user_by_name (l_auth_login) as l_user then
					create l_security
					if
						attached l_user.hashed_password as l_hashed_password and then
					   	l_security.password_hash (l_auth_password, l_hash).is_case_insensitive_equal (l_hashed_password)
					then
						Result := True
					else
						log.write_information (generator + ".is_valid_credential User: wrong username or password" )
					end
				else
					log.write_information (generator + ".is_valid_credential User:" + l_auth_login + "does not exist" )
				end
			end

		end

feature -- Change: user

	new_user (a_user: CMS_USER)
			-- Add a new user `a_user'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_password_salt, l_password_hash: STRING
			l_security: SECURITY_PROVIDER
		do
			error_handler.reset
			if
				attached a_user.password as l_password and then
				attached a_user.email as l_email
			then
				sql_begin_transaction
				create l_security
				l_password_salt := l_security.salt
				l_password_hash := l_security.password_hash (l_password, l_password_salt)

				log.write_information (generator + ".new_user")
				create l_parameters.make (4)
				l_parameters.put (a_user.name, "name")
				l_parameters.put (l_password_hash, "password")
				l_parameters.put (l_password_salt, "salt")
				l_parameters.put (l_email, "email")
				l_parameters.put (create {DATE_TIME}.make_now_utc, "created")

				sql_change (sql_insert_user, l_parameters)
				if not error_handler.has_error then
					a_user.set_id (last_inserted_user_id)
				end
				sql_commit_transaction
			else
				-- set error
				error_handler.add_custom_error (-1, "bad request" , "Missing password or email")
			end
		end

	update_user (a_user: CMS_USER)
			-- Save user `a_user'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_password_salt, l_password_hash: detachable READABLE_STRING_8
			l_security: SECURITY_PROVIDER
		do
			error_handler.reset
			if attached a_user.password as l_password then
					-- New password!
				create l_security
				l_password_salt := l_security.salt
				l_password_hash := l_security.password_hash (l_password, l_password_salt)
			else
					-- Existing hashed password
				l_password_hash := a_user.hashed_password
				l_password_salt := user_salt (a_user.name)
			end
			if
				l_password_hash /= Void and l_password_salt /= Void and
				attached a_user.email as l_email
			then
				log.write_information (generator + ".update_user")
				create l_parameters.make (6)
				l_parameters.put (a_user.id, "uid")
				l_parameters.put (a_user.name, "name")
				l_parameters.put (l_password_hash, "password")
				l_parameters.put (l_password_salt, "salt")
				l_parameters.put (l_email, "email")
				l_parameters.put (create {DATE_TIME}.make_now_utc, "changed")

				sql_change (sql_update_user, l_parameters)
			else
					-- set error
				error_handler.add_custom_error (-1, "bad request" , "Missing password or email")
			end
		end

feature -- Access: roles and permissions

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
		do
			to_implement (generator + ".user_role_by_id")
		end

	user_roles: LIST [CMS_USER_ROLE]
		do
			to_implement (generator + ".user_roles")
			create {ARRAYED_LIST[CMS_USER_ROLE]} Result.make (0)
		end

feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
		do
			to_implement (generator + ".save_user_role")
		end

feature {NONE} -- Implementation

	user_salt (a_username: READABLE_STRING_32): detachable READABLE_STRING_8
			-- User salt for the given user `a_username', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			log.write_information (generator + ".user_salt")
			create l_parameters.make (1)
			l_parameters.put (a_username, "name")
			sql_query (select_salt_by_username, l_parameters)
			if sql_rows_count  = 1 then
				if attached sql_read_string (1) as l_salt then
					Result := l_salt
				end
			end
		end

	fetch_user: detachable CMS_USER
		local
			l_id: INTEGER_64
			l_name: detachable READABLE_STRING_32
		do
			if attached sql_read_integer_32 (1) as i then
				l_id := i
			end
			if attached sql_read_string_32 (2) as s and then not s.is_whitespace then
				l_name := s
			end

			if l_name /= Void then
				create Result.make (l_name)
				if l_id > 0 then
					Result.set_id (l_id)
				end
			elseif l_id > 0 then
				create Result.make_with_id (l_id)
			end

			if Result /= Void then
				if attached sql_read_string (3) as l_password then
						-- FIXME: should we return the password here ???
					Result.set_hashed_password (l_password)
				end
				if attached sql_read_string (5) as l_email then
					Result.set_email (l_email)
				end
			else
				check expected_valid_user: False end
			end
		end

	last_inserted_user_id: INTEGER_64
			-- Last insert user id.
		do
			error_handler.reset
			log.write_information (generator + ".last_inserted_user_id")
			sql_query (Sql_last_insert_user_id, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end

feature {NONE} -- Sql Queries: USER

	Select_users_count: STRING = "select count(*) from Users;"
			-- Number of users.

	Sql_last_insert_user_id: STRING = "SELECT MAX(uid) from Users;"

	Select_users: STRING = "select * from Users;"
			-- List of users.

	Select_user_by_id: STRING = "select * from Users where uid =:uid;"
			-- Retrieve user by id if exists.

	Select_user_by_name: STRING = "select * from Users where name =:name;"
			-- Retrieve user by name if exists.

	Select_user_by_email: STRING = "select * from Users where email =:email;"
			-- Retrieve user by email if exists.

	Select_salt_by_username: STRING = "select salt from Users where name =:name;"
			-- Retrieve salt by username if exists.

	Sql_Insert_user: STRING = "insert into users (name, password, salt, email, created) values (:name, :password, :salt, :email, :created);"
			-- SQL Insert to add a new node.

	sql_update_user: STRING = "update users SET name=:name, password=:password, salt=:salt, email=:email WHERE uid=:uid;"


end
