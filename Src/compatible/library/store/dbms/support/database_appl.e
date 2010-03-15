note
	description: "General application"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DATABASE_APPL [reference G -> DATABASE create default_create end]

inherit

	GENERAL_APPL

	HANDLE_USE

	HANDLE_SPEC [G]

	DB_CONSTANT

create
	default_create,
	login,
	login_and_connect

feature -- Initialization

	login (user_name, password: STRING)
			-- Login to database server under `user_name' with `password'.
		require
			user_name_ok: db_spec.user_name_ok (user_name)
			password_ok: db_spec.password_ok (password)
		local
			l_session_login: like session_login
		do
			l_session_login := session_login
			if not is_logged_to_base then
				create l_session_login.make
				session_login := l_session_login
			end
			check l_session_login /= Void end -- implied by previous if clause
			l_session_login.set (user_name, password)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	login_and_connect (user_name, password: STRING)
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

	set_role(roleId, rolePassWd : STRING)
			-- Set database role with `roleId' and password(if it has one) with `rolePassWd'.
		require
			argument_exist: roleId /= Void
		local
			l_session_login: like session_login
		do
			l_session_login := session_login
			if not is_logged_to_base then
				create l_session_login.make
				session_login := l_session_login
			end
			check l_session_login /= Void end -- implied by previous if clause
			l_session_login.set_role (roleId, rolePassWd)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_data_source (dsn : STRING)
			-- Set database source name with `dsn'.
		require
			argument_exist: dsn /= Void
		local
			l_session_login: like session_login
		do
			l_session_login := session_login
			if not is_logged_to_base then
				create l_session_login.make
				session_login := l_session_login
			end
			check l_session_login /= Void end -- implied by previous if clause
			l_session_login.set_data_source (dsn)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_group(groupId: STRING)
			-- Set database group  with `groupId'.
		require
			argument_exist: groupId /= Void
		local
			l_session_login: like session_login
		do
			l_session_login := session_login
			if not is_logged_to_base then
				create l_session_login.make
				session_login := l_session_login
			end
			check l_session_login /= Void end -- implied by previous if clause
			l_session_login.set_group (groupId)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_base
			-- Initialize or re-activate database server
			-- after a handle change.
		require
			is_logged_to_base: is_logged_to_base
		local
			l_session_database: like session_database
			l_session_status: like session_status
			l_session_execution_type: like session_execution_type
			l_session_login: like session_login
		do
			update_handle
			database_make (Selection_string_size)

			l_session_database := session_database
			if l_session_database = Void then
				create l_session_database
				session_database := l_session_database
			end
			handle.set_database (l_session_database)

			l_session_status := session_status
			if l_session_status = Void then
				create l_session_status.make
				session_status := l_session_status
			end
			handle.set_status (l_session_status)

			l_session_execution_type := session_execution_type
			if l_session_execution_type = Void then
				create l_session_execution_type.make
				session_execution_type := l_session_execution_type
			end
			handle.set_execution_type (l_session_execution_type)

			l_session_login := session_login
			check l_session_login /= Void end -- implied by precondition `is_logged_to_base'
			handle.set_login (l_session_login)
		ensure
			handle.database = session_database
			handle.process = session_process
			handle.status = session_status
			handle.execution_type = session_execution_type
			handle.login = session_login
		end

	set_application (application_name: STRING)
			-- Set database application name with `application_name'.
		require
			argument_exist: application_name /= Void
		local
			l_session_login: like session_login
		do
			l_session_login := session_login
			if not is_logged_to_base then
				create l_session_login.make
				session_login := l_session_login
			end
			check l_session_login /= Void end -- implied by previsous if clause
			l_session_login.set_application (application_name)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_hostname (host_name: STRING)
			-- Set database host name with `host_name'.
		require
			argument_exist: host_name /= Void
		local
			l_session_login: like session_login
		do
			l_session_login := session_login
			if not is_logged_to_base then
				create l_session_login.make
				session_login := l_session_login
			end
			check l_session_login /= Void end -- implied by previsous if clause
			l_session_login.set_hostname (host_name)
		ensure
			is_logged_to_base: is_logged_to_base
		end

feature -- Status report

	is_logged_to_base: BOOLEAN
			-- Is current handle logged to Ingres server?
		do
			Result := session_login /= Void
		ensure
			test_condition: Result implies (session_login /= Void)
		end

feature {NONE} -- Status report

	session_database: detachable DB [G]
			-- Data Base

	session_login: detachable LOGIN [G]
		-- Login information

feature {NONE} -- Status setting

	database_make (i: INTEGER)
		do
			db_spec.database_make (i)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATABASE_APPL


