note
	description: "Null object to meet Void Safe."
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_CONNECTION_NULL

inherit

	DATABASE_CONNECTION
		redefine
			db_application,
			is_connected
		end

create
	make, make_common, make_basic

feature {NONE} -- Initialization

	make_common
			-- Create a database handler for ODBC with common settings.
		do
			create db_application.login (username, password)
			db_application.set_hostname (hostname)
			db_application.set_data_source (database_name)
			db_application.set_base
			create db_control.make
		end

	make (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; connection: BOOLEAN)

			-- Create a database handler for ODBC.
		do
			make_common
		end

	make_basic (a_database_name: STRING)

			-- Create a database handler for ODBC.
		do
			make_common
		end


	login_with_connection_string (a_string: STRING)
			-- Login with `a_connection_string'
			-- and immediately connect to database.
		do
			make_common
		end


feature -- Databse Connection

	db_application: DATABASE_APPL[DATABASE_NULL]
			-- Database application.


	is_connected: BOOLEAN
			-- True if connected to the database.
		do
			Result := True
		end

end
