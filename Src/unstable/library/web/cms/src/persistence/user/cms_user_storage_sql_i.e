note
	description: "Summary description for {CMS_USER_STORAGE_SQL_I}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_USER_STORAGE_SQL_I

inherit
	CMS_USER_STORAGE_I

	CMS_STORAGE_SQL_I

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
			write_information_log (generator + ".user_count")

			sql_query (select_users_count, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_32 (1)
			end
			error_handler.reset
		end

	users: LIST [CMS_USER]
		do
			create {ARRAYED_LIST [CMS_USER]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".all_users")

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
			write_information_log (generator + ".user_by_id")
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
			write_information_log (generator + ".user_by_name")
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
			write_information_log (generator + ".user_by_email")
			create l_parameters.make (1)
			l_parameters.put (a_email, "email")
			sql_query (select_user_by_email, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_user
			else
				check no_more_than_one: sql_rows_count = 0 end
			end
		end

	user_by_activation_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- User for the given activation token `a_token', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_by_activation_token")
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_query (select_user_by_activation_token, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_user
			else
				check no_more_than_one: sql_rows_count = 0 end
			end
		end

	user_by_password_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- User for the given password token `a_token', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_by_password_token")
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_query (select_user_by_password_token, l_parameters)
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
						write_information_log (generator + ".is_valid_credential User: wrong username or password" )
					end
				else
					write_information_log (generator + ".is_valid_credential User:" + l_auth_login + "does not exist" )
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

				write_information_log (generator + ".new_user")
				create l_parameters.make (4)
				l_parameters.put (a_user.name, "name")
				l_parameters.put (l_password_hash, "password")
				l_parameters.put (l_password_salt, "salt")
				l_parameters.put (l_email, "email")
				l_parameters.put (create {DATE_TIME}.make_now_utc, "created")
				l_parameters.put (a_user.status, "status")

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
				write_information_log (generator + ".update_user")
				create l_parameters.make (6)
				l_parameters.put (a_user.id, "uid")
				l_parameters.put (a_user.name, "name")
				l_parameters.put (l_password_hash, "password")
				l_parameters.put (l_password_salt, "salt")
				l_parameters.put (l_email, "email")
				l_parameters.put (create {DATE_TIME}.make_now_utc, "changed")
				l_parameters.put (a_user.status, "status")

				sql_change (sql_update_user, l_parameters)
			else
					-- set error
				error_handler.add_custom_error (-1, "bad request" , "Missing password or email")
			end
		end

feature -- Access: roles and permissions

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_role_by_id")
			create l_parameters.make (1)
			l_parameters.put (a_id, "rid")
			sql_query (select_user_role_by_id, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_user_role
				if Result /= Void and not has_error then
					fill_user_role (Result)
				end
			else
				check no_more_than_one: sql_rows_count = 0 end
			end
		end

	user_roles_for (a_user: CMS_USER): LIST [CMS_USER_ROLE]
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_roles_for")

			create {ARRAYED_LIST [CMS_USER_ROLE]} Result.make (0)
			from
				create l_parameters.make (1)
				l_parameters.put (a_user.id, "uid")
				sql_query (select_user_roles_by_user_id, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_user_role as l_role then
					Result.force (l_role)
				end
				sql_forth
			end
			if not has_error then
				across Result as ic loop
					fill_user_role (ic.item)
				end
			end
		end

	user_roles: LIST [CMS_USER_ROLE]
		local
			l_role: detachable CMS_USER_ROLE
		do
			error_handler.reset
			write_information_log (generator + ".user_roles")

			create {ARRAYED_LIST [CMS_USER_ROLE]} Result.make (0)
			from
				sql_query (select_user_roles, Void)
				sql_start
			until
				sql_after
			loop
				l_role := fetch_user_role
				if l_role /= Void then
					Result.force (l_role)
				end
				sql_forth
			end
			if not has_error then
				across Result as ic loop
					fill_user_role (ic.item)
				end
			end
		end

	fill_user_role (a_role: CMS_USER_ROLE)
		require
			a_role_has_id: a_role.has_id
		do
			if attached role_permissions_by_id (a_role.id) as l_permissions then
				across
					l_permissions as p_ic
				loop
					a_role.add_permission (p_ic.item)
				end
			end
		end

	role_permissions_by_id (a_role_id: INTEGER_32): LIST [READABLE_STRING_8]
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".role_permissions_by_id")

			create {ARRAYED_LIST [READABLE_STRING_8]} Result.make (0)
			from
				create l_parameters.make (1)
				l_parameters.put (a_role_id, "rid")
				sql_query (select_role_permissions_by_role_id, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached sql_read_string (1) as l_permission then
					Result.force (l_permission)
				end
--				if attached sql_read_string_32 (2) as l_module then
--				end
				sql_forth
			end
		end

feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_existing_role: detachable CMS_USER_ROLE
			l_permissions: detachable LIST [READABLE_STRING_8]
			p: READABLE_STRING_8
			l_found: BOOLEAN
		do
			error_handler.reset
			write_information_log (generator + ".save_user_role")


			if a_user_role.has_id then
				l_existing_role := user_role_by_id (a_user_role.id)
				check l_existing_role /= Void and then l_existing_role.id = a_user_role.id end
				if
					l_existing_role /= Void and then
					l_existing_role.name.same_string (a_user_role.name)
				then
						-- No update needed
				else
					create l_parameters.make (2)
					l_parameters.put (a_user_role.id, "rid")
					l_parameters.put (a_user_role.name, "name")
					sql_change (sql_update_user_role, l_parameters)
				end
				if not a_user_role.permissions.is_empty then
					-- FIXME: check if this is non set permissions,or none ...
					if l_existing_role /= Void then
						l_permissions := l_existing_role.permissions
						fill_user_role (l_existing_role)
					end
					if l_permissions = Void or else l_permissions.is_empty then
						l_permissions := role_permissions_by_id (a_user_role.id)
					end

					across
						a_user_role.permissions as ic
					loop
						p := ic.item
						from
							l_found := False
							l_permissions.start
						until
							l_found or l_permissions.after
						loop
							if p.is_case_insensitive_equal (l_permissions.item) then
								l_found := True
							else
								l_permissions.forth
							end
						end
						if l_found then
								-- Already there, skip							
						else
								-- Add permission
							set_permission_for_role_id (p, a_user_role.id)
						end
					end
						-- Remove other
					across
						l_permissions as ic
					loop
						unset_permission_for_role_id (ic.item, a_user_role.id)
					end
				end
			else
				create l_parameters.make (1)
				l_parameters.put (a_user_role.name, "name")
				sql_change (sql_insert_user_role, l_parameters)
				if not error_handler.has_error then
					a_user_role.set_id (last_inserted_user_role_id)
					across
						a_user_role.permissions as ic
					loop
						set_permission_for_role_id (ic.item, a_user_role.id)
					end
				end
			end
		end

	set_permission_for_role_id (a_permission: READABLE_STRING_8; a_role_id: INTEGER)
		require
			a_role_id > 0
			not a_permission.is_whitespace
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (3)
			l_parameters.put (a_role_id, "rid")
			l_parameters.put (a_permission, "permission")
			l_parameters.put (Void, "module") -- FIXME: unsupported for now!
			sql_change (sql_insert_user_role_permission, l_parameters)
		end

	unset_permission_for_role_id (a_permission: READABLE_STRING_8; a_role_id: INTEGER)
		require
			a_role_id > 0
			not a_permission.is_whitespace

		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (2)
			l_parameters.put (a_role_id, "rid")
			l_parameters.put (a_permission, "permission")
			sql_change (sql_delete_user_role_permission, l_parameters)
		end

	last_inserted_user_role_id: INTEGER_32
			-- Last inserted user role id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_user_role_id")
			sql_query (Sql_last_insert_user_role_id, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_32 (1)
			end
		end


feature -- Access: User activation

	activation_elapsed_time (a_token: READABLE_STRING_32): INTEGER_32
			-- amount of time that has passed in days since the token `a_token' was saved.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".activation_elapsed_time")
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_query (sql_select_activation_expiration, l_parameters)
			if sql_rows_count = 1 then
				Result := sql_read_integer_32 (1)
			end
		end

	user_id_by_activation (a_token: READABLE_STRING_32): INTEGER_64
			-- User id associatied with a token `a_token', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_id_by_actication")
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_query (sql_select_userid_activation, l_parameters)
			if sql_rows_count = 1 then
				Result := sql_read_integer_32 (1)
			end
		end

feature -- Change: User activation

	save_activation (a_token: READABLE_STRING_32; a_id: INTEGER_64)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_utc_date: DATE_TIME
		do
			error_handler.reset
			sql_begin_transaction
			write_information_log (generator + ".save_activation")
			create l_utc_date.make_now_utc
			create l_parameters.make (2)
			l_parameters.put (a_token, "token")
			l_parameters.put (a_id, "uid")
			l_parameters.put (l_utc_date, "utc_date")
			sql_change (sql_insert_activation, l_parameters)
			sql_commit_transaction
		end

	remove_activation (a_token: READABLE_STRING_32)
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			sql_begin_transaction
			write_information_log (generator + ".remove_activation")
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_change (sql_remove_activation, l_parameters)
			sql_commit_transaction
		end

feature -- Change: User password recovery

	save_password (a_token: READABLE_STRING_32; a_id: INTEGER_64)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_utc_date: DATE_TIME
		do
			error_handler.reset
			sql_begin_transaction
			write_information_log (generator + ".save_password")
			create l_utc_date.make_now_utc
			create l_parameters.make (2)
			l_parameters.put (a_token, "token")
			l_parameters.put (a_id, "uid")
			l_parameters.put (l_utc_date, "utc_date")
			sql_change (sql_insert_password, l_parameters)
			sql_commit_transaction
		end

	remove_password (a_token: READABLE_STRING_32)
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			sql_begin_transaction
			write_information_log (generator + ".remove_password")
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_change (sql_remove_password, l_parameters)
			sql_commit_transaction
		end

feature {NONE} -- Implementation: User

	user_salt (a_username: READABLE_STRING_32): detachable READABLE_STRING_8
			-- User salt for the given user `a_username', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_salt")
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
				if attached sql_read_integer_32 (6) as l_status then
					Result.set_status (l_status)
				end
			else
				check expected_valid_user: False end
			end
		end

	last_inserted_user_id: INTEGER_64
			-- Last insert user id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_user_id")
			sql_query (Sql_last_insert_user_id, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end

feature {NONE} -- Implementation: User role		

	fetch_user_role: detachable CMS_USER_ROLE
		local
			l_id: INTEGER_32
			l_name: detachable READABLE_STRING_32
		do
			if attached sql_read_integer_32 (1) as rid then
				l_id := rid
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
		end

feature {NONE} -- Sql Queries: USER

	Select_users_count: STRING = "SELECT count(*) FROM Users;"
			-- Number of users.

	Sql_last_insert_user_id: STRING = "SELECT MAX(uid) FROM Users;"

	Select_users: STRING = "SELECT * FROM Users;"
			-- List of users.

	Select_user_by_id: STRING = "SELECT * FROM Users WHERE uid =:uid;"
			-- Retrieve user by id if exists.

	Select_user_by_name: STRING = "SELECT * FROM Users WHERE name =:name;"
			-- Retrieve user by name if exists.

	Select_user_by_email: STRING = "SELECT * FROM Users WHERE email =:email;"
			-- Retrieve user by email if exists.

	Select_salt_by_username: STRING = "SELECT salt FROM Users WHERE name =:name;"
			-- Retrieve salt by username if exists.

	sql_insert_user: STRING = "INSERT INTO users (name, password, salt, email, created, status) VALUES (:name, :password, :salt, :email, :created, :status);"
			-- SQL Insert to add a new user.

	sql_update_user: STRING = "UPDATE users SET name=:name, password=:password, salt=:salt, email=:email, status=:status WHERE uid=:uid;"
			-- SQL update to update an existing user.

feature {NONE} -- Sql Queries: USER ROLE

	sql_last_insert_user_role_id: STRING = "SELECT MAX(rid) FROM roles;"

	select_user_roles: STRING = "SELECT rid, name FROM roles;"
			-- List of user roles.	

	sql_insert_user_role: STRING = "INSERT INTO roles (name) VALUES (:name);"
			-- SQL Insert to add a new user role with name :name.		

	sql_update_user_role : STRING = "UPDATE roles SET name=:name WHERE rid=:rid;"
			-- Update user role with id :rid.	

	select_user_roles_by_user_id: STRING = "SELECT rid, name FROM roles INNER JOIN users_roles ON users_roles.rid=roles.rid WHERE users_roles.uid=:uid;"
			-- List of user roles for user id :uid.	

	select_user_role_by_id: STRING = "SELECT rid, name FROM roles WHERE rid=:rid;"
			-- User role for role id :rid;

	sql_insert_user_role_permission: STRING = "INSERT INTO role_permissions (rid, permission, module) VALUES (:rid, :permission, :module);"
			-- SQL Insert a new permission :permission for user role :rid.

	sql_delete_user_role_permission: STRING = "DELETE FROM role_permissions WHERE rid=:rid AND permission=:permission;"
			-- SQL Delete permission :permission from user role :rid.

	select_role_permissions_by_role_id: STRING = "SELECT permission, module FROM role_permissions WHERE rid=:rid;"
			-- User role permissions for role id :rid;

feature {NONE} -- Sql Queries: USER ACTIVATION

	sql_insert_activation: STRING = "INSERT INTO users_activations (token, uid, created) VALUES (:token, :uid, :utc_date);"
			-- SQL insert a new activation :token.

	sql_select_activation_expiration: STRING = "SELECT DATEDIFF(day,created,UTC_DATE()) FROM users_activations where token = :token;"
			-- elapsed time that has passed in days since the token `a_token' was saved.

	sql_select_userid_activation: STRING = "SELECT uid FROM users_activations where token = :token;"
			-- Retrieve userid given the activation token.

	Select_user_by_activation_token: STRING = "SELECT u.* FROM users as u JOIN users_activations as ua ON ua.uid = u.uid and ua.token = :token;"
			-- Retrieve user by activation token if exist.

	Sql_remove_activation: STRING = "DELETE FROM users_activations WHERE token = :token;"
			-- Remove activation token.

feature {NONE} -- User Password Recovery

	sql_insert_password: STRING = "INSERT INTO users_password_recovery (token, uid, created) VALUES (:token, :uid, :utc_date);"
			-- SQL insert a new password recovery :token.

	Sql_remove_password: STRING = "DELETE FROM users_password_recovery WHERE token = :token;"
			-- Retrieve password if exist.

	Select_user_by_password_token: STRING = "SELECT u.* FROM users as u JOIN users_password_recovery as ua ON ua.uid = u.uid and ua.token = :token;"
			-- Retrieve user by password token if exist.

end
