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
			create roleId.make (0)
			create rolePassWd.make (0)
			create groupId.make (0)

			create connection_string.make (0)
		end

feature -- Status setting

	set (uname, upasswd: STRING)
			-- Set user name and password before connection becomes possible.
		require
			user_name_ok: db_spec.user_name_ok (uname)
			password_ok: db_spec.password_ok (upasswd)
		do
			name := uname.twin
	      	passwd := upasswd.twin
		ensure
			password_ensure: db_spec.password_ensure (name, passwd, uname, upasswd)
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

	set_hostname (uhostname: STRING)
		require
			argument_not_void: uhostname /= Void
		do
			hostname := uhostname.twin
		ensure
			name_set: hostname.is_equal(uhostname)
		end

	set_data_source (udata_source: STRING)
			-- Set Data Source of ODBC.
		require
			argument_not_void: data_source /= Void
		do
			data_source := udata_source.twin
		ensure
			data_source_set: data_source.is_equal(udata_source)
		end

	set_role (uroleId: STRING; urolePassWd: detachable STRING)
			-- Set role identifier of data base.
		require
			argument_not_void: uroleId /= Void
		do
			roleId := uroleId.twin
			if (urolePassWd /= Void) then
				rolePassWd := urolePassWd.twin
			else
				rolepasswd := Void
			end
		ensure
			name_set: roleId.is_equal(uroleId)
		end

	set_group (ugroupId: STRING)
		require
			argument_not_void: ugroupId /= Void
		do
			groupId := ugroupId.twin
		ensure
			name_set: groupId.is_equal(ugroupId)
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

	roleId: STRING
			-- Role identifier .

	rolePassWd: detachable STRING
			-- Role password.

	groupId: STRING
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


