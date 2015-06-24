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
	login, login_with_default, login_with_database_name

feature -- Initialization

	login_with_default
			-- Create a database handler for ODBC with common settings.
		do
			create database_error_handler.make
			create db_application.login (default_username, default_password)
			db_application.set_hostname (default_username)
			db_application.set_data_source (default_database_name)
			db_application.set_base
			create db_control.make
		end

	login (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; connection: BOOLEAN)

			-- Create a database handler for ODBC.
		do
			login_with_default
		end

	login_with_database_name (a_database_name: STRING)

			-- Create a database handler for ODBC.
		do
			login_with_default
		end


	login_with_connection_string (a_string: STRING)
			-- Login with `a_connection_string'
			-- and immediately connect to database.
		do
			login_with_default
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
