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
	login_and_connect,
	login_with_connection_string,
	login_with_connection_string_and_connect

feature -- Initialization

	login (user_name, password: STRING)
			-- Login to database server under `user_name' with `password'.
		require
			user_name_ok: db_spec.user_name_ok (user_name)
			password_ok: db_spec.password_ok (password)
		local
			l_session_login: detachable LOGIN [DATABASE]
		do
			l_session_login := manager.current_session.session_login
			if l_session_login = Void then
				create {LOGIN [G]} l_session_login.make
				manager.current_session.set_session_login (l_session_login)
			end
			l_session_login.set (user_name, password)
			l_session_login.set_is_login_by_connection_string (False)
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

	login_with_connection_string (a_connection_string: STRING)
			-- Login with `a_connection_string'
			-- If login with connect string, `user_name', `password' might not be available
			-- unless they are set manually.
		local
			l_session_login: detachable LOGIN [DATABASE]
		do
			l_session_login := manager.current_session.session_login
			if l_session_login = Void then
				create {LOGIN [G]} l_session_login.make
				manager.current_session.set_session_login (l_session_login)
			end
			l_session_login.set_connection_string (a_connection_string)
			l_session_login.set_is_login_by_connection_string (True)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	login_with_connection_string_and_connect (a_connection_string: STRING)
			-- Login with `a_connection_string'
			-- and immediately connect to database.
		local
			session_control: DB_CONTROL
		do
			login_with_connection_string (a_connection_string)
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
			l_session_login: detachable LOGIN [DATABASE]
		do
			if attached manager.current_session.session_login as l_login then
				l_session_login := l_login
			else
				create {LOGIN [G]} l_session_login.make
				manager.current_session.set_session_login (l_session_login)
			end
			l_session_login.set_role (roleId, rolePassWd)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_data_source (dsn : STRING)
			-- Set database source name with `dsn'.
		require
			argument_exist: dsn /= Void
		local
			l_session_login: detachable LOGIN [DATABASE]
		do
			if attached manager.current_session.session_login as l_login then
				l_session_login := l_login
			else
				create {LOGIN [G]} l_session_login.make
				manager.current_session.set_session_login (l_session_login)
			end
			l_session_login.set_data_source (dsn)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_group (groupId: STRING)
			-- Set database group  with `groupId'.
		require
			argument_exist: groupId /= Void
		local
			l_session_login: detachable LOGIN [DATABASE]
		do
			if attached manager.current_session.session_login as l_login then
				l_session_login := l_login
			else
				create {LOGIN [G]} l_session_login.make
				manager.current_session.set_session_login (l_session_login)
			end
			l_session_login.set_group (groupId)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_base
			-- Initialize or re-activate database server
			-- after a handle change.
		require
			is_logged_to_base: is_logged_to_base
		do
			database_make (Selection_string_size)

			if not attached manager.current_session.session_database then
				manager.current_session.set_session_database (create {DB [G]})
			end

			if not attached manager.current_session.session_status then
				manager.current_session.set_session_status (create {DB_STATUS}.make)
			end

			if not attached manager.current_session.session_execution_type then
				manager.current_session.set_session_execution_type (create {DB_EXEC}.make)
			end

			if not attached manager.current_session.all_types then
				manager.current_session.set_all_types (create {DB_ALL_TYPES}.make)
			end
		ensure
			handle.database = session_database
			handle.status = session_status
			handle.execution_type = session_execution_type
			handle.login = manager.current_session.session_login
		end

	set_application (application_name: STRING)
			-- Set database application name with `application_name'.
		require
			argument_exist: application_name /= Void
		local
			l_session_login: detachable LOGIN [DATABASE]
		do
			if attached manager.current_session.session_login as l_login then
				l_session_login := l_login
			else
				create {LOGIN [G]} l_session_login.make
				manager.current_session.set_session_login (l_session_login)
			end
			l_session_login.set_application (application_name)
		ensure
			is_logged_to_base: is_logged_to_base
		end

	set_hostname (host_name: STRING)
			-- Set database host name with `host_name'.
		require
			argument_exist: host_name /= Void
		local
			l_session_login: detachable LOGIN [DATABASE]
		do
			if attached manager.current_session.session_login as l_login then
				l_session_login := l_login
			else
				create {LOGIN [G]} l_session_login.make
				manager.current_session.set_session_login (l_session_login)
			end
			l_session_login.set_hostname (host_name)
		ensure
			is_logged_to_base: is_logged_to_base
		end

feature -- Status report

	is_logged_to_base: BOOLEAN
			-- Is current handle logged to Ingres server?
		do
			Result := attached manager.current_session.session_login
		ensure
			test_condition: Result implies (attached manager.current_session.session_login)
		end

feature {NONE} -- Status setting

	database_make (i: INTEGER)
			-- Initialization in the database object.
		do
			db_spec.database_make (i)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATABASE_APPL


