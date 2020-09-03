note
	description: "Abstract class to handle a database connection"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATABASE_CONNECTION

inherit

	DATABASE_CONFIG

	SHARED_ERROR

feature {NONE} -- Initialization

	make_common
			-- Create a database handler with common settings.
		deferred
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
		end

	make_basic ( a_database_name: STRING)
			-- Create a database handler with common settings and
 			-- set database_name with `a_database_name'.
		require
			database_name_not_void: a_database_name /= Void
			database_name_not_empty: not a_database_name.is_empty
		deferred
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
		end

	make (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; connection: BOOLEAN)

			-- Create a database handler with user `a_username', password `a_password',
			-- host `a_hostname', database_name `a_database_name', and keep_connection `connection'.
		require
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
			password_not_void: a_password /= Void
			hostname_not_void: a_hostname /= Void
			hotname_not_empty: not a_hostname.is_empty
			database_name_not_void: a_database_name /= Void
			database_name_not_empty: not a_database_name.is_empty
		deferred
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
		end

	login_with_connection_string (a_connection_string: READABLE_STRING_8)
			-- Login with `a_connection_string'
			-- and immediately connect to database.
		deferred
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
		end

feature -- Database Setup

	db_application: DATABASE_APPL [DATABASE]
			-- Database application.

	db_control: DB_CONTROL
			-- Database control.

	keep_connection: BOOLEAN
			-- Keep connection alive?

feature -- Conection

	connect
			-- Connect to the database.
		require else
			db_control_not_void: db_control /= Void
		do
			if not is_connected then
				db_control.connect
			end
		end

	disconnect
			-- Disconnect from the database.
		require else
			db_control_not_void: db_control /= Void
		do
			db_control.disconnect
		end

	is_connected: BOOLEAN
			-- True if connected to the database.
		require else
			db_control_not_void: db_control /= Void
		do
			Result := db_control.is_connected
		end

end
