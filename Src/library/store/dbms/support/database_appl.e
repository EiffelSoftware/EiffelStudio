indexing
	description: "General application";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATABASE_APPL [G -> DATABASE create default_create end]

inherit

	GENERAL_APPL

	HANDLE_USE

	HANDLE_SPEC [G]

	DB_CONSTANT

creation
	default_create,
	login,
	login_and_connect

feature -- Initialization

	login (user_name, password: STRING) is
			-- Login to database server under `user_name' with `password'.
		require
			user_name_ok: db_spec.user_name_ok (user_name)
			password_ok: db_spec.password_ok (password)
		do
			if not is_logged_to_base then
				create session_login.make
			end
			session_login.set (user_name, password)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	login_and_connect (user_name, password: STRING) is
			-- Login under `user_name' with `password'
			-- and immediately connect to Ingres database server, 
			-- using a temporary local DB_CONTROL object.
		require
			user_name_ok: db_spec.user_name_ok (user_name)
			password_ok: db_spec.password_ok (password)
		local
			session_control: DB_CONTROL
		do
			login (user_name, password)
			set_base
			create session_control.make
			session_control.connect
		end

feature -- Status setting

	set_role(roleId, rolePassWd : STRING) is
			-- Set database role with `roleId' and password(if it has one) with `rolePassWd'.
		require
			argument_exist: roleId /= Void 
		do
			if not is_logged_to_base then
				create session_login.make
			end
			session_login.set_role (roleId, rolePassWd)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_data_source (dsn : STRING) is
			-- Set database source name with `dsn'.
		require
			argument_exist: dsn /= Void 
		do
			if not is_logged_to_base then
				create session_login.make
			end
			session_login.set_data_source (dsn)
		ensure
			is_logged_to_base: is_logged_to_base
		end

			
	set_group(groupId: STRING) is
			-- Set database group  with `groupId'.
		require
			argument_exist: groupId /= Void
		do
			if not is_logged_to_base then
				create session_login.make
			end
			session_login.set_group (groupId)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_base is
			-- Initialize or re-activate database server
			-- after a handle change.
		require
			is_logged_to_base: is_logged_to_base
		do
			update_handle
			database_make (Selection_string_size)
			if session_database = Void then
				create session_database
			end
			handle.set_database (session_database)
			if session_status = Void then
				create session_status.make
			end
			handle.set_status (session_status)
			if session_execution_type = Void then
				create session_execution_type.make
			end
			handle.set_execution_type (session_execution_type)
			handle.set_login (session_login)
		ensure
			handle.database = session_database
			handle.process = session_process
			handle.status = session_status
			handle.execution_type = session_execution_type
			handle.login = session_login
		end

	set_application (application_name: STRING) is
			-- Set database application name with `application_name'.
		require
			argument_exist: application_name /= Void
		do
			if not is_logged_to_base then
				create session_login.make
			end
			session_login.set_application (application_name)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_hostname (host_name: STRING) is
			-- Set database host name with `host_name'.
		require
			argument_exist: host_name /= Void
		do
			if not is_logged_to_base then
				create session_login.make
			end
			session_login.set_hostname (host_name)
		ensure
			is_logged_to_base: is_logged_to_base
		end

feature -- Status report

	is_logged_to_base: BOOLEAN is
			-- Is current handle logged to Ingres server?
		do
			Result := session_login /= Void
		ensure
			test_condition: Result implies (session_login /= Void)
		end

feature {NONE} -- Status report

	session_database: DB [G]
		-- Data Base

	session_login: LOGIN [G]
		-- Login information

feature {NONE} -- Status setting

	database_make (i: INTEGER) is
		do
			db_spec.database_make (i)
		end

end -- class DATABASE_APPL

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
