note
	description: ""
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	LOGIN [G -> DATABASE create default_create end]

inherit
	HANDLE_SPEC [G]

create -- Creation procedure

	make

feature -- Initialization

	make
		do
			create name.make (0)
			create passwd.make (0)
			create application.make (0)
			create hostname.make (0)
			create data_source.make (0)
			create role_id.make (0)
			create role_passwd.make (0)
			create group_id.make (0)

			create connection_string.make (0)
		end

feature -- Status setting

	set (a_name, a_passwd: STRING)
			-- Set user name and password before connection becomes possible.
		require
			user_name_ok: db_spec.user_name_ok (a_name)
			password_ok: db_spec.password_ok (a_passwd)
		do
			name := a_name.twin
			passwd := a_passwd.twin
		ensure
			password_ensure: db_spec.password_ensure (name, passwd, a_name, a_passwd)
		end

	set_application (appname: STRING)
			-- Set name of application
		require
			argument_not_void: appname /= Void
		do
			application := appname.twin
		ensure
			name_set: application.is_equal(appname)
		end

	set_hostname (a_hostname: STRING)
		require
			argument_not_void: a_hostname /= Void
		do
			hostname := a_hostname.twin
		ensure
			name_set: hostname.same_string (a_hostname)
		end

	set_data_source (a_data_source: STRING)
			-- Set Data Source of ODBC.
		require
			argument_not_void: a_data_source /= Void
		do
			data_source := a_data_source.twin
		ensure
			data_source_set: data_source.same_string (a_data_source)
		end

	set_role (a_role_id: STRING; a_role_passwd: detachable STRING)
			-- Set role identifier of data base.
		require
			argument_not_void: a_role_id /= Void
		do
			role_id := a_role_id.twin
			if a_role_passwd /= Void then
				role_passwd := a_role_passwd.twin
			else
				role_passwd := Void
			end
		ensure
			name_set: role_id.same_string (a_role_id)
		end

	set_group (a_group_id: STRING)
		require
			argument_not_void: a_group_id /= Void
		do
			group_id := a_group_id.twin
		ensure
			name_set: group_id.same_string (a_group_id)
		end

	set_connection_string (a_str: like connection_string)
		require
			a_str_not_void: a_str /= Void
		do
			connection_string := a_str
		ensure
			connect_string_set: connection_string = a_str
		end

	set_is_login_by_connection_string (a_b: like is_login_by_connection_string)
			-- Set `is_login_by_connection_string' with `a_b'.
		do
			is_login_by_connection_string := a_b
		ensure
			is_login_by_connection_string_set: is_login_by_connection_string = a_b
		end

feature -- Status report

	name: STRING
			-- User name

	passwd: STRING
			-- User password

	application: STRING
			-- Application name.

	hostname: STRING
			-- Host name

	data_source: STRING
			-- Data Source.

	role_id: STRING
			-- Role identifier .

	role_passwd: detachable STRING
			-- Role password.

	group_id: STRING
			-- Group Identifier.

	connection_string: STRING
			-- Connect String

	is_login_by_connection_string: BOOLEAN;
			-- Login by connection string

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

end -- class LOGIN
