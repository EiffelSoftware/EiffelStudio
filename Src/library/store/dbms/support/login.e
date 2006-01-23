indexing
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

	make is
		do
			create name.make (1)
			create passwd.make (1)
			create application.make (1)
			create hostname.make (1)
			create data_source.make (1)
			create roleId.make (1)
			create rolePassWd.make (1)
			create groupId.make (1)
		end

feature -- Status setting

	set (uname, upasswd: STRING) is
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

	set_application (appname: STRING) is
			-- Set name of application
		require
			argument_not_void: appname /= Void
		do
			application := appname.twin
		ensure
			name_set: application.is_equal(appname)
		end

	set_hostname (uhostname: STRING) is
		require
			argument_not_void: uhostname /= Void
		do
			hostname := uhostname.twin
		ensure
			name_set: hostname.is_equal(uhostname)
		end

	set_data_source (udata_source: STRING) is
			-- Set Data Source of ODBC.
		require
			argument_not_void: data_source /= Void
		do
			data_source := udata_source.twin
		ensure
	--FIXME(worx without)		data_source_set: data_source.is_equal(udata_source)
		end

	set_role (uroleId, urolePassWd: STRING) is
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

	set_group (ugroupId: STRING) is
		require
			argument_not_void: ugroupId /= Void
		do
			groupId := ugroupId.twin
		ensure
			name_set: groupId.is_equal(ugroupId)
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

	rolePassWd: STRING
			-- Role password. 

	groupId: STRING;
			-- Group Identifier.

indexing
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


