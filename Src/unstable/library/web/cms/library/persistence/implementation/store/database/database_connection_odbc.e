note
	description: "Object that handle a database connection for ODBC"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_CONNECTION_ODBC

inherit
	DATABASE_CONNECTION
		redefine
			db_application
		end

create
	login, login_with_default, login_with_database_name, login_with_connection_string

feature -- Initialization

	login (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; a_keep_connection: BOOLEAN)

			-- Create a database handler for ODBC and set `username' to `a_username',
			-- `password' to `a_password'
			-- `database_name' to `a_database_name'
			-- `keep_connection' to `a_keep_connection'
		local
			retried: BOOLEAN
			l_database_error_handler: detachable like database_error_handler
		do
			create l_database_error_handler.make
			database_error_handler := l_database_error_handler
			create db_application.login (a_username, a_password)
			if not retried then
				db_application.set_hostname (a_hostname)
				db_application.set_data_source (a_database_name)
				db_application.set_base
				create db_control.make
				keep_connection := a_keep_connection
				if keep_connection then
					connect
				end
			else
				create db_control.make
				if is_connected then
					disconnect
				end
			end
		rescue
			if l_database_error_handler = Void then
				create l_database_error_handler.make
			end
			database_error_handler := l_database_error_handler
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			retried := True
			retry
		end

	login_with_default
			-- Create a database handler for ODBC with common settings.
		do
			login_with_database_name (default_database_name)
		end

	login_with_database_name (a_database_name: STRING)
			-- Create a database handler and
			-- set database_name to `a_database_name'.
		do
			login (default_username, default_password, default_hostname, default_database_name, is_keep_connection)
		end

	login_with_connection_string (a_string: STRING)
			-- Login with `a_connection_string'and immediately connect to database.
		local
			retried: BOOLEAN
			l_database_error_handler: detachable like database_error_handler
		do
			create l_database_error_handler.make
			database_error_handler := l_database_error_handler
			create db_application.login_with_connection_string (a_string)
			if not retried then
				db_application.set_base
				create db_control.make
				keep_connection := is_keep_connection
				if keep_connection then
					connect
				end
			else
				create db_control.make
				if is_connected then
					disconnect
				end
			end
		rescue
			if l_database_error_handler = Void then
				create l_database_error_handler.make
			end
			database_error_handler := l_database_error_handler
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			retried := True
			retry
		end

feature -- Databse Connection

	db_application: DATABASE_APPL [ODBC]
			-- Database application.

end
